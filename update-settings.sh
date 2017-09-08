# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show all files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Set asking for password on lock
defaults write com.apple.screensaver askForPassword -int 1

# Ask for password delay 0
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Don't save docs to iCloud by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable Multicast 
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool NO
