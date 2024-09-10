terraform {
  backend "s3" {
    bucket = "devops-directive-tf-state-anurag-unique-id"
    key = "tf-infra/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-locking"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
    region      = "ap-south-1"
}

resource "aws_instance" "one" {
  ami           = "ami-0522ab6e1ddcc7055"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "tanmoy_terraform_state_anurag" {
  bucket        = "devops-directive-tf-state-anurag-unique-id"
  force_destroy = true
}

resource "aws_dynamodb_table" "terraform_locks" {
    name         = "terraform-state-locking"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"
    attribute {
      name       = "LockID"
      type       = "S"
    }
}