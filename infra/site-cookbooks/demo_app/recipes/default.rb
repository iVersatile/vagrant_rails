package 'nodejs'


cookbook_file '/opt/nginx/conf/nginx.conf' do
  source 'nginx.conf'
end

bash 'install bundle' do
  code <<-EOH
  cd /opt/nginx/sites/app
  bundle install --deployment
  EOH
end

bash 'setup db' do
  code <<-EOH
  cd /opt/nginx/sites/app
  rake db:reset
  EOH
end

execute 'start nginx' do
  command '/opt/nginx/sbin/nginx'
end

