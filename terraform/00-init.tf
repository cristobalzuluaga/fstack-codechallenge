provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      env     = var.env
      project = "fullstack-cc"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "tf-state-codechallenges"
    region = "us-east-1"
  }
}
