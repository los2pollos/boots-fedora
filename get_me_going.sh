#!/bin/bash

if ! [ $(id -u) = 0 ]; then
  echo "This script must be run as sudo or root, try again..."
  exit 1
fi

### Per velocizzare il processo senza dover mettere sempre Y ###
echo "defaultyes=True" >> /etc/dnf/dnf.conf


basic_kde_packages='NetworkManager-config-connectivity-fedora bluedevil breeze-gtk breeze-icon-theme cagibi colord-kde cups-pk-helper dolphin glibc-all-langpacks gnome-keyring-pam kcm_systemd kde-gtk-config kde-partitionmanager kde-print-manager kde-settings-pulseaudio kde-style-breeze kdegraphics-thumbnailers kdeplasma-addons kdialog kdnssd kf5-akonadi-server kf5-akonadi-server-mysql kf5-baloo-file kf5-kipi-plugins khotkeys kmenuedit konsole5 kscreen kscreenlocker ksshaskpass ksysguard kwalletmanager5 kwebkitpart kwin pam-kwallet phonon-qt5-backend-gstreamer pinentry-qt plasma-breeze plasma-desktop plasma-desktop-doc plasma-drkonqi plasma-nm plasma-nm-l2tp plasma-nm-openconnect plasma-nm-openswan plasma-nm-openvpn plasma-nm-pptp plasma-nm-vpnc plasma-pa plasma-user-manager plasma-workspace plasma-workspace-geolocation polkit-kde qt5-qtbase-gui qt5-qtdeclarative sddm sddm-breeze sddm-kcm sni-qt xorg-x11-drv-libinput setroubleshoot kfind plasma-pk-updates plasma-discover firewall-config kgpg kate ark kget kcalc kmousetool kcharselect gwenview spectacle flatpak'

my_packages='timeshift'

my_flatpaks='com.toggl.TogglDesktop com.github.phase1geo.minder org.libreoffice.LibreOffice com.jgraph.drawio.desktop org.signal.Signal org.telegram.desktop org.mozilla.Thunderbird us.zoom.Zoom com.github.xournalpp.xournalpp org.videolan.VLC org.mozilla.firefox'

dnf install $basic_kde_packages
dnf install $my_packages
dnf install @"Hardware Support" @base-x @Fonts @"Common NetworkManager Submodules" @"Printing Support" @"Input Methods" @"Multimedia"


flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

for package in $my_flatpaks
do
  flatpak install --noninteractive flathub $package
  echo $package
done

### Cancella l'opzione Y di default aggiunta all'inizio dello scritp nel file di configurazione di dnf ###
sed -i '$d' /etc/dnf/dnf.conf
