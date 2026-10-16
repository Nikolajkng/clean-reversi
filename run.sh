#!/usr/bin/env bash
# Build and launch the original Reversi JavaFX game.
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
RESOURCES="$ROOT/src/main/resources"
CLASSES="$ROOT/build/classes"

for tool in java javac; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Missing '$tool'. Activate a Java JDK using SDKMAN!" >&2
        exit 1
    fi
done

modules="$(java --list-modules)"
for module in javafx.controls javafx.media; do
    if ! grep -q "^${module}@" <<< "$modules"; then
        echo "Missing $module. Switch to a JavaFX-enabled JDK (for example, ZuluFX 17) via SDKMAN!." >&2
        exit 1
    fi
done

mkdir -p "$CLASSES"
javac --add-modules javafx.controls,javafx.media \
    -d "$CLASSES" "$ROOT/src/main/java/januarProjektet2023/Reversi.java"

# The original Java code uses relative File(...) paths for images/audio.
# Run from the resources folder without altering a single line of Java.
cd "$RESOURCES"
exec java --add-modules javafx.controls,javafx.media \
    -cp "$CLASSES:$RESOURCES" januarProjektet2023.Reversi "$@"
