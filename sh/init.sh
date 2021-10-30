#!/bin/bash

source colors.sh

echo
echo $(yellow "---------------------------------")
echo "->-> create new djangocms project"
echo "Usage: ./init.sh [yourProjectName, default=myproject]"
echo
PROJECT_NAME='myproject'
if test -z "$1"
then
    echo Your default project name is $(yellow $PROJECT_NAME)
else
      PROJECT_NAME=$1
fi

if [  -d "$PROJECT_NAME" ]; then
  echo $(red HINT: projectName ${PROJECT_NAME} already exists.)
  exit
fi

command1=$(pip install --upgrade pip)
if [ $? -eq 0 ]; then
    echo "update pip ...................  $(green OK)"
else
  echo $(red FAIL TO UPDATE pip)
  exit
fi

command2=$(pip install djangocms-installer)
if [ $? -eq 0 ]; then
  echo "install djangocms ................. $(green OK)"
else
  echo $(red FAIL TO install djangocms)
  exit
fi

command3=$(pip install pytz)
if [ $? -eq 0 ]; then
  echo "install pytz ...................... $(green OK)"
else
  echo $(red FAIL TO install pytz)
  exit
fi

echo  "please wait while building project $(yellow ${PROJECT_NAME})"
command3=$(djangocms myproject)
if [ $? -eq 0 ]; then
  echo
  echo "djangocms myproject ................ $(green OK)"
else
  echo $(red FAIL TO start $PROJECT_NAME)
  exit
fi
echo "run command: pyton manae.py runserver [port]"
echo $(yellow "---------------------------------")
echo
