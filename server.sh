#!/bin/sh

if [ ! -f /opt/minecraft/data/server.properties ];
then
  echo "Config file does not exists. Copying from defaults"
  cp /opt/minecraft/server.properties.default /opt/minecraft/data/server.properties
fi

if [ ! -f /opt/minecraft/data/.rcon-cli.yaml ];
then
  echo "RCON Cli config not found. Creating defaults"
  echo "host: 127.0.0.1"  >   /opt/minecraft/data/.rcon-cli.yaml
  echo "port: 25575"      >>  /opt/minecraft/data/.rcon-cli.yaml
  echo "password: 123456" >>  /opt/minecraft/data/.rcon-cli.yaml
fi

ln -s /opt/minecraft/data/.rcon-cli.yaml $HOME

cd /opt/minecraft/data
java -jar /opt/minecraft/tuinity-paperclip.jar
