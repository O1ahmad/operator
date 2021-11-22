title "Fluentd launch integration tests"

describe service('fluentd') do
  it { should be_running }
  it { should be_enabled }
end
