describe file '/home/vagrant/.vimrc' do
  it { should exist }
end

describe directory '/home/vagrant/.vim/bundle/YouCompleteMe' do
  it { should exist }
end

describe command 'vim' do
  it { should exist }
end
