pipeline {
    agent any
    tools {
  terraform 'Terraform'
}


    stages {
        stage('Building the infrastructure') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER', region: 'us-west-2') { 
            // sh 'echo $HOME'
          sh 'terraform init'
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {
                            sh "terraform apply --var-file Dev.tfvars -auto-approve"
          }
             }
        }
        }
        stage('Getting private key') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER', region: 'us-west-2') { 
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {             
                  sh 'chmod 777 mykey.pem'
                  sh 'terraform output -raw key > mykey.pem'
                  sh 'chmod 400 mykey.pem'
          }
             }
        }
        }
stage('Creating Ansible config file') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER', region: 'us-west-2') { 
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {             
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
          }
             }
        }
        }

 stage('creating Ansible inventory file') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER', region: 'us-west-2') { 
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {             
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
           stage('Creating Enviroment variables file for our node app') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER', region: 'us-west-2') { 
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {             
              sh '''
            cat <<EOF > ./.env
RDS_HOSTNAME=`terraform output -raw rds_add `
RDS_PORT=`terraform output -raw rds_port `
REDIS_HOSTNAME=`terraform output -raw redis_add `
REDIS_PORT=`terraform output -raw redis_port `
'''
          }
             }
        }
        }
    
             stage('Running Ansible') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER', region: 'us-west-2') { 
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {             
sh 'ansible-playbook -i inventory --private-key mykey.pem playbook.yml'
          }
             }
        }
        }
    }
}
