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

## Step 2: Install Docker Desktop

1. Download from **docker.com/products/docker-desktop**
2. Run the installer, leave **"Use WSL 2"** ticked
3. Restart when asked

If it complains about virtualisation: restart, enter the BIOS (usually F2, F10 or
Del at startup), enable **Intel VT-x** or **AMD-V**, save and exit.

Check it works — Command Prompt:

```
docker --version
docker run hello-world
```

The second prints a paragraph beginning "Hello from Docker!". If both work, Docker
is fine.

## Step 3: Run a test web page

Still in Command Prompt:

```
docker run -d -p 8080:80 --name webtest nginx
```

Open **http://localhost:8080** in the browser. You should see "Welcome to nginx!".

That is a web server running on the laptop. Right now only that laptop can see
it — the next step is what changes that.

## Step 4: Install the tunnel

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

## Step 5: Expose the test page

```
ngrok http --url=kgc-church.ngrok-free.app 8080
```

Leave that window open. Then **on your phone, using mobile data, not the church
wifi**, open:

```
https://kgc-church.ngrok-free.app
```

If you see "Welcome to nginx!" — **that is the whole problem solved.** A service
on the laptop is reachable from the internet, through CGNAT, with HTTPS, without
touching the router.

> ngrok's free tier shows a one-time warning page in a browser. Click through it.
> The apps will not see it — it only affects browsers.

## Step 6: Tidy up

```
docker stop webtest
docker rm webtest
```

Stop ngrok with `Ctrl+C`.

**Report back at this point.** If step 5 worked, the rest is software and I will
write it. If it did not, tell me what happened — that changes the approach and it
is much better to know now.

---

# Part 2 — The real server (after Part 1 works)

Sketched so you can see where this goes. I write the code; you run it.

## What will run on the laptop

```
docker compose up -d
```

Two containers:

| Container | What it does |
|---|---|
| `db` | Postgres, holding the church's data. **Not exposed to the internet.** |
| `api` | The Dart API. The only thing the tunnel points at. |

Both get `restart: unless-stopped`, so they come back by themselves after a power
cut or a reboot. That matters more than it sounds — it is what stops "the server
is down" becoming a phone call to you every time the power blinks.

## What the console apps will do

Each branch's app gets the tunnel address in its settings, signs in with its own
username, and receives only that branch's data — enforced by the API, not by the
app. Records entered while the internet is down are kept and sent when it returns
(see `SERVER.md` §4).

## Still to be built

In order:

1. **Unique ids** — two offline machines currently generate the same id, so one
   member would silently overwrite another. Must be fixed first.
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
