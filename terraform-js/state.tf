terraform {
  backend "s3" {
    bucket = "ss-my-terraform-state"
    key = "global/s3/terraform.state"
    region = "us-east-1"
    dynamodb_table = "terraform-lock-fule"
  }
}