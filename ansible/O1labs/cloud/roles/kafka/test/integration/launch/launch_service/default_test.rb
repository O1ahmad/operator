title "Kafka service launch test suite"

describe file('/etc/systemd/system/kafka.service') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }
  its('content') { should match('EnvironmentFile=') }
end

describe service('kafka') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(9092) do
  before do
    30.times do
      unless port(9092).listening?
        puts "Port 9092 isn't ready, retrying.."
        sleep 1
      end
    end
  end
  it { should be_listening }
  its('protocols') { should cmp 'tcp' }
end

describe port(9999) do
  before do
    30.times do
      unless port(9999).listening?
        puts "Port 9999 isn't ready, retrying.."
        sleep 1
      end
    end
  end
  it { should be_listening }
  its('protocols') { should cmp 'tcp' }
end

describe command('/opt/kafka/bin/kafka-topics.sh --create --topic test ' \
                 '--zookeeper localhost:2181 --replication-factor 1 ' \
                 '--partitions 1') do
  its(:exit_status) { should == 0 }
end

describe command('/opt/kafka/bin/kafka-topics.sh --list --zookeeper localhost:2181') do
  its(:stdout) { should include 'test' }
end
