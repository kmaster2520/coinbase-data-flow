# Build context must be the repo root:
#   docker build -f ecs/Dockerfile -t coinbase-websocket .
#
# Push to ECR:
#   aws ecr get-login-password --region us-east-1 | \
#     docker login --username AWS --password-stdin 391262527903.dkr.ecr.us-east-1.amazonaws.com
#   docker tag coinbase-websocket <EcrRepositoryUri>:latest
#   docker push <EcrRepositoryUri>:latest

FROM python:3.12-slim-bookworm

WORKDIR /app

COPY ecs/websocket_script_coinbase_v2.py .

RUN pip install --no-cache-dir boto3==1.42.67 websockets==16.0

# CoinbaseProductId is passed as CMD argument (e.g. ["BTC-USD"]) from the ECS task definition.
ENTRYPOINT ["python", "websocket_script_coinbase_v2.py"]
