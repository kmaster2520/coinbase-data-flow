# Real-Time Cryptocurrency Trade Ingestion Pipeline

This is a scalable data streaming pipeline that 
ingests over 1.3 million cryptocurrency trades a day from 
Coinbase Websocket API


## Tools/Services Used

### Data Ingestion

A Python script (`ecs/websocket_script_coinbase_v2.py`)
subscribes to the Coinbase Websocket API. 
The script is put into a Docker image and deployed as an ECS task. 
The ECS cluster uses the EC2 launch type, primarily for cost savings.


### VPC Infrastructure

The ECS cluster is deployed to a VPC private subnet. As the ECS task needs
to send requests to an external API, a NAT gateway is needed in a public subnet.  

In addition, a Kinesis Endpoint were created to direct traffic to AWS Kinesis 
along the AWS backbone, a small optimization.






