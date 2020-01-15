#Provider: AWS
provider "aws" {
  #Region retrieved from variables file so that it can be easily changed
  region = var.region
}
