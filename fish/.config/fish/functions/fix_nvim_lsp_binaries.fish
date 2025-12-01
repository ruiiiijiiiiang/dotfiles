function fix_nvim_lsp_binaries
    set MASON_BIN_DIR "$HOME/.local/share/nvim/mason/bin"
    set SYSTEM_BIN_DIR "/run/current-system/sw/bin"

    if not test -w "$MASON_BIN_DIR"
        echo "Error: No write permission for $MASON_BIN_DIR"
        return 1
    end

    for file in "$MASON_BIN_DIR"/*
        if not test -f "$file"
            continue
        end

        set filename (basename "$file")

        if test -x "$file" -a -L "$file"; and not string match -q -r "^$SYSTEM_BIN_DIR/" (readlink -f "$file"); and test -x "$SYSTEM_BIN_DIR/$filename"
            echo "Fixing symlink for $filename..."

            set current_target (readlink -f "$file")
            echo "  Current link: $file -> $current_target"
            echo "  New link will be: $file -> $SYSTEM_BIN_DIR/$filename"

            rm "$file"
            ln -s "$SYSTEM_BIN_DIR/$filename" "$file"

            echo "  ✓ Symlink updated successfully"
        end
    end

    echo "Finished processing all files in $MASON_BIN_DIR"
end
