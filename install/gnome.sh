#!/bin/bash
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

  wget "https://github.com/SAP/SapMachine/releases/download/sapmachine-11.0.2/sapmachine-jdk-11.0.2_linux-x64_bin.tar.gz" -O /home/vagrant/sapmachine-jdk-11.0.2_linux-x64_bin.tar.gz && touch java.is.done
if [ ! -d /usr/java ]; then
  sudo mkdir /usr/java
fi
sudo tar -xzf /home/vagrant/sapmachine-jdk-11.0.2_linux-x64_bin.tar.gz -C /usr/java
 
sudo ln -s /usr/sbin/update-alternatives /usr/sbin/alternatives
sudo alternatives --install "/usr/bin/java" "java" "/usr/java/sapmachine-11.0.2/bin/java" 1
sudo update-alternatives --set java /usr/java/sapmachine-11.0.2/bin/java
 
wget "https://download2.gluonhq.com/openjfx/11.0.2/openjfx-11.0.2_linux-x64_bin-jmods.zip" -O /home/vagrant/openjfx-11.0.2_linux-x64_bin-jmods.zip && touch fx.is.done
sudo unzip /home/vagrant/openjfx-11.0.2_linux-x64_bin-jmods.zip -d /home/vagrant/
sudo cp -r /home/vagrant/javafx-jmods-11.0.2/* /usr/java/sapmachine-11.0.2/jmods
sudo touch /usr/java/sapmachine-11.0.2/lib/javafx.properties

#Cleanup
sudo rm -rf /home/vagrant/sapmachine-jdk-11.0.2_linux-x64_bin.tar.gz
sudo rm -rf /home/vagrant/openjfx-11.0.2_linux-x64_bin-jmods.zip
sudo rm -rf /home/vagrant/javafx-jmods-11.0.2
