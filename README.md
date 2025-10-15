# FundiWaEV Droidcon Presentation 2025

  This presentation showcases how **Android can integrate with Electric Vehicle (EV) systems** — a project by **FundiWaEV**.

---

## 🧠 About the Presentation

This presentation is designed for developers who enjoy low-level, system-oriented engineering topics.

It demonstrates:
- The Android Hardware Abstraction Layer (HAL)
- CAN Bus and Automotive Ethernet integration
- Real-time telemetry examples in Python
- FundiWaEV’s open-source EV development initiative

---

## AOSP Build Log
### System Setup

Maintainer: Wilfred (FundiwaEV)
Host OS: Arch Linux (x86_64)
Build Target: Android Automotive OS (AAOS / AOSP 16)
Last Updated: $(date +"%Y-%m-%d")

| Item        | Value                                 |
| ----------- | ------------------------------------- |
| Host OS     | Arch Linux                            |
| CPU         | AMD / Intel (multi-core, use `nproc`) |
| RAM         | ≥ 32 GB recommended                   |
| Disk Space  | ≥ 150 GB free                         |
| Java        | OpenJDK 17                            |
| Rust        | 1.83.0                                |
| Python      | 3.12+                                 |
| `repo` tool | Latest stable                         |
| Network     | Stable connection for `repo sync`     |

### Detailed Error Table

| Date       | Error / Symptom                               | Module / Path                                              | Likely Cause                           | Solution / Fix                                                    | Result / Notes |
| ---------- | --------------------------------------------- | ---------------------------------------------------------- | -------------------------------------- | ----------------------------------------------------------------- | -------------- |
| 2025-09-10 | `SyncFailFastError: fetch --depth=1`          | `platform/development`                                     | Shallow clone conflict                 | Re-sync with full depth:<br>`repo sync --force-sync --no-tags`    | ✅ Fixed        |
| 2025-10-10 | `Could not create module-finder`              | `external/anole/.../llvm/tablegen`                         | Missing intermediate path / dependency | `rm -rf out/soong/.intermediates` and rebuild                     | ✅ Fixed        |
| 2025-10-09 | `guice_munge_srcjar` build failed             | `external/guice`                                           | JDK mismatch                           | `export JAVA_HOME=/usr/lib/jvm/java-17-openjdk` then `make clean` | ✅ Fixed        |
| 2025-10-14 | `microdroid_manager rustc src/main.rs` failed | `packages/modules/Virtualization/guest/microdroid_manager` | Rust compiler version mismatch         | Installed `rustup 1.83.0`, cleaned intermediates                  | ✅ Fixed        |
| 2025-10-14 | `tmp_idx_6ev8Ng` file exists                  | `.repo/project-objects/.../jdk8.git`                       | Interrupted fetch                      | Deleted temp files and re-synced                                  | ✅ Fixed        |
| —          | `ninja: build stopped: subcommand failed`     | Global (varies)                                            | Upstream build failure                 | Scrolled up for first error, fixed source                         | ⚙️ Pending     |
| —          | Build freezes with no output                  | During `make`                                              | High I/O or Soong deadlock             | Used `htop` to check active jobs                                  | ⚙️ Pending     |

### Environment Maintenance Commands

| Command                                            | Purpose                       |
| -------------------------------------------------- | ----------------------------- |
| `repo sync -c -j$(nproc) --force-sync --no-tags`   | Full sync                     |
| `source build/envsetup.sh && lunch aosp_arm64-eng` | Load environment              |
| `make clobber`                                     | Full clean build              |
| `make -j$(nproc)`                                  | Build using all cores         |
| `ulimit -n 4096`                                   | Prevent Git file limit errors |
| `df -h`                                            | Check available disk space    |
| `rustup default 1.83.0`                            | Set correct Rust toolchain    |

### SomeThings To Note

* Soong errors often resolve after deleting intermediates.
* Rust modules in Android 16 require Rust 1.83+.
* Java 17 is mandatory; Java 11 will break many modules.
* Avoid running repo sync with --depth=1 when building from tags.
* Monitor builds with htop, iotop, or ps -ef | grep soong_build.
* Use SSD storage for faster Soong database access.

## 🧩 Presentation Building Requirements

Make sure your system has the following installed:

### On Debian/Ubuntu/Arch Linux

```bash
sudo apt install texlive-full python3-pygments fonts-jetbrains-mono fonts-inter
```

### Building the Slides

Clone the repository:

```bash
git clone https://github.com/FundiwaEV/fundiwaev-droidcon-presentation.git

cd fundiwaev-droidcon-presentation
```

Then compile using xelatex:

```bash
xelatex -shell-escape fundiwaev_droidcon.tex
```

The -shell-escape flag is required for syntax highlighting via minted.

### New Build Method with Make

You can also use the included `Makefile` for easy builds:

```bash
make            # Compile the slides
make clean      # Remove temporary LaTeX files
make rebuild    # Clean + rebuild
make view       # Open the generated PDF
