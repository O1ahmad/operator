title "vim configuration integration tests"

describe file('/etc/vimrc') do
  it { should exist }
  its('mode') { should cmp '0664' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }

  its('content') { should match("syntax on") }
end

describe file('/home/kitchen/.vimrc') do
  it { should exist }
  its('mode') { should cmp '0664' }
  its('owner') { should eq 'kitchen' }
  its('group') { should eq 'kitchen' }

  its('content') { should match("{{{") }
  its('content') { should match("\" }}}") }
  its('content') { should match("if exists") }
  its('content') { should match("endif") }
end
