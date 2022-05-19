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
          }
        }
        }
    }
}
