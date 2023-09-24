sudo systemctl enable systemd-boot-update.service

sudo systemctl start tlp.service
sudo systemctl enable tlp.service

sudo systemctl start firewalld.service
sudo systemctl enable firewalld.service

# tlp
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket

sudo systemctl disable bluetooth

sudo systemctl start reflector.service
sudo systemctl enable reflector.service

xdg-user-dirs-update
