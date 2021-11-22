title "Kafka jvm.options configuration test suite"

describe file('/opt/kafka/config/jvm.options') do
  it { should exist }
  its('owner') { should eq 'kafka' }
  its('group') { should eq 'kafka' }
  its('mode') { should cmp '0644' }

  its('content') { should match("KAFKA_HEAP_OPTS=") }
  its('content') { should match("-Xmx1g -Xms1g") }
  its('content') { should match("KAFKA_JVM_PERFORMANCE_OPTS=") }
  its('content') { should match("-server") }
  its('content') { should match("KAFKA_JMX_OPTS=") }
end
