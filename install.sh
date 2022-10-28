#!/bin/sh

wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.3.6-stable.tar.xz -O flutter
tar xf flutter

git clone https://github.com/flutter/samples
mv samples/game_template/* .