#!/bin/bash

cat <<EOF > /var/jenkins_home/.ssh/config
host bastion
   HostName $1
   User ubuntu
   identityFile ~/.ssh/mykey.pem

host private_instance
   HostName  $2
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   identityFile ~/.ssh/mykey.pem

   #test
EOF
