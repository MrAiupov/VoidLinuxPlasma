#### Основная информация
https://voidlinux.org/

Руководство установки
https://docs.voidlinux.org/installation/live-images/guide.html

По багам в Плазма в Войд, можно обращаться к сопровождающему
https://www.reddit.com/user/Johnnynator2/

#### Основные команды xbps
```bash
# Помощь по XBPS
все ответы имеются в статье
https://github.com/void-linux/void-packages

# обновление пакетов
sudo xbps-install -Suv

# установка пакета
sudo xbps-install -Suv имя_пакета

# удаление пакета с зависимостями
sudo xbps-remove -R имя_пакета

# чистка системы от пакетов сирот и кэша обновлений
sudo xbps-remove -oO

# удаление всех старых ядер, кроме актуального
sudo vkpurge rm all

# поиск пакетов для установки
sudo xbps-query -Rs имя_пакета

# также, списки пакетов, можно смотреть через сайт
# я обычно так и делаю, как то удобнее мне так
https://voidlinux.org/packages/
```

#### Установка стороннего ядра Linux
```bash

# Устанавливаем нужно ядро, например lunux6.12
sudo xbps-install -Suv linux6.12  

# Реконфингурируем lunux6.12
sudo xbps-reconfigure -f linux6.12

# Перезагружаемся
sudo reboot

# Если всё работает, при желаении можно удалить все старые ядра, кроме актуального, но не рекомендуется, ведь если что то пойдёт не так, то всегда можно загрузится в актуальную версию ядра
sudo vkpurge rm all
```

#### Установка KDE Plasma
```bash
# синхронизация репозиториев и обновление пакетов
sudo xbps-install -u xbps
sudo xbps-install -Suv
# перезагрузка после обновления, если что то установил или обновил
sudo reboot

# повторная проверка синхронизации репозиториев и обновления пакетов
sudo xbps-install -Suv

# Установка иксов, кде пакетов, сети, системы межпроцессного взаимодействия и менеджера входа и поддержка ntfs разделов
sudo xbps-install xorg kde5 kde5-baseapps kdewebkit NetworkManager NetworkManager-openvpn dbus sddm ntp ntfs-3g flatpak flatpak-kcm

# Установка дополнительных компонентов если вы программист, занимаетесь сборками пакетов или используете виртуализацию
sudo xbps-install linux-headers base-devel

# Установка дополнительных репозиторие Войда, с драйверами аудио, видео, блютуз, сторонних программ и так далее
sudo xbps-install void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree

# обязательная синхронизация репозиториев и обновление пакетов
sudo xbps-install -Suv

# установка Pipewire и Bluetooth
sudo xbps-install -S pipewire libspa-bluetooth wireplumber bluez
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
sudo cp /usr/share/applications/pipewire.desktop /etc/xdg/autostart/

# Либо установить PulseAudio и Bluetooth
sudo xbps-install alsa-utils pulseaudio bluez bluez-alsa

# включение служб в автозапуск Runit для первого включения
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/sddm /var/service
sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/bluetoothd /var/service

# Драйвера AMD (если у вас основная видеокарта AMD)
sudo xbps-install -Suv linux-firmware-amd mesa-dri vulkan-loader vulkan-loader-32bit Vulkan-ValidationLayers Vulkan-ValidationLayers-32bit mesa-vulkan-radeon amdvlk mesa-vaapi mesa-vdpau libbsd

# удалены и из репозитория 
vkd3d-32bit vkd3d

# либо драйвера Nvidia (если у вас основная видеокарта Nvidia)
sudo xbps-install nvidia nvidia-libs nvidia-libs-32bit vulkan-loader vkd3d-32bit vkd3d vulkan-loader-32bit Vulkan-ValidationLayers Vulkan-ValidationLayers-32bit libbsd nv-codec-headers

# либо установка Intel  (если у вас основная видеокарта Intel)
sudo xbps-install linux-firmware-intel mesa-dri vulkan-loader mesa-vulkan-intel intel-video-accel
sudo nano /etc/mkinitcpio.conf
MODULES=(... i915 ...)

### Перезагружаемся в систему
sudo reboot

My Full Disk Encrypted BTRFS KDE chroot Install
https://gitlab.com/BreakPointSSC/void-linux-uefi-luks-btrfs/-/blob/main/Void_Linux_Full_Disk_Encryption_KDE.txt
Источник на руководство найдено тут
https://www.reddit.com/r/voidlinux/comments/r16cuo/my_full_disk_encrypted_btrfs_kde_chroot_install/
```

