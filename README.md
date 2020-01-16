# aws-terraform
Documentation on how to set up webserver and autoscaling web instances on aws using terraform

# Initialisation - Setting up terraform
Terraform needs to be installed on your systm for the deployment to work.

Go to https://www.terraform.io/downloads.html and choose the appropriate version for your Operating System
Then follow the instruction on the website which is to unzip the file. You just need to use the 'terraform' command once it's unzipped.

You can now start using terraform

<<<<<<< HEAD
 terraform init
=======
```
 terraform init
```
>>>>>>> 7cc4c2b6527b456dc757a7fed3f60a6bb19b81fe

This sets up the terraform environment in the directory you are working in, any files saved as .tf will be used to set up your infrastructure.

Next we will start writing up the tf files that will be used for your infrastructure. They can be written as 1 whole file, or you can split
them up into categories as you see fit. Such as network, variables, data, providers, and main.

In our case, they will be 

```
outputs.tf
data.tf
variables.tf
ssh-key-pair.tf
security-group.tf
provider.tf
main.tf
```

You will need to create an ssh-key and access/secret key on AWS. The ssh-key to be used is declared in the ssh-key-pair.tf file. 

For the access key and secretr, you can set them up as environment
variables, a credentials file, or as an EC2 role. In our case we will use the environment variables.

```
export AWS_SECRET_ACCESS_KEY="secretkey_value"
export AWS_ACCESS_KEY_ID="accesskey_value"
```

After having set this up you can start building your infrastructure.

```
terraform plan -out "build.out"
```
This tells terraform to check the syntax of your code and plans out how the orchestration will be executed. It will see what needs to be added,
changed, or removed but will not actually do it. By stating the '-out "build.out"' you are saving the information to an output file which can 
be used next. This is an optional argument and it will still work without it.

```
terraform apply "build.out"
```
This is what will actually build your infrastructure. Since we stated the output file from earlier it will use it to execute the orchestration.


You can then check the instances on your AWS interface. 
