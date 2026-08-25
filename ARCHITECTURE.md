# Church Management System — Architecture & Roadmap

**Status:** Working application with its own local database. Multi-branch.
**Stack:** Flutter 3.44 · Dart 3.12 · Drift/SQLite · Riverpod · go_router · fl_chart
**Targets:** Windows · macOS · Linux · Web (Android/iOS can be added with one command)
**Last updated:** 15 August 2026

This document explains how the system is put together, the decisions behind it,
and what I recommend building next. If you read only one section, read
"Where to start when you're back" at the bottom.

---

## 1. What exists right now

A complete, working front end for a church management console, built as a
Flutter desktop application. Seventeen screens across six branches, all
rendering real (mock) data, all responsive from phone to wide desktop, light and
dark themed, passing `flutter analyze` with zero issues and 21 tests.

```
/dashboard      Church health at a glance — KPIs, trends, activity, alerts
/branches       Every campus: leadership, size, giving, health
/departments    Youth, Children and every other department, per branch
/members        Directory with search, filter, sort, pagination
/members/:id    Full member profile: giving, serving, care, notes
/attendance     Service records, trends, member check-in, who attended each service
/ministries     Departments and small groups with leaders and capacity
/events         Calendar, registrations, weekly schedule, announcements
/volunteers     Serving rotas by Sunday, coverage by role
/finance        Donations, expenses, pledges, fund analysis
/communication  Email/SMS/WhatsApp/push campaigns + compose
/care           Pastoral care queue with priority and assignment
/discipleship   Courses, enrolment and the growth pathway
/assets         Equipment register with condition and value
/access         Users, roles, and the module permission matrix
/settings       Church profile, services, appearance, preferences, integrations
```

### Ghana is not the United States

`lib/config/ghana.dart` holds the country-specific reference data, because
getting this wrong is the kind of thing that quietly annoys every user:

* **Regions, not states.** Ghana has sixteen regions (six of them created in the
  2018 reorganisation, which an older list would omit). Addresses pick from that
  list rather than accepting free text — typing produces "Gt. Accra",
  "greater accra" and "Accra Region" for one place, which then breaks any
  grouping by region. The database column is still called `state` because
  renaming it needs a migration; `Address.region` is the accessor to use.
* **A region is inferred from the city** where the city is recognisable, so the
  common case needs no extra thought. An unrecognised city leaves the field
  alone rather than guessing.
* **Phone numbers** normalise to `+233 XX XXX XXXX` from whatever was typed —
  `0241234567`, `241234567`, `+233241234567`. A number that is not a Ghanaian
  mobile (a landline, or one from abroad) is stored unchanged rather than
  mangled into a shape it does not have.
* Dates are day-first and amounts are in cedis, both handled by `Fmt`.

### The app ships empty

A fresh database holds one headquarters branch, one administrator and the
department catalogue. That is the minimum: a member must belong to a branch, and
somebody has to be able to sign in.

Everything else — members, giving, attendance, events, departments — is entered
by the church. There was a bundled demo congregation of 240 members; it is gone,
because seeded examples only have to be found and deleted before real use, and
they make it hard to tell whether a figure on screen is yours or invented.

The department *catalogue* is kept, because it is structure rather than data: it
defines what a Youth or Children's department is, which is what makes the same
department comparable between branches.

Removing the demo data surfaced three things that had been hidden by it:

* The growth funnel counted `ministryIds`, which departments replaced, so
  "Serving in a ministry" always read zero and the funnel collapsed.
* KPI tiles carried hardcoded trend percentages and generated sparklines — they
  looked like real history and were not. Both are now omitted until there is
  something to compare against.
* Six screens divided by a total that is zero on a fresh install, and the
  attendance screen read `records.first` unguarded. `Fmt.share` and explicit
  empty checks handle those.

### What works, and what does not

**Data persists.** The app carries its own SQLite database (§2.9). Adding a
member, starting a department, checking people in, recording giving, changing
settings — all of it is written to disk and is still there after a restart.

**Sign-in is real.** Accounts live in the database with PBKDF2-hashed
passwords. A Department Head signs in and sees only their department; a Branch
Pastor only their branch.

