#!/usr/bin/env bash

echo "PROVISIONNNNNNN!!!1"

# thanks god for RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
# using "bash -s stable --ruby" doesn't work ATM
curl -sSL https://get.rvm.io | bash -s stable
source /home/vagrant/.rvm/scripts/rvm
rvm install 2.4.1
rvm --default use 2.4.1

# jekyll!!
gem install jekyll bundler

# get dependencies for the blog
# note that this is completely dependant on the default path that vagrant mounts
bundle install --gemfile=/vagrant/Gemfile

# turns out that jekyll requires some kind of javascript runtime, so let's get node
sudo yum install -y epel-release
sudo yum install -y nodejs

# we want to serve the blog when the machine is up, because it's cool
LINE='cd /vagrant && source /home/vagrant/.rvm/scripts/rvm && bundle exec jekyll serve --detach --host 0.0.0.0'
FILE='/home/vagrant/.bashrc'
grep -qF "$LINE" $FILE || echo "$LINE" >> $FILE
