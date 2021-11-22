title "td-agent launch integration tests"

describe service('td-agent') do
  it { should be_running }
  it { should be_enabled }
end
