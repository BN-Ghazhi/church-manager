# Putting the data on a Windows server

How to run the church's data on a Windows 10 laptop you own, with the desktop
consoles and (later) mobile apps reading from it over the internet.

Decisions already taken: a **Dart API server** reusing this app's own code, **not
Tailscale**, branches in **other towns**, and **offline writes that sync when the
server returns**.

**Docker and Postgres were dropped** after sizing the workload — see
`SERVER-SETUP.md` §"Do we need Docker?". Five branches over ten years comes to
~1.8M rows and ~344 MB, comfortably inside SQLite, whose only real limit is one
writer at a time and that is ~10–20 concurrent writers away. The server is a
single self-contained `.exe` plus one database file, run as a Windows service.
Same engine the app already uses, so the schema, migrations and 189 tests carry
over.

---

> **Setting it up?** `SERVER-SETUP.md` is the step-by-step guide for the Windows
> laptop, starting with a one-evening connectivity test. This document is the
> architecture and the reasoning behind it.

## 1. The network constraint, measured

Tested from the developer's connection (MTN/Scancom, Accra):

```
public IP seen by the internet   154.161.13.229   ... then 154.161.50.93
this machine                     192.168.0.204
router                           192.168.0.1

tracepath 8.8.8.8
  hop 1   192.168.0.1        the router
  hop 2   10.36.201.19       PRIVATE - inside MTN's network
  hop 4   10.188.5.1         PRIVATE
```

Two facts, both confirmed:

1. **Behind CGNAT.** The hops past the router are private addresses belonging to
   MTN, so the public IP is MTN's and shared. **Port forwarding cannot work** —
   there is no port on a public IP that is yours.
2. **The IP is dynamic.** It changed from `154.161.13.229` to `154.161.50.93`
   during a single session.

Consequences:

| Approach | Works? | Why |
|---|---|---|
| Port forwarding on the router | **No** | The public IP is not on your router |
| DuckDNS / No-IP dynamic DNS | **No** | Maps a name to an IP that isn't yours |
| Static IP from MTN | Maybe | Usually a business-tier add-on; worth pricing |
| **Outbound tunnel** | **Yes** | Dials out, so no inbound port is needed |

Outbound is unrestricted (all reachable, latency 29 ms, 0% loss), so a tunnel is
the route in.

### Tunnel options that need no domain purchase

| Service | Address | Stable? |
|---|---|---|
| **ngrok free** | `yourname.ngrok-free.app` | **Yes** — free tier includes one static domain |
| Cloudflare Tunnel | `data.yourchurch.org` | Yes, but needs a domain (~$10/yr) |
| Cloudflare quick tunnel | `random.trycloudflare.com` | No — new URL every restart |
| localhost.run / pinggy | random | No |
| ZeroTier | `10.x.x.x` private IP | Yes, but installs on every client device |

**Recommended: ngrok's free static domain.** One permanent HTTPS address, no
domain to buy, runs as a Windows service so it survives reboots. Its free tier
has a bandwidth cap and shows a one-time browser warning page — irrelevant for
an app calling an API. Move to Cloudflare Tunnel with a real domain when the
church can spend $10/year.

---

## 2. Why a Dart server, and the part that is already proven

The server reuses this app's own code rather than reimplementing it. That claim
was tested, not assumed: the domain layer was copied into a bare Dart package
with **no Flutter dependency**, and it both analysed and ran clean.

```
$ dart analyze          # models, permissions, ghana, password
No issues found!

$ dart run bin/probe.dart
hash length: 44
verify correct:   true
verify wrong:     false
branchPastor/Attendance: full
member/Attendance:       none
modules in matrix: 14
```

`lib/models/models.dart` needs exactly one change — `package:flutter/foundation.dart`
becomes `package:meta/meta.dart` — because its only Flutter use is `@immutable`,
27 times. Nothing else.

What that buys:

| Shared verbatim | Why it matters |
|---|---|
| `lib/models/models.dart` | Request/response types, enum names, `Member.ageAt`, `StaffUser.canSeeAllBranches` |
| `lib/config/permissions.dart` | The authorization matrix, one copy, no drift |
| `lib/db/password.dart` | **Identical PBKDF2, so existing passwords keep working** |
| `lib/config/ghana.dart` | Regions, phone formatting |

That last row is the reason not to write the server in another language: any
other stack means re-implementing PBKDF2 byte-for-byte or forcing every account
to reset its password.

---

## 3. Shape of the thing

```
church management/
  lib/                        the Flutter client, structure unchanged
  packages/churchms_core/     plain Dart: models, permissions, password, rules
  server/                     shelf API + Drift/SQLite, depends on churchms_core
```

Deployed as one native binary, built with `dart compile exe`, needing nothing
installed beside it:

```
C:\ChurchServer\
  church-server.exe
  church.sqlite
  server.log
```

Registered as a Windows service (`sc create ... start= auto`, with
`sc failure ... actions= restart/5000`) so it starts at boot and restarts on
crash without anyone logging in. ngrok the same. That is what brings the church
back online without you after a power cut — the thing `restart: unless-stopped`
was there for, minus two gigabytes of Docker.

