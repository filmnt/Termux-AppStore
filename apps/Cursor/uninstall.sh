#!/data/data/com.termux/files/usr/bin/bash

check_and_delete "${distro_path}/opt/AppImageLauncher/cursor"
check_and_delete "${distro_path}/usr/share/icons/hicolor/*/apps/cursor.png"
check_and_delete "${PREFIX}/share/applications/pd_added/cursor.desktop"
