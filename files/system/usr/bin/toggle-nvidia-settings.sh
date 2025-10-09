#!/usr/bin/env bash

SOURCE_DESKTOP="/usr/local/share/applications/nvidia-settings.desktop"
OVERRIDE_DESKTOP="$HOME/.local/share/applications/nvidia-settings.desktop"

# Ensure local override directory exists
mkdir -p "$(dirname "$OVERRIDE_DESKTOP")"

# Only proceed if the source file exists
if [ ! -f "$SOURCE_DESKTOP" ]; then
  echo "Source .desktop file missing: $SOURCE_DESKTOP"
  exit 1
fi

# Copy the original desktop file to the local override path
cp "$SOURCE_DESKTOP" "$OVERRIDE_DESKTOP"

# Function to update or insert NoDisplay
set_nodisplay_value() {
  local file="$1"
  local value="$2"

  if grep -q "^NoDisplay=" "$file"; then
    sed -i "s/^NoDisplay=.*/NoDisplay=$value/" "$file"
  else
    # Add it under the `[Desktop Entry]` section
    sed -i "/^\[Desktop Entry\]/a NoDisplay=$value" "$file"
  fi
}

# Decide whether to show or hide the app
if lspci | grep -qi nvidia; then
  set_nodisplay_value "$OVERRIDE_DESKTOP" false
  echo "NVIDIA GPU detected — un-hiding NVIDIA Settings."
else
  set_nodisplay_value "$OVERRIDE_DESKTOP" true
  echo "No NVIDIA GPU detected — hiding NVIDIA Settings."
fi
