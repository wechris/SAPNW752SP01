echo "install Gnome..."
sudo zypper ar obs://GNOME:/STABLE:/3.16/openSUSE_13.2/GNOME:STABLE:3.16
sudo zypper mr -p 98 -r GNOME:STABLE:3.16
sudo zypper dup --from GNOME:STABLE:3.16
zypper install gnome-shell metatheme-adwaita-common gnome-shell-lang gnome-desktop-lang
zypper --non-interactive install --force-resolution --no-confirm --auto-agree-with-licenses patterns-openSUSE-gnome

sudo sed -i 's/"sddm"/"gdm"/g' /etc/sysconfig/displaymanager
sudo echo "/usr/bin/Xorg                 root:root       4711" >> /etc/permissions.local
sudo ln -svf /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target
sudo chkstat --system --set

echo "install JAVA..."
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.rpm
sudo zypper --non-interactive remove --force-resolution 'java*'
sudo ln -s /usr/sbin/update-alternatives /usr/sbin/alternatives
sudo rpm -ivh --nodeps /home/vagrant/jdk-8u191-linux-x64.rpm
 
sudo alternatives --install "/usr/bin/java" "java" "/usr/java/jdk1.8.0_191-amd64/bin/java" 1
sudo update-alternatives --set java /usr/java/jdk1.8.0_191-amd64/bin/java

