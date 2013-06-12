include_recipe "riemann-server::default"
include_recipe "java"

user "riemann" do
  home "/home/riemann"
  shell "/bin/bash"
  system true
end

if platform_family?("debian")

  remote_file "/tmp/riemann_#{node[:riemann][:server][:version]}_all.deb" do
    source "http://aphyr.com/riemann/riemann_#{node[:riemann][:server][:version]}_all.deb"
    mode 0644
  end

  dpkg_package "/tmp/riemann_#{node[:riemann][:server][:version]}_all.deb"

elsif platform?("redhat", "centos", "fedora", "amazon", "scientific")

  include_recipe "yum::epel"
  
  remote_file "/tmp/riemann-#{node[:riemann][:server][:version]}-1.noarch.rpm" do
    source "http://aphyr.com/riemann/riemann-#{node[:riemann][:server][:version]}-1.noarch.rpm"
    mode 0644
  end

  yum_package "/tmp/riemann-#{node[:riemann][:server][:version]}-1.noarch.rpm"

end

runit_service "riemann"

service "riemann" do
  supports :restart => true
  action [:start]
end

node.set[:riemann][:server][:service] = true
node.set[:riemann][:server][:bind_ip] = node[:ipaddress] unless node[:riemann][:server][:bind_ip]

template "/etc/riemann/riemann.config" do
  source "riemann.config.erb"
  owner "root"
  group "root"
  mode 0644

  notifies :restart, resources(:service => 'riemann')
  variables :bind_ip => node[:riemann][:server][:bind_ip]
end

directory "/var/log/riemann/" do
  mode 0755
  owner 'riemann'
  group 'riemann'
  action :create
end

directory "/usr/lib/riemann" do
  mode 0775
  owner 'riemann'
  group 'riemann'
  action :create
end
