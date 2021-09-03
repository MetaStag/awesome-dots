#!/bin/bash

######################################
###########>INSTALLATION<#############
######################################

cp -r alacritty $HOME/.config/
cp -r nvim $HOME/.config/
cp -r polybar $HOME/.config/
cp -r rofi $HOME/.config/
cp -r termite $HOME/.config/
cp -r .zshrc $HOME/
cp -r awesome $HOME/.config/
cp -r dunst $HOME/.config/
cp -r glava $HOME/.config/
cp -r .moc $HOME/
cp -r picom.conf $HOME/.config/
cp -r sddm $HOME/.config/
cp -r zathura $HOME/.config/
cd ../
rm -rf $HOME/awesome-dots

echo "Logout or Restart WM :)"