**Still not connected to the outside world.** Composing a campaign saves a real
record with status `scheduled`, but nothing is transmitted — there is no SMS or
email provider wired up, and the confirmation message says so. A few actions
(CSV export, report generation) remain stubs and route through
`showStubMessage()` in `lib/widgets/feedback.dart`, which states plainly that
they are previews.

### Why Flutter

One codebase compiles to Windows, macOS and Linux desktop binaries, plus web
and (with `flutter create --platforms=android,ios .`) mobile. The UI is drawn by
Flutter's own engine rather than native controls, so the app looks identical on
every platform — which is what you want for an internal tool used across a
church office's mixed hardware.

The trade-off worth knowing: Flutter web renders to a canvas, not DOM elements.
Browser-level text selection and find-in-page behave differently from a normal
web page, and screen-reader support relies on Flutter's semantics layer.

**The web build does not currently start.** Adding the local database made
desktop the working target: Drift on web runs SQLite in a worker backed by
IndexedDB, which needs `sqlite3.wasm` and `drift_worker.js` (both committed to
`web/`) *and* cross-origin isolation headers from the server. With those in
place the app still hangs before first paint, and I did not chase it further
because desktop is the stated target. If web matters later, start by running
`flutter run -d chrome` and reading the un-minified error — the release build
minifies it into uselessness.

---

## 2. Architecture

### 2.1 Layer separation

The whole design rests on one rule: **screens never know where data comes
from.**

```
  lib/models/models.dart        ← the domain contract (Member, Donation, …)
           ↑
  lib/db/tables.dart            ← Drift schema
  lib/db/repository.dart        ← every read and write, and the rules they obey
           ↑
  lib/providers/repository.dart ← Riverpod providers: THE SEAM
           ↑
  lib/screens/*.dart            ← screens read providers, never the database
```

No screen imports `lib/db`. They call `ref.watch(membersProvider)`, and the
provider layer decides where that list comes from. Today it is SQLite on the
local disk; when a server arrives, only `lib/providers/repository.dart` changes:

```dart
final membersProvider = Provider<List<Member>>(...);          // local database
final membersProvider = FutureProvider<List<Member>>((ref) => // server
    ref.watch(apiProvider).fetchMembers());
```

The screens do not move, because asking a provider is already how they get data.
This is the single most valuable structural property of the codebase — preserve
it.

**Rules live in the repository, not the forms.** Cross-branch integrity (a
department head must belong to that branch; a children's department cannot
enrol adults; headquarters cannot be deleted) is enforced in
`lib/db/repository.dart`, so it holds for any caller — a future import script or
API endpoint included — rather than only for the dialog that happens to be
wired up today.

### 2.2 State management: Riverpod

Chosen over Provider and BLoC because it is compile-safe (a missing provider is
a build error, not a runtime crash), needs no `BuildContext` to read, and makes
the mock→API swap a one-line change per provider.

The only mutable state today is `themeModeProvider`, a `Notifier` holding the
light/dark/system choice. Everything else is read-only derived data. Screens
with local interaction state (check-in selections, filter values, form fields)
use `StatefulWidget` — appropriate, because that state genuinely belongs to the
widget and dies with it.

One gotcha, already handled: **Riverpod exports a `Family` type**, which
collides with the domain's `Family` (a household). Every file importing both
uses `import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;`.

### 2.3 The shared widget library

This is where repetition is prevented. A small shared library carries the entire UI:

| Widget | Used by | Purpose |
|---|---|---|
| `DataTableView<T>` | 7 screens | Generic table: sort, search, filter, paginate |
| `SectionCard` | every screen | Titled panel — the universal container |
| `StatCard` | every screen | KPI tile with trend pill and sparkline |
| `StatusBadge` | 9 screens | **Every** status in the app, one colour system |
| `PageHeader` | every screen | Title, description, actions |
| `PageBody` | every screen | Scroll container and max-width |
| `ResponsiveGrid` | every screen | Reflows children into as many columns as fit |
| `SplitRow` | most screens | Two panels side by side, stacked when narrow |
| `PersonTile` | 6 screens | Avatar + name + subtitle |
| `EmptyState` | many | Nothing-to-show state |
| `Sparkline` | StatCard | Custom-painted inline trend line |
| `EventTile` | 2 screens | Event row with date chip |
| charts.dart | 8 screens | Trend, bar and donut charts over fl_chart |
| `RowActions` | every table | View / edit / delete buttons on a table row |
| `StatRow` | every screen | The KPI row, collapsible and remembered |
| `showDetailSheet` | every table | The "click a row for details" modal |
| `DetailRows` | every modal | Label/value list that skips blank values |
| `FormDialog` + fields | every form | One validated dialog, create and edit alike |

