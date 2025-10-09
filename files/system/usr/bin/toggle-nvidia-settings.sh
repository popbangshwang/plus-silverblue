#!/usr/bin/env bash

DESKTOP_FILE="/usr/share/applications/nvidia-settings.desktop"

if [ ! -f "$DESKTOP_FILE" ]; then
  echo "Desktop file not found."
  exit 1
fi

if lspci | grep -qi nvidia; then
  # Show NVIDIA Settings
  sed -i 's/^NoDisplay=true/NoDisplay=false/' "$DESKTOP_FILE"
  echo "NVIDIA GPU detected, un-hiding NVIDIA Settings."
else
  # Hide it
  sed -i 's/^NoDisplay=false/NoDisplay=true/' "$DESKTOP_FILE"
  echo "No NVIDIA GPU detected, hiding NVIDIA Settings."
fi

