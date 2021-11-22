title "Ansible package installation integration tests"

describe file('/usr/bin/ansible') do
  it { should exist }
  its('mode') { should cmp '0755' }
end

describe command('ansible --help') do
  its('exit_status') { should eq 0 }
end
