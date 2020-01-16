# aws-terraform
Documentation on how to set up instances on aws using terraform

# Initialisation - Setting up terraform
Terraform needs to be installed on your systm for the deployment to work.

Go to https://www.terraform.io/downloads.html and choose the appropriate version for your Operating System
Then follow the instruction on the website which is to unzip the file. You just need to use the 'terraform' command once it's unzipped.

You can now start using terraform

```
 terraform init
```

This sets up the terraform environment in the directory you are working in, any files saved as .tf will be used to set up your infrastructure.
