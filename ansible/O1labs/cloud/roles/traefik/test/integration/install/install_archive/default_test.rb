title "Traefik archive installation integration tests"

describe directory('/opt/traefik') do
  it { should exist }
  its('owner') { should eq 'traefik' }
  its('group') { should eq 'traefik' }
end

describe command('/opt/traefik/traefik version') do
  its('exit_status') { should eq 0 }
end
