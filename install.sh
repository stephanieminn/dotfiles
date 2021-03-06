#!/usr/bin/env zsh

sudo echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
# NB: It seems like Brew installs xcode command line tools
# so I'm removing that step from the README and let's see
# if we can get a system up and running without XCode
if which brew >/dev/null 2>&1; then
  echo "brew already installed"
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Configure Chrome to start where you left off on startup
cd $HOME/Library/Application\ Support/Google/Chrome/Default
jq -ec '.session.restore_on_startup = 1' Secure\ Preferences > Prefs.tmp && mv Prefs.tmp Secure\ Preferences

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null 2>&1

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | zsh

# Create a repos directory
if [ ! -d "$HOME/repos" ]; then
  mkdir $HOME/repos
else
  echo "~/repos folder already exists"
fi

# Add Projects to Favorites
mysides add repos file:///Users/$(id -un)/repos

# Create a ~/.config directory
if [ ! -d "$HOME/.config" ]; then
  mkdir $HOME/.config
else
  echo "~/.config already exists"
fi

pg_ctl -D /usr/local/var/postgres start > /dev/null 2>&1
brew services start postgresql > /dev/null 2>&1

# Set macOS preferences
cd $HOME
source $HOME/dotfiles/.macos

# Symlink dotfiles
echo "Symlinking dotfiles..."
./symlinks.sh

# may fix missing icons?
# sudo rm -rfv /Library/Preferences/com.apple.dock.plist

# restart
echo "Setup complete. Restarting..."
sudo shutdown -r now
