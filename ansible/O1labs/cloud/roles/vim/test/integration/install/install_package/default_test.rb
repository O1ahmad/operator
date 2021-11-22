title "vim package installation integration tests"

case os[:family]
when "debian"
  describe package('vim') do
    it { should be_installed }
  end
else
  describe package('vim-enhanced') do
    it { should be_installed }
  end
end
