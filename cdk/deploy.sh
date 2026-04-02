#!/bin/bash

#AWS_REGION="us-east-1"
VPC_ID="vpc-013914d1062557cd7"
SUBNET_ID="subnet-0ac0bc58b5403af7b"
BUCKET_NAME="greatestbucketever"

cdk deploy CryptoTradeFirehose --context bucket_name=$BUCKET_NAME
cdk deploy CryptoTradeEndpoints --context vpc_id=$VPC_ID --context subnet_id=$SUBNET_ID
