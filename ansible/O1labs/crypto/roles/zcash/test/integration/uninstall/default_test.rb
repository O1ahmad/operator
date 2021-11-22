title "Zcash uninstallation integration tests"

describe service('zcashd') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe file('/etc/systemd/system/zcashd.service') do
  it { should_not exist }
end

describe directory('/opt/zcashd') do
  it { should_not exist }
end

describe file('/etc/zcashd/zcash.conf') do
  it { should_not exist }
end

describe user('zcashd') do
  it { should_not exist }
end

describe group('zcashd') do
  it { should_not exist }
end
