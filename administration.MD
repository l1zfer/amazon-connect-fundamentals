# Amazon Connect Administration
## Introduction to Advanced Contact Flow Design
- Create personalized customer experiences by using dynamic attributes
- Build reusable components to streamline contact flow development
- Implement effective error handling to ensure smooth customer interactions
    - *"Hello Sarah, thanks for being a Gold member with us for 5 years! I see you have an upcoming flight to Chicago tomorrow."*
### Dynamic Attributes and Personalization
- Contact attributes in Amazon Connect are like digital sticky notes that follow a customer's interaction throughout their journey
- Store important information that can be used to personalize the experience
- For referencing contact attributes in Amazon Connect, you need to use specific JSON syntax
- Lambda contact attributes may also be referred to as an External attribute due to their JSONPath namespace: `$.External.attributeName`
    - **User-defined attributes**: require a name for the key/value pair
    - **System attributes**: predefined attributes that can only be referenced, not created; information such as customer's phone number
    - **Lambda contact attributes**: key-value pairs from the most recent invocation of an `Invoke AWS Lambda` function block. Lambda contact attributes are overwritten with each invocation of the Lambda function
    - **Flow attributes**: like a type user-defined attribute, but restricted to the flow where they are set
### Creating Custom Blocks and Reusable Components
#### Flow modules explained
- Reusable sections of a flow that you can create once and use multiple times, like functions in programming
- Used in authentication processes that are used in multiple flows, standard greetings or disclaimers, error handling routines and data collection sequences (such as gathering customer information)
- Centralize logic in a single location, ensuring all flows automatically leverage the most recent published version, eliminating redundancy and maintaining consistency across your system
- Not all flows support the use of modules - only **Inbound** and **Campaign** flows
### Error handling and Recovery Patterns
#### Common error scenarios
- Failed connections to external services
- Customers providing invalid inputs without error checking
- System limitations (such as attribute size exceeding 32 KB)
#### Strategies
- **Always use error branches**: Every block that could potentially fail should have its error path handled gracefully to maintain a positive customer experience
- **Provide clear customer messaging**: When errors occur, explain clearly what happened and what the customer should do next, if needed
- **Create recovery options**: Give customers a way to retry or speak to an agent
- **Log errors for analysis**: Use contact attributes to track what went wrong for later improvement
#### Best practices
- **Proactive error prevention**
    - Implement graceful degradation: design fallback options when services are unavailable, create simplified alternate flows during outages, provide agent escalation paths for system failures
    - Implement input validation: verify customer inputs before processing, set appropriate retry counts for customer inputs, provide clear instructions when invalid data is entered
