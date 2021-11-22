title "Kafka service launch test suite"

describe file('/etc/systemd/system/kafka.service') do
  it { should_not exist }
end

describe service('kafka') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe directory('/opt/kafka') do
  it { should_not exist }
end

describe directory('/mnt/data/kafka') do
  it { should_not exist }
end

describe user('kafka') do
  it { should_not exist }
end

describe group('kafka') do
  it { should_not exist }
end
