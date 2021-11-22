title "OpenSSH authorized_keys configuration integration tests"

describe file('/home/test/.ssh/authorized_keys') do
  it { should exist }
  its('mode') { should cmp '0644' }

  its('content') { should match("NAME=value") }
  its('content') { should match("test.example.net") }
end
