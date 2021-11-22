title "Prometheus archive installation integration tests"

describe file('/etc/prometheus/prometheus.yml') do
  it { should exist }
  its('owner') { should eq 'prometheus' }
  its('group') { should eq 'prometheus' }
  its('mode') { should cmp '0644' }

  its('content') { should match("global:") }
  its('content') { should match("scrape_interval: 10s") }
  its('content') { should match("external_labels:") }
  its('content') { should match("monitor: test") }
end

describe command('/opt/prometheus/promtool check config /etc/prometheus/prometheus.yml') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match("SUCCESS") }
end
