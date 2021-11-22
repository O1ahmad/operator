title "Consul configuration integration tests"

describe directory('/etc/consul.d/') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }
end

describe file('/etc/consul.d/test-defaults.json') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }

  its('content') { should match('datacenter') }
  its('content') { should match('data_dir') }
  its('content') { should match('log_file') }
end

describe file('/etc/consul.d/test-http-check.json') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }

  its('content') { should match('check') }
  its('content') { should match('https://localhost:5000/health') }
  its('content') { should match('POST') }
end

describe directory('/mnt/etc/consul.d') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }
end

describe file('/mnt/etc/consul.d/test-service-defaults.json') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }

  its('content') { should match('service-defaults') }
  its('content') { should match('example-api') }
  its('content') { should match('http') }
end

describe file('/mnt/etc/consul.d/test-proxy-defaults.json') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }

  its('content') { should match('proxy-defaults') }
  its('content') { should match('local_connect_timeout_ms') }
  its('content') { should match('handshake_timeout_ms') }
end

describe file('/mnt/etc/consul.d/test-service-router.json') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }

  its('content') { should match('service-router') }
  its('content') { should match('match') }
  its('content') { should match('path_prefix') }
  its('content') { should match('destination') }
end

describe file('/mnt/etc/consul.d/test-service-splitter.json') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }

  its('content') { should match('service-splitter') }
  its('content') { should match('weight') }
  its('content') { should match('service_subset') }
end

describe file('/mnt/etc/consul.d/test-service-resolver.json') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }

  its('content') { should match('service-resolver') }
  its('content') { should match('default_subset') }
  its('content') { should match('subsets') }
  its('content') { should match('filter') }
end

describe directory('/var/data/consul') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }
end

describe directory('/mnt/var/log/consul') do
  it { should exist }
  its('owner') { should eq 'consul' }
  its('group') { should eq 'consul' }
end
