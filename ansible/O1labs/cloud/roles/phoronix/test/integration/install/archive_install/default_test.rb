title "Phoronix archive installation test suite"

describe directory('/opt/phoronix') do
  it { should exist }
end

describe file('/opt/phoronix/phoronix-test-suite') do
  it { should exist }
end

describe command('/opt/phoronix/phoronix-test-suite --help') do
  its('exit_status') { should eq 0 }
end

