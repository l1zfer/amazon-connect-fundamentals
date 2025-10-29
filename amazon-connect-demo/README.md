# Amazon Connect demo: TravelDreams

## Task
- Create an Amazon Connect instance and a routing system for "TravelDreams", a fictional travel agency, including a voicebot for simple requests and a customized Agent workspace that reflects the company's corporate design.

## Assumptions for TravelDreams' Inbound Call Center:
- TravelDreams offers three main categories of services:
    1. Vacation bookings
    2. Business travel
    3. Customer service (for existing bookings)
- Business hours are Monday to Friday from 9:00 AM to 6:00 PM.
- A voicebot should handle simple requests 24/7, especially useful outside business hours.
- TravelDreams has agents with different language skills (German, English, Portuguese).
- VIP customers should be treated with priority.
- A queue should be set up for high call volumes.
- Agents need quick access to caller information during calls.
- TravelDreams has a specific corporate design with defined colors, fonts, and logo.

## Tasks for the colleague:
- Create a new Amazon Connect instance.
- Set up a main contact flow that greets the caller and asks for the desired language.
- Implement a menu selection for the three main categories (vacation bookings, business travel, customer service) and add an option for checking booking status.
- Create separate contact flows for each category with specific prompts and routing rules.
- Implement a business hours check. During business hours, route calls to agents. Outside business hours, offer the option to use the voicebot or wait for the next business day.
- Develop a voicebot that can handle simple requests, specifically checking the status of a booking:
    1. Create a dummy DynamoDB table with sample booking data (booking ID, status, customer name, travel dates, contact information, VIP status).
    2. Implement a Lambda function to query the DynamoDB table.
    3. In the contact flow, use Amazon Lex to create a chatbot that can understand and process the "check booking status" intent.
    4. Integrate the Lex bot with the Lambda function to retrieve booking status from the DynamoDB table.
    5. Provide the booking status to the customer via text-to-speech.
- Integrate a customer number query to identify VIP customers and treat them with priority.
- Set up a queue that is activated during high call volumes. Add an estimated wait time announcement.
- Implement basic routing that directs callers to the appropriate agents based on their language selection and chosen category.
- Set up and customize the Agent workspace:
    1. Configure the Contact Control Panel (CCP) for agents.
    2. Create a custom agent interface using Amazon Connect Streams API and a web application framework (e.g., React).
    3. Implement a Lambda function that retrieves customer data from the DynamoDB based on the caller's phone number or customer ID.
    4. Use Amazon Connect Customer Profiles to create a unified view of customer data.
    5. Display relevant customer information (booking details, contact history, VIP status) in the agent interface when a call is connected.
    6. Customize the agent interface to match TravelDreams' corporate design:
        - Apply the company's color scheme to the interface elements
        - Use the corporate font for text elements
        - Incorporate the TravelDreams logo in the header or appropriate area
        - Design custom icons that align with the corporate style
        - Create a layout that reflects the company's brand identity
    7. Ensure the custom interface is responsive and works well on different screen sizes.
- Implement call routing to ensure that customer information is passed to the agent workspace when the call is connected.
- Add a customer satisfaction survey at the end of the call.
- Configure basic reports to monitor the performance of the contact center (e.g., call volume, average handling time, customer satisfaction, voicebot usage).
- Set up agent performance metrics and real-time monitoring dashboards, styled to match the corporate design.