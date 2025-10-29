# Quick Setup Guide - TravelDreams Amazon Connect

## Option 1: Automated Script (Recommended)

Run the script that automates the entire process:

```bash
./create-connect-instance.sh
```

This script will:
- ✅ Create Amazon Connect instance
- ✅ Configure S3 buckets for storage
- ✅ Create DynamoDB table with sample data
- ✅ Create service queues (General, Vacation, Business, CS, VIP)
- ✅ Configure routing profile
- ✅ Generate `instance-config.json` file with all configurations

**Estimated time**: 2-3 minutes

---

## Option 2: Manual Commands

If you prefer to execute step by step, see the file:
```
setup-commands.md
```

---

## Prerequisites

✅ AWS CLI installed and configured
✅ IAM user created: `traveldreams-connect-admin`
✅ Credentials configured in `personal` profile
✅ Required permissions attached (TravelDreamsConnectPolicy)
✅ `jq` installed (for automated script)

### Install jq (if needed):

**macOS:**
```bash
brew install jq
```

**Linux:**
```bash
sudo apt-get install jq
```

---

## After Execution

### 1. Verify the Instance

```bash
cat instance-config.json
```

This file contains:
- Instance ID
- Resource ARNs
- Queue IDs
- Console URL

### 2. Access the Console

URL: `https://traveldreams-contact-center.my.connect.aws/`

### 3. Create Admin User

```bash
INSTANCE_ID=$(cat instance-config.json | jq -r '.instance_id')
SECURITY_PROFILE_ID=$(aws connect list-security-profiles --instance-id $INSTANCE_ID --profile personal | jq -r '.SecurityProfileSummaryList[] | select(.Name=="Admin") | .Id')
ROUTING_PROFILE_ID=$(cat instance-config.json | jq -r '.routing_profile_id')

aws connect create-user \
  --instance-id $INSTANCE_ID \
  --username admin-traveldreams \
  --password-config PasswordResetRequired=true \
  --identity-info FirstName=Admin,LastName=TravelDreams,Email=admin@traveldreams.com \
  --phone-config PhoneType=SOFT_PHONE,AutoAccept=false,AfterContactWorkTimeLimit=0 \
  --security-profile-ids $SECURITY_PROFILE_ID \
  --routing-profile-id $ROUTING_PROFILE_ID \
  --profile personal
```

---

## Useful Verifications

### Verify data in DynamoDB
```bash
aws dynamodb scan --table-name TravelDreamsBookings --profile personal
```

### List queues
```bash
INSTANCE_ID=$(cat instance-config.json | jq -r '.instance_id')
aws connect list-queues --instance-id $INSTANCE_ID --profile personal
```

### Check S3 bucket
```bash
aws s3 ls s3://traveldreams-connect-data/ --profile personal
```

---

## Next Manual Steps

### Via Amazon Connect Console:

1. **Contact Flows**
   - Create main welcome flow
   - Create language selection flow
   - Create flows for each department
   - Configure business hours

2. **Amazon Lex Bot**
   - Create bot for status verification
   - Configure intents and slots
   - Integrate with Lambda

3. **Lambda Functions**
   - Create function for DynamoDB query
   - Create function for VIP identification
   - Configure permissions

4. **Phone Numbers**
   - Claim number
   - Associate with contact flow

5. **Agent Workspace**
   - Configure CCP
   - Customize interface
   - Apply TravelDreams branding

6. **Reports and Metrics**
   - Configure dashboards
   - Define performance metrics
   - Configure alerts

---

## Troubleshooting

### Error: "Instance already exists"
The instance has already been created. Use the existing Instance ID.

### Error: "Bucket already exists"
The S3 bucket already exists. Continue with the next steps.

### Error: "Table already exists"
The DynamoDB table already exists. Skip table creation.

### Error: "Access Denied"
Verify that the IAM user has all required permissions.

---

## Created Resources

| Resource | Name | Type |
|---------|------|------|
| Connect Instance | traveldreams-contact-center | Connect Instance |
| S3 Bucket | traveldreams-connect-data | S3 Bucket |
| DynamoDB Table | TravelDreamsBookings | DynamoDB Table |
| General Queue | TravelDreams-General-Queue | Queue |
| Vacation Queue | TravelDreams-Vacation-Queue | Queue |
| Business Queue | TravelDreams-Business-Queue | Queue |
| Service Queue | TravelDreams-CustomerService-Queue | Queue |
| VIP Queue | TravelDreams-VIP-Queue | Queue |
| Routing Profile | TravelDreams-Agent-Profile | Routing Profile |

---

## Cleanup (Delete Resources)

**WARNING**: This will delete all created resources!

```bash
./cleanup-connect-instance.sh
```

(Cleanup script will be created separately if needed)

---

## Support

For questions or issues:
1. Check CloudWatch logs
2. Consult AWS documentation
3. Review IAM policies

---

**Creation Date**: 2025-10-29
**Version**: 1.0
