title "Kibana service uninstallation integration tests"

describe file('/etc/systemd/system/kibana.service') do
  it { should_not exist }
end

describe service('kibana') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe directory('/opt/kibana') do
  it { should_not exist }
end

describe directory('/mnt/data/kibana') do
  it { should_not exist }
end

describe directory('/mnt/log/kibana') do
  it { should_not exist }
end
