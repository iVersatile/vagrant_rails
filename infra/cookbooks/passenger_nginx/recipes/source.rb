#
# Cookbook Name:: passenger_nginx
# Recipe:: default
#
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Author:: Joshua Sierles (<joshua@37signals.com>)
# Author:: Michael Hale (<mikehale@gmail.com>)
# Author:: Dave Miller (<dave@rabblemedia.net>)
#
# Copyright:: 2009, Opscode, Inc
# Copyright:: 2009, 37signals
# Copyright:: 2009, Michael Hale
# Copyright:: 2012, Rabble Media, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


include_recipe "build-essential"

nginx_version = node[:passenger][:nginx_version]
nginx_flags = node[:passenger][:nginx_flags]
nginx_prefix = node[:passnger][:nginx_prefix]

case node[:platform]
when "centos","redhat"
  if node['platform_version'].to_f < 6.0
    package 'curl-devel'
  else
    package 'libcurl-devel'
    package 'openssl-devel'
    package 'zlib-devel'
  end
else
  %w{ libcurl4-gnutls-dev libssl-dev }.each do |pkg|
    package pkg do
      action :upgrade
    end
  end
end

gem_package "passenger" do
  version node[:passenger][:version]
end

remote_file "#{Chef::Config[:file_cache_path]}/nginx-#{nginx_version}.tar.gz" do
  source "http://nginx.org/download/nginx-#{nginx_version}.tar.gz"
  action :create_if_missing
end

bash "extract_nginx_source" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
  tar zxvf nginx-#{nginx_version}.tar.gz
  EOH
end

execute "passenger_module" do
  command "passenger-install-nginx-module --nginx-source-dir=#{Chef::Config[:file_cache_path]}/nginx-#{nginx_version} --auto --prefix=#{nginx_prefix} --extra-configure-flags=#{nginx_flags}"
  creates node[:passenger][:module_path]
end
