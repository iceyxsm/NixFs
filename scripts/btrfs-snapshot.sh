#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Btrfs Snapshot Helper
# Usage: ./btrfs-snapshot.sh [create|list|delete|restore] [subvolume] [name]
# ============================================================

SNAPSHOT_DIR="/snapshots"
ACTION="${1:-help}"
SUBVOL="${2:-}"
NAME="${3:-}"

mkdir -p "$SNAPSHOT_DIR"

case "$ACTION" in
    create)
        if [[ -z "$SUBVOL" || -z "$NAME" ]]; then
            echo "Usage: $0 create <subvolume-path> <snapshot-name>"
            echo "Example: $0 create /home home_backup_20260607"
            exit 1
        fi
        echo "Creating read-only snapshot of $SUBVOL -> $SNAPSHOT_DIR/$NAME"
        btrfs subvolume snapshot -r "$SUBVOL" "$SNAPSHOT_DIR/$NAME"
        echo "Snapshot created."
        ;;
    list)
        echo "Available snapshots in $SNAPSHOT_DIR:"
        ls -1 "$SNAPSHOT_DIR" 2>/dev/null || echo "(none)"
        ;;
    delete)
        if [[ -z "$NAME" ]]; then
            echo "Usage: $0 delete <snapshot-name>"
            exit 1
        fi
        echo "Deleting snapshot $SNAPSHOT_DIR/$NAME"
        btrfs subvolume delete "$SNAPSHOT_DIR/$NAME"
        echo "Deleted."
        ;;
    restore)
        if [[ -z "$SUBVOL" || -z "$NAME" ]]; then
            echo "Usage: $0 restore <target-subvolume> <snapshot-name>"
            echo "WARNING: This deletes the current subvolume and replaces it with the snapshot."
            exit 1
        fi
        echo "Restoring $SNAPSHOT_DIR/$NAME -> $SUBVOL"
        btrfs subvolume delete "$SUBVOL"
        btrfs subvolume snapshot "$SNAPSHOT_DIR/$NAME" "$SUBVOL"
        echo "Restored."
        ;;
    *)
        echo "Btrfs Snapshot Helper"
        echo ""
        echo "Usage: $0 <action> [args...]"
        echo ""
        echo "Actions:"
        echo "  create  <subvolume> <name>  Create a read-only snapshot"
        echo "  list                        List all snapshots"
        echo "  delete  <name>              Delete a snapshot"
        echo "  restore <subvolume> <name>  Restore a snapshot (destructive!)"
        ;;
esac
