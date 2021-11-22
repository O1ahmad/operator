title "Kafka server.properties configuration test suite"

describe file('/opt/kafka/config/server.properties') do
  it { should exist }
  its('owner') { should eq 'kafka' }
  its('group') { should eq 'kafka' }
  its('mode') { should cmp '0644' }

  its('content') { should match("broker.id =") }
  its('content') { should match("advertised.listeners =") }
  its('content') { should match("zookeeper.connect =") }
  its('content') { should match("log.dirs =") }
end

describe directory('/mnt/kafka/data') do
  it { should exist }
  its('owner') { should eq 'kafka' }
  its('group') { should eq 'kafka' }
  its('mode') { should cmp '0755' }
end