Three deserve explanation.

**`DataTableView<T>`** is fully generic. A screen supplies `columns`, a `rowId`
function, an optional `searchable` accessor and optional `filters`. It gets
sorting, searching, multi-filter, pagination and empty states for free. Columns
can be marked `hideOnNarrow` so wide tables degrade gracefully. This is why
members, events, donations, expenses, assets, care requests and attendance
records all behave identically without duplicated code.

**`StatusBadge`** solves a problem that usually creates sprawl. The app has ~30
distinct status words across modules. Rather than each module inventing colours,
`StatusBadge.toneOf()` maps every domain enum value to one of five semantic
tones (success/warning/danger/info/neutral), and one map turns tones into
colours. `StatusBadge.of(anyEnum)` reads both the tone and the label. Add a
status to the switch and it looks right everywhere; two visually identical
statuses can never drift apart.

**`ResponsiveGrid`** replaces hand-written breakpoint logic. Give it a
`minItemWidth` and it computes how many equal columns fit, then lays children
out. Almost every "cards in a grid" layout in the app is one call.

### 2.4 Navigation as data

`lib/config/navigation.dart` is the single source of the information
architecture. The sidebar, the icon rail, the mobile drawer, the breadcrumb and
the command palette all read from it. Add a screen there and it appears in all
of them, correctly grouped, with the right icon and description.

### 2.5 Responsive shell

`AppShell` adapts to the *window*, not the platform, so one build works as a
desktop app and in a browser:

| Width | Navigation |
|---|---|
| ≥ 1100 | Full sidebar with section labels and badges |
| 700–1100 | Icon rail with tooltips |
| < 700 | Hamburger + drawer |

### 2.6 Tables, modals and edits

Every list in the app is a `DataTableView<T>`, and every table row carries the
same three actions in the same place: **view**, **edit**, **delete**. That
uniformity is the point — a user who learns the members table has learned all
eight of them.

- **View** opens `showDetailSheet`, a modal built from `DetailRows`. It skips
  blank values rather than printing empty labels, so a sparsely-filled record
  looks deliberate instead of broken.
- **Edit** reuses the *same* form widget that created the record. Each
  `show…Form` takes an optional existing record; when present, the fields are
  pre-filled, the title and button change, and submit calls `update…` instead of
  `create…`. There is no second edit screen to drift out of step.
- **Delete** goes through `confirmDelete`, which states the consequence in
  plain words ("attendance trends will be recalculated without it") rather than
  asking "Are you sure?". Deletes are **soft** everywhere: the row keeps its
  `deletedAt` stamp and drops out of every query, so nothing is ever
  unrecoverably lost.

Two invariants are enforced in the repository rather than the UI, so they hold
no matter who calls: **headquarters cannot be deleted** (every record needs a
branch to belong to), and an update writes only the columns it was passed —
`Value.absent()` for the rest — so a partial edit cannot blank out fields it
never showed the user.

### 2.7 Was this member present?

A headcount answers *how many*; the question a pastor actually asks is *whether
a particular person has been in church lately*. Two reads answer it, and the UI
surfaces both:

| Read | Answers | Shown in |
|---|---|---|
| `watchServiceAttendees(serviceId)` | who was at this service | Attendance → service modal |
| `watchMemberAttendance(memberId)` | which services this member attended | member detail modal |
| `attendanceRate(memberId, branchId:)` | how many of the last N services | member detail modal |

A service can exist with a headcount and no names against it — that is a normal
state, not an error, and both screens say so explicitly rather than showing an
empty list that reads like a bug.

### 2.8 First-run setup

A fresh database holds the department catalogue and nothing else — no church, no
branch, no account. `Seeder.needsOnboarding` reports that, resolved once at
startup into `needsOnboardingProvider` because the router's redirect is
synchronous, and the redirect then makes `/setup` the only reachable route.

The app previously shipped `admin` / `church2026`. That is not a default so much
as a published credential: every install in the world had the same one until
somebody acted on a line in the README. Setup collects the first password
instead, so there is nothing to leak.

