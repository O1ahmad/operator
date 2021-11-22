title "EWBF Zecminer archive installation integration tests"

describe user('zecminer') do
  it { should exist }
end

describe group('zecminer') do
  it { should exist }
end

describe file('/opt/zecminer/miner') do
  it { should exist }
  its('owner') { should eq 'zecminer' }
  its('group') { should eq 'zecminer' }
  its('mode') { should cmp '0775' }
end

describe command('/opt/zecminer/miner --help') do
  its('exit_status') { should eq 0 }
end
