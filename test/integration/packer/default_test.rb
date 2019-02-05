%w(
  packer
  zip
).each do |pkg|
  describe command pkg do
    it { should exist }
  end
end

describe file '/root/packer.zip' do
  it { should_not exist }
end
