package 'zip'

execute 'wget https://releases.hashicorp.com/packer/1.3.3/packer_1.3.3_linux_amd64.zip -O packer.zip' do
  not_if 'test -f /bin/packer'
  notifies :run, 'execute[unzip]', :immediately
end

execute 'unzip' do
  command 'unzip packer.zip -d /bin'
  action :nothing
  notifies :run, 'execute[clean]', :immediately
end

execute 'clean' do
  command 'rm packer.zip'
  action :nothing
end
