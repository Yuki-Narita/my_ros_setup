#!/bin/bash

###########################################
# ROS環境セットアップ用シェルスクリプト(kinetic) #
###########################################

read -p "password? : " password

#######################
# システムのアップデート #
#######################

echo $password | sudo -S apt -y update
echo $password | sudo -S apt -y upgrade
echo $password | sudo -S apt -y dist-upgrade

########################
# home 以下を英語に変更 #
########################

env LANG=C xdg-user-dirs-gtk-update


################################
# デュアルブートでの時計ズレを修正 #
################################

echo $password | sudo -S timedatectl set-local-rtc true


#################
# bashrc の設定 #
#################

# ターミナルにgitのブランチ表示
echo "if [ -f /etc/bash_completion.d/git-prompt ]; then" >> ~/.bashrc
echo "    export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w\$(__git_ps1) \n\[\033[01;34m\]\\$\[\033[00m\] '" >> ~/.bashrc
echo "else" >> ~/.bashrc
echo "    export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \n\[\033[01;34m\]\\$\[\033[00m\] '" >> ~/.bashrc
echo "fi" >> ~/.bashrc

# エイリアス
echo "alias cm='cd ~/catkin_ws && catkin build'" >> ~/.bashrc
echo "alias bashrc='vim ~/.bashrc'" >> ~/.bashrc
echo "alias cs='cd ~/catkin_ws/src'" >> ~/.bashrc

echo "alias terminator8='terminator -l ros8 & exit'" >> ~/.bashrc
echo "alias terminatorm='terminator -l rosmulti & exit'" >> ~/.bashrc



###################
# ROSのインストール #
###################

echo $password | sudo -S sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
yes | sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
echo $password | sudo -S apt -y update
echo $password | sudo -S apt -y install ros-kinetic-desktop-full
echo $password | sudo -S rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
echo $password | sudo -S apt -y install python-rosinstall


########################
# ワークスペースの設定 #
########################

echo $password | sudo -S apt -y install python-catkin-tools
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws && catkin build
cd ~
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

#######################
# turtlebot関連の設定 #
#######################

echo $password | sudo -S apt -y install ros-kinetic-turtlebot ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-interactions ros-kinetic-turtlebot-simulator ros-kinetic-kobuki-ftdi ros-kinetic-ar-track-alvar-msgs
. /opt/ros/kinetic/setup.bash
rosrun kobuki_ftdi create_udev_rules
echo "export TURTLEBOT_3D_SENSOR=kinect" >> ~/.bashrc
source ~/.bashrc
#echo $password | sudo -S apt -y install ros-kinetic-rtabmap-ros

##########################
# その他ツールのインストール #
##########################
echo $password | sudo -S add-apt-repository -y ppa:maarten-baert/simplescreenrecorder
echo $password | sudo -S apt -y update
echo $password | sudo -S apt -y install simplescreenrecorder
echo $password | sudo -S apt install -y vim terminator openssh-server

# terminator設定
mkdir -p ~/.config/terminator
curl https://raw.githubusercontent.com/Yuki-Narita/my_ros_setup/master/terminator_config > ~/.config/terminator/config

# git
#curl https://raw.githubusercontent.com/Yuki-Narita/my_ros_setup/master/git_config > ~/.gitconfig

#######################
# multiSLAM関連の設定 #
#######################
#cd ~/catkin_ws/src
#git clone https://github.com/hidakalab-robot/multiple_robots_slam.git
#catkin build

#sudo sh -c "echo 0 >/proc/sys/net/ipv4/icmp_echo_ignore_broadcasts"
#echo 'net.ipv4.icmp_echo_ignore_broadcasts=0' | sudo tee -a /etc/sysctl.conf > /dev/null
#sudo service procps restart

##########
# 後片付け #
##########

echo $password | sudo -S apt -y update
echo $password | sudo -S apt -y upgrade
echo $password | sudo -S apt -y dist-upgrade
echo $password | sudo -S apt -y autoremove

echo スクリプトが終了しました
#echo あとはVScodeとchromeの最新版をインストールしてください
