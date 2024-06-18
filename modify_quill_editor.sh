#!/bin/bash

# Define the path to the quill-editor.component.d.ts file
QUILL_EDITOR_FILE="node_modules/ngx-quill/lib/quill-editor.component.d.ts"

# Define the new import line
NEW_IMPORT_LINE="import QuillType from 'quill'; import Delta from 'quill';"

# Check if the file exists
if [ -f "$QUILL_EDITOR_FILE" ]; then
    echo "File $QUILL_EDITOR_FILE found."
    # Backup the original file
    cp "$QUILL_EDITOR_FILE" "${QUILL_EDITOR_FILE}.bak"
    echo "Backup created at ${QUILL_EDITOR_FILE}.bak."

    # Output the first few lines before modification for debugging
    echo "Before modification:"
    head -n 5 "$QUILL_EDITOR_FILE"

    # Replace the first line with the new import line
    sed -i "s|import QuillType, { Delta } from 'quill';|$NEW_IMPORT_LINE|" "$QUILL_EDITOR_FILE"
    echo "Import line replaced successfully in $QUILL_EDITOR_FILE."

    # Output the first few lines after modification for debugging
    echo "After modification:"
    head -n 5 "$QUILL_EDITOR_FILE"
else
    echo "File $QUILL_EDITOR_FILE not found."
    exit 1
fi
