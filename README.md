# Instructions

This repo contains nearly all that's necessary to have a rails dev workstation
setup. There are a couple assumptions:

1. Your host has git installed.
2. Your host has VirtualBox installed.
3. You have the vagrant gem installed.

If those dependencies are satisfied then you should be able to do the following:

    git clone git@github.com:scottmuc/vagrant_rails.git
    cd vagrant_rails
    vagrant up dev
    vagrant ssh dev
    cd workspace && script/server
    # visit http://localhost:9292/

