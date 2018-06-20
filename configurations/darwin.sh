#
# System Configuration for macOS
#

LOGIN_MESSAGE="Use of this system is for authorized users only."
DNS_SERVERS="1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001 8.8.8.8"

# Show all file extensions
run_cmd "defaults write NSGlobalDomain AppleShowAllExtensions -bool true"

# Show all files
run_cmd "defaults write com.apple.finder AppleShowAllFiles -bool true"

# Set asking for password on lock
run_cmd "defaults write com.apple.screensaver askForPassword -int 1"

# Ask for password delay 0
run_cmd "defaults write com.apple.screensaver askForPasswordDelay -int 0"

# Don't save docs to iCloud by default
run_cmd "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false"

# Disable Multicast 
# see: https://derflounder.wordpress.com/2016/08/22/disabling-bonjour-advertisement-on-os-x-el-capitan-and-later/
run_cmd "sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES"

# Enable Stealth Mode
run_cmd "/usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on"

# Enable Verbose Boot
run_cmd "sudo nvram boot-args=-v"

# Set DNS Servers
run_cmd "networksetup -setdnsservers Wi-Fi $DNS_SERVERS"
run_cmd "networksetup -setdnsservers Ethernet $DNS_SERVERS"

# Set system run message
run_cmd "sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText '$LOGIN_MESSAGE'"

if ! which brew>/dev/null; then
  # Install Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

printf "${LIGHT_GREEN}SET${RESET} hostname($(hostname)): "
read HOSTNAME;

if [[ "$HOSTNAME" == "" ]]; then
  HOSTNAME="$(hostname)"
fi

sudo scutil --set HostName $HOSTNAME &&
sudo scutil --set LocalHostName $HOSTNAME &&
sudo scutil --set ComputerName $HOSTNAME &&
dscacheutil -flushcache && 
printf " ---> ${LIGHT_GREEN}OK${RESET}\n"