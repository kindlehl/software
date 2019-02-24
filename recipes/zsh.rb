package %w( curl git zsh )

execute "curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sudo -u #{node['username']} sh" do
  creates "/home/#{node['username']}/.oh-my-zsh"
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
