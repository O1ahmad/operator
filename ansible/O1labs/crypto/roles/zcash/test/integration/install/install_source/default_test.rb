title "Zcashd archive installation integration tests"

describe user('zcashd') do
  it { should exist }
end

describe group('zcashd') do
  it { should exist }
end

describe file('/opt/zcashd/src/zcashd') do
  it { should exist }
  its('owner') { should eq 'zcashd' }
  its('group') { should eq 'zcashd' }
  its('mode') { should cmp '0755' }
end

describe command('/opt/zcashd/src/zcashd --help') do
  its('exit_status') { should eq 0 }
end

describe file('/opt/zcashd/src/zcash-cli') do
  it { should exist }
  its('owner') { should eq 'zcashd' }
  its('group') { should eq 'zcashd' }
  its('mode') { should cmp '0755' }
end

describe command('/opt/zcashd/src/zcash-cli --help') do
  its('exit_status') { should eq 0 }
end
