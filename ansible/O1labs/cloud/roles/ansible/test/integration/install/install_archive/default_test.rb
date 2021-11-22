title "Ansible archive installation integration tests"

describe directory('/opt/ansible') do
  it { should exist }
end

describe file('/usr/local/bin/ansible') do
  it { should exist }
end

describe command('ansible --help') do
  its('exit_status') { should eq 0 }
end

