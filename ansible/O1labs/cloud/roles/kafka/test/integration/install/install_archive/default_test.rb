title "Kafka service installation suite"

describe user('kafka') do
  it { should exist }
end

describe group('kafka') do
  it { should exist }
end

describe file('/opt/kafka/bin/kafka-server-start.sh') do
  it { should exist }
  its('owner') { should eq 'kafka' }
  its('group') { should eq 'kafka' }
  its('mode') { should cmp '0775' }
end
