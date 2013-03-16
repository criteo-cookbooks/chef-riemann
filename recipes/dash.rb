user "riemann-dash" do
  home "/home/riemann-dash"
  shell "/bin/bash"
  system true
end

gem_package "riemann-dash" do
  action :install
end

runit_service "riemann-dash"

service "riemann-dash" do
  supports :restart => true
  supports :start => true
  action [ :restart ]
end

remote_directory "/opt/riemann-dash" do
  source "riemann-dash"
  owner "riemann-dash"
  group "riemann-dash"
  files_owner "riemann-dash"
  files_group "riemann-dash"

  notifies :restart, resources(:service => 'riemann-dash')
end
