# Kingdom Grace Chapel — Management System

A complete management console for a local church — members, attendance, giving,
events, volunteers, pastoral care, discipleship, assets and communication.

Built with **Flutter**, so one codebase runs as a **Windows, macOS and Linux
desktop app**, in the **browser**, and on mobile if you add those targets.

**The app carries its own database.** A single SQLite file inside the app — no
server, no setup, works offline. Everything you add or change is saved and is
still there when you reopen it. See [ARCHITECTURE.md](ARCHITECTURE.md) for how
it's built and what to build next.

## Context

Built for **Kingdom Grace Chapel (K.G.C.)**, a Ghanaian church, so amounts are
in Ghana cedi (GH₵) and the default country is Ghana.

**The app ships empty.** A fresh install contains one headquarters branch, one
administrator account and the department catalogue — nothing else. No demo
members, giving or attendance to delete first: you enter your own records.

## Stack

Flutter 3.44 · Dart 3.12 · Drift/SQLite · Riverpod · go_router · fl_chart

## Getting other branches' data into HQ

Each install has its own database, so a branch working on its own laptop is
**not** visible to HQ — that needs either one shared machine or a server.
See **[BRANCH-DATA.md](BRANCH-DATA.md)** for the three options and what each
costs.

## One branch for now

Multi-branch is supported but switched off (`multiBranchEnabled` in
`lib/config/features.dart`). The Branches screen stays visible so the capability
is discoverable, but nothing on it can be changed and **Add branch** is shown
disabled rather than hidden — a church that grows should be able to see the app
handles it. The branch switcher is gone, since there is only one branch, and
everything files against it automatically.

Switching it back on is one line. No data model changes are involved: a
single-branch church is the multi-branch case with one row.

## Switched-off modules

Giving & Finance, Communication, Volunteers, Pastoral Care and Assets are hidden
everywhere — sidebar, command palette, dashboard, routes and the permission
matrix. They are hidden, not deleted: remove a line from `hiddenModules` in
`lib/config/features.dart` to bring one back.

What stays visible: Dashboard (with Reports), Branches, Members, Attendance,
Departments, Groups & Ministries, Discipleship, Events, Roles & Access and
Settings.

## Editing roles and permissions

**Roles & Access** has three tabs, each a table with view, edit and delete:

- **Users** — accounts, their role, scope and status. Edit changes the name,
  username, role, branch, department, status and cross-branch access; a separate
  action sets a new password.
- **Roles** — the ten roles and what each reaches. Editing a role sets its access
  to every module at once.
- **Permissions** — one row per module. Editing a row sets what each role may do
  there.

Only the differences from the built-in defaults are stored, so a church that
never edits permissions keeps getting improvements to the defaults. Super Admin
always keeps full access — it is the account that fixes everyone else's.

## Pastors and leaders

A branch can have several pastors. Only one of them *leads* it, and the two facts
are stored separately:

- **A title** belongs to the person. Set it on the member record — "Pastor",
  "Associate Pastor", "Youth Pastor", "Reverend". Free text, with the common ones
  suggested, so a branch can have as many pastors as it actually has.

  **Church office only.** "Mr", "Mrs", "Miss", "Dr" and the like are refused: they
  say nothing the record does not already hold, they go stale when someone
  marries, and allowing them would turn a field meaning "holds office in this
  church" into one meaning nothing in particular. Most members leave it blank.
  A doctorate is fine *alongside* office — "Rev. Dr." is accepted, "Dr." alone is
  not.
- **A post** belongs to the branch, department or group. Branch pastor,
  assistant, department head, group leader — one holder each, because there is
  one of each job.

**Neither grants access to the system.** Most pastors never sign in; a login is
created separately in Roles & Access. That separation is deliberate — being a
pastor is who someone is, not what they may do in a database.

**Members → Pastors & leaders** lists both: everyone with a pastoral title *or* a
post. Someone holding two posts is one row showing both; a pastor who leads
nothing still gets a row, marked "No post — pastor by title".

## Member photos

**Add member** (or Edit) has a photo at the top of the form — **Add photo**,
pick a JPG, PNG or WebP up to 6 MB. It then shows in the directory, the Pastors
tab, the detail view and the full profile. Members without one show their
initials, which is the normal case rather than a fallback.

The file is copied into the app's own storage, so moving or deleting the original
does not break it. Only the filename is stored, not a full path — an absolute
path breaks when records are restored on another machine.

