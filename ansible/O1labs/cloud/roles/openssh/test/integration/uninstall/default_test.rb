title "OpenSSH uninstall integration tests"

describe file('/home/test/.ssh/config') do
  it { should_not exist }
end

describe file('/home/test/.ssh/authorzed_keys') do
  it { should_not exist }
end

describe file('/home/test/.ssh/known_hosts') do
  it { should_not exist }
end

describe file('/home/test/.ssh/id_rsa') do
  it { should_not exist }
end
