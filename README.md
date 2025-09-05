# sriram-dev-setup-macbook-dotfiles

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/sriramkilambi/.zprofile

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/sriramkilambi/.zprofile

eval "$(/opt/homebrew/bin/brew shellenv)"

brew install iterm2 --cask

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

nvm install 18.12.1

node -v

npm -v

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/powerline/fonts.git --depth=1

cd fonts

./install.sh

cd ..

rm -rf fonts

brew install --cask font-meslo-lg-nerd-font

(curl -Ls https://raw.githubusercontent.com/sindresorhus/iterm2-snazzy/main/Snazzy.itermcolors > /tmp/Snazzy.itermcolors && open /tmp/Snazzy.itermcolors)

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

brew install neovim ripgrep jesseduffield/lazygit/lazygit tmux fzf fd

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone https://github.com/junegunn/fzf-git.sh.git

brew install bat

mkdir -p "$(bat --config-dir)/themes"

cd -p "$(bat --config-dir)/themes"

curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme

bat cache --build

brew install git-delta eza tlrc thefuck zoxide

brew install yazi ffmpegthumbnailer ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font






source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
