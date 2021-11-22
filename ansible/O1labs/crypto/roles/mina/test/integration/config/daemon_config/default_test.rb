title "Coda configuration integration tests"

describe file('/mnt/config/coda/daemon.json') do
  it { should exist }
  its('content') { should match('"client-port":') }
  its('content') { should match('"libp2p-port":') }
  its('content') { should match('"rest-port":') }

  its('content') { should match('"log-block-creation":') }
  its('content') { should match('"log-received-blocks":') }
  its('content') { should match('"log-snark-work-gossip":') }
  its('content') { should match('"log-txn-pool-gossip":') }
end
