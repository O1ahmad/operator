title "Phoronix test-run launch test suite"

describe file('/usr/bin/wait_for_completion.sh') do
  it { should exist }
  its('mode') { should cmp '0755' }
end

describe file('/usr/bin/test_post_exec.sh') do
  it { should exist }
  its('mode') { should cmp '0755' }
end

describe file('/opt/phoronix/runtime/pts-compress-gzip.env') do
  it { should exist }
  its('mode') { should cmp '0644' }
end

describe file('/etc/systemd/system/pts-compress-gzip.service') do
  it { should exist }
end

describe service('pts-compress-gzip') do
  it { should be_installed }
  it { should be_enabled }
end

describe file('/home/kitchen/.phoronix-test-suite/runtime/pts-encode-mp3.env') do
  it { should exist }
  its('mode') { should cmp '0644' }
end

describe file('/etc/systemd/system/pts-encode-mp3.service') do
  it { should exist }
end

describe service('pts-encode-mp3') do
  it { should be_installed }
  it { should be_enabled }
end

describe file('/home/kitchen/.phoronix-test-suite/runtime/pts-apache.env') do
  it { should exist }
  its('mode') { should cmp '0644' }
end

describe file('/etc/systemd/system/pts-apache.service') do
  it { should_not exist }
end

describe service('pts-apache') do
  it { should_not be_installed }
  it { should_not be_enabled }
end
