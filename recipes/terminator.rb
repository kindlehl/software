package 'terminator'

python_runtime '2' do
  get_pip_url 'https://github.com/pypa/get-pip/raw/f88ab195ecdf2f0001ed21443e247fb32265cabb/get-pip.py'
  pip_version '18.0'
end

python_package 'requests'

terminator_conf_dir = File.join node['home'], '.config/terminator'

directory File.join terminator_conf_dir, 'plugins' do
  recursive true
  owner node['username']
  group node['username']
end

cookbook_file File.join terminator_conf_dir, 'config' do
  source 'terminator'
  owner node['username']
  group node['username']
end

plugin_url = ` expr $(terminator -v | cut -d' ' -f2) \>= 1.90 ` ? 'https://git.io/v5Zww' : 'https://git.io/v5Zwz'

remote_file File.join terminator_conf_dir, 'plugins/terminator-themes.py' do
  source plugin_url
  owner node['username']
  group node['username']
end
