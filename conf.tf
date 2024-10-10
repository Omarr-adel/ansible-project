# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
}
/*terraform {
  backend "s3" {
    bucket = "tfbucket-iti"
    key    = "tfstate"
    region = "us-east-1"
    dynamodb_table = "TfStateLocking"
  }
}*/
