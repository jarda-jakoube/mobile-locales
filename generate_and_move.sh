#!/bin/bash
APP_PATH=$1
if [ -z "$APP_PATH" ]
then
  echo "Add app directory as argument!"
else
  if [ -d "$APP_PATH" ]
  then
    docker build -t translations:v1 .
    docker run -v $PWD/android-output:/app/android-output -v $PWD/ios-output:/app/ios-output translations:v1
    echo $APP_PATH
    echo 'moving czech';
    cp android-output/values-cs/strings.xml $APP_PATH/app/src/main/res/values/strings.xml
    echo 'moving slovak';
    cp android-output/values-sk/strings.xml $APP_PATH/app/src/main/res/values-sk/strings.xml
    echo 'done';
  else
    echo "Error: ${APP_PATH} not found. Can not continue."
    exit 1
  fi
fi