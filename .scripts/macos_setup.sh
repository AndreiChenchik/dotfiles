#!/usr/bin/env bash
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AndreiChenchik/dotfiles/HEAD/.scripts/macos_setup.sh)"

echo "Make sure you are logged in into AppStore already"
read -p "Press enter to continue"
echo "macOS setup is in progress!"

# Prepare Xcode
xcode-select --install
sudo softwareupdate --install-rosetta
sudo xcodebuild -license accept

# Setup brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew analytics off
brew update

# Setup git
git config --global user.name "Andrei Chenchik"
git config --global user.email andrei@chenchik.me

# Restore configs
dotfiles_dir=".dotfiles"
git clone --bare https://github.com/AndreiChenchik $HOME/$dotfiles_dir
alias config='git --git-dir=$HOME/$dotfiles_dir/ --work-tree=$HOME'
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
config checkout
config config --local status.showUntrackedFiles no

# Install sowftware
brew bundle install -f $HOME/.Brewfile

# Install poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# macOS Config
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.Finder AppleShowAllFiles true
defaults -currentHost write -g AppleFontSmoothing -int 1

killall Finder

# 1Password Login
echo "Enter your 1password email: "
read user_email
op signin my.1password.com $user_email                          

echo "Done, please restart terminal session"
