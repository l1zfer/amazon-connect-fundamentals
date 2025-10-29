# CLI Commands Guide - Amazon Connect TravelDreams Instance Setup

## Step 1: Configure AWS Profile (optional - if you want to use traveldreams profile)

```bash
aws configure --profile traveldreams
```
- Access Key ID: `AKIA3WNWNI4IQD3LDUVL`
- Secret Access Key: (see traveldreams-credentials.txt file)
- Default region: `us-east-1`
- Default output format: `json`

---

## Step 2: Create Amazon Connect Instance

```bash
aws connect create-instance \
  --identity-management-type CONNECT_MANAGED \
  --instance-alias traveldreams-contact-center \
  --inbound-calls-enabled \
  --outbound-calls-enabled \
  --profile personal
```

**Note**: Save the `InstanceId` returned - you'll need it for the next steps.

---

## Step 3: Verify Instance Status

```bash
aws connect describe-instance \
  --instance-id <INSTANCE_ID_FROM_STEP_2> \
  --profile personal
```

---

## Step 4: Create S3 Bucket for Storage

```bash
aws s3 mb s3://traveldreams-connect-data \
  --region us-east-1 \
  --profile personal
```

---

## Step 5: Configure Data Storage in Instance

```bash
aws connect associate-instance-storage-config \
  --instance-id <INSTANCE_ID> \
  --resource-type CALL_RECORDINGS \
  --storage-config StorageType=S3,S3Config={BucketName=traveldreams-connect-data,BucketPrefix=CallRecordings} \
  --profile personal

aws connect associate-instance-storage-config \
  --instance-id <INSTANCE_ID> \
  --resource-type CHAT_TRANSCRIPTS \
  --storage-config StorageType=S3,S3Config={BucketName=traveldreams-connect-data,BucketPrefix=ChatTranscripts} \
  --profile personal

aws connect associate-instance-storage-config \
  --instance-id <INSTANCE_ID> \
  --resource-type SCHEDULED_REPORTS \
  --storage-config StorageType=S3,S3Config={BucketName=traveldreams-connect-data,BucketPrefix=Reports} \
  --profile personal
```

---

## Step 6: Create DynamoDB Table for Booking Data

```bash
aws dynamodb create-table \
  --table-name TravelDreamsBookings \
  --attribute-definitions \
      AttributeName=BookingId,AttributeType=S \
      AttributeName=CustomerPhone,AttributeType=S \
  --key-schema \
      AttributeName=BookingId,KeyType=HASH \
  --global-secondary-indexes \
      "IndexName=CustomerPhoneIndex,KeySchema=[{AttributeName=CustomerPhone,KeyType=HASH}],Projection={ProjectionType=ALL},ProvisionedThroughput={ReadCapacityUnits=5,WriteCapacityUnits=5}" \
  --provisioned-throughput \
      ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --profile personal
```

---

## Step 7: Insert Sample Data in DynamoDB

```bash
aws dynamodb put-item \
  --table-name TravelDreamsBookings \
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
  --profile personal

aws dynamodb put-item \
  --table-name TravelDreamsBookings \
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
  --profile personal

aws dynamodb put-item \
  --table-name TravelDreamsBookings \
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
  --profile personal
```

---

## Step 8: Create Service Queue

```bash
aws connect create-queue \
  --instance-id <INSTANCE_ID> \
  --name "TravelDreams-General-Queue" \
  --description "General customer service queue for TravelDreams" \
  --hours-of-operation-id <HOURS_OF_OPERATION_ID> \
  --profile personal
```

**Note**: You'll need the `HoursOfOperationId`. To get it:

```bash
aws connect list-hours-of-operations \
  --instance-id <INSTANCE_ID> \
  --profile personal
```

---

## Step 9: Create Department-Specific Queues

