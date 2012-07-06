# -*- mode: ruby -*-
# vi: set ft=ruby :
HERE = File.dirname(__FILE__)
INFRA_DIR = "#{HERE}/infra"
APP_DIR = "#{HERE}/app"

Vagrant::Config.run do |config|
  # Production is Ubunti 12.04 so is our Vagrant box
  config.vm.box     = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # We want to use the same ruby version that production will use
  config.vm.provision :shell, :path => "#{INFRA_DIR}/script/server_bootstrap.sh"

  config.vm.define :dev do |config|
    # Setting up a share so we can edit locally but run in vagrant
    config.vm.share_folder "rails_app", "/home/vagrant/workspace", "#{APP_DIR}"

    # Using default rack settings
    config.vm.forward_port 9292, 9292

    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["#{INFRA_DIR}/site-cookbooks", "#{INFRA_DIR}/cookbooks"]
      chef.add_recipe("apt")
      chef.add_recipe("postgresql::apt_postgresql_ppa")
      chef.add_recipe("postgresql::server")
      chef.add_recipe "workstation::git"
      chef.add_recipe "workstation::bash"
      chef.add_recipe "workstation::vim"
      chef.add_recipe "workstation::default"
      chef.json = {
                    :postgresql => {
                      :version  => "9.1",
                      :listen_addresses => "*",
                      :hba => [
                        { :method => "trust", :address => "0.0.0.0/0" },
                        { :method => "trust", :address => "::1/0" },
                      ],
                      :password => {
                        :postgres => "password"
                      }
                    }
                  }
    end
  end

  config.vm.define :deploy do |config|
    # Now using production like web servers
    config.vm.forward_port 80, 8080

    config.vm.share_folder "rails_app", "/opt/nginx/sites/app", "#{APP_DIR}"

    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["#{INFRA_DIR}/site-cookbooks", "#{INFRA_DIR}/cookbooks"]
      chef.add_recipe("apt")
      chef.add_recipe("postgresql::apt_postgresql_ppa")
      chef.add_recipe("postgresql::server")
      chef.add_recipe 'passenger_nginx'
      chef.add_recipe 'demo_app'
      chef.json = {
                    :passenger => { :nginx_prefix => '/opt/nginx' },
                    :postgresql => {
                      :version  => "9.1",
                      :listen_addresses => "*",
                      :hba => [
                        { :method => "trust", :address => "0.0.0.0/0" },
                        { :method => "trust", :address => "::1/0" },
                      ],
                      :password => {
                        :postgres => "password"
                      }
                    }
                  }
    end
  end
end
