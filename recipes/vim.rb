#
# Cookbook:: software
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

vimpkg = node['platform'] == 'debian' ? 'vim-nox' : 'vim'

package vimpkg
package %w(
  python2.7-dev
  build-essential
)

username = node['username']
homedir = "/home/#{node['username']}"
vundledir = File.join(homedir, '.vim/bundle')

directory vundledir do
  recursive true
  owner username
  group username
end

git File.join(vundledir, 'Vundle.vim') do
  user username
  repository 'https://github.com/VundleVim/Vundle.vim.git'
end

cookbook_file "#{homedir}/.vimrc" do
  source 'vimrc'
  owner username
  group username
end

plugin_lock = File.join(vundledir, 'vundle.lock')

execute "vim +PluginInstall +qall && #{File.join vundledir, 'YouCompleteMe/install.py'} --clang-completer && touch #{plugin_lock}" do
  creates plugin_lock
end
