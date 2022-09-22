#!/usr/bin/env bash

systemctl --user disable --now "rust-binary-metafile-template.timer" "rust-binary-metafile-template.service"

CONFIG_DIR=${XDG_CONFIG_DIRS:-"$HOME/.config"}
rm -f "$CONFIG_DIR/systemd/user/rust-binary-metafile-template.service"
rm -f "$CONFIG_DIR/systemd/user/rust-binary-metafile-template.timer"
rm -f "$HOME/.local/bin/rust-binary-metafile-template"

systemctl --user daemon-reload


echo "$HOME/.local/share/rust-binary-metafile-template/ is not touched and is still existing"
