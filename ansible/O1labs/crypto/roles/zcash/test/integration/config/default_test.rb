title "Zcashd configuration integration tests"

describe directory('/etc/zcashd') do
  it { should exist }
  its('owner') { should eq 'zcashd' }
  its('group') { should eq 'zcashd' }
end

describe file('/etc/zcashd/zcash.conf') do
  it { should exist }
  its('owner') { should eq 'zcashd' }
  its('group') { should eq 'zcashd' }

  its('content') { should match('testnet=1') }
  its('content') { should match('bind=0.0.0.0') }
  its('content') { should match('server=1') }
  its('content') { should match('gen=1') }
end
