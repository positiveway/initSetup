InstallCMD="sudo apt install -y"
UpdateCMD="sudo apt update"
DownloadStdOut="wget -O -"

sudo apt autoremove -y

#custom kernels 1
echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list
$DownloadStdOut https://dl.xanmod.org/gpg.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/xanmod-kernel.gpg add -
$UpdateCMD

#time dualboot
timedatectl set-local-rtc 1

#build
$InstallCMD git curl build-essential libssl-dev unzip

#extensions
$InstallCMD gnome-shell-extensions chrome-gnome-shell gnome-tweaks

#kernel build
$InstallCMD libncurses-dev gawk flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf

#multimedia
$InstallCMD ubuntu-restricted-extras


#controller
$InstallCMD libappindicator3-dev gir1.2-appindicator3-0.1 libgtk-3-dev libgtkmm-3.0-dev clang libsdl2-dev libdrm-dev libhidapi-dev libusb-1.0-0 libusb-1.0-0-dev libevdev-dev

#VPN
$InstallCMD openresolv wireguard
cd ../../VPN/keychains
sudo cp -R ./ /etc/wireguard
sudo chown root:root -R /etc/wireguard && sudo chmod 600 -R /etc/wireguard

#rust
$DownloadStdOut https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

#go
goVersion="19"

goPackage="go1.$goVersion.linux-amd64.tar.gz"
wget https://go.dev/dl/$goPackage
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $goPackage
rm ./$goPackage

#python
pythonVer="10"

pythonPackage="python3.$pythonVer"
sudo add-apt-repository -y ppa:deadsnakes/ppa && $UpdateCMD
$InstallCMD $pythonPackage $pythonPackage-dev $pythonPackage-gdbm $pythonPackage-venv


cd $HOME/Documents

#bdprochot
prochotRepo="turnoff-BD-PROCHOT"
sudo rm -rf ./$prochotRepo
git clone https://github.com/yyearth/$prochotRepo.git


#custom kernels 2
$InstallCMD linux-xanmod linux-xanmod-edge


exit
#mouse
$InstallCMD imwheel
bash <($DownloadStdOut http://www.nicknorton.net/mousewheel.sh)
chmod +x mousewheel.sh
./mousewheel.sh


