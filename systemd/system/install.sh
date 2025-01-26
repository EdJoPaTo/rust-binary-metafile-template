#!/usr/bin/env bash
set -eu

dir=$(basename "$(pwd)")
if [ "$dir" == "systemd" ] || [ "$dir" == "system" ]; then
	echo "run from main directory like this: ./systemd/system/install.sh"
	exit 1
fi

nice cargo build --release --locked

# systemd
function copyIntoLocal() {
	sudo mkdir -p "$(dirname "$2")"
	sed -e 's#/usr/#/usr/local/#' -e 's#/var/#/var/local/#' "$1" | sudo tee "$2" >/dev/null
}
copyIntoLocal systemd/system/service "/usr/local/lib/systemd/system/rust-binary-metafile-template.service"
copyIntoLocal systemd/system/timer "/usr/local/lib/systemd/system/rust-binary-metafile-template.timer"
copyIntoLocal systemd/system/sysuser "/etc/sysusers.d/rust-binary-metafile-template.conf"
copyIntoLocal systemd/system/tmpfile "/etc/tmpfiles.d/rust-binary-metafile-template.conf"
sudo systemd-sysusers
sudo systemd-tmpfiles --create
sudo systemctl daemon-reload

# stop, replace and start new version
sudo systemctl stop "rust-binary-metafile-template.service" "rust-binary-metafile-template.timer"
sudo cp -v "target/release/rust-binary-metafile-template" /usr/local/bin/

# You probably only need one
sudo systemctl enable --now "rust-binary-metafile-template.service"
sudo systemctl enable --now "rust-binary-metafile-template.timer"
