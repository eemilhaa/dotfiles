mkdir -p ~/.config/
mkdir -p ~/repos/

# link terminal config files to local $HOME so distroboxes have access to them
ln -s ~/dotfiles/confs/helix ~/.config/
ln -s ~/dotfiles/confs/zellij ~/.config/
ln -s ~/dotfiles/confs/lsd ~/.config/
ln -s ~/dotfiles/confs/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/confs/pypoetry ~/.config/
ln -s ~/dotfiles/confs/alacritty ~/.config/
ln -s ~/dotfiles/confs/containers ~/.config/
ln -s ~/dotfiles/confs/zsh/.zshrc.d ~/

chsh -s /bin/zsh  # This must be done manually on silverblue

git config --global user.name "eemilhaa"
git config --global user.email "eemil.haapanen@gmail.com"