- **Error logging and monitoring**
    - Cross-system error correlation: linking Amazon Connect errors with external systems, database failure impact tracking, CRM integration error detection, third-party service disruption correlation, end-to-end customer journey error mapping
    - Log and monitor errors: enable contact records for error tracking, set up Amazon CloudWatch alarms for error thresholds, create dashboards to visualize error patterns, [review CCP logs using Amazon Connect CCP Log Parser](https://docs.aws.amazon.com/connect/latest/adminguide/download-ccp-logs.html#step-review-ccp-logs)
- **Customer and agent communication**
    - Transparent error communication: clear messaging to customers when errors occur, avoidance of technical jargon in customer-facing error messages, real-time status updates during system disruptions, setting appropriate expectations about resolution timeframes, confirmation of issue receipt and tracking
    - Agent error notification system: immediate alerts to agents when systems fail, error context provided in the Agent Workspace, guidance scripts for communicating specific errors to customers, visual indicators for different severity levels, quick access to known issue repository
- **Automated recovery strategies**
    - Flow fallbacks: alternative branches for different error scenarios, default paths when primary services are unavailable, simplified flows that execute during system degradation, error-specific recovery flows triggered by error types, dynamic flow switching based on system health checks
    - Queue management recovery: automatic queue overflow handling, dynamic re-queuing based on error conditions, queue priority adjustments during system stress, alternate queue routing during primary queue failures, callback options automatically offered during queue errors
### Best practices for Complex Flows
- **Naming and documentation**
    - Use descriptive naming conventions for flows, blocks, and attributes
    - Document your flows with comments and clear structure
    - Create a standardized naming system across your organization
- **Visual organization**
    - Use color-coded branches to visually distinguish different paths
    - Break complex logic into modules for better organization
    - Use the search function to quickly find blocks in complex flows
- **Testing strategy**
    - Create test cases that cover all possible paths
    - Test thoroughly with different scenarios and edge cases
    - Validate each individual error handling path
- **Maintenance considerations**
    - Plan for regular reviews and updates
    - Document dependencies between flows
    - Consider how changes might impact other parts of the system

## AWS Service Integration
### AWS Lambda integration
- When integrated with Connect, Lambda performs key functions like accessing databases, updating CRMs, sending notifications, processing business logic, and connecting to third-party APIs
- Must be associated or added to a Connect instance before usage. Once associated, the Lambda function may be used in a flow
- Add a `Play prompt` block between Lambda functions to prevent silence
### Amazon Lex integration
- By using Amazon Connect with Amazon Lex, customers can speak their responses or press buttons on their keypad to navigate menus and access services
    - Allows self-service capabilities, like checking account balances or routing to the appropriate department through natural conversation flows
- Benefits:
    - Natural conversation experiences
    - Intent recognition to understand what customers want
    - Collection of required information
    - Processing both voice and chat interactions
    - Multi-language support
- Best practices:
    - Provide simple and realistic phrases (utterances) as training sets
    - Regularly review bot performance and update your utterance sets
    - Give clear prompts that guide users toward supported intents
    - Plan for fallback scenarios when customer intent is unrecognized
    - Use synonyms to handle different ways that customers might express the same intent
#### Amazon Lex configuration
- Setting up an Amazon Lex bot in Amazon Connect involves creating a bot with specific intents in the Amazon Lex console. You then integrate the bot with your Amazon Connect instance through a flow
- Further info: https://docs.aws.amazon.com/connect/latest/adminguide/amazon-lex.html
### Database connections
- Common database integration scenarios include customer profile lookups, order history retrieval, account status verification, storing customer preferences, recording interaction outcomes
- Connection methods:
    - **Through Lambda (most common approach)**: Lambda functions act as the intermediary between Amazon Connect and your database
    - **Through Amazon API Gateway**: Use this method for more complex integrations with authentication requirements
    - **Direct to Amazon DynamoDB**: Use this method is for simpler use cases with Lambda
#### Implementation
1. Set up proper permissions for Lambda to access your database (RDS, DynamoDB, other AWS databases or an on-premise database)
2. Code Lambda functions to perform create, read, update and delete (CRUD) operations on your database based on contact interactions
3. Pass relevant customer data between Connect and your Lambda using contact attributes
4. Validate the end-to-end flow
#### Best practices
- Cache frequently accessed data to improve performance
- Plan for database unavailability in your flows
- Be mindful of security when storing and accessing customer data
- Consider read replicas for high-volume lookup operations
- Follow the [principle of least privilege](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started-reduce-permissions.html) when configuring AWS Identity and Access Management (IAM) roles
- Store sensitive credentials in [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/) and optimize database calls to maintain low latency
### Amazon Polly integration
- Natural text-to-speech (TTS) in multiple voices and languages
    - Neural TTS for even more human-like voices
    - Configure text-to-speech in `Play prompt` blocks
- Support for [Speech Synthesis Markup Language (SSML) tags](https://docs.aws.amazon.com/connect/latest/adminguide/supported-ssml-tags.html)
#### Best practices
- Test pronunciations of industry-specific terms
- Use SSML for pauses, emphasis, and proper pronunciation
- Consider different voices for different types of messages
- Balance natural speech with efficiency
- Use Amazon Polly's SSML tags in Connect to create natural-sounding voice interactions that enhance caller satisfaction