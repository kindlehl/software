describe command 'which zsh' do
  its(:stdout) { should match '/bin/zsh' }
  its(:exit_status) { should eq 0 }
end

%w(
  zsh
  curl
  git
).each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end

%w(
  .zshrc
  .work_specific
).each do |dotfile| 
  describe file dotfile do
    it { should exist }
    it { should be_owned_by 'vagrant' }
    it { should be_grouped_into 'vagrant' }
  end
end

describe directory '/home/vagrant/.oh-my-zsh' do
  it { should exist }
end
