title "tmux uninstall integration tests"

describe file('/home/kitchen/.tmux.conf') do
  it { should_not exist }
end
