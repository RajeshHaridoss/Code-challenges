# Code-challenge1 - A 3 tier environment is a common setup. Use a tool of your choosing/familiarity create these resources. Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility
Terraform Code in Codechallenge1 directory consists of modules to create VPC, subnets, route tables, security groups, EC2 instances and rds instance. These modules are used to create a cloud infrastructure in a particular region.  
Custom modules as well as AWS modules are used to create the resources to show the reusability,resilience and speed of development using modules. Please note that this is not a complete infrastructure as there could be connectivity issues. Due to insufficient time,could not code all the parameters required.   

Terraform workspace is used to show the reproducibility of the code to create any new environments like Dev/Test/prod by just passing the corresponding variables file. Any number of environments can be created and destroyed within minutes using this approach. 

## Folders/Files
+ 'modules' - contains custom modules to create vpc, subnet, route table, rds and security group for ec2 instance
+ 'vars' - variable files to create new environments like dev, prod and test
+ 'worspace' - This directory will be created when the terraform commands are run to create new workspace like dev,test or prod.
+ `provider.tf` - AWS Provider details 
+ `main.tf` - main terraform configuration file that uses modules to launch all the resources for this project. 
+ `vars.tf` - define the variables and set default values for those variables. 
+ `userdata.sh` - Used to install docker and nginx application in both the public and private EC2 instances

Run below commands to provision the infrastructure for Dev Environment by passing the variable file corresponding to dev Environment. Please note that code is tested and the infratructure will be created in AWS account but it is not the complete infrastructure as there could be connection issues between rds and instances.  

To setup provisioner
```
$ terraform init
```

To launch the cluster for Dev environment :
```
$ terraform workspace new dev
$ terraform workspace select dev
$ terraform plan -var-file=vars/dev.tfvars
$ terraform apply -var-file=vars/dev.tfvars -auto-approve
```

To teardown the cluster in Dev Environment:
```
$ terraform destroy  -var-file=vars/dev.tfvars -auto-approve
```

# CodeChallenge2 - We need to write code that will query the meta data of an instance within aws and provide a json formatted output. The choice of language and implementation is up to you.The code allows for a particular data key to be retrieved individually

There are 2 ways to query the metadata of an instance which we normally use in our work. Code is present in the CodeChallenge2 directory.

1. aws "describe-instances" uses filters to scope the results to specific instance types and instance ids and the --query parameter to display only the required parameters. 
2. terraform state command to pull the terraform state file in JSON format and use Jquery to scope the results to specific component(ec2 instance) by name(or any other parameters) and also to display only the required parameters.

# CodeChallenge3 - We have a nested object, we would like a function that you pass in the object and a key and get back the value. How this is implemented is up to you.

There could be mulitple ways to achieve the goal. Here a simple javascript code is used to achieve the same. Code is present in the CodeChallenge3 directory.
