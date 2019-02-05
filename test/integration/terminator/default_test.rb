%w(
  terminator
  python2.7
).each do |cmd|
  describe command cmd do
    it { should exist }
  end
end

%w(
  /home/vagrant/.config/terminator/plugins/
  /home/vagrant/.config/terminator/plugins/terminator-themes.py
  /home/vagrant/.config/terminator/config
).each do |inode|
  if inode =~ %r{/$}
    describe directory inode do
      it { should exist }
    end
  else
    describe file inode do
      it { should exist }
    end
  end
end
