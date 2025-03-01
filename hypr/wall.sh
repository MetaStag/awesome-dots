#!/bin/bash

# Define the folder containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/walls"

# Define a file to track the current wallpaper index
STATE_FILE="./.current_wallpaper_index"

# Get a list of all image files in the directory
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f)

# Check if there are any wallpapers in the directory
if [[ ${#WALLPAPERS[@]} -eq 0 ]]; then
  exit 1
fi

# Read the current index from the state file, defaulting to 0 if it doesn't exist
if [[ -f "$STATE_FILE" ]]; then
  CURRENT_INDEX=$(cat "$STATE_FILE")
else
  CURRENT_INDEX=0
fi

# Increment the index and wrap around if necessary
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))

# Get the next wallpaper
NEXT_WALLPAPER="${WALLPAPERS[$NEXT_INDEX]}"

# Set the new wallpaper using swww
swww img "$NEXT_WALLPAPER" --transition-type grow --transition-pos top-left

# Save the new index to the state file
echo "$NEXT_INDEX" > "$STATE_FILE"
