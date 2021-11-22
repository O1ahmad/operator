title "Prometheus service uninstall integration tests"

describe service('prometheus') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe file('/etc/systemd/system/prometheus.service') do
  it { should_not exist }
end

describe directory('/opt/prometheus') do
  it { should_not exist }
end

describe directory('/etc/prometheus/rules.d') do
  it { should_not exist }
end

describe service('alertmanager') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe directory('/opt/alertmanager') do
  it { should_not exist }
end

describe service('node_exporter') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe file('/etc/systemd/system/node_exporter.service') do
  it { should_not exist }
end

describe directory('/opt/node_exporter') do
  it { should_not exist }
end

describe user('prometheus') do
  it { should_not exist }
end

describe group('prometheus') do
  it { should_not exist }
end
