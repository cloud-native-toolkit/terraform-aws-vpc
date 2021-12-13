#!/bin/bash
#SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)
#echo "SCRIPT_DIR: ${SCRIPT_DIR}"
export VPC_ID=$(terraform output -json | jq '."dev-vpc-id".value')
REGION=$(cat terraform.tfvars | grep -E "^region" | sed "s/region=//g" | sed 's/"//g')

echo "VPC_ID: ${VPC_ID}"
echo "REGION: ${REGION}"

# aws configure 

echo "Checking VPC exists with ID in AWS: ${VPC_ID}"
VPC_ID_OUT=$(aws ec2 describe-vpcs --vpc-ids vpc-00278503c31f67c3a --query 'Vpcs[0].VpcId' --output=json) 
echo "VPC_ID_OUT: $VPC_ID_OUT"
if [[ ( $VPC_ID_OUT == $VPC_ID) ]]; then
  echo "VPC id found: ${VPC_ID_OUT}"
    exit 0  
else
    echo "Not Found"
fi

# exit 1