#### Установка сторонних программ через xbps
```bash
# Я бы обязательно установил вот эти программы
sudo xbps-install -Suv nano xclip git curl ffmpeg yt-dlp kcalc spectacle okular ark gwenview gnome-disk-utility gparted kdegraphics-thumbnailers ffmpegthumbs noto-fonts-cjk noto-fonts-emoji android-tools scrcpy libreoffice libreoffice-i18n-ru mkvtoolnix-gui foliate ruby kdenlive krita gimp handbrake inkscape obs audacity mpv qbittorrent kget

# Wine по желанию, если вы используете Windows программы или игры
sudo xbps-install -Suv wine wine-32bit wine-gecko wine-mono wine-devel winetricks steam lutris

# добавить репозиторий флатпак
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

Описание некоторых программ и дополнений
opera --
firefox firefox-i18n-ru -- веб браузер
kdewebkit -- для запуска веб приложений в телеграм
noto-fonts-cjk noto-fonts-emoji  -- шрифты и смайлы для браузеров
xclip -- для работы с буфером обмена
kdegraphics-thumbnailers ffmpegthumbs -- превью видео и pdf для dolphin
android-tools -- для управления смартфоном через Fastboot и ADB
ssr -- SimpleScreenRecorder
neochat -- клиент матрикс
scrcpy -- стрим экрана смартфона на компьютер
pycharm-community` -- среда разработки pycharm-community
keepassxc -- менеджер паролей
guvcview -- GTK web-камера
libbsd -- чаще всего нужен для GOG игр (например Dead Cell)
nv-codec-headers -- для рендера hevc в ffmpeg nvidea
elise -- медиаплеер
quiterss --
flameshot --

Показ экрана смартфона через scrcpy, подключив его через USB и выдав разрешение
`sudo scrcpy -m 1024`

Команды для Flameshot (скриншоты), данные команды назначил на горячие клавиши в системе
flameshot full -- снимок всего экрана
flameshot gui -- снимок экрана с граф. интерфейсом

https://www.chromium.org/developers/how-tos/api-keys/
```

#### Установка Flatpak
```bash
#### Установка Flatpak

sudo xbps-install -S flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo reboot

Обратите внимание, что каталоги '/var/lib/flatpak/exports/share' и '/home/mraiupov/.local/share/flatpak/exports/share', не находятся по пути поиска, заданном переменной окружения XDG_DATA_DIRS, поэтому приложения, установленные Flatpak, могут не отображаться на рабочем столе, пока сеанс не будет перезапущен.
```

#### Установка сторонних программ через xbps-src
```bash
# Установка сторонник программ через XBPS-SRC, обязательно без sudo, на примере Google Chrome и Vivaldi

# можно глянуть какие пакеты там есть, просто открыв ссылку
# https://github.com/void-linux/void-packages
# и нажать кнопку Go to file и начать вводить ключевое слово
# и он выводить списком, совпадения
# для установки данных пакетов, надо склонировать репозиторий гит себе в какую нибудь папку
# я выбрал домашнюю директорию, создав в ней папку Programs и уже внутри данной папки
# я начал воодить такие команды

# вносим правки в git
git config --global url."https://".insteadOf git://
# потому что https://github.blog/2021-09-01-improving-git-protocol-security-github/

# склонировать репозиторий
git clone git://github.com/void-linux/void-packages.git
# открыть папку
cd void-packages
# установить внутренние инструменты xbps-src
./xbps-src binary-bootstrap
# снимаем ограничения с установки "ограниченных" пакетов
echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf
# качаем пакет вивальди
./xbps-src pkg vivaldi
# качаем пакет гугл хром
./xbps-src pkg google-chrome

# Теперь пакет нужно установить командой (через sudo)
sudo xbps-install --repository hostdir/binpkgs/nonfree vivaldi
sudo xbps-install --repository hostdir/binpkgs/nonfree google-chrome

# и стоит запомнить что пакеты с открытым пакетом ставятся в одну папку, а закрытые пакеты в другой
# как именно они отличаются я без понятия
# hostdir/binpkgs -- путь для открытых пакетов
# hostdir/binpkgs/nonfree -- путь для закрытых пакетов

# Установка Яндекс Браузера
https://gitlab.com/vsyr89/yandex-browser
# Мой форк
https://github.com/MrAiupov/yandex-browser

