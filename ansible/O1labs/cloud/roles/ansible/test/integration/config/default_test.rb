title "Ansible configuration integration tests"

describe file('/usr/local/etc/ansible/ansible.cfg') do
  it { should exist }
  its('owner') { should eq 'ansible' }
  its('group') { should eq 'ansible' }
  its('mode') { should cmp '0644' }

  its('content') { should match("[default]") }
  its('content') { should match("log_path = /var/log/ansible.log") }
  its('content') { should match("debug = true") }
  its('content') { should match("enable_task_debugger = true") }
end

describe command('ansible-config dump') do
  its('exit_status') { should eq 0 }
end
