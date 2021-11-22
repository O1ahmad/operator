title "Consul service launch integration tests"

describe service('consul') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
