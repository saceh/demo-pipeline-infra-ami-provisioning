provider "aws" {
  region = "ap-southeast-1"
  version = "~> 2.24"
  profile = "${var.awsprofile}"
}

############### GLOBAL STATE BACKEND ###############
terraform {
  backend "s3" {
    region  = "ap-southeast-1"
    encrypt = true
  }
}
