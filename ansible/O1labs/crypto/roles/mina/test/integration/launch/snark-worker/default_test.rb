title "Coda daemon launch integration tests"

describe service('coda-snark-worker@1') do
  it { should be_installed }
  it { should be_enabled }
end

describe service('coda-snark-worker@2') do
  it { should be_installed }
  it { should be_enabled }
end
