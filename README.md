# my_ros_setup
kinetic用
ubuntu16.04をインストールした直後のセットアップ用

## ros_setup.sh
セットアップを自動化したやつ
スクリプトを実行するとROSのインストール等を自動でやってくれるはず
<!--
``
$ sh ros_setup.sh
``
-->

## terminator_config
terminatorの設定ファイル(自分用)
<!--
1. ファイル名を config にリネーム
2. ~/.config/terminator/ に配置
-->
## git_config
.gitconfig

## インストールコマンド
```
$ sudo apt install curl

$ bash <(curl -sL https://raw.githubusercontent.com/Yuki-Narita/my_ros_setup/master/ros_setup.sh)
```
