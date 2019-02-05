describe file '/etc/apt/sources.list.d/oracle.list' do
  it { should exist }
end

describe command 'vboxmanage' do
  it { should exist }
end

describe command 'vagrant' do
  it { should exist }
end

describe command 'vagrant plugin list' do
  its(:stdout) { should match /vagrant-berkshelf/ }
  its(:stdout) { should match /vagrant-ohai/ }
end
