#!/usr/bin/env bash

cp .gitconfig ~

mkdir .ssh
for privkey in $(ls *.crypt | awk -F '.' '{print $1}'); do
  cat $privkey.crypt | openssl enc -d -des3 -base64 -pbkdf2 | tee .ssh/$privkey
  chmod 0400 .ssh/$privkey
  cp $privkey.pub .ssh
done

mv .ssh ~
eval $(ssh-agent)
ssh-add
