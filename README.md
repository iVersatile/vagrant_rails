# Instructions

This repo contains nearly all that's necessary to have a rails dev workstation
setup. There are a couple assumptions:

1. Your host has [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed.
2. You have the [vagrant](http://downloads.vagrantup.com/tags/v1.0.3) installed installed.

If those dependencies are satisfied then you should be able to do the following:

    vagrant up dev
    vagrant ssh dev
    cd workspace && script/server
    # visit http://localhost:9292/

or

    vagrant up deploy
    # visit http://localhost:8080/

