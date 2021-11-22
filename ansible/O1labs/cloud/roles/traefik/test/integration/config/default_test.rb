title "Traefik configuration integration tests"

describe directory('/etc/traefik') do
  it { should exist }
  its('owner') { should eq 'traefik' }
  its('group') { should eq 'traefik' }
end

describe file('/etc/traefik/traefik.yml') do
  it { should exist }
  its('owner') { should eq 'traefik' }
  its('group') { should eq 'traefik' }

  its('content') { should match('entryPoints:') }
  its('content') { should match('address:') }
  its('content') { should match('providers:') }
  its('content') { should match('directory:') }
end

describe directory('/mnt/etc/traefik') do
  it { should exist }
  its('owner') { should eq 'traefik' }
  its('group') { should eq 'traefik' }
end

describe file('/mnt/etc/traefik/example-config.yml') do
  it { should exist }
  its('owner') { should eq 'traefik' }
  its('group') { should eq 'traefik' }

  its('content') { should match('http:') }
  its('content') { should match('routers:') }
  its('content') { should match('middlewares:') }
  its('content') { should match('services:') }
end

describe directory('/var/log/traefik') do
  it { should exist }
  its('owner') { should eq 'traefik' }
  its('group') { should eq 'traefik' }
end

describe directory('/var/log/traefik/access') do
  it { should exist }
  its('owner') { should eq 'traefik' }
  its('group') { should eq 'traefik' }
end