```
cd void-packages
cd srcpkgs
git clone https://github.com/MrAiupov/yandex-browser/
cd ../
./xbps-src pkg yandex-browser
xbps-install -v --repository hostdir/binpkgs/nonfree yandex-browser
```

# Проверить обновления программ, работает не со всеми программами, а только с теми, где эта функция присутствует

./void-packages/xbps-src update-check vivaldi
./void-packages/xbps-src update-check google-chrome

#  Как обновлять приложения, уставновленные через xbps-src, ответ прост, переустановкой, синхронизировав клонированный гит снова

# открываем папку войд пакетж
cd void-packages
# синхронизируем склонированный гит
git pull
# обновляем внутренные инструменты xbps-src
./xbps-src bootstrap-update
# скачиваем нужный пакет, который хотели обновить
./xbps-src pkg имя_пакета
# устанавливаем данный пакет
sudo xbps-install --repository hostdir/binpkgs/nonfree имя_пакета
```
#### Установка VirtualBox
```bash
#### Установка VirtualBox в Void Linux
sudo xbps-install linux-headers base-devel virtualbox-ose
sudo modprobe vboxdrv
sudo gpasswd -a $USER vboxusers

*Установить VirtualBox Oracle VM VirtualBox Extension Pack
*для поддержки USB устройств в виртуальной машине
https://www.virtualbox.org/wiki/Downloads
```

#### Установка QEMU/KVM
```bash
### Установка QEMU/KVM на Void linux, лучше использовать виртуалбокс, так как бывает ошибка удаления виртуальной машины

sudo xbps-install qemu libvirt virt-manager vsv
# vsv - Это менеджер сервисов Void

# включение служб виртуализации для QEMU/KVM
sudo ln -s /etc/sv/libvirtd /var/service
sudo ln -s /etc/sv/virtlockd /var/service
sudo ln -s /etc/sv/virtlogd /var/service
# добавление пользователя в группу для управления виртуализации
sudo gpasswd -a "$USER" libvirt

Проверка состояния служб, в том числе виртуальных служб:
sudo vsv status virt

Инструкции QEMU/KVM взяты с этих источников
(есть неточности с данными пакетами, они необязательны для установки, но есть в инструкциях ниже)
`sudo xbps-install bridge-utils iptables2`
https://www.reddit.com/r/voidlinux/comments/ghwvv5/guide_how_to_setup_qemukvm_emulation_on_void_linux/
Источник QEMU/KVM (более ясная инструкция), плюс со способами устранения разных ошибок
https://blog.daveeddy.com/2019/02/11/kvm-virtualization-with-virtmanager-on-void-linux/

Гугл хром без гугла (не рабочая инструкция), но сохранил на всякий случай
https://github.com/DAINRA/ungoogled-chromium-void
```
#### Старые инструкции
```bash
## Ниже текст не читать, он в доработке (возможно имеются ошибки)
## Инструкция установки через rootfs на GPT диск

cfdisk
mkfs.vfat /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
mount /dev/nvme0n1p2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi

for dir in dev proc sys run; do mkdir -p /mnt/$dir ; mount --rbind /$dir /mnt/$dir ; mount --make-rslave /mnt/$dir ; done

xbps-install -Sy -R https://alpha.de.repo.voidlinux.org/current -r /mnt base-system grub dhcpcd nano grub-x86_64-efi

chroot /mnt
chown root:root /
chmod 755 /
passwd root
useradd -m -G users,wheel,audio mraiupov
passwd mraiupov
echo pchome > /etc/hostname
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/default/libc-locales
nano /etc/fstab
tmpfs /tmp tmpfs defaults,nosuid,nodev 0 0
/dev/sde1 /boot/efi vfat defaults 0 0
/dev/sde2 / ext4 defaults 0 0
xbps-reconfigure -fa

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable

grub-mkconfig -o /boot/grub/grub.cfg


Либо установится через автоустанвщик и потом войти в ЛайвРежиме в установку

mount /dev/nvme0n1p2 /mnt
mount /dev/nvme0n1p1 /mnt/boot/efi

for dir in dev proc sys run; do mkdir -p /mnt/$dir ; mount --rbind /$dir /mnt/$dir ; mount --make-rslave /mnt/$dir ; done

chroot /mnt
rm -rf /mnt/boot/efi/ /mnt/boot/grub

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable

grub-mkconfig -o /boot/grub/grub.cfg
xbps-install -Sy -R grub-x86_64-efi


