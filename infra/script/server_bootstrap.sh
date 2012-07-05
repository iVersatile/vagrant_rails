#!/bin/sh

set -e

if [ -e /usr/local/bin/chef-solo ]; then
  echo This kitchen is ready!
  exit 0
fi

sudo apt-get update

sudo apt-get install -y ruby1.9.1 ruby1.9.1-dev \
                        rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 \
                        build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 \
                         --slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz \
                                   /usr/share/man/man1/ruby1.9.1.1.gz \
                         --slave   /usr/bin/ri ri /usr/bin/ri1.9.1 \
                         --slave   /usr/bin/irb irb /usr/bin/irb1.9.1 \
                         --slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1

sudo update-alternatives --config ruby
sudo update-alternatives --config gem

echo Finally... installing chef
sudo gem install chef --no-ri --no-rdoc
sudo gem install bundler --no-ri --no-rdoc

