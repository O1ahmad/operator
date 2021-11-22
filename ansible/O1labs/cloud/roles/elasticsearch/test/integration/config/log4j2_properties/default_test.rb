title "Elasticsearch log4j configuration integration tests"

describe file('/opt/elasticsearch/config/log4j2.properties') do
  it { should exist }
  its('owner') { should eq 'elasticsearch' }
  its('group') { should eq 'elasticsearch' }
  its('mode') { should cmp '0644' }

  its('content') { should match("log action execution errors") }
  its('content') { should match("logger.action.name =") }
  its('content') { should match("logger.action.level =") }
end
