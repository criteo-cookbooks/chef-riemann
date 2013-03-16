user "riemann" do
  home "/home/riemann"
  shell "/bin/bash"
  system true
end

if Chef::Config[:solo]
  riemann_server = {
    "riemann_server_ipaddress" => node.ipaddress.first,
  }
  databag_item = Chef::DataBagItem.new
  databag_item.data_bag("riemann_server")
  databag_item.raw_data = riemann_server
  databag_item.save
end

remote_file "/tmp/riemann_#{version}_all.deb" do
  source "http://aphyr.com/riemann/riemann_#{version}_all.deb"
  mode 0644
end

dpkg_package "/tmp/riemann_#{version}_all.deb"

runit_service "riemann"

service "riemann" do
  supports :restart => true
  action [:start]
end

template "/etc/riemann/riemann.config" do
  source "riemann.config.erb"
  owner "root"
  group "root"
  mode 0644

  notifies :restart, resources(:service => 'riemann')
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