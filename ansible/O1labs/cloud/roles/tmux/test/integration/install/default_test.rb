title "tmux installation integration tests"

describe package('tmux') do
  it { should be_installed }
end

describe command('tmux -V') do
  its('exit_status') { should eq 0 }
end
