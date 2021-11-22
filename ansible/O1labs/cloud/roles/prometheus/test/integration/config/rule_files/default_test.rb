title "Prometheus rules files configuration integration tests"

describe file('/opt/prometheus/rules.d/example-rules.yml') do
  it { should exist }
  its('owner') { should eq 'prometheus' }
  its('group') { should eq 'prometheus' }
  its('mode') { should cmp '0644' }

  its('content') { should match('name: recording rule example') }
  its('content') { should match('record: job:http_inprogress_requests:sum') }
end

describe command('/opt/prometheus/promtool check rules /opt/prometheus/rules.d/example-rules.yml') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match('SUCCESS') }
end

describe file('/etc/prometheus/rules.d/nondefault-path-example-rules.yml') do
  it { should exist }
  its('owner') { should eq 'prometheus' }
  its('group') { should eq 'prometheus' }
  its('mode') { should cmp '0644' }

  its('content') { should match('name: alerting rule example') }
  its('content') { should match('alert: HighRequestLatency') }
  its('content') { should match('job:request_latency_seconds') }
end

describe command('/opt/prometheus/promtool check rules /etc/prometheus/rules.d/nondefault-path-example-rules.yml') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match('SUCCESS') }
end

describe command('/opt/prometheus/promtool check config /opt/prometheus/prometheus.yml') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match("SUCCESS") }
end
