#!/usr/bin/env bash

name="rust-binary-metafile-template"

systemctl --user disable --now "$name.timer" "$name.service"

CONFIG_DIR=${XDG_CONFIG_DIRS:-"$HOME/.config"}
rm -f "$CONFIG_DIR/systemd/user/$name.service"
rm -f "$CONFIG_DIR/systemd/user/$name.timer"
rm -f "$HOME/.local/bin/$name"

systemctl --user daemon-reload


echo "$HOME/.local/share/rust-binary-metafile-template/ is not touched and is still existing"
