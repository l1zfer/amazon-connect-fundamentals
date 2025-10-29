#!/bin/bash

set -e

PROFILE="personal"
REGION="us-east-1"
INSTANCE_ALIAS="traveldreams-contact-center"
BUCKET_NAME="traveldreams-connect-data"
TABLE_NAME="TravelDreamsBookings"

echo "=========================================="
echo "TravelDreams - Amazon Connect Setup"
echo "=========================================="
echo ""

echo "[1/12] Creating Amazon Connect Instance..."
INSTANCE_OUTPUT=$(aws connect create-instance \
  --identity-management-type CONNECT_MANAGED \
  --instance-alias $INSTANCE_ALIAS \
  --inbound-calls-enabled \
  --outbound-calls-enabled \
  --region $REGION \
  --profile $PROFILE \
  --output json)

INSTANCE_ID=$(echo $INSTANCE_OUTPUT | jq -r '.Id')
INSTANCE_ARN=$(echo $INSTANCE_OUTPUT | jq -r '.Arn')

echo "Instance created successfully!"
echo "Instance ID: $INSTANCE_ID"
echo "Instance ARN: $INSTANCE_ARN"
echo ""

sleep 10

echo "[2/12] Verifying instance status..."
aws connect describe-instance \
  --instance-id $INSTANCE_ID \
  --region $REGION \
  --profile $PROFILE
echo ""

echo "[3/12] Creating S3 bucket for storage..."
aws s3 mb s3://$BUCKET_NAME \
  --region $REGION \
  --profile $PROFILE || echo "Bucket may already exist"
echo ""

echo "[4/12] Configuring call recordings storage..."
aws connect associate-instance-storage-config \
  --instance-id $INSTANCE_ID \
  --resource-type CALL_RECORDINGS \
  --storage-config "StorageType=S3,S3Config={BucketName=$BUCKET_NAME,BucketPrefix=CallRecordings}" \
  --region $REGION \
  --profile $PROFILE || echo "Storage config may already exist"
echo ""

echo "[5/12] Configuring chat transcripts storage..."
aws connect associate-instance-storage-config \
  --instance-id $INSTANCE_ID \
  --resource-type CHAT_TRANSCRIPTS \
  --storage-config "StorageType=S3,S3Config={BucketName=$BUCKET_NAME,BucketPrefix=ChatTranscripts}" \
  --region $REGION \
  --profile $PROFILE || echo "Storage config may already exist"
echo ""

echo "[6/12] Configuring scheduled reports storage..."
aws connect associate-instance-storage-config \
  --instance-id $INSTANCE_ID \
  --resource-type SCHEDULED_REPORTS \
  --storage-config "StorageType=S3,S3Config={BucketName=$BUCKET_NAME,BucketPrefix=Reports}" \
  --region $REGION \
  --profile $PROFILE || echo "Storage config may already exist"
echo ""

echo "[7/12] Creating DynamoDB table for bookings..."
aws dynamodb create-table \
  --table-name $TABLE_NAME \
  --attribute-definitions \
      AttributeName=BookingId,AttributeType=S \
      AttributeName=CustomerPhone,AttributeType=S \
  --key-schema \
      AttributeName=BookingId,KeyType=HASH \
  --global-secondary-indexes \
      "IndexName=CustomerPhoneIndex,KeySchema=[{AttributeName=CustomerPhone,KeyType=HASH}],Projection={ProjectionType=ALL},ProvisionedThroughput={ReadCapacityUnits=5,WriteCapacityUnits=5}" \
  --provisioned-throughput \
      ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --region $REGION \
  --profile $PROFILE || echo "Table may already exist"

echo "Waiting for table to be active..."
aws dynamodb wait table-exists \
  --table-name $TABLE_NAME \
  --region $REGION \
  --profile $PROFILE
echo ""

echo "[8/12] Inserting sample booking data..."
aws dynamodb put-item \
  --table-name $TABLE_NAME \
  --item '{
    "BookingId": {"S": "BK12345"},
    "CustomerPhone": {"S": "+5511999999999"},
    "CustomerName": {"S": "Maria Silva"},
    "Status": {"S": "Confirmed"},
    "TravelDates": {"S": "2025-12-15 to 2025-12-22"},
    "Destination": {"S": "Paris, France"},
    "BookingType": {"S": "Vacation"},
    "VIPStatus": {"BOOL": true}
  }' \
  --region $REGION \
  --profile $PROFILE

aws dynamodb put-item \
  --table-name $TABLE_NAME \
  --item '{
    "BookingId": {"S": "BK12346"},
    "CustomerPhone": {"S": "+5511988888888"},
    "CustomerName": {"S": "João Santos"},
    "Status": {"S": "Pending"},
    "TravelDates": {"S": "2025-11-10 to 2025-11-15"},
    "Destination": {"S": "New York, USA"},
    "BookingType": {"S": "Business"},
    "VIPStatus": {"BOOL": false}
  }' \
  --region $REGION \
  --profile $PROFILE

aws dynamodb put-item \
  --table-name $TABLE_NAME \
  --item '{
    "BookingId": {"S": "BK12347"},
    "CustomerPhone": {"S": "+5511977777777"},
    "CustomerName": {"S": "Ana Costa"},
    "Status": {"S": "Confirmed"},
    "TravelDates": {"S": "2026-01-05 to 2026-01-12"},
    "Destination": {"S": "Tokyo, Japan"},
    "BookingType": {"S": "Vacation"},
    "VIPStatus": {"BOOL": true}
  }' \
  --region $REGION \
  --profile $PROFILE

echo "Sample data inserted successfully!"
echo ""

