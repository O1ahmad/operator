title "Elasticsearch package installation integration tests"

describe user('elasticsearch') do
  it { should exist }
end

describe group('elasticsearch') do
  it { should exist }
end

describe package('elasticsearch') do
  it { should be_installed }
end
