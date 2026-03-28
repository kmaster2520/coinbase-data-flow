#!/bin/bash

#PRODUCT_IDS="BTC-USD,ETH-USD"
PRODUCT_IDS="LTC-USD"

aws cloudformation deploy \
  --stack-name CoinbaseECSCluster \
  --template-body file://websocket_ecs_cft.yaml \
  --parameter-overrides \
      ParameterKey=CoinbaseProductId,ParameterValue="$PRODUCT_IDS" \
  --capabilities CAPABILITY_NAMED_IAM
