# WyseDay Mars 2024: CloudGuru + Terraform

## Introduction
[CloudGuru](https://learn.acloud.guru/) is an online cloud learning center which is very special because it allows users to experiment in the cloud (**AWS, GCP, Azure**) with playground sessions which are new accounts ready to be used for a limited time (~4h).

This is super useful since it gives the liberty to the developer to create and test *almost anything*. In this repo, we will create a little project in AWS using terraform so that we can redeploy our project even if our playground time expires. All that it will be needed is to create another playground session and redeploy the project!

The project is a simple S3 Bucket configured for public read access and Static Website Hosting with a `index.html` and `error.html`.

## Installation
1. Login to CloudGuru and Select the Playground AWS
1. Copy the **Access Key Id** and **Secret Access Key** into the `terraform/main.tf` 
1. Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
1. Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) in your machine
1. configure your AWS CLI by using the given Access Key and Secret Access Key
    ```sh
    aws configure
    ```
1. While in the root folder of this project, initialize terraform
    ```sh
    terraform -chdir=terraform init
    ```
1. Deploy the S3 and files using 
    ```sh
    terraform -chdir=terraform apply -auto-approve
    ```
1. Copy and paste the URL output in the terminal:
    `S3_Website_Endpoint = "testing-bucket-number-######.s3-website-us-east-1.amazonaws.com"`

## Credits
This project was created by this creator of this Repository and is only for educational purposes 