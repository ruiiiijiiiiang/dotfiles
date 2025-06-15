#!/usr/bin/env bash

# Directory to scan
MASON_BIN_DIR="$HOME/.local/share/nvim/mason/bin"
SYSTEM_BIN_DIR="/run/current-system/sw/bin"

# Check if we have the necessary permissions
if [ ! -w "$MASON_BIN_DIR" ]; then
	echo "Error: No write permission for $MASON_BIN_DIR"
	exit 1
fi

# Loop through all files in the mason bin directory
for file in "$MASON_BIN_DIR"/*; do
	# Skip if not a file
	if [ ! -f "$file" ]; then
		continue
	fi

	# Get just the filename without path
	filename=$(basename "$file")

	# Check if:
	# 1. The file is executable
	# 2. It's a symbolic link
	# 3. It doesn't currently link to a file in the system bin
	# 4. There is an executable with the same name in the system bin
	if [ -x "$file" ] && [ -L "$file" ] &&
		! readlink -f "$file" | grep -q "^$SYSTEM_BIN_DIR/" &&
		[ -x "$SYSTEM_BIN_DIR/$filename" ]; then

		echo "Fixing symlink for $filename..."

		# Get the current target to display info
		current_target=$(readlink -f "$file")
		echo "  Current link: $file -> $current_target"
		echo "  New link will be: $file -> $SYSTEM_BIN_DIR/$filename"

		# Remove the current symlink
		rm "$file"

		# Create a new symlink pointing to the system binary
		ln -s "$SYSTEM_BIN_DIR/$filename" "$file"

		echo "  ✓ Symlink updated successfully"
	fi
done

echo "Finished processing all files in $MASON_BIN_DIR"