`completeOnboarding` is one transaction. A half-finished setup would leave an app
that cannot be signed into *and* cannot be set up again, which is unrecoverable
without deleting the database — so the branch, the account and the church profile
land together or not at all. Writing this exposed a real bug: the department
catalogue was seeded by both first launch and setup, and the second plain insert
collided and aborted the transaction, so setup failed on every fresh install.
It is `insertOnConflictUpdate` now, and `test/onboarding_test.dart` covers the
repeat.

### 2.9 Who can see what

Access has two dimensions that always apply together:

- **Capability** — *what* you may do. `permissionMatrix` maps module × role to
  view/edit/delete, and `canViewProvider` / `canEditProvider` are what screens
  and nav items consult.
- **Scope** — *whose data* you see. `RoleScope` is all branches, your branch,
  your department, or just yourself.

Cross-branch sight is a **permission granted per account**
(`StaffUser.canSeeAllBranches`), not a fixed property of a role. A Super Admin
can grant it to any branch-level account from Roles & Access and revoke it
again; department heads and volunteers can never receive it. This is why the
church's own structure can change without editing the role enum.

**Permissions are editable, and only the differences are stored.**
`permissionMatrix` in `lib/config/permissions.dart` stays the default every
church starts from; a row in `permission_overrides` says "this role's access to
this module is not the default any more". `watchPermissionMatrix()` merges the
two, so a church that never touches permissions keeps getting improvements to
the defaults while one that has customised a role keeps its choice. Storing the
whole matrix instead would freeze today's module list into the database, and a
module added later would land as a silent gap on existing installs.

Two things are deliberately not editable. Super Admin's access is fixed — it is
the account that grants everyone else theirs, so a mistake there could lock every
administrator out of the screen that fixes it, and with no server nobody could
undo it. And nobody can edit their own role or cross-branch access, for the same
reason at account level.

**Switched-off modules** are enforced in one place. `Features.hiddenModules`
(`lib/config/features.dart`) is checked inside `permissionForProvider`, so every
`canView`/`canEdit` call inherits it, and the router refuses the matching routes
so a typed URL cannot reach one either. They are hidden, not deleted: the
screens and their tests still work, and re-enabling one is removing a line.

"One place" only holds if everything asks through that gate, and the first
version of this did not: the sidebar and the command palette both read the
permission matrix directly, so hidden modules kept appearing in the navigation.
Both now call `canViewProvider`. `test/hidden_modules_test.dart` asserts the
outcome rather than the mechanism — that no visible destination belongs to a
hidden module, and that an edited permission cannot outrank the switch — so the
next bypass fails a test instead of shipping.

Every branch-scoped query funnels through one gate, `activeBranchIdsProvider`.
A screen cannot accidentally read another branch's data, because it never picks
the branch filter itself. Note that client-side scoping is a convenience, not a
security boundary — when a server arrives, the same filter must be enforced
server-side (§4, item 5).

### 2.10 Three separate ideas: title, post, account

Conflating any two of these breaks the church's actual structure, so they are
kept apart deliberately:

- **Title** — `Member.title`, free text but **church office only**. An honorific
  the person carries. A branch may have a senior pastor, two associates and a
  youth pastor; all four are pastors and only the first leads anything.
  `Member.isPastor` matches on the text rather than an enum, because churches word
  these differently ("Snr. Pastor", "Rev. Dr.", "Apostle") and a fixed list would
  need a code change every time one is added.

  `MemberTitle.validate` refuses civil and academic titles — Mr, Mrs, Miss, Dr,
  Prof, Chief, Nana. They duplicate what the record already holds, go stale on
  marriage, and admitting them would make the field mean nothing in particular.
  Matching is whole-word, because "Minister" contains no standalone "Mr" and a
  substring check would refuse several real titles. A church word anywhere in the
  string wins, which is what lets "Rev. Dr." through while refusing "Dr." alone —
  the doctorate is part of how a minister is addressed. The rule is applied in the
  repository as well as the form, so a caller that skips the form cannot quietly
  change what the column means; a refused value is stored blank rather than
  throwing, since the member is still worth saving.
- **Post** — a column on the branch, department or group. One holder per job, so
  it lives on the thing being led (§2.10).
- **Account** — a `StaffUser` with a role in the permission matrix. Most pastors
  never sign in, and a title must never imply a login.

