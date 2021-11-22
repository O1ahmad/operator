title "Coda daemon launch integration tests"

describe service('coda-daemon') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
