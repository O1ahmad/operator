title "OpenSSH user identities configuration integration tests"

describe file('/home/kitchen/.ssh/id_rsa') do
  it { should exist }
  its('mode') { should cmp '0644' }
end

describe file('/home/kitchen/.ssh/id_rsa.pub') do
  it { should exist }
  its('mode') { should cmp '0644' }
end
