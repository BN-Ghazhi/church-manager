# Server setup — step by step

For the **Windows 10 laptop** that will hold the church's data and serve it to the
console apps in other towns.

Work through Part 1 first. It proves the hard part — getting anything at all
reachable from the internet — before any app code exists. If it fails, you have
spent an evening, not a month.

---

## First: why not just expose MySQL directly?

A reasonable question, and the answer is two separate blockers.

**1. There is no IP to expose.** Measured on the MTN connection:

```
public IP seen by the internet   154.161.50.93
this machine                     192.168.0.204
hop past your router             10.36.201.19   <- private, inside MTN
```

The public address belongs to MTN and is shared with other customers. Your router
does not hold it, so there is no port on it to forward. This is CGNAT, and it is
true whatever you install — MySQL, Postgres, anything.

**2. A database on the internet has no permission rules.** If the app talks
straight to MySQL, the app must contain the database password — and anyone who has
the installer has that password. With it they can run any query they like, not
just the ones the app offers:

```sql
SELECT * FROM donations;             -- every gift, every branch
SELECT username, password_hash ...;  -- every account
UPDATE user_accounts SET role = 'superAdmin' WHERE id = 'theirs';
DROP TABLE members;
```

This app's permission rules live in Dart, on the client. `lib/providers/permissions.dart`
says so in its own header: *"This is a UI convenience, not a security boundary."*
A database port on the internet has nothing standing in front of it.

**So: an API in front of the database.** The API holds the password, checks who is
asking, and only ever answers questions that account is allowed to ask. The
database itself never faces the internet.

```
  console app  ──HTTPS──>  API  ──localhost──>  database
                            │
                    checks the token,
                    filters to your branch
```

---

# Part 1 — Prove connectivity (do this first)

About an evening. Nothing here touches the church's data.

## Step 1: Check what that laptop's connection gives you

On the Windows laptop, open **Command Prompt** and run:

```
curl https://api.ipify.org
ipconfig
```

Compare the address `curl` prints with the **Default Gateway** under `ipconfig`,
then open the gateway address in a browser (usually `192.168.0.1`) and find its
**WAN** or **Internet** IP.

- If the router's WAN IP **matches** what `curl` printed → you have a real public
  IP. Port forwarding is possible, though a tunnel is still simpler and safer.
- If they **differ**, or the WAN IP starts `100.64.`–`100.127.`, `10.`, or
  `192.168.` → **CGNAT**. Port forwarding cannot work. Use the tunnel.

On the connection I measured, it is CGNAT. Expect the same if the laptop is on
the same router.

## Step 2: Run a test web page

**No Docker needed** — see "Do we need Docker?" below. Windows 10 ships with
PowerShell, which can serve a page for this test.

Open **PowerShell** (not Command Prompt) and paste this in one go:

```powershell
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://localhost:8080/')
$listener.Start()
Write-Host 'Test server running on http://localhost:8080 - Ctrl+C to stop'
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $html = [Text.Encoding]::UTF8.GetBytes('<h1>Church server test - it works</h1>')
  $ctx.Response.ContentType = 'text/html'
  $ctx.Response.OutputStream.Write($html, 0, $html.Length)
  $ctx.Response.Close()
}
```

Open **http://localhost:8080** in the browser. You should see
"Church server test - it works".

Leave that PowerShell window running. Right now only this laptop can see it — the
next step changes that.

## Step 3: Install the tunnel

We use **ngrok** because its free tier includes one permanent address, and it
needs no domain purchase.