```bash
aws connect create-queue \
  --instance-id <INSTANCE_ID> \
  --name "TravelDreams-Vacation-Queue" \
  --description "Queue for vacation bookings" \
  --hours-of-operation-id <HOURS_OF_OPERATION_ID> \
  --profile personal

aws connect create-queue \
  --instance-id <INSTANCE_ID> \
  --name "TravelDreams-Business-Queue" \
  --description "Queue for business travel" \
  --hours-of-operation-id <HOURS_OF_OPERATION_ID> \
  --profile personal

aws connect create-queue \
  --instance-id <INSTANCE_ID> \
  --name "TravelDreams-CustomerService-Queue" \
  --description "Queue for customer service" \
  --hours-of-operation-id <HOURS_OF_OPERATION_ID> \
  --profile personal

aws connect create-queue \
  --instance-id <INSTANCE_ID> \
  --name "TravelDreams-VIP-Queue" \
  --description "Priority queue for VIP customers" \
  --hours-of-operation-id <HOURS_OF_OPERATION_ID> \
  --profile personal
```

---

## Step 10: Create Routing Profile

```bash
aws connect create-routing-profile \
  --instance-id <INSTANCE_ID> \
  --name "TravelDreams-Agent-Profile" \
  --description "Default routing profile for TravelDreams agents" \
  --default-outbound-queue-id <QUEUE_ID> \
  --media-concurrencies \
      Channel=VOICE,Concurrency=1 \
      Channel=CHAT,Concurrency=2 \
  --profile personal
```

---

## Step 11: List Instance Information

```bash
aws connect list-phone-numbers \
  --instance-id <INSTANCE_ID> \
  --profile personal

aws connect list-queues \
  --instance-id <INSTANCE_ID> \
  --profile personal

aws connect list-routing-profiles \
  --instance-id <INSTANCE_ID> \
  --profile personal
```

---

## Step 12: Get Amazon Connect Console Access URL

```bash
aws connect describe-instance \
  --instance-id <INSTANCE_ID> \
  --query 'Instance.ServiceRole' \
  --profile personal
```

Access URL will be: `https://traveldreams-contact-center.my.connect.aws/`

---

## Step 13: Create Connect Admin User (via console or CLI)

```bash
aws connect create-user \
  --instance-id <INSTANCE_ID> \
  --username admin-traveldreams \
  --password-config PasswordResetRequired=true \
  --identity-info FirstName=Admin,LastName=TravelDreams,Email=admin@traveldreams.com \
  --phone-config PhoneType=SOFT_PHONE,AutoAccept=false,AfterContactWorkTimeLimit=0 \
  --security-profile-ids <ADMIN_SECURITY_PROFILE_ID> \
  --routing-profile-id <ROUTING_PROFILE_ID> \
  --profile personal
```

To get Admin security profile ID:

```bash
aws connect list-security-profiles \
  --instance-id <INSTANCE_ID> \
  --profile personal
```

---

## Useful Verification Commands

### Check DynamoDB Table
```bash
aws dynamodb scan \
  --table-name TravelDreamsBookings \
  --profile personal
```

### Check S3 Bucket
```bash
aws s3 ls s3://traveldreams-connect-data/ --profile personal
```

### Verify Connect Instance
```bash
aws connect describe-instance \
  --instance-id <INSTANCE_ID> \
  --profile personal
```

### List All Contact Flows
```bash
aws connect list-contact-flows \
  --instance-id <INSTANCE_ID> \
  --profile personal
```

---

## Important Notes

1. Replace `<INSTANCE_ID>` with the actual instance ID created
2. Replace `<HOURS_OF_OPERATION_ID>` with the hours of operation ID
3. Replace `<QUEUE_ID>` with the created queue ID
4. Replace `<ROUTING_PROFILE_ID>` with the routing profile ID
5. Contact flows need to be created via console or imported via JSON
6. Amazon Lex for voicebot needs to be configured separately
7. Lambda functions for integration need to be created and configured

---

## Next Manual Steps (via Console)

After executing the commands above, you'll need to access the Amazon Connect console to:

1. Create contact flows
2. Configure Amazon Lex bot
3. Create and associate Lambda functions
4. Configure phone numbers
5. Customize agent interface
6. Configure reports and dashboards
7. Test the complete system

---

**Console URL**: https://console.aws.amazon.com/connect/
**Instance**: traveldreams-contact-center
