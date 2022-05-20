terraform {
  backend "s3" {
    bucket         = "bu-jenkins-cket"
    key            = "myfile.stfile"
    region         = "us-west-2"
    dynamodb_table = "statfile"
    profile        = "default"
  }

}
