terraform {
  backend "s3" {
    bucket         = "terraform-backend-iti2"
    key            = "myfile.stfile"
    region         = "eu-west-2"
    dynamodb_table = "terraform-lab1"
    profile        = "default"
  }

}
