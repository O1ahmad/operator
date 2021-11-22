title "td-agent package installation integration tests"

describe file('/usr/sbin/td-agent') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0755' }
end

describe command('which td-agent') do
  its('exit_status') { should eq 0 }
end

describe file('/etc/td-agent/td-agent.conf') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }
end
