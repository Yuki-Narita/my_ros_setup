#########################################
# ROS環境セットアップ用シェルスクリプト #
#########################################

#########################
# home 以下を英語に変更 #
#########################

#GUI
#$ env LANG=C xdg-user-dirs-gtk-update
#CUI
env LANG=C xdg-user-dirs-update


#####################
# ROSのインストール #
#####################

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
yes | sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt -y update
sudo apt -y install ros-kinetic-desktop-full
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
sudo apt -y install python-rosinstall


########################
# ワークスペースの設定 #
########################

sudo apt -y install python-catkin-tools
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/ & catkin build
cd ~
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc


#######################
# turtlebot関連の設定 #
#######################

sudo apt -y install ros-kinetic-turtlebot ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-interactions ros-kinetic-turtlebot-simulator ros-kinetic-kobuki-ftdi ros-kinetic-ar-track-alvar-msgs
. /opt/ros/kinetic/setup.bash
rosrun kobuki_ftdi create_udev_rules
echo "export TURTLEBOT_3D_SENSOR=kinect" >> ~/.bashrc
source ~/.bashrc
sudo apt -y install ros-kinetic-rtabmap-ros


#######################
# multiSLAM関連の設定 #
#######################
sudo sh -c "echo 0 >/proc/sys/net/ipv4/icmp_echo_ignore_broadcasts"
echo 'net.ipv4.icmp_echo_ignore_broadcasts=0' | sudo tee -a /etc/sysctl.conf > /dev/null
sudo service procps restart


###################################################
# その他便利ツールのインストール 及び　細かい設定 #
###################################################

sudo apt -y install terminator
sudo apt -y install vim

cd ~/catkin_ws/src
git clone https://github.com/Yuki-Narita/multiple_robots_slam.git
cd ~/catkin_ws & catkin build

##以下bashrcの設定

# ターミナルにgitのブランチ表示
echo "#ターミナルにgitのブランチ名表示" >> ~/.bashrc
echo "if [ -f /etc/bash_completion.d/git-prompt ]; then
    export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '
else
    export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \n\[\033[01;34m\]\$\[\033[00m\] '
fi" >> ~/.bashrc

# ROSのホスト設定のテンプレート
echo "export ROS_HOSTNAME=rosdesk" >> ~/.bashrc
echo "export ROS_MASTER_URI=http://rosdesk:11311" >> ~/.bashrc

# 短縮コマンド
echo "alias cm='cd ~/catkin_ws && catkin build'" >> ~/.bashrc
echo "alias bash='vim ~/.bashrc'" >> ~/.bashrc
echo "alias cs='cd ~/catkin_ws/src'" >> ~/.bashrc

echo "alias terminator8='terminator -l ros8 & exit'" >> ~/.bashrc
echo "alias terminator6='terminator -l ros6 & exit'" >> ~/.bashrc
echo "alias terminatorm='terminator -l rosmulti & exit'" >> ~/.bashrc

## あとは etc/host の設定をすればok
sudo apt -y update
sudo apt -y upgrade