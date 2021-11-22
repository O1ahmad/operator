title "Alertmanager setup integration tests"

describe file('/etc/systemd/system/alertmanager.service') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }

end

describe service('alertmanager') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
