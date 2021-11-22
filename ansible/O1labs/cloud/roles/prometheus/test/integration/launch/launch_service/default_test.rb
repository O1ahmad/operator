title "Prometheus service launch integration tests"

describe file('/etc/systemd/system/prometheus.service') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }

  its('content') { should match('--config.file=/opt/prometheus/prometheus.yml') }
  its('content') { should match('--storage.tsdb.path=/var/data/prometheus') }
  its('content') { should match('--web.listen-address=0.0.0.0:9090') }
  its('content') { should match('LimitDATA=1G') }
end

describe service('prometheus') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
