#
# Cookbook Name:: riemann-server
# Recipe:: dash
#
# Copyright (C) 2013 cloudbau GmbH
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

include_recipe 'runit'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node[:riemann][:ruby_version]

user "riemann-dash" do
  home "/home/riemann-dash"
  shell "/bin/bash"
  system true
end

directory "/home/riemann-dash" do
  user "riemann-dash"
end

rbenv_gem "riemann-dash" do
  ruby_version node[:riemann][:ruby_version]
  action :install
end

runit_service "riemann-dash"

service "riemann-dash" do
  supports :restart => true
  supports :start => true
end

remote_directory "/opt/riemann-dash" do
  source "riemann-dash"
  owner "riemann-dash"
  group "riemann-dash"
  files_owner "riemann-dash"
  files_group "riemann-dash"
  notifies :restart, 'service[riemann-dash]'
end
