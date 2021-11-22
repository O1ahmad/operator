title "Zcashd archive installation integration tests"

describe user('zcashd') do
  it { should exist }
end

describe group('zcashd') do
  it { should exist }
end

describe file('/opt/zcashd/bin/zcashd') do
  it { should exist }
  its('owner') { should eq 'zcashd' }
  its('group') { should eq 'zcashd' }
  its('mode') { should cmp '0775' }
end

describe command('/opt/zcashd/bin/zcashd --help') do
  its('exit_status') { should eq 0 }
end

describe file('/opt/zcashd/bin/zcash-cli') do
  it { should exist }
  its('owner') { should eq 'zcashd' }
  its('group') { should eq 'zcashd' }
  its('mode') { should cmp '0775' }
end

describe command('/opt/zcashd/bin/zcash-cli --help') do
  its('exit_status') { should eq 0 }
end
