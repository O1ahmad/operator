title "Coda package installation test suite"

describe package('coda-testnet-postake-medium-curves') do
  it { should be_installed }
end

describe file('/usr/local/bin/coda') do
  it { should exist }
end

describe command('/usr/local/bin/coda help') do
  its('exit_status') { should eq 0 }
end
