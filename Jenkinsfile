pipeline {
    agent any
    tools {
  terraform 'Terraform'
}


    stages {
        stage('Build') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER', region: 'us-west-2') {
          sh 'terraform init'
          sh 'terraform apply -var-file Dev.tfvars --auto-approve'
            sh 'terraform output -raw key > mykey.pem'
            sh '''
            cat <<EOF > /var/jenkins_home/.ssh/config
host bastion
   HostName `terraform output -raw pubEC2`
   User ubuntu
   identityFile /var/jenkins_home/workspace/Terraform/mykey.pem

host private_instance
   HostName  `terraform output -raw privEC2`
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   identityFile /var/jenkins_home/workspace/Terraform/mykey.pem
EOF
'''
     sh '''
            cat <<EOF > ./inventory
[host]
private_instance
EOF
'''
          }
        }
        }
    }
}
