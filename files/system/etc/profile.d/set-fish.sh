#!/bin/bash

# Set Fish shell if not already
if [ "$SHELL" != "/usr/bin/fish" ]; then
  chsh -s /usr/bin/fish "$USER"
fi