echo "[9/12] Getting Hours of Operation ID..."
HOURS_OUTPUT=$(aws connect list-hours-of-operations \
  --instance-id $INSTANCE_ID \
  --region $REGION \
  --profile $PROFILE \
  --output json)

HOURS_ID=$(echo $HOURS_OUTPUT | jq -r '.HoursOfOperationSummaryList[0].Id')
echo "Hours of Operation ID: $HOURS_ID"
echo ""

echo "[10/12] Creating queues..."

echo "Creating General Queue..."
GENERAL_QUEUE_OUTPUT=$(aws connect create-queue \
  --instance-id $INSTANCE_ID \
  --name "TravelDreams-General-Queue" \
  --description "General customer service queue for TravelDreams" \
  --hours-of-operation-id $HOURS_ID \
  --region $REGION \
  --profile $PROFILE \
  --output json)
GENERAL_QUEUE_ID=$(echo $GENERAL_QUEUE_OUTPUT | jq -r '.QueueId')
echo "General Queue ID: $GENERAL_QUEUE_ID"

echo "Creating Vacation Queue..."
VACATION_QUEUE_OUTPUT=$(aws connect create-queue \
  --instance-id $INSTANCE_ID \
  --name "TravelDreams-Vacation-Queue" \
  --description "Queue for vacation bookings" \
  --hours-of-operation-id $HOURS_ID \
  --region $REGION \
  --profile $PROFILE \
  --output json)
VACATION_QUEUE_ID=$(echo $VACATION_QUEUE_OUTPUT | jq -r '.QueueId')
echo "Vacation Queue ID: $VACATION_QUEUE_ID"

echo "Creating Business Queue..."
BUSINESS_QUEUE_OUTPUT=$(aws connect create-queue \
  --instance-id $INSTANCE_ID \
  --name "TravelDreams-Business-Queue" \
  --description "Queue for business travel" \
  --hours-of-operation-id $HOURS_ID \
  --region $REGION \
  --profile $PROFILE \
  --output json)
BUSINESS_QUEUE_ID=$(echo $BUSINESS_QUEUE_OUTPUT | jq -r '.QueueId')
echo "Business Queue ID: $BUSINESS_QUEUE_ID"

echo "Creating Customer Service Queue..."
CS_QUEUE_OUTPUT=$(aws connect create-queue \
  --instance-id $INSTANCE_ID \
  --name "TravelDreams-CustomerService-Queue" \
  --description "Queue for customer service" \
  --hours-of-operation-id $HOURS_ID \
  --region $REGION \
  --profile $PROFILE \
  --output json)
CS_QUEUE_ID=$(echo $CS_QUEUE_OUTPUT | jq -r '.QueueId')
echo "Customer Service Queue ID: $CS_QUEUE_ID"

echo "Creating VIP Queue..."
VIP_QUEUE_OUTPUT=$(aws connect create-queue \
  --instance-id $INSTANCE_ID \
  --name "TravelDreams-VIP-Queue" \
  --description "Priority queue for VIP customers" \
  --hours-of-operation-id $HOURS_ID \
  --region $REGION \
  --profile $PROFILE \
  --output json)
VIP_QUEUE_ID=$(echo $VIP_QUEUE_OUTPUT | jq -r '.QueueId')
echo "VIP Queue ID: $VIP_QUEUE_ID"
echo ""

echo "[11/12] Creating routing profile..."
ROUTING_PROFILE_OUTPUT=$(aws connect create-routing-profile \
  --instance-id $INSTANCE_ID \
  --name "TravelDreams-Agent-Profile" \
  --description "Default routing profile for TravelDreams agents" \
  --default-outbound-queue-id $GENERAL_QUEUE_ID \
  --media-concurrencies \
      Channel=VOICE,Concurrency=1 \
      Channel=CHAT,Concurrency=2 \
  --region $REGION \
  --profile $PROFILE \
  --output json)
ROUTING_PROFILE_ID=$(echo $ROUTING_PROFILE_OUTPUT | jq -r '.RoutingProfileId')
echo "Routing Profile ID: $ROUTING_PROFILE_ID"
echo ""

echo "[12/12] Saving configuration..."
cat > instance-config.json <<EOF
{
  "instance_id": "$INSTANCE_ID",
  "instance_arn": "$INSTANCE_ARN",
  "instance_alias": "$INSTANCE_ALIAS",
  "region": "$REGION",
  "bucket_name": "$BUCKET_NAME",
  "table_name": "$TABLE_NAME",
  "hours_of_operation_id": "$HOURS_ID",
  "queues": {
    "general": "$GENERAL_QUEUE_ID",
    "vacation": "$VACATION_QUEUE_ID",
    "business": "$BUSINESS_QUEUE_ID",
    "customer_service": "$CS_QUEUE_ID",
    "vip": "$VIP_QUEUE_ID"
  },
  "routing_profile_id": "$ROUTING_PROFILE_ID",
  "console_url": "https://$INSTANCE_ALIAS.my.connect.aws/"
}
EOF

echo ""
echo "=========================================="
echo "Setup completed successfully!"
echo "=========================================="
echo ""
echo "Instance Information:"
echo "  Instance ID: $INSTANCE_ID"
echo "  Console URL: https://$INSTANCE_ALIAS.my.connect.aws/"
echo ""
echo "Configuration saved to: instance-config.json"
echo ""
echo "Next steps:"
echo "  1. Access the Connect console to create contact flows"
echo "  2. Configure Amazon Lex for the voicebot"
echo "  3. Create Lambda functions for integrations"
echo "  4. Request and configure phone numbers"
echo "  5. Customize the agent workspace"
echo ""


