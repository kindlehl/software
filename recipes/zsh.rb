package %w( curl git zsh )

execute 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"' do
  user node['username']
  group node['username']
  cwd File.join '/home', node['username']
  creates '.oh-my-zsh'
end

%w(
  .zshrc
  .work_specific
).each do |dotfile|
  cookbook_file File.join "/home/#{node['username']}", dotfile do
    source dotfile
    owner node['username']
    group node['username']
  end
end

user node['username'] do
  shell '/bin/zsh'
  action :modify
end
