title "Traefik service launch integration tests"

describe service('traefik') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