The temptation was a `pastors` table or a `pastor` role. Either would have made a
title mean access, which is precisely wrong: a title is who someone is, an
account is what they may do.

### 2.11 Leadership is derived, not stored

A branch already names its pastor, a department its head, a group its leader.
`leadershipPostsProvider` assembles the Pastors tab from those columns instead of
a `pastors` table, because a second record of the same fact can disagree with the
first — someone replaced as a department head but still listed as one. Appointing
a leader writes to the record that owns the post, so the list changes with it.

`LeadershipRole` is ordered by seniority, which is what lets a person's posts and
the table itself sort sensibly without a separate rank column.

`setGroupLeader` was added alongside `createSmallGroup`: groups had a table and a
`leaderId` column but no way to create one, so that post could never be filled.

### 2.12 Stat cards that lead somewhere

`StatCard.accent` and `StatCard.onTap` are optional and belong together. Colour
is not decoration here — it is the affordance that says the tile is pressable,
so a card that cannot navigate must not be tinted, and `LinkedStatCard` enforces
exactly that: it takes a route plus the module that route needs, and when
`canViewProvider` says no it drops the accent, the tap, the tooltip and the
hover in one go. That keeps a switched-off module from producing a card that
looks live and then bounces off the router's redirect, which reads as breakage.

Deliberately not applied everywhere. A row of six identically-washed cards is
louder without being clearer, so the tint marks the numbers a screen exists to
lead with.

### 2.13 Colour and links

`accentColor` (`lib/theme/app_theme.dart`) is the single mapping from the six
`AccentToken` values to real colours. It had been copy-pasted into three screens
and the copies had already begun to drift, which is exactly the failure this
codebase is meant to avoid.

`ContactLink` (`lib/widgets/contact_link.dart`) turns a stored value into
something the platform can open, and the conversions are the point: a phone
number keeps only digits and a leading `+` because `tel:` rejects the spaces a
readable number contains; a website gains a scheme because "kgc.org" alone is
read as a relative path and fails silently; an address becomes a maps search, so
it works without coordinates. A link that cannot be handled says so rather than
doing nothing, because a dead tap reads as a broken app.

### 2.14 Member photos

`Member.photo` holds a **filename**, not a path, resolved against the app's
`photos` directory by `memberPhotoProvider`. An absolute path breaks the moment
records are restored on another machine or the install moves between native and
sandboxed storage; a filename stays valid. A missing file resolves to null and the
avatar falls back to initials, because the database can outlive the image.

Files are named from the clock rather than the member id, because a photo is
chosen *before* a new member has an id — and reusing a name would let a cached
image show for the wrong person.

The form copies the file into storage immediately but does not touch the member
record until save, so cancelling leaves an unreferenced file rather than a
half-applied change. `pruneOrphanPhotos` clears those after each save. It reads
`allMemberPhotos`, which deliberately **ignores branch scope and soft deletes**:
pruning while signed in as one branch must not delete another branch's photos, and
a soft-deleted member can still be restored, so their photo is not litter. Both
are tested, since a mistake there destroys files rather than merely displaying
something wrong.

### 2.15 Branding

The sidebar logo and the sign-in background can be replaced from Settings. The
chosen file is **copied into the app's own storage** rather than referenced where
it sits — a path into Downloads or onto a USB stick breaks the moment the file
moves, and the app would silently lose its logo. Only the copy's path lives in
the settings table, and a missing file falls back to the built-in default rather
than rendering a broken box, because the database can outlive the image.

### 2.16 Persistence

One SQLite file, via Drift, in the platform's application-support directory. No
server, no setup, works offline. The schema is `lib/db/tables.dart`; generated
code is committed, so `build_runner` needs
`--delete-conflicting-outputs` when regenerating.

**Schema version 2.** The version is in `lib/db/database.dart`, and every bump
needs an `onUpgrade` branch — an install that already holds real records must be
migrated, never re-created. v1 → v2 renamed `user_accounts.email` to `username`
and turned each address into its local part (`grace@kgc.org` → `grace`), keeping
the same password. `test/migration_test.dart` builds a v1 database by hand and
signs in through the upgrade, because a broken migration does not lose a feature
— it locks someone out of their own church's records.

