#!/bin/bash

SUBNET_ID="subnet-0ac0bc58b5403af7b"
SECURITY_GROUP_ID="sg-06f51ddc0f1cb5760"
ECR_IMAGE_URI="391262527903.dkr.ecr.us-east-1.amazonaws.com/coinbase-websocket:latest"


#PRODUCT_IDS="BTC-USD,ETH-USD"
PRODUCT_IDS="LTC-USD"

aws cloudformation create-stack \
  --stack-name CoinbaseECSCluster \
  --template-body file://websocket_ecs_cft.yaml \
  --parameters \
      ParameterKey=SubnetId,ParameterValue=$SUBNET_ID \
      ParameterKey=SecurityGroupId,ParameterValue=$SECURITY_GROUP_ID \
      ParameterKey=EcrImageUri,ParameterValue=$ECR_IMAGE_URI \
      ParameterKey=CoinbaseProductId,ParameterValue="$PRODUCT_IDS" \
  --capabilities CAPABILITY_NAMED_IAM
