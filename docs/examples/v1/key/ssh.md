# Add SSH key for inventory operations authorization

### curl --request POST --form "ssh=@/my/ssh/ops" https://localhost:1001/v1/key
------------
`> cat /my/ssh/ops`
```
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACAImZAxRqROnKuSlz9pV/eLaWtO67D35p2FecBunq4uwAAAAJgA1JIiANSS
IgAAAAtzc2gtZWQyNTUxOQAAACAImZAxRqROnKuSlz9pV/eLaWtO67D35p2FecBunq4uwA
AAAED32QE+wL2JSNxmWISN2l3bGad4qyWjNqO74Nn9BpRsVQiZkDFGpE6cq5KXP2lX94tp
a07rsPfmnYV5wG6eri7AAAAAD29wc0BleGFtcGxlLmNvbQECAwQFBg==
-----END OPENSSH PRIVATE KEY-----
```

## Response
```
{
  "message": "SSH key, ops, successfully uploaded."
}
```
