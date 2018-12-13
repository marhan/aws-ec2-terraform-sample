# Sample Project for AWS EC2 instances.

## Create the virtual machine

### Initialize

    cd .terraform
    terraform init

### Plan with defaults

    terraform plan
    
### Plan with variables file

    terraform plan -var-file=variables.tfvars
        
### Plan with parameters

    terraform plan -var region=eu-central-1 -var profile=terraform -var key_name=my-experiment
    
### Find the 'Public DNS' in the Terraform state file

    cat terraform.tfstate | jq '.modules[].resources."aws_instance.my-experiment-vm".primary.attributes.public_dns'
    
### Connect to virtual machine via ssh

    ssh -i "my-experiment.pem" ubuntu@PUBLIC_DNS
    
## Destroy the virtual machine

    terraform destroy 
        
## Hints

### Retrieve AMI in your zone

    aws ec2 describe-images --owners "099720109477" \
    --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*" "Name=virtualization-type,Values=hvm" "Name=is-public,Values=true" \
    | jq ".Images[].ImageId"

## Tools

* [Terraform](https://www.terraform.io)
* [aws cli](https://docs.aws.amazon.com/de_de/cli/latest/userguide/installing.html)
* [jq](https://stedolan.github.io/jq/)
