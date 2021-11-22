title "Journald group-adds integration tests"

describe group('systemd-journal') do
  it { should exist }
  its('members') { should include 'kitchen' }
end
