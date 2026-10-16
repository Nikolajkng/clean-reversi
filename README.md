# Reversi (JavaFX)

The original Reversi board game, built as a standalone JavaFX application. This distribution keeps the working `Reversi.java` **byte-for-byte unchanged**; only the file layout and the scripts/documentation have been updated.

## Requirements

- Linux graphical desktop (tested previously by the project owner on Debian 13).
- A **JDK with JavaFX included**, with at least `javafx.controls` and `javafx.media`. **Azul ZuluFX Java 17** is recommended for this older project.
- Bash (for `run.sh`).
- A terminal running in your graphical desktop session (JavaFX needs a display).

**Important:** Most standard Debian OpenJDK and Eclipse Temurin installations do **not** include JavaFX. Running `javac` with those JDKs produces `package javafx.* does not exist` errors. JavaFX-enabled Zulu (`.fx-zulu`) builds provide the required modules.


## Run the game (recommended)

From the extracted project directory:

```bash
./run.sh
```

Or invoke it from elsewhere:

```bash
/path/to/Reversi-clean/run.sh
```

The script:

1. Confirms `java`, `javac`, and the required JavaFX modules are available.
2. Compiles the original source into `build/classes/` (created automatically).
3. Starts `januarProjektet2023.Reversi` using the correct classpath and working directory.

It **recompiles on each launch**; you don't need Gradle, Maven, or a separate build step. If the script loses its executable permission, run `bash run.sh` or `chmod +x run.sh`.

## Build and start manually

From the project root, with a JavaFX-enabled JDK selected:

```bash
mkdir -p build/classes
javac --add-modules javafx.controls,javafx.media \
  -d build/classes src/main/java/januarProjektet2023/Reversi.java
```

Then start it (still in the project root):

```bash
ROOT="$(pwd)"
(
  cd src/main/resources
  java --add-modules javafx.controls,javafx.media \
    -cp "$ROOT/build/classes:$ROOT/src/main/resources" \
    januarProjektet2023.Reversi
)
```

**Why start inside `src/main/resources`?** The *unchanged* Java source loads images/audio with `new File("filename")`. Those paths are interpreted relative to the process's working directory. The CSS uses `getClass().getResource("Reversi.css")` instead; its location under `januarProjektet2023/` lets Java find it on the classpath. The provided script handles both behaviors without any source edits.


## What was removed from this cleaned export?

- Earlier and experimental Java variants (`Backups/`, `BasicReversi.java`, `Reversi - v10.java`, `Reversi_Peter.java`, `Michelles WINNER*`).
- Other implementations (`Reversi_med_klasser/`, `CompleteGame/`). These may contain useful alternative work, but **are not required** to run the standalone `Reversi.java` that was compiled successfully.
- Duplicate pictures and sounds inside `Billeder/` and `Sounds/` (their active counterparts were byte-for-byte identical to the root copies in the original upload).
- Placeholder/test files and precompiled `out/` classes.
- The bundled `.git/` repository metadata: this is a clean **source export**, not a continuation of the original Git repository. Preserve the original uploaded project/clone if you need its commit history or the alternative versions.

Nothing inside `Reversi.java` was removed or reformatted, including any unused methods or imports. The archive is deliberately a minimal export of the previously working **standalone** game, not a refactor of its source code.