Deletes are soft everywhere (`deletedAt`), and every read filters on it. Writes
stamp `updatedAt`, and list ordering breaks ties on `createdAt` so a
just-added record sorts first (§5, "List ordering").

Each install has its **own** database — a branch laptop is not visible to
headquarters without a shared machine or a server. `BRANCH-DATA.md` lays out the
three options and what each costs.

### 2.17 Notable decisions and their reasons

**Charts take a `ValueFormat` enum, not a formatter function.** Keeps chart
call sites declarative and consistent, and avoids passing closures through
widget trees.

**Chart colours are fixed hex values in `AppTheme.chartColors`,** chosen to be
legible on both light and dark surfaces, rather than derived from the Material
scheme (which would make series colours shift between themes).

**`intl` locale data is initialized in `main()`.** Without
`await initializeDateFormatting(Fmt.locale)`, every `DateFormat` call throws
`LocaleDataException` on first paint. This was a real bug, caught by running the
built app in a browser rather than by reading the code.

**Enums carry their own `label`.** Every domain enum has a display string
attached, so the UI never re-derives text from an identifier and labels can't
diverge between screens.

**Design tokens live in `AppTheme`, `AppSpacing`, `AppRadius`.** Flutter has no
utility-class system, so these play the role a stylesheet would: change a value
there and it reaches every screen.

---

## 3. Domain model

Defined in `lib/models/models.dart` — this is the contract your database schema
should mirror.

**People:** `Member` (with `Address`, status, ministries, group, family, tags,
baptism, notes), `Family`, `StaffUser`
**Structure:** `Ministry`, `SmallGroup`, `Course`
**Activity:** `ChurchEvent`, `AttendanceRecord`, `VolunteerSlot`
**Money:** `Donation`, `Pledge`, `ExpenseRecord`
**Engagement:** `Campaign`, `AnnouncementItem`, `CareRequest`
**Operations:** `AssetItem`, `ModulePermission`

All models are immutable value types. Relationships are modelled by ID reference
(`memberId`, `leaderId`, `ministryIds`) exactly as they would be as foreign
keys, so translating to a relational schema is close to mechanical.

---

## 4. What I recommend building next

Ordered by dependency, not by how interesting each item is.

### Phase 1 — Done

Local database, seeding, real sign-in, hashed passwords, branch-scoped queries
and working writes across members, departments, check-in, giving, care,
campaigns and settings. What remains from the original Phase 1:

**1. Password change on first sign-in.** `UserAccounts.mustChangePassword`
exists in the schema but nothing acts on it yet. Force a change when an invited
account signs in for the first time, and remove the demo credentials from the
sign-in screen once real accounts exist.

**2. Backups.** A single SQLite file is easy to back up and easy to lose. Add a
scheduled copy to a second location, and an export/import in Settings. This is
the most valuable next thing to build.

**3. Migrations.** `schemaVersion` is 1 with no `onUpgrade` step. The moment
real data exists, every schema change needs a migration — Drift generates and
tests these, but the strategy has to be written.

**4. Optional sync.** If branches ever need to share data live, the local
database becomes a cache in front of a server rather than the source of truth.
Design that *before* multiple sites are running independently, because merging
divergent local databases afterwards is painful.

**5. Branch scoping on the server.** The branch model already exists in the
UI (§2.8). Carry it into the schema: `branch_id` on every scoped table, indexed,
and enforced by row-level security or an equivalent server-side filter. The
client-side scoping is a convenience, never a boundary.

If this will ever serve more than one *church* (not just multiple branches of
this one), add `organization_id` above `branch_id` now — retrofitting a second
tenancy level is far more painful than adding it up front.

### Phase 2 — Complete the core workflows

**8. Real check-in.** The UI exists; it needs to persist attendance. Add a
kiosk mode for a tablet at the door, and QR or SMS self-check-in. Child check-in
needs a security-code print-out matching guardian to child — a safeguarding
requirement, not a nice-to-have.

**9. Online giving.** Paystack or Flutterwave — both operate in Ghana and support mobile money, which matters here. Card,
transfer and USSD. Webhook to record donations automatically, recurring giving,
automated receipts. Annual contribution statements are listed in `/reports` and
are typically the single most-requested finance feature.

**10. Messaging delivery.** Twilio or Hubtel for SMS (Hubtel is Ghana-based), Resend or Mailgun for
email. Needs a server-side queue — sending 800 messages from a client will fail.

