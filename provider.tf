provider "aws" {
    region    ="ap-south-1"
    version   ="~> 2.35"
  
}
terraform {
  required_version    = "~> 0.12.0"
  
  backend "remote" {
    organization  = "AabhusanInc"
    workspaces {
      name        = "rds"
    }
  }
} 