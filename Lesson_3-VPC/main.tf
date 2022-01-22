# Build AWS instance

provider "aws" {
  region  = var.default_region # instant region
  profile = "student"
}
