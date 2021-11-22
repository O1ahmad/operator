title "Elasticsearch uninstallation integration tests"

describe file('/etc/systemd/system/elasticsearch.service') do
  it { should_not exist }
end

describe service('elasticsearch') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe directory('/opt/elasticsearch') do
  it { should_not exist }
end

describe directory('/var/data/elasticsearch') do
  it { should_not exist }
end

describe directory('/var/log/elasticsearch') do
  it { should_not exist }
end
