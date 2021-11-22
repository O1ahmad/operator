title "Zcashd service launch integration tests"

describe service('zcashd') do
  it { should be_installed }
  it { should be_enabled }
end
