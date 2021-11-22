title "Prometheus file service discovery integration tests"

describe file('/opt/prometheus/file_sd/example-file.slow.json') do
  it { should exist }
  its('owner') { should eq 'prometheus' }
  its('group') { should eq 'prometheus' }
  its('mode') { should cmp '0644' }

  its('content') { should match('host1:1234') }
  its('content') { should match('file-sd-json') }
end

describe file('/etc/prometheus/file_sd/file.yml') do
  it { should exist }
  its('owner') { should eq 'prometheus' }
  its('group') { should eq 'prometheus' }
  its('mode') { should cmp '0644' }

  its('content') { should match('host2:1234') }
  its('content') { should match('file-sd-yml') }
end

describe command('/opt/prometheus/promtool check config /opt/prometheus/prometheus.yml') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match("SUCCESS") }
end
