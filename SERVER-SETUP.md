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

## Step 1: Find out if you can be reached from the internet

**Everything in Part 1 happens on the Windows laptop** — the one that will be the
server. Not the machine the app was built on. Sit at that laptop now.

### 1a. Open the black command window

Press the **Windows key** on the keyboard. Type:

```
cmd
```

Press **Enter**. A black window opens with white text ending in `>`. This is
Command Prompt. Everything below gets typed into it.

> You can copy a command from here and paste it in: click inside the black
> window, then press **Ctrl+V** (or right-click, which also pastes).

### 1b. Run the test

Type this exactly, then press **Enter**:

```
tracert -h 4 8.8.8.8
```

It takes about 20 seconds. It is drawing the first four steps of the path from
this laptop out to the internet.

### 1c. Read the answer

You will see something like this:

```
Tracing route to dns.google [8.8.8.8]

  1     2 ms     1 ms     2 ms  192.168.0.1
  2     3 ms     2 ms     3 ms  10.92.181.66      <-- LOOK AT THIS LINE
  3     *        *         *     Request timed out.
  4    48 ms    50 ms    49 ms  41.x.x.x
```

**Look at line 2** (and line 3 if line 2 says "Request timed out").

Line 1 is always your own router — usually `192.168.something`. That is normal
and tells you nothing.

Now check what line 2 starts with:

| Line 2 starts with | Meaning |
|---|---|
| `10.` | **CGNAT** — use the tunnel |
| `100.64.` to `100.127.` | **CGNAT** — use the tunnel |
| `172.16.` to `172.31.` | **CGNAT** — use the tunnel |
| `192.168.` | **CGNAT** — use the tunnel |
| anything else (e.g. `41.`, `154.`, `196.`) | You may have a real public IP |

**Write down what line 2 says.** That single line decides everything.

### 1d. What it means

**If it was CGNAT** (the likely answer on MTN, Vodafone or AirtelTigo home
internet): your internet provider shares one public address between many
customers. There is no address that belongs only to you, so there is nothing to
"open a port" on. No router setting can change this — it is above your router.

This is not a problem. Continue to Step 2; the tunnel handles it.

**If line 2 was a public address**: you *might* be able to open a port on your
router instead. The tunnel is still simpler, safer and free, so continue to
Step 2 anyway — but tell me what you saw, because it opens up an option.

### 1e. Optional: a second confirmation

If you want to double-check, type:

```
curl https://api.ipify.org
```

That prints the address the internet sees you as, for example
`154.161.50.93`. Then type:

```
ipconfig
```

Look for **Default Gateway** — that is your router, e.g. `192.168.0.1`. Open
that number in a web browser, sign in to the router (the password is often on a
sticker underneath it), and find the page showing **WAN IP** or **Internet IP**.

If the router's WAN IP is *different* from what `curl` printed, that is CGNAT
confirmed. If they match, you have a real public IP.

You do not need this step — `tracert` already answered it. It is only here if you
want to see it twice.

## Step 2: Put a test page on the laptop

Nothing to install. Windows 10 can already do this.

### 2a. Open PowerShell

Press the **Windows key**. Type:

```
powershell
```

Press **Enter**. A **blue** window opens. (Step 1 used the black one; this step
needs the blue one — they understand different commands.)

### 2b. Start the test page

Copy the whole block below — all nine lines — and paste it into the blue window
(click inside it, then **Ctrl+V**), then press **Enter**:

```powershell
$l = New-Object System.Net.HttpListener
$l.Prefixes.Add('http://localhost:8080/')
$l.Start()
'Test page running. Leave this window open.'
while ($l.IsListening) {
  $c = $l.GetContext()
  $b = [Text.Encoding]::UTF8.GetBytes('<h1>Church server test - it works</h1>')
  $c.Response.OutputStream.Write($b, 0, $b.Length); $c.Response.Close()
}
```

It prints "Test page running" and then appears to hang. **That is correct** — it
is waiting for visitors. Leave this window open for the rest of Part 1.

### 2c. Check it

Open a web browser on that same laptop and go to:

```
http://localhost:8080
```

