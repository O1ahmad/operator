title "Zecminer uninstallation integration tests"

describe service('zecminer') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe file('/etc/systemd/system/zecminer.service') do
  it { should_not exist }
end

describe directory('/opt/zecminer') do
  it { should_not exist }
end

describe file('/etc/zecminer/miner.cfg') do
  it { should_not exist }
end

describe user('zecminer') do
  it { should_not exist }
end

describe group('zecminer') do
  it { should_not exist }
end
