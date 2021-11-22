title "Journald unit configuration integration tests"

describe service('systemd-journald') do
  it { should be_installed }
  it { should be_running }
end

describe file('/etc/systemd/journald.conf') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }
  its('content') { should match("Storage=auto") }
  its('content') { should match("Compress=True") }
  its('content') { should match("MaxLevelStore=notice") }
end

describe file('/run/systemd/journald.conf.d/journald.conf') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }
  its('content') { should match("Storage=volatile") }
  its('content') { should match("Compress=False") }
  its('content') { should match("MaxLevelStore=alert") }
end

describe file('/etc/systemd/journald.conf.d/debug-overrides.conf') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }
  its('content') { should match("Storage=persistent") }
  its('content') { should match("Compress=True") }
  its('content') { should match("MaxLevelStore=debug") }
end
