title "Kibana configuration integration tests"

describe file('/opt/kibana/config/kibana.yml') do
  it { should exist }
  its('owner') { should eq 'kibana' }
  its('group') { should eq 'kibana' }
  its('mode') { should cmp '0644' }

  its('content') { should match("server.name:") }
  its('content') { should match("path.data:") }
  its('content') { should match("logging:") }
  its('content') { should match("verbose:") }
  its('content') { should match("json:") }
end

describe directory('/mnt/data/kibana') do
  it { should exist }
  its('owner') { should eq 'kibana' }
  its('group') { should eq 'kibana' }
  its('mode') { should cmp '0755' }
end