**11. Event registration.** Public registration pages, ticket types, capacity
limits, waitlists, QR check-in at the door.

**12. File uploads.** Member photos, sermon audio, expense receipts. The
`Member` model has no `avatarUrl` yet — add it and `PersonTile` can show real
photos with initials as fallback.

**13. Offline support.** This is where Flutter earns its keep: a local database
(Drift or Isar) with sync-on-reconnect means check-in works when the church
wifi doesn't. Worth doing properly.

### Phase 3 — The things that make it genuinely useful

**14. Member self-service app.** The same codebase can ship a member-facing
mobile build: update contact details, see giving history, download statements,
register for events, submit prayer requests. Highest-leverage feature for
reducing admin workload, because the congregation maintains its own data.

**15. Automation engine.** The toggles on `/settings` describe the intended
behaviour: first-timer follow-up, birthday greetings, inactivity flagging, rota
reminders, giving receipts. Build them as scheduled server jobs. Follow-up
automation is what actually converts visitors into members.

**16. Report generation.** Make the `/reports` templates run: date-range picker,
real PDF/CSV/XLSX output (the `pdf` and `excel` Dart packages handle this), and
scheduled email delivery.

**17. Attendance intelligence.** Flag members whose attendance is declining
*before* they disappear. A member who drops from weekly to fortnightly is the
one to call. This is the difference between recording history and enabling
pastoral care.

### Phase 4 — Scale and polish

- **Windows installer** — MSIX packaging for distribution
- **Auto-update** — desktop apps need an update path; consider Sparkle/Squirrel
- **Multi-campus** — campus dimension on attendance, giving and events
- **Sermon library** — audio/video, series, notes, podcast feed
- **Facility booking** — room reservations with conflict detection
- **Background checks** — clearance status for children's workers (a legal
  requirement in many jurisdictions)
- **Bulk import** — CSV import with column mapping; every church migrating from
  a spreadsheet needs this on day one
- **Audit log** — who changed what, when. Essential for financial records.
- **Data export / GDPR** — full export and hard delete on request

### Cross-cutting concerns

**Testing.** Twenty-one tests exist across `test/widget_test.dart` (data
integrity: determinism, demographics, funnel monotonicity, date sanity,
joined-before-born, branch containment, department eligibility, core coverage)
and `test/permissions_test.dart` (branch scoping and capability checks, including
proof that a Branch Pastor's providers return only their own branch and that
cross-branch selection is rejected). Originally five data-integrity tests (`test/widget_test.dart`) covering
determinism, demographic consistency, funnel monotonicity, date sanity and the
joined-before-born guard. Worth adding: widget tests for `DataTableView`
(sort/filter/paginate is where bugs will hide) and `integration_test` for the
critical flows once auth exists.

**Accessibility.** Material widgets carry semantics by default, but Flutter web
renders to canvas, so screen-reader support depends on the semantics tree. Worth
an audit with TalkBack/NVDA before any public-facing release.

**Performance.** All data is in memory today. Once queries are real, paginate
server-side for tables over ~1,000 rows and use `ListView.builder` (already the
case in the check-in list) rather than building whole lists.

**Security checklist for when the backend lands:** rate-limit auth endpoints,
parameterised queries only, encrypt giving data at rest, never log PII, and
treat the permission matrix as server-enforced.

---

## 5. Project structure

```
lib/
├── main.dart               Entry point, router, intl init
├── config/
│   ├── app_config.dart     Church profile, services, current user
│   └── navigation.dart     Single source of the IA
├── models/models.dart      The domain contract
├── db/
│   ├── tables.dart         Drift schema (+ generated database.g.dart)
│   ├── repository.dart     Every read and write, and the rules they obey
│   └── seeder.dart         First-run state: one branch, one admin, catalogue
├── aggregates/             Pure functions over whatever the database returns
│   ├── dashboard.dart      KPIs, demographics, growth funnel
│   ├── attendance.dart     Attendance trends
│   └── finance.dart        Giving and expense totals by fund
├── providers/
│   ├── repository.dart     Riverpod providers: THE SEAM
│   ├── auth.dart           Sign-in and the current user
│   └── permissions.dart    Capability × scope, and the branch gate
├── screens/                One file per screen
├── shell/
│   ├── app_shell.dart      Responsive sidebar/rail/drawer + top bar
│   └── command_palette.dart Ctrl+K search
├── theme/app_theme.dart    Design tokens
├── utils/formatters.dart   All formatting
└── widgets/                The reusable library (section 2.3)
```

