# repo for virtualbox packages
apt_repository 'oracle' do
  uri 'http://download.virtualbox.org/virtualbox/debian'
  trusted true
  components %w(contrib)
end

package 'virtualbox-5.2'

node.default['vagrant']['user'] = node['username']
include_recipe 'vagrant'

%w(
  vagrant-berkshelf
  vagrant-ohai
).each do |plugin|
  vagrant_plugin plugin do
    user node['username']
  end
end
