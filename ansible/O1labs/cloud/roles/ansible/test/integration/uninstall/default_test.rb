title "Ansible configuration integration tests"

describe directory('/opt/ansible') do
  it { should_not exist }
end

describe file('/usr/local/etc/ansible/ansible.cfg') do
  it { should_not exist }
end

describe directory('/usr/local/etc/ansible') do
  it { should_not exist }
end

describe file('/etc/profile.d/ansible-vars.sh') do
  it { should_not exist }
end