1. Sign up at **ngrok.com** (free)
2. Dashboard → **Setup & Installation** → download for Windows
3. Unzip `ngrok.exe` somewhere sensible, e.g. `C:\ngrok\`
4. Dashboard → **Your Authtoken** → copy it
5. In Command Prompt:

```
cd C:\ngrok
ngrok config add-authtoken PASTE_YOUR_TOKEN_HERE
```

6. Dashboard → **Domains** → **Create Domain**. You get something like
   `kgc-church.ngrok-free.app`. **Write it down** — this is the address the apps
   will use, and it does not change.

## Step 4: Expose the test page

```
ngrok http --url=kgc-church.ngrok-free.app 8080
```

Leave that window open. Then **on your phone, using mobile data, not the church
wifi**, open:

```
https://kgc-church.ngrok-free.app
```

If you see "Church server test - it works" — **that is the whole problem
solved.** A service on the laptop is reachable from the internet, through CGNAT,
with HTTPS, without touching the router.

> ngrok's free tier shows a one-time warning page in a browser. Click through it.
> The apps will not see it — it only affects browsers.

## Step 5: Tidy up

Press `Ctrl+C` in both windows — the PowerShell test server and ngrok.

**Report back at this point.** If step 4 worked, the rest is software and I will
write it. If it did not, tell me what happened — that changes the approach and it
is much better to know now.

---

# Part 2 — The real server (after Part 1 works)

Sketched so you can see where this goes. I write the code; you run it.

## What will run on the laptop

**One file. No Docker, no Postgres, no runtime to install.**

```
C:\ChurchServer\
  church-server.exe          the API - one self-contained binary
  church.sqlite              the data
  server.log
```

`dart compile exe` produces a native Windows executable with nothing to install
beside it — the same way `churchms.exe` needs no Dart on your machine today.

Installed as a **Windows Service** so it starts at boot and restarts if it
crashes, without anyone logging in:

```
sc create ChurchServer binPath= "C:\ChurchServer\church-server.exe" start= auto
sc failure ChurchServer reset= 0 actions= restart/5000
```

ngrok runs as a service the same way. Two services, both automatic, nothing to
remember after a power cut.

## Do we need Docker?

**No.** It was in the original plan because that is the conventional production
setup, but for this church it is cost without benefit:

| | Docker + Postgres | Single .exe + SQLite |
|---|---|---|
| To install | Docker Desktop, WSL2, BIOS virtualisation | nothing |
| Disk | ~2 GB before your data | ~15 MB |
| RAM idle | ~1–2 GB | ~30 MB |
| Things that can break | Docker, WSL2, 2 containers, volumes | one process |
| Backup | `pg_dump`, then copy | copy one file |
| Concurrent writers | thousands | ~10–20 |

The last row is the only one favouring Postgres, and it is far beyond this
church. Sized honestly for **five branches over ten years** — 2,000 members, three
services a week each, 150 check-ins per service:

```
attendance rows        7,800
check-in rows      1,170,000
giving rows          624,000
TOTAL              1,803,800 rows   ~344 MB
```

SQLite handles millions of rows and databases into the terabytes. Its real limit
is one writer at a time, and writes here are sub-millisecond — so roughly 10–20
simultaneous writers before it matters. A church with 5–10 staff accounts is two
orders of magnitude below that.

It is also the same engine the app already uses, so the schema, the migrations
and 189 tests carry over unchanged.

**When Postgres would be worth it:** dozens of branches writing at once, or
several churches on one server. Both are a long way off, and the API in front
means swapping the database later does not touch the apps.

## What the console apps will do

Each branch's app gets the tunnel address in its settings, signs in with its own
username, and receives only that branch's data — enforced by the API, not by the
app. Records entered while the internet is down are kept and sent when it returns
(see `SERVER.md` §4).

## Still to be built

In order:

1. **Unique ids** — two offline machines currently generate the same id, so one
   member would silently overwrite another. Demonstrated, and must be fixed
   first.
2. Shared core package, so the server reuses the app's models, permission rules
   and password hashing (proven to work — `SERVER.md` §2).
3. The API: sign-in with real tokens, then read endpoints, then writes.
4. Offline outbox and sync.
5. Backups with a restore you have actually performed.

`SERVER.md` has the full phasing and the honest estimate: 15–20 weeks part-time.

---

## Things worth knowing before you start

**Keep the laptop plugged in and stop it sleeping.** Settings → System → Power &
sleep → set both to **Never**. A closed lid or a sleeping laptop takes every
branch offline.

**Put it where the internet is most reliable.** Not automatically the church —
wherever the connection drops least.

**A UPS is part of the build, not an extra.** Dumsor at that one location stops
every branch from seeing data.

**The database will be the only copy.** Get backups working before real records
go in, not after.
