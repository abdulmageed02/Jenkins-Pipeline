pipeline {
    agent any
    tools {
  terraform 'Terraform'
}


    stages {
        stage('Build') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER', region: 'us-west-2') { 
            sh 'echo $HOME'
          sh 'terraform init'
          sh 'terraform apply -var-file Dev.tfvars --auto-approve'
            sh 'chmod 777 mykey.pem'
            sh 'terraform output -raw key > mykey.pem'
            sh 'chmod 400 mykey.pem'
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
            
           sh 'ansible-playbook -i inventory --private-key mykey.pem playbook.yml'

               sh '''
            cat <<EOF > ./.env
RDS_HOSTNAME=`terraform output rds_add `
RDS_USERNAME='hossam'
RDS_PASSWORD='202997hH7'
RDS_PORT=`terraform output rds_port `
REDIS_HOSTNAME=`terraform output redis_add `
REDIS_PORT=`terraform output rds_port `
'''
         git branch: 'rds_redis', url: 'https://github.com/abdulmageed02/jenkins_nodejs_example.git'
                sh ' echo $HOSTNAME'
                sh 'echo $HOME'
                sh 'docker build . -t node-app'
                sh 'docker rm -f node-app'
                sh 'docker run --env-file ../.env -d -p 3000:3000 --name node-app node-app'

          }
        }
        }
    }
}
