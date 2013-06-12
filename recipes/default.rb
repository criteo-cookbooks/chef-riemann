include_recipe 'runit'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node[:riemann][:ruby_version] do
  global true
end
