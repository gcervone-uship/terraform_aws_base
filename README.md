# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* Quick summary
* Version
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* Summary of set up
    * Install Terraform (https://www.terraform.io/downloads.html)
    * Download ml terraform_aws_base repo from bitbucket (https://bitbucket.org/mnv_tech/terraform_aws_base)

* Configuration
    * Setup aws cli config
    * Setup remote state on S3

* Dependencies
    * IAM User
    * (Optional) IAM Groups for multiple permissions
    * S3 bucket - backend (stores state)
    * DynamoDB - locking (table name: "ml-sre-terraform-aws-base" primary partition key "LockID")
    * Main DNS - mml.cloud - this is set up by AWS when the domain is purchased.  No need to recreate with terraform.

    When configuring Terraform, use either environment variables or the standard credentials file ~/.aws/credentials to 
    provide the administrator user's IAM credentials within the administrative account to both the S3 backend and to 
    Terraform's AWS provider.
    
S3 bucket
//resource "aws_s3_bucket" "terraform_state" {
//  bucket = "ml-sre-terraform-state"
//
//  versioning {
//    enabled = true
//  }
//
//  lifecycle {
//    prevent_destroy = true
//  }
//}




* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines ###

* Writing tests
    terraform validate
    terraform fmt
    terraform graph | dot -Tpng > graph.png
    terraform plan

* Code review
* Other guidelines

### Who do I talk to? ###

* Macmillan Learning SRE Group - ml-sre@macmillan.com

#### Main
VPC 
Security Groups 
Route 53 – main DNS (for shared only atm)  <<- should it be a prereq and should I import? 

#### Across Accounts 
Sub Domain Delegation 
Sub Domain SSL Certificates 
Peering VPCs (off for shared) 

### Bugs/Enhancements
* When removing whole VPC have to run twice.  Is there a dependency that I need to define??
* Use a tag in the VPC to store the latest commit hash for the code and config.
    That doesn't work, will also put in all resources in module.  need something else. 
* Go back and make sure all taggable resources are tagged.
* Using workaround to compute the count of public and private subdomains in the vpc outputs.tf file.

