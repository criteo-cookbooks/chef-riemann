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
  notifies :start, resources(:service => 'riemann-dash')
end
