title "EWBF Zecminer configuration integration tests"

describe directory('/etc/zecminer') do
  it { should exist }
  its('owner') { should eq 'zecminer' }
  its('group') { should eq 'zecminer' }
end

describe file('/etc/zecminer/miner.cfg') do
  it { should exist }
  its('owner') { should eq 'zecminer' }
  its('group') { should eq 'zecminer' }

  its('content') { should match('[common]') }
  its('content') { should match('logfile') }
  its('content') { should match('/var/log/miner.log') }

  its('content') { should match('[server]') }
  its('content') { should match('server') }
  its('content') { should match('zec-us1.nanopool.org') }
end
