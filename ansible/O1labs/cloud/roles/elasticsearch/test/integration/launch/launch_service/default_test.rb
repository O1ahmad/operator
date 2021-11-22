title "Elasticsearch service launch integration tests"

describe file('/etc/systemd/system/elasticsearch.service') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }

  its('content') { should match("ExecStart=") }
  its('content') { should match("Environment=ES_HOME") }
end

describe service('elasticsearch') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
