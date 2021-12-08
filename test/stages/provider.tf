

provider "aws" {
  region = var.region
   //Action: Define variable
  #ibmcloud_api_key = var.ibmcloud_api_key
  access_key= var.access_key
  secret_key=var.secret_key
}