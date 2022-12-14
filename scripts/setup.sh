export DEBIAN_FRONTEND=noninteractive

# configure user
export USER_NAME=ubuntu
export USER_ID=1000
apt-get update
apt-get install -y sudo
useradd -l -u ${USER_ID} -G sudo -md /home/${USER_NAME} -s /bin/bash -p ${USER_NAME} ${USER_NAME}

# configure ssh
apt-get install -y openssh-server xauth

mkdir /var/run/sshd
ssh-keygen -t rsa
mv /sshd_config /etc/ssh/sshd_config

# configure vnc with gnome desktop
apt-get instal -y ubuntu-desktop
apt-get install -y gnome-core gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
apt-get install -y vnc4server
vncserver :1
mv /xstartup /home/${USER_NAME}/.vnc/xstartup
vncserver -kill :1

# configure some recommended tools
apt-get install -y vim tmux net-tools

# configure network related stuffs
mv /resolv.conf /etc/resolv.conf
sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
apt-get update

# clean
apt-get clean