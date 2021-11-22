title "Kafka log4j configuration test suite"

describe file('/opt/kafka/config/log4j.properties') do
  it { should exist }
  its('owner') { should eq 'kafka' }
  its('group') { should eq 'kafka' }
  its('mode') { should cmp '0644' }

  its('content') { should match("Set root logger list") }
  its('content') { should match("log4j.rootLogger =") }

  its('content') { should match("Define stdout logger appender") }
  its('content') { should match("log4j.appender.stdout =") }

  its('content') { should match("Define kafka logger appender") }
  its('content') { should match("log4j.appender.kafkaAppender =") }
end
