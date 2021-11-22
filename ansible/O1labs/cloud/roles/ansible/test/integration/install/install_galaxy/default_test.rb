title "Ansible Galaxy content installation integration tests"

describe directory('/home/ansible/.ansible/roles/0x0i.systemd') do
  it { should exist }
end

describe directory('/home/ansible/.ansible/roles/0x0i.tmux') do
  it { should exist }
end

describe directory('/home/ansible/.ansible/collections/ansible_collections/newswangerd/collection_demo') do
  it { should exist }
end
