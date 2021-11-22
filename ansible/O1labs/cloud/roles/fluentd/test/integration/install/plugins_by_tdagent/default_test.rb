title "td-agent plugin installation integration tests"

describe file('/usr/sbin/td-agent-gem') do
  it { should exist }
end

describe command('/usr/sbin/td-agent-gem list | grep fluent-plugin-assert') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match ('fluent-plugin-assert') }
end

describe command('/usr/sbin/td-agent-gem list | grep fluent-plugin-prometheus') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match ('fluent-plugin-prometheus') }
  its('stdout') { should match ('1.7.0') }
end
