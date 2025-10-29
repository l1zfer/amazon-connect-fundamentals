#!/bin/bash

set -e

PROFILE="personal"
REGION="us-east-1"
BUCKET_NAME="traveldreams-connect-data"
TABLE_NAME="TravelDreamsBookings"

echo "=========================================="
echo "TravelDreams - Cleanup Script"
echo "=========================================="
echo ""
echo "WARNING: This will delete all resources!"
echo ""

if [ ! -f "instance-config.json" ]; then
    echo "Error: instance-config.json not found!"
    echo "Please run this script from the project directory."
    exit 1
fi

INSTANCE_ID=$(cat instance-config.json | jq -r '.instance_id')

echo "Instance ID: $INSTANCE_ID"
echo ""
read -p "Are you sure you want to delete all resources? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Cleanup cancelled."
    exit 0
fi

echo ""
echo "[1/5] Deleting Amazon Connect Instance..."
aws connect delete-instance \
  --instance-id $INSTANCE_ID \
  --region $REGION \
  --profile $PROFILE || echo "Failed to delete instance or already deleted"
echo ""

echo "[2/5] Emptying and deleting S3 bucket..."
aws s3 rm s3://$BUCKET_NAME --recursive --profile $PROFILE || echo "Bucket already empty or doesn't exist"
aws s3 rb s3://$BUCKET_NAME --profile $PROFILE || echo "Failed to delete bucket or already deleted"
echo ""

echo "[3/5] Deleting DynamoDB table..."
aws dynamodb delete-table \
  --table-name $TABLE_NAME \
  --region $REGION \
  --profile $PROFILE || echo "Failed to delete table or already deleted"
echo ""

echo "[4/5] Deleting IAM policy..."
aws iam detach-user-policy \
  --user-name traveldreams-connect-admin \
  --policy-arn arn:aws:iam::804078307089:policy/TravelDreamsConnectPolicy \
  --profile $PROFILE || echo "Policy already detached"

aws iam delete-policy \
  --policy-arn arn:aws:iam::804078307089:policy/TravelDreamsConnectPolicy \
  --profile $PROFILE || echo "Failed to delete policy or already deleted"
echo ""

echo "[5/5] Deleting IAM user..."
ACCESS_KEYS=$(aws iam list-access-keys \
  --user-name traveldreams-connect-admin \
  --profile $PROFILE \
  --output json 2>/dev/null | jq -r '.AccessKeyMetadata[].AccessKeyId') || echo "No access keys found"

if [ ! -z "$ACCESS_KEYS" ]; then
    for KEY in $ACCESS_KEYS; do
        echo "Deleting access key: $KEY"
        aws iam delete-access-key \
          --user-name traveldreams-connect-admin \
          --access-key-id $KEY \
          --profile $PROFILE
    done
fi

aws iam delete-user \
  --user-name traveldreams-connect-admin \
  --profile $PROFILE || echo "Failed to delete user or already deleted"
echo ""

echo "[6/5] Cleaning up local files..."
rm -f instance-config.json
echo ""

echo "=========================================="
echo "Cleanup completed!"
echo "=========================================="
echo ""
echo "All TravelDreams resources have been deleted."
echo ""


