title "Kibana package installation integration tests"

describe user('kibana') do
  it { should exist }
end

describe group('kibana') do
  it { should exist }
end

describe package('kibana') do
  it { should be_installed }
end
