title "OpenSSH ssh-agent setup integration tests"

describe file('/home/kitchen/.config/systemd/user/ssh-agent.service') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
  its('group') { should eq 'kitchen' }
  its('mode') { should cmp '0644' }
end

describe file('/home/kitchen/.bash_profile') do
  it { should exist }
  its('owner') { should eq 'kitchen' }
  its('group') { should eq 'kitchen' }
  its('content') { should match("SSH_AUTH_SOCK") }
  its('content') { should match("XDG_RUNTIME_DIR") }
end
