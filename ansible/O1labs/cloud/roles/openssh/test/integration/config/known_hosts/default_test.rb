title "OpenSSH known_hosts configuration integrated test file"

describe file('/etc/ssh/ssh_known_hosts') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }

  its('content') { should match("@revoke") }
end

describe file('/home/kitchen/.ssh/known_hosts') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
  its('group') { should eq 'kitchen' }
  its('mode') { should cmp '0644' }

  its('content') { should match("th!s !s @ k3y") }
end
