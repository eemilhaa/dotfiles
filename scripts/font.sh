font_dir="$HOME/.local/share/fonts/"
mkdir -p $font_dir

echo "installing font to $font_dir"

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.0/IosevkaTerm.zip
unzip IosevkaTerm.zip -d $font_dir
fc-cache -fv
