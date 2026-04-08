import base64
import binascii
import json


EXAMPLE_EVENT = {
    "invocationId": "085d3401-c076-4054-b657-2a1c01dd107c",
    "sourceKinesisStreamArn": "arn:aws:kinesis:us-east-1:391262527903:stream/raw-trade-data",
    "deliveryStreamArn": "arn:aws:firehose:us-east-1:391262527903:deliverystream/KDS-S3-trade-data",
    "region": "us-east-1",
    "records": [
        {
            "recordId": "shardId-00000000000200000000000000000000000000000000000000000000000000000000000000000000000049669534775090560008083220088837278296638367081844178978000000000000",
            "approximateArrivalTimestamp": 1765030657336,
            "data": "ewogICJjaGFubmVsIjogIm1hcmtldF90cmFkZXMiLAogICJwcm9kdWN0X2lkIjogIkJUQy1VU0QiLAogICJ0cmFkZV9pZCI6ICI5ODE4MDQ5NTUiLAogICJwcmljZSI6ICI3NDA0MCIsCiAgInNpemUiOiAiMC4wMDAwODQyNCIsCiAgInRpbWUiOiAiMjAyNi0wMy0xNlQyMDozMzoyNC43NjM0OTVaIiwKICAic2lkZSI6ICJTRUxMIgp9",
            "kinesisRecordMetadata": {
                "sequenceNumber": "49669534775090560008083220088837278296638367081844178978",
                "subsequenceNumber": 0,
                "partitionKey": "BTCUSDT-aggTrade",
                "shardId": "shardId-000000000002",
                "approximateArrivalTimestamp": 1765030657336
            }
        }
    ]
}


def lambda_handler(event, context):

    transformed_records = []

    for evt in event.get("records", []):
        item_b64 = evt.get("data", "")
        try:
            item_string = base64.b64decode(item_b64.encode("ascii")).decode("ascii")
            item = json.loads(item_string)
        except binascii.Error as exc:
            print(exc)
            continue
        except json.JSONDecodeError as exc:
            print(exc)
            continue

        # COINBASE
        if item.get("channel") == "market_trades":
            if not item.get("time"):
                continue

            processed_item = {
                "eventType": item.get("channel", ""),
                "symbol": item.get("product_id", ""),
                "price": item.get("price", "0.0"),
                "quantity": item.get("size", "0.0"),
                "tradeId": item.get("trade_id", "0"),
                "side": item.get("side", ""),
                "tradeTime": item.get("time", "")
            }

            transformed_records.append({
                "recordId": evt.get("recordId", ""),
                "result": "Ok",
                "data": base64.b64encode(json.dumps(processed_item).encode("ascii")).decode("ascii")
            })

        else:
            continue

    return {
        "records": transformed_records
    }


if __name__ == "__main__":
    class EventContext:
        aws_request_id = "d"
    print(lambda_handler(EXAMPLE_EVENT, EventContext))