---

## 4. Offline writes and sync

The requirement: when the server is unreachable, the app keeps accepting data and
sends it when the connection returns. That is the right call for branches in
other towns with dumsor and patchy internet — a Sunday service cannot wait for a
laptop in Accra — but it is also **the single largest piece of work here**, and it
changes what has to be built before anything else.

### What the schema already gives us

Better than expected. 18 of the 21 tables carry `createdAt`, `updatedAt` and
`deletedAt` through the `_Timestamps` mixin, and deletes are already soft (10
`deletedAt` writes). That is most of what sync needs: a per-row watermark to ask
"what changed since?", and deletions that survive as facts rather than absences.

### The blocking problem: ids collide offline

`_nextId` (`lib/db/repository.dart:20`) picks the next id by reading the highest
existing one and adding 1. Offline, on two machines, that produces the same id.
Demonstrated with two separate databases standing in for two branch laptops:

```
Kumasi created: mem-0001
Tema created:   mem-0001
COLLISION: true
```

On sync one of those two members silently overwrites the other. A real person
disappears from the register, with no error anywhere. **Offline sync cannot be
built on top of this**, so ids must become globally unique first — UUIDv7 or
ULID, keeping the readable `mem-` prefix so seeded and imported data stay
distinguishable.

It is 16 call sites, all inside the repository, and only a handful of places pin
the format (`test/widget_test.dart`, `test/migration_test.dart`,
`lib/db/seeder.dart`). Cheap now with 2 members of real data; a foreign-key
rewrite across 21 tables later.

### Three tables cannot sync as they stand

`DepartmentMembers`, `CheckIns` and `Settings` have no timestamps and are written
by **hard delete then re-insert**:

```dart
// setDepartmentMembers - lib/db/repository.dart:681
await (db.delete(db.departmentMembers)
      ..where((t) => t.departmentId.equals(departmentId))).go();
await db.batch((b) { b.insertAll(...); });
```

Locally that is fine. Across two machines it is a lost-update: whichever side
syncs second replaces the whole membership list, discarding the other's edits
with no conflict reported. These need row-level identity, timestamps and soft
deletes before they can travel.

### Conflict policy

Needed per table, and it must be written down rather than emerge by accident:

| Kind of data | Rule | Why |
|---|---|---|
| Attendance, giving, expenses | **Both survive** — they are events, not states | Two branches recording different services must never overwrite each other |
| Member details, branch details | **Last write wins** on `updatedAt` | Two people editing one phone number: the later edit is the intended one |
| Department membership, check-ins | **Merge by row**, not by list | The delete-and-replace pattern above is exactly what loses data |
| Settings, permissions | **Server wins** | One church-wide truth; a stale offline client should not reimpose old settings |

### What gets built

```
lib/sync/
  outbox.dart       queued local writes, with retry and ordering
  replicator.dart   pull changes since a per-table watermark
  conflicts.dart    the table above, in code
  connectivity.dart online / offline / syncing, surfaced in the UI
```

Plus an honest UI state: a persistent indicator showing "3 changes waiting to
sync", because silently queueing writes and hoping is how a church discovers in
March that February never uploaded.

---

## 5. The client keeps its shape

The measurement that drives this: screens read **synchronous `List<T>`**, and
there are **268 provider reads across 28 files**. Converting them to `AsyncValue`
would touch 25–35 files for no visible gain.

So the local Drift database **stays**, as a read cache filled from the server.
Drift's `.watch()` fires when the cache updates, every `StreamProvider` emits,
every screen refreshes — exactly as now. `lib/providers/repository.dart` changes
by close to nothing, which is what `ARCHITECTURE.md` §2.1 calls the codebase's
most valuable property.

It also means the app still **opens and shows existing data** when the server is
unreachable, which matters given power cuts — and with the outbox from §4, new
records can still be entered and are sent when the connection returns.

New client code:

```
lib/api/       client.dart, endpoints.dart, exceptions.dart
lib/sync/      replicator.dart, connectivity.dart
```

`ChurchRepository` keeps its exact public signature: its 21 `watch*` methods still
read local Drift; its ~44 write methods POST/PATCH/DELETE and then apply the
server's canonical row to the cache. **That is why the 42 UI write call sites
across 15 files need no changes.**

---

## 6. Security — the real cost

`lib/providers/permissions.dart` says it already:

> "This is a UI convenience, not a security boundary. When the backend lands,
> every one of these checks must be repeated server-side."

Today the client downloads every branch's rows and filters in Dart. On a server
the allowed branch set must be **derived from the token**, never from anything the
client sends. A request for a branch the token does not cover gets a 403, not a
quietly narrowed result.

Also required:

- **Real tokens.** `sessionProvider` is currently an in-memory `StaffUser?` with
  no token and no expiry. Needs JWT access tokens (~15 min) plus rotating refresh
  tokens, and revocation when a role or password changes.
