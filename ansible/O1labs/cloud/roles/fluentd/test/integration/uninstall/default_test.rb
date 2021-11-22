title "Fluentd/td-agent uninstallation integration tests"

describe service('td-agent') do
  it { should_not be_running }
  it { should_not be_enabled }
end

describe package('td-agent') do
  it { should_not be_installed }
end

describe directory('/etc/td-agent') do
  it { should_not exist }
end
