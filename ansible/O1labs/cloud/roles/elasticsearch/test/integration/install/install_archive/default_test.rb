title "Elasticsearch archive installation integration tests"

describe user('elasticsearch') do
  it { should exist }
end

describe group('elasticsearch') do
  it { should exist }
end

describe file('/opt/elasticsearch/bin/elasticsearch') do
  it { should exist }
  its('owner') { should eq 'elasticsearch' }
  its('group') { should eq 'elasticsearch' }
  its('mode') { should cmp '0775' }
end
