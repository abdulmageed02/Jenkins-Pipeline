pipeline {
    agent any
    tools {
  terraform 'Terraform'
}


    stages {
        stage('Building the infrastructure') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER') { 
            // sh 'echo $HOME'
          sh 'terraform -chdir=terraform/ init -reconfigure'
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {
                            sh "terraform -chdir=terraform/ apply --var-file Dev.tfvars -auto-approve"
          }
             }
        }
        }
        stage('Getting private key') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER') { 
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {             
                
                
                  sh 'terraform -chdir=terraform/ output -raw key > mykey.pem'
                  sh 'chmod 400 mykey.pem'
                  sh 'pwd'
          }
             }
        }
        }
stage('Creating Ansible config file') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER') { 
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {             
            sh '''
            cat <<EOF > $HOME/.ssh/config
host bastion
   HostName `terraform -chdir=terraform/ output -raw pubEC2`
   User ubuntu
   identityFile $HOME/mykey.pem
   StrictHostKeyChecking=no

host private_instance
   HostName  `terraform -chdir=terraform/ output -raw privEC2`
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   identityFile $HOME/mykey.pem
   StrictHostKeyChecking=no
EOF
'''
          }
             }
        }
        }

 stage('creating Ansible inventory file') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER') { 
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
        withAWS(credentials: 'AWS_IAM_USER') { 
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {             
              sh '''
            cat <<EOF > ./.env
RDS_HOSTNAME=`terraform -chdir=terraform/ output -raw rds_add `
RDS_PORT=`terraform -chdir=terraform/ output -raw rds_port `
REDIS_HOSTNAME=`terraform -chdir=terraform/ output -raw redis_add `
REDIS_PORT=`terraform -chdir=terraform/ output -raw redis_port `
'''
          }
             }
        }
        }
    
             stage('Running Ansible') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER') { 
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {             
sh 'ansible-playbook -i inventory --private-key $HOME/mykey.pem Ansible/playbook.yml'
          }
             }
        }
        }
        stage('application Link ') {
            steps {
        withAWS(credentials: 'AWS_IAM_USER') { 
          withCredentials([usernamePassword(credentialsId: 'ENV_VAR', usernameVariable: 'TF_VAR_db_User', passwordVariable: 'TF_VAR_db_Pass')]) {             
sh 'terraform -chdir=terraform/ output app_link'
          }
             }
        }
        }
    }
}
