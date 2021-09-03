######################################
############>INSTALLATION<##############
######################################
#!/bin/bash

cd $HOME/
git clone https://github.com/MetaStag/awesome-dots.git
cd awesome-dots
cp -r alacritty $HOME/.config/
cp -r nvim $HOME/.config/
cp -r polybar $HOME/.config/
cp -r rofi $HOME/.config/
cp -r termite $HOME/.config/
cp -r .zshrc $HOME/.config/
cp -r awesome $HOME/.config/
cp -r dunst $HOME/.config/
cp -r glava $HOME/.config/
cp -r .moc $HOME/.config/
cp -r picom.conf $HOME/.config/
cp -r sddm $HOME/.config/
cp -r zathura $HOME/.config/
rm -rf $HOME/awesome-dots
echo "Logout or Restart WM :)"