***
***
***

Автор руководства Константин t.me/freeconst

Руководство установки Void Linux EFI Btrfs на SSD через chroot, с субтомами и без шифрования.

Грузишься в Live и логинишься под рутом
(удобнее сразу запустить bash для человеческого дополнения по TAB):
su -c bash

Делаем разметку диска:
fdisk /dev/nvme0n1

Создаём 2 раздела для EFI и BTRFS:
g, n, 500M, t, uefi, n, Enter-Enter

Форматируем разделы:
mkfs.vfat -n EFI -F32 /dev/nvme0n1p1
mkfs.btrfs -L ROOT /dev/nvme0n1p2

Монтируем BTRFS, создаём сабвольюмы:
mount -o $BTRFS_OPTS /dev/nvme0n1p2 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots

Дальше работаем уже с корневым сабвольюмом:
umount /mnt
mount -o $BTRFS_OPTS,subvol=@ /dev/nvme0n1p2 /mnt

mkdir -p /mnt/home
mount -o $BTRFS_OPTS,subvol=@home /dev/nvme0n1p2 /mnt/home

mkdir -p /mnt/.snapshots
mount -o $BTRFS_OPTS,subvol=@snapshots /dev/nvme0n1p2 /mnt/.snapshots

Создаём сабвольюмы, которые не будут попадать в снапшоты:
mkdir -p /mnt/var/cache
btrfs subvolume create /mnt/var/cache/xbps
btrfs subvolume create /mnt/var/tmp
btrfs subvolume create /mnt/srv

Монтируем EFI:
mkdir -p /mnt/boot/efi/
mount /dev/nvme0n1p1 /mnt/boot/efi/

Выбираем зеркало, нужную архитектуру, записываем в переменные:
REPO=https://repo-default.voidlinux.org/current
ARCH=x86_64

Копируем ключи с установочного диска:
mkdir -p /mnt/var/db/xbps/keys
cp /var/db/xbps/keys/* /mnt/var/db/xbps/keys/

Разворачиваем базовую систему:
XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system

Монтируем необходимые директории хоста и чрутимся в систему:
mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc

cp /etc/resolv.conf /mnt/etc/

BTRFS_OPTS=$BTRFS_OPTS PS1='(chroot) # ' chroot /mnt/ /bin/bash

Редактируем следующие файлы:
/etc/hostname - вписываем имя хоста
/etc/rc.conf - локальные настройки
/etc/default/libc-locales - раскомментируем нужные локали

Генерируем локали:
xbps-reconfigure -f glibc-locales

Задаём пароль рута:
passwd

Собираем FSTAB:
EFI_UUID=$(blkid -s UUID -o value /dev/nvme0n1p1)
ROOT_UUID=$(blkid -s UUID -o value /dev/nvme0n1p2)
cat <<EOF > /etc/fstab
UUID=$ROOT_UUID / btrfs $BTRFS_OPTS,subvol=@ 0 1
UUID=$EFI_UUID /boot/efi vfat defaults,noatime 0 2
UUID=$ROOT_UUID /home btrfs $BTRFS_OPTS,subvol=@home 0 2
UUID=$ROOT_UUID /.snapshots btrfs $BTRFS_OPTS,subvol=@snapshots 0 2
tmpfs /tmp tmpfs defaults,nosuid,nodev 0 0
EOF

Создаём свап-сабвольюм и подключаем (опционально):
btrfs subvolume create /var/swap
truncate -s 0 /var/swap/swapfile
chattr +C /var/swap/swapfile
btrfs property set /var/swap/swapfile compression none
chmod 600 /var/swap/swapfile
dd if=/dev/zero of=/var/swap/swapfile bs=1G count=16 status=progress
mkswap /var/swap/swapfile
swapon /var/swap/swapfile

Установка GRUB:
xbps-install -S grub-x86_64-efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Void Linux"

Реконфигурим всю систему, выходим из чрута, перезагружаемся:
xbps-reconfigure -fa
exit
shutdown -r now

Базовая система установлена.
Устанавливаем шел на выбор:
xbps-install -S zsh

Создаём пользователя сразу с выбранным шелом и задаём ему пароль:
useradd -m -G wheel -s /bin/zsh <username>
passwd <username>

Разрешаем группе wheel работать с sudo (раскомментировать строку с %wheel):
visudo

Дальше логинимся под юзером и устанавливаем нужные драйверы, рабочие окружения и т.д.
```
