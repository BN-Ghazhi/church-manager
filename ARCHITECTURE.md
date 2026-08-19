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
/attendance     Service records, trends, member check-in
/ministries     Departments and small groups with leaders and capacity
/events         Calendar, registrations, weekly schedule, announcements
/volunteers     Serving rotas by Sunday, coverage by role
/finance        Donations, expenses, pledges, fund analysis
/communication  Email/SMS/WhatsApp/push campaigns + compose
/care           Pastoral care queue with priority and assignment
/discipleship   Courses, enrolment and the growth pathway
/assets         Equipment register with condition and value
/access         Users, roles, and the module permission matrix
/reports        Report templates, scheduled reports, data previews
/settings       Church profile, services, appearance, preferences, integrations
```

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
  lib/models/models.dart      ← the domain contract (Member, Donation, …)
           ↑
  lib/data/*.dart             ← mock data, typed against the contract
           ↑
  lib/providers/repository.dart ← Riverpod providers: THE SEAM
           ↑
  lib/screens/*.dart          ← screens read providers, never data files
```

When the backend arrives, only `repository.dart` changes. A provider like

```dart
final membersProvider = Provider<List<Member>>((ref) => mem.members);
```

becomes

```dart
final membersProvider = FutureProvider<List<Member>>((ref) =>
    ref.watch(apiProvider).fetchMembers());
```

and the screens follow, because `ref.watch(membersProvider)` is already how they
ask for data. This is the single most valuable structural property of the
codebase — preserve it.

Two screens (`command_palette.dart`, `member_form.dart`) import `lib/data`
directly for convenience. Route those through providers when the API lands.

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

### 2.6 Deterministic mock data

Mock data uses a seeded generator (`lib/data/seed.dart`), never `Random()`. The
dataset is byte-identical on every run and platform, which keeps screenshots,
tests and demos stable. Dates are anchored to a fixed `kDemoNow`
(14 August 2026) so relative times ("2 days ago") stay sensible.

The dataset is deliberately realistic in size — 96 members, 140 donations,
26 weeks of attendance — so pagination, filtering and chart density are properly
exercised rather than looking good with five rows.

Dashboard demographics (age bands, gender split, growth funnel) are **derived
from the member list**, not hard-coded, so charts always agree with the
directory. The funnel stages are strict nested subsets, so it narrows
monotonically and the conversion percentages are honest.

### 2.7 Notable decisions and their reasons

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
├── data/                   Mock data — the swap point for the API
│   ├── seed.dart           Deterministic generator + kDemoNow
│   ├── members_data.dart
│   ├── ministries_data.dart
│   ├── events_data.dart
│   ├── finance_data.dart
│   ├── operations_data.dart
│   └── dashboard_data.dart Derived aggregates
├── providers/repository.dart  Riverpod providers: THE SEAM
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

- Screens read providers, never `lib/data` directly
- All formatting goes through `Fmt` — no inline `DateFormat` or string interpolation of numbers
- New statuses get registered in `StatusBadge.toneOf()`, not styled ad hoc
- New screens get added to `navigation.dart` and the router
- Stub actions call `showStubMessage()` so they stay honest
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
  Tema, Kumasi, Takoradi, Tamale and Cape Coast, Ghanaian names (Akan, Ewe, Ga
  and northern), `+233` mobile numbers, and Paystack (which operates in Ghana).
  Change `ChurchConfig` in `lib/config/app_config.dart`, `Fmt` in
  `lib/utils/formatters.dart`, and the seed lists in `lib/data/`.
- **Neutral near-monochrome theme** — deliberately unbranded. Church colours go
  in `AppTheme.seed` and the accent constants.
- **Ten roles across four scopes** — see §2.8. Your actual structure may differ;
  both the role list (`models.dart`) and the matrix (`operations_data.dart`) are
  straightforward to edit.
- **Departments vs. Ministries** — `/departments` is the new per-branch model;
  `/ministries` is the older HQ-level view, kept so nothing was lost. Retire the
  latter once you are happy with the former.
- **"Grace Chapel"** — placeholder name throughout.
- **fl_chart** — all chart code is isolated in `lib/widgets/charts.dart` if you
  want to swap it.
- **Riverpod** — chosen for the reasons in §2.2; the provider layer is thin
  enough to swap if your team prefers BLoC.
