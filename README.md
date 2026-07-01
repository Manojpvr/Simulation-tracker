# Simulation Tracker

A lightweight browser-based app for tracking molecular dynamics simulations. Organize simulations into folders and subfolders, track status (Planned → Queued → Running → Finished / Failed), and duplicate runs as new realizations with automatic naming.

## Features

- **Folder tree** with unlimited nesting for organizing simulation campaigns
- **Status tracking** with kanban board and list views
- **Realization duplication** — duplicating `Kapitza_NEMD_450K` renames the original to `_r1` and creates `_r2`, with automatic increment for subsequent realizations
- **Copy / paste between folders** — copy a simulation (⎘ on its card), select a target folder, and click **Paste**. If the target already has a sim of the same name, the pasted copy is added as a new version using the same `_rN` scheme (existing → `_r1`, pasted → `_r2`). Copy once, paste into several folders.
- **Simulation metadata** — system, force field, ensemble/method, timesteps, and free-text notes
- **Persistent storage** via browser localStorage (survives browser restarts)
- **Export / Import** — back up your data as JSON and restore it on any machine
- **Install as app** — runs in its own window without browser chrome (see below)

## Files

```
simulation-tracker.html   ← the app (single HTML file; loads React/Babel from a CDN, so it needs internet)
start-sim-tracker.bat     ← Windows launcher
start-sim-tracker.sh      ← Linux launcher
start-sim-tracker.command ← macOS launcher
README.md                 ← this file
```

## Quick Start

### Windows

1. Double-click `start-sim-tracker.bat`
2. The app opens in your default browser at `http://localhost:8787`
3. A terminal window runs the server — keep it open while using the app

**Requires:** Python 3 installed and available as `python` on your PATH.

### Linux

1. Make the script executable (one-time):
   ```bash
   chmod +x start-sim-tracker.sh
   ```
2. Run it:
   ```bash
   ./start-sim-tracker.sh
   ```

**Requires:** Python 3 installed and available as `python3`.

### macOS

1. Make the script executable (one-time):
   ```bash
   chmod +x start-sim-tracker.command
   ```
2. Double-click `start-sim-tracker.command` from Finder, or run from terminal:
   ```bash
   ./start-sim-tracker.command
   ```

**Requires:** Python 3 (pre-installed on macOS or via Homebrew).

## Install as a Desktop App (Optional)

Once the app is running at `http://localhost:8787`, you can install it as a standalone desktop app:

**Chrome:**
1. Open `http://localhost:8787/simulation-tracker.html`
2. Click the ⋮ menu (top-right)
3. Go to **Cast, save, and share** → **Install page as app**
4. Name it "Sim Tracker" and click Install

**Edge:**
1. Open the URL in Edge
2. Click the ⋮ menu → **Apps** → **Install this site as an app**

The installed app gets its own window (no URL bar), appears in your Start menu / application launcher, and can be pinned to your taskbar or dock.

## Copying Simulations Between Folders

You can copy a simulation from one folder and paste it into another. If the destination already has a simulation with the same name, the pasted copy is filed as a **new version** instead of overwriting or creating a duplicate name.

1. On any simulation card, click the **⎘** button (to the left of the ⧉ duplicate button). The card gets a blue outline to show it's on the clipboard, and a **⎗ Paste** button appears in the top toolbar.
2. Select the destination folder in the sidebar (when *All Simulations* is selected, paste goes to *Unfiled*).
3. Click **⎗ Paste**. The copied simulation's name is shown on the button; the **×** on it clears the clipboard.

The clipboard stays loaded after pasting, so you can copy once and paste into several folders.

**Versioning on name collision** — if the destination folder already contains a simulation of the same name, the app applies its `_rN` realization scheme (the same one used by ⧉ duplicate):

- Destination has `Kapitza_450K` → paste `Kapitza_450K`
- Existing one is renamed to `Kapitza_450K_r1`, the pasted copy becomes `Kapitza_450K_r2`
- Further pastes auto-increment (`_r3`, `_r4`, …). The paste button's tooltip tells you when a paste will be added as a new version.

Versioning is scoped **per folder** — identical names in other folders are left alone. If the destination has no matching name, it's just a plain copy.

## Data Management

- **Where is data stored?** In your browser's `localStorage`, keyed to `localhost:8787`. Clearing browser data for localhost will erase it.
- **Export:** Click the ⬇ Export button in the toolbar to download a `sim-tracker-backup.json` file.
- **Import:** Click the ⬆ Import button and select a previously exported JSON file.
- **Moving between machines:** Export on one machine, copy the JSON file, import on the other.

## Stopping the Server

Close the terminal window running the Python server, or press `Ctrl+C` in it. Your data is safe in the browser — the server is only needed to serve the HTML file.

## Troubleshooting

- **I updated the app but the page looks the same.** The browser cached the old page. Do a hard refresh with **Ctrl + Shift + R** (Windows/Linux) or **Cmd + Shift + R** (macOS). If the app is installed as a desktop app, open the plain URL `http://localhost:8787/simulation-tracker.html` in a normal browser tab and hard-refresh there. Your saved data lives in `localStorage`, so refreshing never erases it.
- **The launcher window flashes and closes / "address already in use".** A server is already running on port 8787. Just open `http://localhost:8787/simulation-tracker.html` in your browser, or close the existing Python terminal window before relaunching.
