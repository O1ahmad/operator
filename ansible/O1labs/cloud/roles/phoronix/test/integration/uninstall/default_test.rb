title "Phoronix uninstallation test suite"

describe file('/usr/bin/wait_for_completion.sh') do
  it { should_not exist }
end

describe file('/usr/bin/test_post_exec.sh') do
  it { should_not exist }
end

describe file('/home/kitchen/.phoronix-test-suite/runtime') do
  it { should_not exist }
end

describe file('/home/kitchen/.phoronix-test-suite/user-config.xml') do
  it { should_not exist }
end

describe service('pts-compress-gzip') do
  it { should_not be_enabled }
  it { should_not be_running }
end
