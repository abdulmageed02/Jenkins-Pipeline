#!/bin/bash

cat <<EOF > config
host bastion
   HostName $1
   User ubuntu
   identityFile ~/mykey.pem

host private_instance
   HostName  $2
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   identityFile ~/mykey.pem
EOF

cat <<EOF > ./inventory
[host]
private_instance
EOF