### Adding a pastor

1. **Members → Add member** (or edit an existing one)
2. Set **Title** to "Pastor", "Associate Pastor" or whatever they are called
3. Save — they now appear under Pastors & leaders

To put one of them *over* a branch, department or group, use **Appoint a leader**
on that tab. That is a separate step, because most pastors lead no unit.

The list is derived from the branches, departments and groups themselves, not
stored separately — so it can never disagree with them. "Appoint a leader" writes
to whichever record owns the post, and a leader must belong to that branch, which
the repository enforces rather than the form.

There is no delete on this tab. A post is vacated by reassigning it from the
branch, department or group that owns it; a delete button here would look like it
removes the person.

## Clickable stat cards

Some cards are tinted and open the screen behind the number — Active members
goes to the directory, Last Sunday to attendance, Departments to departments.
Colour and clickability are the same decision: a tinted card is the signal that
it does something, so a card pointing at a switched-off module, or one your role
cannot open, stays plain and inert rather than looking pressable and bouncing off
a redirect.

Not every card is coloured. Six identically-washed tiles are just louder, not
clearer, so colour marks the ones worth leading with.

## Editing a branch

The Edit action on a branch row opens the full record — name, short code,
address, city, region, status, colour, founding date, phone, email and website.
Leadership is set separately, from the same row's detail view, because a pastor
must be a member of that branch and the two forms answer different questions.

A branch's colour shows up as its code badge and a stripe down its row, so a long
list is scannable by campus. Phone, email, website and address are links: they
open the dialler, mail client, browser or a map. An address with no coordinates
still works — it becomes a maps search.

## Your own logo and sign-in background

**Settings → Branding** replaces the sidebar logo and the sign-in background.
The chosen file is copied into the app's own storage, so moving or deleting the
original does not break it.

## Who can see what

Only **Super Admin** sees other branches. Everyone else — including Senior
Pastor and HQ Finance — is confined to their own branch, and the app behaves for
them as though their branch is the whole church: no Branches screen, no branch
switcher, no cross-branch totals.

Cross-branch sight is a **permission granted per account**, not a fixed property
of the role. A Super Admin can grant it to any branch-level account from
Roles & Access (the globe button on each row) and revoke it again. Department
heads and volunteers can never receive it.

## Signing in

First run:

| | |
|---|---|
| Username | `admin` |
| Password | `church2026` |

If you installed an earlier version, your existing accounts are migrated
automatically the first time you open this one: the part of your old email
address before the `@` becomes your username, and your password is unchanged.
So `grace@kgc.org` signs in as `grace`.

Sign-in uses a **username**, not an email address — a church office is not a
place where everyone has a work email, and requiring one shuts out the people
most likely to be using this. Members do not need an email address either; the
field is optional on the member form.

**Change that password once you are in.** It is published in this repository, so
it protects nothing. Click your name at the bottom of the sidebar →
**Change password**. It asks for the current one, so nobody at an unlocked
machine can lock you out of your own account.

If someone forgets theirs, a Super Admin resets it from **Roles & Access** — open
the user and choose **Reset password**. There is no email server to send a link
to, so you set a new one and tell them what it is.

Then, in order:

1. **Settings** — your church's address, phone and pastor, and rename the
   headquarters branch if you want something other than
   "Kingdom Grace Chapel Headquarters".
2. **Branches** — add your other campuses.
3. **Members** — add people. Every member belongs to one branch.
4. **Departments** — start Youth, Children and the rest at each branch, drawing
   members from that branch's roll.
5. **Roles & Access** — create accounts for your pastors and administrators.


## Install it

```bash
flutter build linux --release
./packaging/build-installer.sh
./dist/Install-Church-Management.run
```

That installs and opens it, with no password needed, and it appears in your
applications menu as **Church Management**.

To remove it, search the menu for **"Uninstall Church Management"** — your
records are kept, so reinstalling resumes where you left off. GNOME will not run a `.desktop`
launcher from a normal folder, so there is no file to double-click — see
[packaging/README.md](packaging/README.md) if you want a clickable menu entry.

To share with other Linux machines, `./packaging/build-deb.sh` produces a
~10 MB `.deb` that installs with `sudo apt install ./church-management_*.deb`.

