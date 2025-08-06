# Установка дополнительных репозиторие Войда, с драйверами аудио, видео, блютуз, сторонних программ и так далее
sudo xbps-install void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree

# синхронизация репозиториев и обновление пакетов
sudo xbps-install -Suv

# Установка Xorg, KDE пакетов, сети, системы межпроцессного взаимодействия и менеджера входа и поддержка ntfs разделов
sudo xbps-install xorg kde5 kde5-baseapps kdewebkit NetworkManager NetworkManager-openvpn dbus sddm ntp ntfs-3g flatpak flatpak-kcm

# Установка дополнительных компонентов если вы программист, занимаетесь сборками пакетов или используете виртуализацию
sudo xbps-install linux-headers base-devel

# установка Pipewire и Bluetooth
sudo xbps-install -S pipewire libspa-bluetooth wireplumber bluez
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
sudo cp /usr/share/applications/pipewire.desktop /etc/xdg/autostart/

# Драйвера AMD (если у вас основная видеокарта AMD)
sudo xbps-install -Suv linux-firmware-amd mesa-dri vulkan-loader vulkan-loader-32bit Vulkan-ValidationLayers Vulkan-ValidationLayers-32bit mesa-vulkan-radeon amdvlk mesa-vaapi mesa-vdpau libbsd

# Установка основных программ
sudo xbps-install -Suv nano xclip git curl ffmpeg yt-dlp kcalc spectacle okular ark gwenview gnome-disk-utility gparted kdegraphics-thumbnailers ffmpegthumbs noto-fonts-cjk noto-fonts-emoji android-tools scrcpy libreoffice libreoffice-i18n-ru mkvtoolnix-gui foliate ruby kdenlive krita gimp handbrake inkscape obs audacity mpv qbittorrent kget

# Wine по желанию, если вы используете Windows программы или игры
sudo xbps-install -Suv wine wine-32bit wine-gecko wine-mono wine-devel winetricks steam lutris

# добавить репозиторий флатпак
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# включение служб в автозапуск Runit для первого включения
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/sddm /var/service
sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/bluetoothd /var/service

