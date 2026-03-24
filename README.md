# Coinbase Data Flow

README in progress

## Tools/Services Used

Infrastructure Creation

| Feature                 | Tool                  | Purpose   |
|-------------------------|-----------------------|-----------|
| Infrastructure Creation | AWS CloudFormation    | s         |
| Infrastructure Creation | AWS CLI (BASH)        | s         |
| Data Ingestion          | AWS EC2               | s         |
| Data Ingestion          | AWS Kinesis           | s         |
| Data Ingestion          | AWS Firehose + Lambda | s         |
| Data Store              | AWS S3                | s         |
| Data Transformation     | DBT                   | s         |

## Architecture Diagram

TODO



### Why EC2 over ECS

EC2 and ECS are both capable of running scripts, however the websocket script is very simple and only requires 
Python, and few `pip install` commands to run. This setup works almost universally across Linux platforms and architectures
(x86 and ARM). 

EC2 requires less overhead (no container registry setup, no image creation), and is easier to set up. So I decided
to use EC2 as the platform for the Python websocket script for streaming live trade data.


