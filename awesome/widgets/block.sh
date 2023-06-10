# Shell script to block firefox by messing with permissions

killall firefox
killall xfce4-terminal

chmod 000 /usr/bin/firefox
chmod 000 /snap/bin/firefox
chmod 000 /usr/bin/xfce4-terminal

sleep 30 # block for 30 minutes

chmod 750 /usr/bin/firefox
chmod 750 /snap/bin/firefox
chmod 750 /usr/bin/xfce4-terminal
