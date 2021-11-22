title "Phoronix package installation test suite"

describe file('/usr/bin/phoronix-test-suite') do
  it { should exist }
end

describe command('phoronix-test-suite --help') do
  its('exit_status') { should eq 0 }
end

