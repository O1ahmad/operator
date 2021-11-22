title "Fluentd configuration integration tests"

describe file('/etc/td-agent/td-agent.conf') do
  it { should exist }
  its('content') { should match("@include /etc/td-agent/conf.d") }
  its('content') { should match("<source") }
  its('content') { should match("@type debug_agent") }
  its('content') { should match("port 24230") }
  its('content') { should match("@type stdout") }
  its('content') { should match("<match") }
end

describe directory('/etc/td-agent/conf.d') do
  it { should exist }
end

describe file('/etc/td-agent/conf.d/test-pipeline.conf') do
  it { should exist }
  its('content') { should match("<source") }
  its('content') { should match("@type http") }
  its('content') { should match("@id test_case") }
  its('content') { should match("port 9880") }
  its('content') { should match("@type record_transformer") }
  its('content') { should match("<filter") }
end
