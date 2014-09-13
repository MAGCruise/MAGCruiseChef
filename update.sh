#!/bin/sh

# update repositoty
git pull
git submodule update

# update ruby gems
bundle install

# update community cookbooks for Berkfile
rm -rf cookbooks
bundle ex berks vendor cookbooks
