title "vim uninstall integration tests"

describe file('/home/kitchen/.vimrc') do
  it { should_not exist }
end
