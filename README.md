# Removal Software

A simple GitHub Pages download site for two Windows text-cleaning tools:

- **Text Formatting Toolkit v5.0**
- **Punctuator Remover v2.0**

Both are AutoHotkey scripts (`.ahk`). They require **AutoHotkey v2.0**.

## What the programs do

### Text Formatting Toolkit v5.0

Cleans only the text you select.

**Controls**
- `Ctrl + Alt + O` — turn cleaning ON or OFF.
- `Ctrl + Alt + P` — clean the currently selected text (only while cleaning is ON).

**Cleaning rules**
- Removes periods, commas, apostrophes, quotation marks, colons, semicolons, square brackets, and hyphens.
- Keeps `!`, `?`, and parentheses.
- Changes the standalone word `an` to `a` (case-insensitive).
- Lowercases the first character of each sentence, except the standalone pronoun `I`.

A small startup guide appears when the script launches.

### Punctuator Remover v2.0

A simpler punctuation-removal tool. It cleans only the text you select.

**Controls**
- `Ctrl + Alt + O` — turn the remover ON or OFF.
- `Ctrl + Shift + P` — clean the currently selected text (only while the remover is ON).

**Cleaning rules**
- Removes periods, commas, apostrophes, quotation marks, colons, semicolons, and square brackets.
- Keeps `!`, `?`, and parentheses.
- Does not remove hyphens, change `an` to `a`, or change sentence capitalization.

## Required: AutoHotkey v2.0

These downloads are `.ahk` scripts, so install **AutoHotkey v2.0** before running either one.

Official download page:
https://www.autohotkey.com/download/2.0/

1. Open the official AutoHotkey v2 download page.
2. Download the AutoHotkey v2 installer for Windows.
3. Run the installer and complete the setup.
4. Download either program from this website.
5. Open the downloaded `.ahk` file. It should launch with AutoHotkey v2.
6. Follow the on-screen startup guide (Toolkit v5.0) or use the shortcuts listed above.

To close a running script, find its green AutoHotkey tray icon near the Windows clock, right-click it, and choose **Exit**. If the icon is hidden, open the small tray overflow menu.

## Publish this website with GitHub Pages

1. Sign in to GitHub and create a new repository. A name such as `removal-software` works.
2. Set the repository visibility to **Public** if you want anyone to access the page.
3. Upload `index.html`, this `README.md`, and the `downloads` folder with both `.ahk` files.
4. Open the repository's **Settings** tab.
5. Select **Pages** in the sidebar.
6. Under **Build and deployment**, choose **Deploy from a branch**.
7. Choose branch `main` and folder `/ (root)`, then click **Save**.
8. Wait for GitHub Pages to publish. The Pages settings screen will show the website address.
9. Open that address and test both download links.

## Optional: make standalone EXE versions

The files in this repository are the original `.ahk` scripts, not compiled `.exe` files. If you want standalone EXE downloads later, compile each script on Windows using AutoHotkey's Ahk2Exe compiler. Then add the resulting `.exe` files to `downloads/` and update the download links in `index.html`. An EXE build generally lets users run the program without separately installing AutoHotkey.

## Test phrases

Download `Test-Phrases-and-Controls.txt` from this page for examples you can copy into an app and test with either program.
