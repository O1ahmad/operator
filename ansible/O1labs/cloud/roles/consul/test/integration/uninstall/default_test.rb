title "Grafana uninstallation integration tests"

describe service('consul') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe file('/etc/systemd/system/consul.service') do
  it { should_not exist }
end

describe directory('/opt/consul') do
  it { should_not exist }
end

describe file('/etc/consul/test-example.json') do
  it { should_not exist }
end

describe file('/var/log/consul/consul.log') do
  it { should_not exist }
end

describe directory('/var/data/consul') do
  it { should_not exist }
end

describe user('consul') do
  it { should_not exist }
end

describe group('consul') do
  it { should_not exist }
end
