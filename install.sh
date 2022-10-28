#!/bin/sh

wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.3.6-stable.tar.xz -O flutter
tar xf flutter

git clone https://github.com/flutter/samples
mv samples/game_template/* .
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository "deb http://dl.google.com/linux/chrome/deb/ stable main"
sudo apt update -y
sudo apt install google-chrome-stable -y 