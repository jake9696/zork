# The Zork Protocol: Legacy C Porting Guide

**Target Audience:** Agent Zero & Autonomous Developers
**Mission:** Modernize legacy C text adventures (Zork II, III) for Windows, macOS, and Linux.

## 🤖 Agent Zero Workflow Strategy

1.  **Exploration First:** Don't just try to compile. Run `ls -R` and read the `Makefile` first. Understand the 1990s build logic before applying 2020s fixes.
2.  **Iterative Compilation:**
    *   Run `make` -> Capture Error -> Fix *one* thing -> Repeat.
    *   *Do not* try to fix all warnings at once. Focus on Errors first.
3.  **Cross-Platform Awareness:**
    *   If you fix it for Linux, you might break it for macOS. Always verify both if possible, or write portable code (`#ifdef __APPLE__`, `#ifndef _WIN32`).

---

## Phase 1: Initial Analysis & Setup

1.  **Environment Prep**
    *   **Linux:** `apt install build-essential libncurses-dev`
    *   **Windows (Cross):** `apt install mingw-w64 nsis`

2.  **Source Code Audit**
    *   **Dependencies:** Grep for `curses.h`, `termcap.h`, `unistd.h`.
    *   **Data Files:** Look for `fopen`. Legacy games often hardcode paths (e.g., `/usr/games/lib`).
        *   *Fix:* Change to relative paths or define macros like `TEXTFILE` to look in the current directory.
    *   **Makefile:** Replace `-ltermcap` with `-lcurses` or `-lncurses`.

## Phase 2: Linux & macOS Compatibility

1.  **Modernizing Function Prototypes (The "K&R" Problem)**
    *   **Issue:** Old C code uses `func(a) int a; { ... }` or empty `func();`.
    *   **Symptom:** "Too many arguments" error on Linux/GCC.
    *   **Fix:** Convert to ANSI C. Change `void rdints();` to `void rdints(int, int *, FILE *);` in both header and `.c` file.

2.  **Terminal Handling**
    *   **Issue:** `termcap` is dead.
    *   **Fix:** Link against `ncurses`. Ensure `<curses.h>` is included.

3.  **Build Scripting**
    *   Create a `build.sh` that handles OS detection.
    *   *Agent Tip:* macOS `clang` is strict. Use `-Wno-deprecated-non-prototype` to suppress noise if you can't refactor everything.

## Phase 3: Windows Porting (Cross-Compilation)

1.  **MinGW-w64 Toolchain**
    *   Compiler: `x86_64-w64-mingw32-gcc`

2.  **POSIX Abstraction**
    *   **Issue:** Windows has no `unistd.h`.
    *   **Fix:** Wrap includes: `#ifndef _WIN32 #include <unistd.h> #endif`.
    *   **Console:** Windows CMD is not a VT100 terminal. Disable complex pagination if possible (e.g., define `MORE_NONE` for Zork).

3.  **Installer (NSIS)**
    *   **Requirement:** The game EXE needs its DAT file in the *same folder*.
    *   **Solution:** Use NSIS to package `zork.exe` and `dtextc.dat` into a single `zork_setup.exe`.

## Phase 4: Testing Protocol

1.  **Smoke Test:** Compile and run. Does it crash immediately? (Check data file path).
2.  **Binary Formats:**
    *   Linux: `ELF 64-bit`
    *   macOS: `Mach-O 64-bit`
    *   Windows: `PE32+`

## Phase 5: Release Hygiene

1.  **README:** Document prerequisites (`xcode-select`, `libncurses-dev`) and data file location.
2.  **Git:** Ignore `*.o`, `*.exe`, `*.dat` (generated). Tag releases.

## Checklist for Zork II & III
- [ ] Fork & Clone
- [ ] Fix Makefile (switch to `-lcurses`)
- [ ] Fix `dinit.c` / `dmain.c` prototypes (K&R -> ANSI)
- [ ] Create `build.sh` (Linux/macOS)
- [ ] Create `build_win.sh` (MinGW)
- [ ] Create `installer.nsi`
- [ ] Update README with "Eat Pray Love" joke
