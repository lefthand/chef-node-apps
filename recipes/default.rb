#
# Cookbook Name:: node_apps
# Recipe:: default
#
# Copyright (C) 2015 Justin Bodeutsch
# 
# All rights reserved - Do Not Redistribute
#

node.set['nodejs']['install_method'] = 'package'

node.set['apache']['version'] = "2.4"
node.set['apache']['pid_file'] = "${APACHE_PID_FILE}"
node.set['apache']['ext_status'] = true

include_recipe "apache2"
include_recipe "apache2::mod_proxy_http"
include_recipe "nodejs"

apache_site "000-default" do
  enable false
end

directory node['node_app']['log_path'] do
  mode "0775"
  owner node['node_app']['user']
  group node['node_app']['user']
  recursive true
  action :create
end

logrotate_app "node_logs" do
  path node['node_app']['log_path']
  frequency "weekly"
  rotate 12 
  create "644 #{node['node_app']['user']} #{node['node_app']['user']}"
end

node['node_app']['apps'].each do |app|

  directory "/var/www/html/#{app['url']}" do
    mode "0775"
    owner node['node_app']['user']
    group node['node_app']['user']
    recursive true
    action :create
  end

  template = app['template'] || 'app.conf.erb'
  cookbook = app['cookbook'] || 'node_app'
  port = app['port'] || '3000'
  command = app['command'] || 'bin/www'
  if app['capistrano_style']
    docroot = "/var/www/html/#{app['url']}/current"

    directory "/var/www/html/#{app['url']}/releases" do
      mode "0775"
      owner node['node_app']['user']
      group node['node_app']['user']
      recursive true
      action :create
    end
    directory "/var/www/html/#{app['url']}/shared" do
      mode "0775"
      owner node['node_app']['user']
      group node['node_app']['user']
      recursive true
      action :create
    end

  else
    docroot = "/var/www/html/#{app['url']}"
  end

  template "/etc/init/#{app['name']}.conf" do
    source "app.init.erb"
    user "root"
    group "root"
    mode "0644"
    variables({
      :name => app['name'],
      :command => command,
      :docroot => docroot
    })
  end

  web_app app['url'] do
    server_name app['url']
    docroot docroot
    template template
    cookbook cookbook
    port port
    notifies :restart, "service[apache2]"
  end
end
