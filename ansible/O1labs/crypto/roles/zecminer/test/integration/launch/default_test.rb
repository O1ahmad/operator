title "Zecminer service launch integration tests"

describe service('zecminer') do
  it { should be_installed }
  it { should be_enabled }
end
