title "Prometheus archive installation integration tests"

describe user('prometheus') do
  it { should exist }
end

describe group('prometheus') do
  it { should exist }
end

describe directory('/opt/prometheus') do
  it { should exist }
end

describe file('/opt/prometheus/prometheus') do
  it { should exist }
  it { should be_file }

  its('owner') { should eq 'prometheus' }
  its('group') { should eq 'prometheus' }
  its('mode') { should cmp '0775' }
end
