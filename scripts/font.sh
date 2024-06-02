font_name='IosevkaTerm'
font_dir="$HOME/.local/share/fonts/"
mkdir -p $font_dir

echo "installing font to $font_dir"

wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$font_name.zip"
unzip "$font_name.zip" -d $font_dir && rm "$font_name.zip"
fc-cache -fv
