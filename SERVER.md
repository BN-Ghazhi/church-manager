# Putting the data on a Windows server

How to run the church's data on a Windows 10 laptop you own, with the desktop
consoles and (later) mobile apps reading from it over the internet.

Decisions already taken: **Docker on the Windows laptop**, a **Dart API server**
reusing this app's own code, and **not Tailscale**.

---

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
  server/                     shelf API + Postgres, depends on churchms_core
  deploy/
    docker-compose.yml        Postgres + the API, one command to start
    .env.example              secrets, never committed
```

Docker Desktop on Windows 10 requires **WSL2** and virtualisation enabled in the
BIOS. Two containers:

```yaml
# deploy/docker-compose.yml  (sketch)
services:
  db:
    image: postgres:16
    restart: unless-stopped          # comes back after a power cut
    environment:
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - churchdata:/var/lib/postgresql/data

  api:
    build: ../server
    restart: unless-stopped
    ports: ["8080:8080"]
    depends_on: [db]
    environment:
      DATABASE_URL: postgres://postgres:${DB_PASSWORD}@db:5432/church
      JWT_SECRET: ${JWT_SECRET}

volumes:
  churchdata:
```

`restart: unless-stopped` matters more than it looks: it is what brings the
church back online without you after a reboot or an outage.

---

## 4. The client keeps its shape

The measurement that drives this: screens read **synchronous `List<T>`**, and
there are **268 provider reads across 28 files**. Converting them to `AsyncValue`
would touch 25–35 files for no visible gain.

So the local Drift database **stays**, as a read cache filled from the server.
Drift's `.watch()` fires when the cache updates, every `StreamProvider` emits,
every screen refreshes — exactly as now. `lib/providers/repository.dart` changes
by close to nothing, which is what `ARCHITECTURE.md` §2.1 calls the codebase's
most valuable property.

It also means the app still **opens and shows existing data** when the server is
unreachable, which matters given power cuts. Only new writes are blocked.

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

## 5. Security — the real cost

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

## 6. Two changes worth making before any of this

Cheap now, expensive later, and useful regardless of when the server happens.

**Ids are not safe for two writers.** `_nextId` (`lib/db/repository.dart:20`)
does `SELECT id ... ORDER BY id DESC LIMIT 1` then adds one. Two clients creating
a member at the same moment compute the same id and the second insert fails —
precisely the scenario a server enables. It is also wrong at scale: string
ordering means `mem-9999` → `mem-10000` sorts *below* `mem-9999`, so the counter
silently resets. 16 call sites. Migrating 2 members is trivial; migrating 2,000
across 21 tables with foreign keys is not.

**Brand images store absolute paths.** `lib/providers/branding.dart:85` saves
`target.path` into the settings table. Once settings come from a server that path
names one machine's disk. Member photos use bare filenames and are fine.

---

## 7. Phases, each ending in something testable

| Phase | What | Weeks |
|---|---|---|
| 0 | Prove the tunnel from the Windows laptop; Docker Desktop + WSL2 running; both restart after a forced power cut | 0.5–1 |
| 1 | Extract `packages/churchms_core/`. **189 tests must still pass** | 1 |
| 2 | Postgres + API + migration script + auth + **read** endpoints with server-side branch scoping | 2 |
| 3 | **Milestone:** two machines, correctly scoped live data from the laptop, over the internet | 2 |
| 4 | Writes, the 14 rules, real 4xx surfaced in forms | 3 |
| 5 | Live push, photo upload with authorization | 2 |
| 6 | Backups with a tested restore, audit log, rate limiting | 1–2 |

**11–16 weeks part-time.** Phase 3 is the deliberate go/no-go: by then the real
latency over your own connection is known.

Mobile is unblocked after phase 4 — same API, `flutter create --platforms=android,ios .`

---

## 8. The risk that is not code

The server is a laptop in Accra. In an online-only design its uptime becomes
every branch's uptime, and each of these independently stops the church recording
a Sunday service:

- power cut (dumsor) at that location
- MTN outage
- the lid closed, or the laptop taken out
- Docker or the tunnel not restarting after a reboot

Mitigations: a UPS, mobile-data failover, `restart: unless-stopped` on every
container, the tunnel as a Windows service, and disabling suspend-on-lid-close.

Two alternatives worth weighing honestly:

- **Put the laptop in the church, on the church LAN.** Sunday then depends on a
  switch and a UPS in the same room as the people using it. CGNAT, home internet
  and home power all stop mattering. Remote access can be added afterwards.
- **A small VPS (~$5–6/month).** Removes power, connectivity and uptime risk
  entirely and gives a static IP. It costs money and is not "a laptop I own", but
  it dissolves most of this section.
