title "Traefik uninstallation integration tests"

describe service('traefik') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe file('/etc/systemd/system/traefik.service') do
  it { should_not exist }
end

describe directory('/opt/traefik') do
  it { should_not exist }
end

describe file('/etc/traefik/traefik.yml') do
  it { should_not exist }
end

describe directory('/mnt/etc/traefik/traefik.yml') do
  it { should_not exist }
end

describe file('/var/log/traefik/traefik.log') do
  it { should_not exist }
end

describe user('traefik') do
  it { should_not exist }
end

describe group('traefik') do
  it { should_not exist }
end
