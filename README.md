# Jenkins Pipeline 

## Infrastructure
infra structure is built on aws with terraform tool and it consists of:
* 1 VPC
* 4 Subnets 2 Public and 2 Private
* Internet Gateway
* 2 Nat Gateway in the Public Subnets
* Bastion host in the Public Subnet
* EC2 instance in Private Subnet
* Load balancer to expose the private instace 
* RDS mysql
* Redis

# Jenkins Configurations

## Plugins used 
* `Pipeline: AWS Steps` to add aws iam user creditionals 
* `Terraform` so jenkins can use terraform 
* `Ansible` so jenkins can use ansible 

# Pipelines 
* ## terraform pipeline:
     * that build the infrastructure on aws from this repo we are in 
     
     * then ansible will configure the the private intance to  be ready as jenkins slave 
     by installing `open-jdk` and copy `agent.jar` file to it

     * config file is created by script in `jenkinsfile` and its dynamic 

     * the config file that created and `ansbile` use to reach the 
     private instance from bastion host: 

    

     ![config file](https://raw.githubusercontent.com/abdulmageed02/Jenkins-Pipeline-/main/IMAGES/Screenshot%20from%202022-05-20%2023-43-18.png)
    
    ### then from jenkins console connect the private instance like this:
    ![agent](https://github.com/abdulmageed02/Jenkins-Pipeline-/blob/main/IMAGES/Screenshot%20from%202022-05-20%2023-45-55.png?raw=true)
    ### now its connected and ready to host deployments
    ![agent](https://github.com/abdulmageed02/Jenkins-Pipeline-/blob/main/IMAGES/Screenshot%20from%202022-05-20%2023-49-00.png?raw=true)
    ![agent](https://github.com/abdulmageed02/Jenkins-Pipeline-/blob/main/IMAGES/Screenshot%20from%202022-05-20%2023-45-35.png?raw=true)


* ## Node-app Deployment pipeline


    * jenkins deploy the app from this [forked repo](https://github.com/abdulmageed02/jenkins_nodejs_example/tree/rds_redis) 

    * the app need Enviroment variables and their values are created by `terraform` then copied to the private instance using `ansible`

    * this pipeline is triggered by the completeion of the `terraform pipeline`

   * ## you can test the deployment  mysql connection form  [here](http://nlb-177c3bc341684f22.elb.us-east-1.amazonaws.com/db)

   * ## and the redis connecton from [here](http://nlb-177c3bc341684f22.elb.us-east-1.amazonaws.com/redis)

