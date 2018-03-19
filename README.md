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
    * S3 bucket

* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Macmillan Learning SRE Group - ml-sre@macmillan.com

### ToDo

* Create pipeline workflow to segregate the various environments from each other (i.e. dev, prod, qa, etc)


* Segregate workflow on logical boundaries:
    - Pre-work
        - organization account creation
        - s3 bucket creation
        - primary domain creation (mml.cloud)
        - import mml.cloud
        ```bash
terraform import aws_route53_zone.mml-cloud Z3NHPDOM9AF16B
```
    - Create aws base vpcs
    - How to orchestrate across several accounts.  How do credentials and state work?
    - Post-config
        - Peering of VPCs
        - subdomain delegation for hosted zones mml.cloud
        - creation of SSL certificates


