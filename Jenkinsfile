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
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {
                            sh "terraform apply --var-file Dev.tfvars -auto-approve"
          }
            sh 'chmod 777 mykey.pem'
            sh 'terraform output -raw key > mykey.pem'
            sh 'chmod 400 mykey.pem'
            sh '''
            cat <<EOF > /var/jenkins_home/.ssh/config
host bastion
   HostName `terraform output -raw pubEC2`
   User ubuntu
   identityFile /var/jenkins_home/workspace/Terraform/mykey.pem
   StrictHostKeyChecking=no

host private_instance
   HostName  `terraform output -raw privEC2`
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   identityFile /var/jenkins_home/workspace/Terraform/mykey.pem
   StrictHostKeyChecking=no
EOF
'''
     sh '''
            cat <<EOF > ./inventory
[host]
private_instance
EOF
'''
            
           
               sh '''
            cat <<EOF > ./.env
RDS_HOSTNAME=`terraform output -raw rds_add `
RDS_PORT=`terraform output -raw rds_port `
REDIS_HOSTNAME=`terraform output -raw redis_add `
REDIS_PORT=`terraform output -raw redis_port `
'''
        sh 'ansible-playbook -i inventory --private-key mykey.pem playbook.yml'
        
          }
        }
        }
    }
}