You should see **"Church server test - it works"**.

Only this laptop can see it so far. Step 3 fixes that.

> If nothing appears, the blue window will show an error. Send me what it says.

## Step 3: Get the tunnel

### 3a. Make a free account

In the browser, go to **https://ngrok.com** and click **Sign up**. It is free —
use Google sign-in if that is easier. No card needed.

### 3b. Download it

Once signed in you land on a **Setup & Installation** page. Choose **Windows**,
then click **Download**. You get a file like `ngrok-v3-stable-windows-amd64.zip`
in your Downloads folder.

### 3c. Unzip it to a simple place

1. Open **File Explorer** → **Downloads**
2. Right-click the ngrok zip → **Extract All...**
3. In the box, replace the path with exactly:

```
C:\ngrok
```

4. Click **Extract**

You should now have `C:\ngrok\ngrok.exe`. Check in File Explorer by typing
`C:\ngrok` into its address bar.

### 3d. Give ngrok your token

Back on the ngrok website, that same setup page shows a command containing your
personal token. It looks like:

```
ngrok config add-authtoken 2abcXYZ...longstring...
```

**Copy that whole line from the website.**

Now open a **new black Command Prompt** (Windows key → `cmd` → Enter) and type:

```
cd C:\ngrok
```

Press Enter. Then paste the line you copied from the website and press Enter.

It should reply `Authtoken saved to configuration file`.

### 3e. Claim your permanent address

On the ngrok website, in the left-hand menu click **Domains** (under
"Universal Gateway"), then **+ Create Domain** or **+ New Domain**.

The free plan gives you one. You will get something like:

```
kgc-church.ngrok-free.app
```

**Write this down.** It never changes, and it is the address every branch's app
will point at.

## Step 4: Open it to the internet

In the same black Command Prompt (still in `C:\ngrok`), type this — replacing the
address with **your** one from step 3e:

```
ngrok http --url=kgc-church.ngrok-free.app 8080
```

Press Enter. The window fills with a status display showing `Session Status
online` and your address.

**Leave this window open too.** You now have two windows running: the blue one
(the test page) and this black one (the tunnel).

### The moment of truth

Take your **phone**. Turn **wifi off** so it uses mobile data — this is important,
because you must come in from the internet, not from inside the house.

In the phone's browser, go to your address:

```
https://kgc-church.ngrok-free.app
```

If you see "Church server test - it works" — **that is the whole problem
solved.** A service on the laptop is reachable from the internet, through CGNAT,
with HTTPS, without touching the router.

> ngrok's free tier shows a one-time warning page in a browser. Click through it.
> The apps will not see it — it only affects browsers.

## If something goes wrong

| What you see | What it means | What to do |
|---|---|---|
| `'ngrok' is not recognized` | You are not in the right folder | Type `cd C:\ngrok` first, then the command again |
| `'tracert' is not recognized` | You are in PowerShell, not Command Prompt | Windows key → `cmd` → Enter, and try again |
| Blue window: `Access is denied` | Windows blocked the port | Close it, right-click **PowerShell** → **Run as administrator**, paste again |
| Browser on the laptop shows nothing at `localhost:8080` | The blue window is not running | Check it still says "Test page running" |
| Phone shows "tunnel not found" | ngrok is not running, or the address is mistyped | Check the black window still shows `Session Status online`; check spelling |
| Phone shows an ngrok warning page | Normal on the free plan | Click **Visit Site** — the apps never see this |
| Phone shows nothing at all | Phone may still be on wifi | Turn wifi off on the phone; you must arrive from the internet |
| `ERR_NGROK_...` with a number | ngrok has an explanation | Send me the error number |

## Step 5: Stop it for now

Click each window and press **Ctrl+C**, then close them. Nothing is left running,
and nothing has been installed except ngrok.

## Then tell me

Two things:

1. **What line 2 of `tracert` said** (step 1c) — the CGNAT answer
2. **Whether the page appeared on your phone** (step 4)

If yes to (2), the hard part is done and I will write the API. If no, tell me what
you saw instead — that changes the approach, and knowing now saves weeks.

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
