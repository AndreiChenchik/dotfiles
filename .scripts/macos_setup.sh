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
git config --global user.signingKey A688B7C116CA5B13
git config --global commit.gpgsign true
git config --global gpg.program /usr/local/bin/gpg

# Restore configs
git clone --bare https://github.com/AndreiChenchik/dotfiles $HOME/.dotfiles
mkdir -p .config-backup && \
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# Install sowftware
brew bundle install --file=$HOME/.Brewfile

# Install poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

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