- **The 14 repository rules** move server-side (branch membership for leaders,
  department age ranges, HQ undeletable, civil titles, username uniqueness…).
  They currently **fail silently** — 7 bare `return;` guards and zero `throw`s —
  which over a network becomes "a write that reported success and did nothing".
  They must become 4xx responses the forms can show.
- **Two gaps that exist today**, worth fixing whenever this is built:
  `setBranchVisibility` checks the *target's* role but not the *caller's*, so
  only-Super-Admin-may-grant is not actually enforced; and nobody-edits-their-own-role
  is enforced in the UI only.
- **Rate limiting** on sign-in, **audit log** for financial tables, **HTTPS only**,
  **photo endpoints behind the same branch check** (an open bucket leaks the whole
  congregation's photos).
- **Backups with a rehearsed restore.** There is no backup feature today, and one
  laptop would now hold every branch's records.

---

## 7. What must change first

Cheap now, expensive later, and useful regardless of when the server happens.

**Ids must become globally unique.** Demonstrated in §4: two offline machines
both produce `mem-0001`, and syncing loses one of the two members silently. This
is a prerequisite for offline sync, not a nice-to-have. It is also wrong at scale
independently: string ordering means `mem-9999` → `mem-10000` sorts *below*
`mem-9999`, so the counter silently resets at 10,000 rows.

**Three tables need sync metadata.** `DepartmentMembers`, `CheckIns` and
`Settings` have no timestamps and are written by hard-delete-then-reinsert (§4).
As they stand, a second machine's edits are discarded on sync with no conflict
reported.

**Brand images store absolute paths.** `lib/providers/branding.dart:85` saves
`target.path` into the settings table. Once settings come from a server that path
names one machine's disk. Member photos use bare filenames and are fine.

---

## 8. Phases, each ending in something testable

| Phase | What | Weeks |
|---|---|---|
| 0 | Prove the tunnel from the Windows laptop reaches a phone on mobile data; server and tunnel both restart after a forced power cut | 0.5 |
| 1 | **UUID ids**, plus timestamps and soft deletes on the three tables that lack them. Nothing else can be built on the current ids | 1 |
| 2 | Extract `packages/churchms_core/`. **189 tests must still pass** | 1 |
| 3 | API + auth + **read** endpoints with server-side branch scoping | 2 |
| 4 | **Milestone:** two machines, correctly scoped live data from the laptop, over the internet | 2 |
| 5 | Writes, the 14 rules, real 4xx surfaced in forms | 3 |
| 6 | **Offline outbox and sync**, with the conflict policy from §4 and a visible pending-changes indicator | 3–4 |
| 7 | Photo upload with authorization; backups with a *tested* restore; audit log; rate limiting | 2 |

**15–20 weeks part-time**, up from 11–16 because offline sync is genuinely large.
Phase 4 is the deliberate go/no-go: by then the real latency over your own
connection is known, and the decision to continue is informed.

Phase 1 is worth doing **whether or not the rest happens** — the id collision is
a latent bug in the app today, and it gets more expensive with every member
added.

Mobile is unblocked after phase 4 — same API, `flutter create --platforms=android,ios .`

---

## 9. The risk that is not code

The server is a laptop in Accra, and the branches are in **other towns**. Offline
sync (§4) means an outage no longer stops a branch recording a service — which is
exactly why it is worth the extra weeks. What an outage still costs:

- nobody sees anyone else's data until the server returns
- the longer it is down, the more conflicts accumulate to resolve
- a branch cannot sign in for the first time, or on a new machine, while it is down

And these still take the server down, in a town where nobody can walk over and
check the machine:

- power cut (dumsor) at that location
- MTN outage
- the lid closed, or the laptop taken out
- the server or the tunnel service not restarting after a reboot

Mitigations: a UPS, mobile-data failover, `restart: unless-stopped` on every
container, the tunnel as a Windows service, and disabling suspend-on-lid-close.

**The branches are in other towns.** That rules out the otherwise-attractive
option of keeping the server on the church LAN: a laptop on a switch in Accra is
unreachable from Kumasi or Tema, so the tunnel is not optional — it is the whole
mechanism. It also means every branch's Sunday depends on one building's power
and one ISP connection.

Which leaves one honest alternative:

- **A small VPS (~$5–6/month).** Hetzner, DigitalOcean, or a Ghanaian host. It
  removes power cuts, home-internet outages, CGNAT and the dynamic IP in one go,
  and gives a real static address with proper HTTPS. It is not "a laptop I own"
  and it costs money — but with branches spread across towns, the laptop is a
  single point of failure for the whole church, sitting in the one place nobody
  using it can see.

  Cost comparison over a year: a VPS is roughly GH₵900–1,100. A UPS large enough
  to keep a laptop, router and modem running through a long outage is comparable,
  and does nothing about an ISP failure.

If the laptop is the decision, put it wherever the internet is most reliable —
not necessarily the church, and not necessarily a home — and treat the UPS and a
mobile-data failover as part of the build, not extras.
