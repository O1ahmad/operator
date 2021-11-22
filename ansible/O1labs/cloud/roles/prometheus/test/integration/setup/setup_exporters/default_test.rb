title "Prometheus exporter setup integration tests"

describe directory('/opt/prometheus/exporters/node_exporter') do
  it { should exist }
  its('owner') { should eq 'prometheus' }
  its('group') { should eq 'prometheus' }
end

describe file('/etc/systemd/system/node_exporter.service') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }

  its('content') { should match('--log.level=debug') }
  its('content') { should match('--web.listen-address=') }
end

describe service('node_exporter') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(9110) do
  it { should be_listening }
end
