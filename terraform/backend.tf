terraform {
  backend "s3" {
    bucket         = "jenkinstaskpipeline"
    key            = "myfile.stfile"
    region         = "us-east-1"
    dynamodb_table = "statelock"
    profile        = "default"
  }

}
