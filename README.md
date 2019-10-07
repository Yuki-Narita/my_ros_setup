# ROS環境のセットアップをする際に必要な工程のメモ
自分用

## ros_setup.sh
#セットアップを自動化したやつ(メインコンテンツ)
#ファイルを実行するとROSのインストール等を自動でやってくれるはず

#``
#$ sh ros_setup.sh
#``

## terminator_config
#terminatorの設定ファイル(自分用)
#1. ファイル名を config にリネーム
#2. ~/.config/terminator/ に配置

``
$ curl -sLf https://raw.githubusercontent.com/Yuki-Narita/my_ros_setup/master/ros_setup.sh | bash
``
