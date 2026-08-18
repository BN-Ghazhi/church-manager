# Installing and sharing

Three separate things: installing on this machine, sharing with other Linux
machines, and building for Windows.

---

## 1. Install on this machine

```bash
flutter build linux --release      # if you have changed the code
./packaging/build-installer.sh
./dist/Install-Church-Management.run
```

That installs it and opens it. No password, no package manager.

### Why there is no clickable installer file

Modern GNOME (this machine runs Shell 50) **refuses to execute `.desktop` files
from ordinary folders**, and the old `metadata::trusted` flag that used to permit
it no longer exists. A launcher placed in `dist/` therefore opens in a text
editor — VS Code, here — instead of running.

`.deb` files fare no better: they are registered to snap-store, which cannot
install them.

So the terminal command above is the honest one-step route. If you would rather
click, register the installer into the applications menu first, which *is* a
location GNOME trusts:

```bash
./dist/register-installer.sh
```

Then search your applications menu for **"Install Church Management"** and click
it. That only needs doing once; afterwards it behaves like any other app.

It then appears in the applications menu as **Church Management**, and as
`churchms` in a terminal.

| What | Where |
|---|---|
| Program files | `~/.local/lib/org.gracechapel.churchms/` |
| **Your data** | `~/.local/share/org.gracechapel.churchms/church_management.sqlite` |
| Menu entry | `~/.local/share/applications/org.gracechapel.churchms.desktop` |

Program files and data are in **separate** directories deliberately, so
reinstalling or upgrading never touches the church's records.

To remove:

```bash
./packaging/uninstall-linux.sh            # keeps the database
./packaging/uninstall-linux.sh --purge    # deletes it too
```

---

## 2. Share with other Linux machines

```bash
./packaging/build-deb.sh
```

Produces `dist/church-management_1.0.0_amd64.deb` (~10 MB). Send that one file
to any Debian or Ubuntu machine:

```bash
sudo apt install ./church-management_1.0.0_amd64.deb
```

It installs to `/opt/org.gracechapel.churchms`, adds the menu entry, and pulls
in the GTK and SQLite libraries it needs. Remove it with
`sudo apt remove church-management`.

**Double-clicking a `.deb` does not reliably work.** On Ubuntu with GNOME it
often opens in snap-store, which cannot install `.deb` packages, so the window
appears to do nothing. Either use the `apt install` command above, or install
`gdebi` (`sudo apt install gdebi`) to get a working graphical installer. For
click-to-install without any of that, use the self-extracting installer from
section 1 — it needs no root and no package manager.

Each machine gets its **own separate database**. Nothing is shared between
installs — see "A caution about sharing" below.

### Other Linux distributions

The `.deb` only covers Debian/Ubuntu and derivatives (Mint, Pop!_OS, Zorin).
For Fedora or Arch, either build from source on that machine or copy
`build/linux/x64/release/bundle/` across and run `churchms` from it — the
bundle is self-contained apart from GTK 3, which those systems already have.

---

## 3. Windows

**A Windows `.exe` cannot be built from Linux.** Flutter has no
cross-compilation for desktop targets: Windows binaries must be produced on
Windows. That is a Flutter limitation, not a missing step here.

Everything needed is already prepared — the `windows/` target is configured and
the app metadata is set. On a Windows machine:

**Install once:**
1. [Flutter SDK](https://docs.flutter.dev/get-started/install/windows)
2. [Visual Studio 2022](https://visualstudio.microsoft.com/downloads/) with the
   **"Desktop development with C++"** workload — the Community edition is free
3. Optional: [Inno Setup 6](https://jrsoftware.org/isdl.php), for a single-file
   installer

**Then, from the project folder:**

```powershell
powershell -ExecutionPolicy Bypass -File packaging\build-windows.ps1
```

That builds `build\windows\x64\runner\Release\churchms.exe` and, if Inno Setup
is present, `dist\church-management-1.0.0-setup.exe` — one file you can send to
anyone.

Without Inno Setup, zip the whole `Release` folder. **The `.exe` will not run on
its own** — it needs the DLLs and `data\` folder beside it.

On Windows the database lives in `%APPDATA%\org.gracechapel.churchms\`, and the
uninstaller deliberately leaves it alone.

### If you have no Windows machine

Use a free CI runner. GitHub Actions gives Windows builders at no cost for
public repositories:

```yaml
# .github/workflows/windows.yml
name: Windows build
on: [push, workflow_dispatch]
jobs:
  build:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: { channel: stable }
      - run: flutter pub get
      - run: dart run build_runner build
      - run: flutter build windows --release
      - uses: actions/upload-artifact@v4
        with:
          name: church-management-windows
          path: build/windows/x64/runner/Release/
```

Push, and download the built app from the workflow's artifacts.

---

## A caution about sharing

Every install has its **own private database**. Two people running the app on
two machines are keeping two unrelated sets of records — adding a member on one
will never appear on the other.

That is the correct behaviour for an offline desktop app, and fine for a single
church office computer. It is **not** what you want if several people across
branches need to work from the same data. That needs a shared server, which is
a real piece of work and is the first item under "Optional sync" in
[ARCHITECTURE.md](../ARCHITECTURE.md).

Until then, treat one machine as the authoritative copy.

## Back up the database

One file holds everything, so copy it somewhere safe on a schedule:

```bash
cp ~/.local/share/org.gracechapel.churchms/church_management.sqlite \
   ~/Backups/church-$(date +%F).sqlite
```

Close the app first, or the copy may catch a partial write.
