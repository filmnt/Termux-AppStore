#!/data/data/com.termux/files/usr/bin/bash

supported_arch="aarch64,arm"
package_name="code-insiders"
version=distro_local_version
app_type="distro"
supported_distro="all"
# working_dir="${distro_path}"
run_cmd="/usr/share/code-insiders/code-insiders --no-sandbox"

if [[ "$selected_distro" == "debian" ]] || [[ "$selected_distro" == "ubuntu" ]];then

distro_run '
sudo apt update -y -o Dpkg::Options::="--force-confnew"
# Ensure wget and gpg are installed
sudo apt-get install -y wget gpg

# Download and store the Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/packages.microsoft.gpg > /dev/null

# Ensure the correct permissions
sudo install -D -o root -g root -m 644 /etc/apt/keyrings/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

# Add the VS Code repository
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# Ensure apt-transport-https is installed (if needed)
sudo apt-get install -y apt-transport-https

# Update package lists
sudo apt-get update -y
'
    $selected_distro install code-insiders -y
elif [[ "$selected_distro" == "fedora" ]]; then
distro_run '
# Import Microsoft GPG key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Add the VS Code repository without user interaction
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

# Update the package list
sudo dnf check-update -y
'
    $selected_distro install code-insiders -y
fi
fix_exec "pd_added/code-insiders.desktop" "--no-sandbox"