**Windows needs a Windows machine** — Flutter cannot cross-compile desktop
targets. Everything is prepared; run `packaging\build-windows.ps1` there, or
use the included GitHub Actions workflow to get a build without one.

Full detail, including backups and a caution about each install having its own
separate database: **[packaging/README.md](packaging/README.md)**.

## Getting started

```bash
flutter pub get
flutter run -d linux       # Linux desktop
flutter run -d windows     # Windows desktop
flutter run -d macos       # macOS desktop
```

**Desktop is the working target.** The web build does not currently start —
the local database needs browser features that a plain static server does not
provide. See ARCHITECTURE.md §"Why Flutter" for detail.

```bash
flutter analyze            # static analysis (currently clean)
flutter test               # data-integrity tests
flutter build web          # production web bundle
flutter build windows      # Windows executable (build on Windows)
```

Adding mobile later is one command:

```bash
flutter create --platforms=android,ios .
```

## The screens

| Route | What it does |
|---|---|
| `/dashboard` | Two tabs: **Dashboard** (KPIs, trends, activity, alerts) and **Reports** |
| `/branches` | Table of every campus; click a row for its details in a modal |
| `/departments` | Youth, Children and other departments, per branch |
| `/members` | Directory, plus a Pastors & leaders tab |
| `/members/:id` | Member profile: giving, serving, care and notes |
| `/attendance` | Service records, trends and member check-in |
| `/ministries` | Departments and small groups with leaders and capacity |
| `/events` | Calendar, registrations, weekly schedule, announcements |
| `/volunteers` | Serving rotas by Sunday and coverage by role *(hidden)* |
| `/finance` | Donations, expenses, pledges and fund analysis *(hidden)* |
| `/communication` | Email, SMS, WhatsApp and push campaigns *(hidden)* |
| `/care` | Pastoral care queue with priority and assignment *(hidden)* |
| `/discipleship` | Courses, enrolment and the growth pathway |
| `/assets` | Equipment register with condition and value *(hidden)* |
| `/access` | Users, roles and the module permission matrix |
| `/settings` | Four tabs: Church, Appearance, Preferences, Data |

## Multi-branch

The church is a network of campuses. Headquarters is itself a branch, every
member belongs to exactly one, and each branch runs its own departments (Youth,
Children and the rest) drawn from a shared church-wide catalogue — which is what
makes the same department comparable between campuses.

Access has two dimensions that always apply together: **what** you may do (the
permission matrix) and **whose data** you see (your scope — all branches, your
branch, your department, or just yourself). A Branch Pastor has full control of
their own branch and cannot see any other; a Super Admin sees everything.

## Try these

- Add a member, then close and reopen the app — they are still there
- Sign in as a Department Head and watch the sidebar shrink to what they may see
- Use the **branch switcher** in the top bar to focus one campus or view all
- Press <kbd>Ctrl</kbd>/<kbd>Cmd</kbd> + <kbd>K</kbd> for the command palette
- Toggle light/dark from the top right, or pick a mode in Settings
- Sort, filter and search any table; every row has **view, edit and delete**
- Open **Attendance → a service record** to see exactly who was checked in
- Open a member from the directory to see which services they attended
- Collapse the stats row at the top of any page to give the table more room
- Fold the sidebar's nav groups, or collapse the sidebar entirely
- Resize the window — the sidebar becomes an icon rail, then a drawer, and
  tables drop non-essential columns

## Making it yours

| What | Where |
|---|---|
| Church name, address, services, currency | `lib/config/app_config.dart` |
| Colours, spacing, radius, type | `lib/theme/app_theme.dart` |
| Navigation and screen list | `lib/config/navigation.dart` |
| Domain model | `lib/models/models.dart` |
| Ghana regions, phone format | `lib/config/ghana.dart` |
| Where the API will plug in | `lib/providers/repository.dart` |

## Project layout

```
lib/
├── main.dart         Entry point and router
├── config/           Church profile and navigation
├── models/           The domain contract
├── db/               SQLite schema, repository and first-run seeder
├── aggregates/       Pure functions over whatever the database returns
├── providers/        Riverpod providers — the data seam
├── screens/          One file per screen
├── shell/            Responsive navigation shell + command palette
├── theme/            Design tokens
├── utils/            Formatters
└── widgets/          The reusable widget library
```

Conventions and the reasoning behind them are in
[ARCHITECTURE.md](ARCHITECTURE.md).
