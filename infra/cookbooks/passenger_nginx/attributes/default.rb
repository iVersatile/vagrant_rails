default[:passenger][:version]     = "3.0.12"
default[:passenger][:max_pool_size] = "6"
default[:passenger][:root_path]   = "#{languages[:ruby][:gems_dir]}/gems/passenger-#{passenger[:version]}"
default[:passenger][:nginx_version] = "1.1.17"
default[:passenger][:nginx_prefix] = "/usr"
default[:passenger][:nginx_conf] = "/etc"
default[:passenger][:nginx_flags] = [
    "--conf-path=#{node[:passenger][:nginx_conf]}/nginx.conf",
    "--with-http_gzip_static_module",
    "--with-http_ssl_module",
    "--without-http_ssi_module",
    "--with-http_realip_module",
    "--with-http_degradation_module",
    "--with-http_geoip_module",
    "--with-google_perftools_module",
    "--with-http_mp4_module",
    "--with-http_flv_module",
    "--with-http_stub_status_module",
    "--without-mail_pop3_module",
    "--without-mail_imap_module",
    "--without-mail_smtp_module"
  ]