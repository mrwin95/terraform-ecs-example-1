terraform {
  backend "s3" {
    bucket = "tn-terraform-remote-state"
    key = "tn-website-ecs.tfstate"
    region = "ap-northeast-3"
    profile = "sam"
  }
}