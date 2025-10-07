# Amazon Connect Architecture Fundamentals
## Creating an Amazon Connect instance
- Before beginning:
    - AWS accounts are automatically signed up to Amazon Connect - you are charged only for the services you use
    - To create an instance, you will need the `AmazonConnect_FullAccess` policy permissions granted
    - You will need to know the minimum IAM permissions required to create an instance
    - 🇮🇳 Amazon Connect is not available to customers in India using Amazon Web Services India Private Limited (AWS India), which is an affiliate of AWS based in India
    - When you create an instance, you must decide how you want to manage users. You can't change the identity management option after you create the instance
- Creation steps:
    1. Set identity management option (store users in Amazon Connect, link to an existing directory or use SAML 2.0-based authentication)
    2. Set up an administrator (optional)
    3. Configure telephony settings (allow either outbound or inbound calls, or both)
    4. Set data storage
### Setting up for the first time
- Log in to the instance by navigating to *https://<your-instance>.my.connect.com* and lopgging with the admin credentials previously created
- Claim a phone number under **Channels** > **Phone Numbers**, then associate it with the flow
### Additional setup steps
- **Set hours of operation**: Hours of operation define when Amazon Connect resources, such as queues, are available and can be referenced in flows
    - You can create multiple hours of operation for different teams or services
- **Create queues**: Queues allow contacts to be routed to the most suitable agents to service them (think of it like different lines at a bank - one line is for deposits, while another line is for loans, and so on)
    - Use descriptive names that reflect the purpose of the queue
- **Create prompts**: Prompts are media that can be used to play back audio to customer or agent contact flows
- **Create flows**: Flows, similar to an interactive voice response (IVR), define the customer's experience when they contact you
    - Each step of a flow uses a flow block - each block is a different action
    - Make sure you select the correct flow type when creating a new flow. Each flow has blocks specifically available for that flow type
- **Create routing profiles**: A routing profile is a collection of queues an agent services contact from. Routing profiles enable agents to service multiple queues with the proper priority (*new agents* might only handle chats, while *experienced agents* might handle one voice call and three chats, for instance)
    - Each agent can only have one routing profile assigned at any time
- **Configure users**: User management enables adding, managing, and deleting users. User-specific settings, such as routing profiles and permissions, can be assigned after the users are created
    - Least privilege is key

## Reporting
- Amazon Connect has built-in reports on performance accessible from the dashboard
    - Think of real-time metrics as a live traffic map showing current conditions, whereas historical metrics are like reviewing footage of past traffic patterns to plan better routes
### Key metrics
- **Service Level**: percentage of contacts answered within a specific time threshold
    - Shows if customers are being served promptly
- **Average handle time (AHT)**: average time agents spend on each contact (talk time and after-contact work)
    - Indicates agent efficiency and contact complexity
- **Abandonment rate**: percentage of customers who hang up before speaking to an agent
    - High rates suggest customers are waiting too long
- **Contacts in queue**: number of customers currently waiting for service in queue
    - Indicates current demand and potential wait times
- **Occupancy**: percentage of time agents spend handling contacts compared to waiting
    - Shows if you have the right staffing levels