#
# Cookbook Name:: riemann
# Recipe:: dashboard
#
# Copyright (C) 2013 cloudbau GmbH
# Copyright (C) 2014 Criteo
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
#

user node['riemann']['dashboard']['user'] do
  home node['riemann']['dashboard']['home']
  shell "/bin/bash"
  system true
end

directory node['riemann']['dashboard']['home'] do
  user node['riemann']['dashboard']['user']
end

[ 'ruby', 'ruby-devel', 'rubygems' ].each do |pkg|
  package pkg do
    action :install
  end
end

gem_package 'bundler' do
  action :install
end

cookbook_file "#{node['riemann']['dashboard']['home']}/Gemfile" do
  source "dashboard/Gemfile"
  mode "0755"
end

template "/etc/init.d/riemann-dash" do
  source "dashboard/riemann-dash.erb"
  owner "root"
  group "root"
  mode "0711"
end

execute 'bundle install --path vendor/bundle' do
  cwd node['riemann']['dashboard']['home']
  user node['riemann']['dashboard']['user']
  not_if 'bundle check'
end

template "#{node['riemann']['dashboard']['home']}/config.yml" do
  source "dashboard/config.yml.erb"
  owner node['riemann']['dashboard']['user']
  mode '0644'
end

template "#{node['riemann']['dashboard']['home']}/config.ru" do
  source "dashboard/config.ru.erb"
  owner node['riemann']['dashboard']['user']
end

service "riemann-dash" do
  supports :restart => true, :start => true, :stop => true, :reload => false
  action [:enable, :start]
end