### List ordering

A record you have just added must be visible, not buried. Every list is ordered
so that holds:

| List | Order |
|---|---|
| Giving, expenses, attendance | Business date descending, then entry time descending |
| Assets, courses, departments, care, campaigns | Entry time descending |
| Members | Most recently joined first by default; the Member column still sorts alphabetically for directory lookups |
| Events | By start date, soonest first — a calendar reads forwards |
| Branches | Headquarters first, then by date established |

The entry-time tie-break matters: ordering by business date alone leaves rows
that share a date in arbitrary order, so a gift recorded today alongside three
others would not reliably appear on top. Pinned by `test/ordering_test.dart`.

Back-dated records are a deliberate exception — a ledger is ordered by when the
money moved, not when it was typed, so entering last month's offering does not
push it above this week's.

### Conventions worth keeping

- Screens read providers, never `lib/db` directly
- All formatting goes through `Fmt` — no inline `DateFormat` or string interpolation of numbers
- New statuses get registered in `StatusBadge.toneOf()`, not styled ad hoc
- New screens get added to `navigation.dart` and the router
- Stub actions call `showStubMessage()` so they stay honest
- Every table row gets `RowActions`; every KPI row is a `StatRow`
- Edit reuses the create form (`show…Form(context, record: existing)`), never a
  second screen
- Deletes are soft and go through `confirmDelete` with a stated consequence
- Comments explain *why*, not *what*

---

## 6. Running it

```bash
flutter pub get
flutter run -d chrome          # web
flutter run -d windows         # Windows desktop (on a Windows machine)
flutter run -d linux           # Linux desktop (needs clang, cmake, ninja, pkg-config)

flutter analyze                # currently clean
flutter test                   # 5 data-integrity tests
flutter build web              # production web bundle
flutter build windows          # Windows .exe (must run on Windows)
```

**Note on this machine:** Linux desktop builds need
`sudo apt install clang cmake ninja-build pkg-config libgtk-3-dev`. Web and
Android tooling are already working. Windows builds must be produced on a
Windows machine (or via CI) — Flutter cannot cross-compile desktop targets.

---

## 7. Where to start when you're back

1. **Look at the UI first.** `flutter run -d chrome`, then click through every
   screen. Easier to judge what's missing by seeing it than by reading this.
2. **Read `lib/models/models.dart`.** It is the domain model, and it is what
   your database schema should look like.
3. **Read `lib/widgets/data_table_view.dart`.** Understanding this one widget
   explains how seven screens work.
4. **Read `lib/providers/repository.dart`.** It is short, and it is where the
   backend will plug in.
5. **Decide two things before writing any schema:** multi-tenancy (one church or
   many?) and backend platform (Supabase vs. custom API). Both are expensive to
   reverse.
6. **Then start Phase 1.** Everything else depends on it.

### Things I decided that you may want to overrule

- **Ghanaian context** — Ghana cedi (GH₵), Accra headquarters with branches in
  Ghana's sixteen regions (not "states"), `+233` mobile numbers, and Paystack (which operates in Ghana).
  Change `ChurchConfig` in `lib/config/app_config.dart`, `Fmt` in
  `lib/utils/formatters.dart`, and the reference data in `lib/config/ghana.dart`.
- **Neutral near-monochrome theme** — deliberately unbranded. Church colours go
  in `AppTheme.seed` and the accent constants.
- **Ten roles across four scopes** — see §2.8. Your actual structure may differ;
  both the role list (`models.dart`) and the matrix (`lib/config/permissions.dart`) are
  straightforward to edit.
- **Departments vs. Ministries** — `/departments` is the new per-branch model;
  `/ministries` is the older HQ-level view, kept so nothing was lost. Retire the
  latter once you are happy with the former.
- **"Grace Chapel"** — placeholder name throughout.
- **fl_chart** — all chart code is isolated in `lib/widgets/charts.dart` if you
  want to swap it.
- **Riverpod** — chosen for the reasons in §2.2; the provider layer is thin
  enough to swap if your team prefers BLoC.
