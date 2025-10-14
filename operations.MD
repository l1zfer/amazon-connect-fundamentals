# Amazon Connect Operations
## Operational Management
- Overseeing daily activities to ensure efficient customer service delivery
- Scheduling agents, monitoring performance metrics, managing contact queues, maintaining system functionality, implementing workflow processes, and responding to incidents
### Operational task framework
- Within Amazon Connect, tasks can be the tool to bring the framework to actionable items
- **Identifying key areas upon starting daily operations**: agent staffing and availability, queue management, system performance, customer experience metrics, incident tracking
- **Creating checklists of specific tasks**: review overnight incident reports, check agent staffing against the day's forecast, verify that all queues are operational, review any scheduled maintenance
- **Task scheduling on different frequencies**: at the start of each day, hourly during peak periods, Weekly for deeper analysis, monthly for trend reporting
    - Task templates can be used to create structured task workflows
- A common mistake is creating too many tasks without prioritization. Instead, focus on high-impact activities that directly affect customer experience and agent productivity
### Maintenance routines
- **Flow maintenance**: regularly review and optimize your contact flows to ensure that they are working as expected
- **Queue configuration review**: periodically evaluate your queue settings to ensure that they align with current business needs
- **User management**: keep your agent list current by removing inactive users and ensuring that proper security profiles are assigned using least-privilege access control
- **Scheduling maintenance**: schedule routine maintenance during off-peak hours, communicate changes to all stakeholders in advance, document all maintenance activities for future reference
- **Avoiding common pitfalls**: always test changes in a development environment before implementing in production, maintain detailed documentation of all system configurations to help troubleshoot issues that might arise after maintenance
- https://docs.aws.amazon.com/connect/latest/adminguide/operational-excellence.html
### Resource monitoring
#### Amazon Connect Real-time metrics report
- Help contact center managers analyze and track agent and queue metrics
- View and compare queue performance using custom-defined time periods
- **Agent availability**: track real-time agent states to ensure adequate staffing across channels
- **Queue performance**: monitor queue lengths, abandonment rates, and service levels in real time
#### Amazon Connect Flow Logs
- Real-time details about events in your flows as customers interact with them
- Use flow logs to help debug your flows as you are creating them - https://docs.aws.amazon.com/connect/latest/adminguide/about-contact-flow-logs.html
- To enable flow logs, choose **Enable flow logs** in the AWS Console for your Connect instance
#### Set logging flow block
- Flow logs are generated only for flows that include a `Set logging behavior` block with Logging behavior enabled
    - You control which flows, or parts of flows, that logs are generated for by including multiple `Set logging behavior` blocks and configuring the logging behavior as needed
#### Amazon CloudWatch
- Use CloudWatch to collect and track metrics in custom dashboards from Amazon Connect available metrics tailored to your specific needs
    - For instance, you might set up an alert to notify managers when abandonment rates exceed 5 percent, or when service level drops below the target for more than 15 minutes
- Configure CloudWatch for Amazon Connect metrics to capture system-level data
- Create custom dashboards for your most important operational metrics
- Clear protocol for response upon identifying an issue:
    1. Assess the severity and impact
    2. Implement immediate mitigation steps if needed
    3. Document the incident
    4. Follow up with root cause analysis
- Relevant literature:
    - https://docs.aws.amazon.com/connect/latest/adminguide/real-time-metrics-reports.html
    - https://docs.aws.amazon.com/connect/latest/adminguide/about-contact-flow-logs.html
    - https://docs.aws.amazon.com/connect/latest/adminguide/monitoring-cloudwatch.html

## Agent and Team Management
### Agent Scheduling Techniques
- Amazon Connect offers [forecasting, capacity planning, and scheduling](https://docs.aws.amazon.com/connect/latest/adminguide/forecasting-capacity-planning-scheduling.html) tools powered by machine learning to help optimizing workforce
- **Forecasting and scheduling basics**:
    1. Create accurate forecasts based on historical data
    2. Define shift profiles (templates for weekly shifts)
    3. Establish staffing groups based on skills and contact types
    4. Set up business and HR rules (like break times, maximum hours, and so on)
    5. Generate schedules that meet service level targets
    6. Review and publish schedules for supervisor and agent access
- **Creating effective schedules**:
    1. Create shift profiles that align with contact patterns (for example, if your call volume peaks between 10 AM and 2 PM but chat volume is highest from 2 PM to 6 PM, you might create shifts that ensure adequate coverage across both channels)
    2. Implement staff rules for scheduling. Amazon Connect lets you create staff rules such as the following:
        - Minimum time between shifts (for example, 12 hours)
        - Maximum consecutive working days (for example, 5 days)
        - Break frequency and duration
    3. Use staffing groups to match skills with needs. Group agents based on their skills, language capabilities, or certification levels to ensure that the right agents are available for specific contact types
- **Schedule optimization**:
    - Monitor schedule adherence to understand whether agents are following their schedules
    - Adjust schedules based on unexpected volume changes
    - Balance part-time and full-time staff for maximum flexibility
- Other effective agent management techniques:
    - Setting clear performance expectations
    - Providing regular feedback and coaching
    - Ensuring that agents have proper tools and training
    - Monitoring quality metrics (handle time, first-call resolution, customer satisfaction)
    - Supporting work-life balance through flexible scheduling options
### Performance Management
- [Amazon Connect Contact Lens](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens.html) provides contact center analytics and quality management capabilities
    - You can use these to monitor, measure, and continuously improve contact quality and agent performance for a better overall customer experience:
        - Speech analytics to identify customer sentiment
        - Performance dashboards highlighting areas for improvement
        - Compliance monitoring for required disclosures or procedures
- When performance gaps are identified:
    - Review specific interactions using recordings and transcripts
        - For example: "Let's listen to this call where the customer needed to escalate. What approaches might have resolved their issue earlier?"
    - Provide specific, actionable feedback
        - Instead of "Your handle time is too high," try "I noticed that you spent extra time searching for information. Let's look at some navigation shortcuts that could help."
    - Create personalized development plans
        - For agents struggling with chat efficiency, you might assign specific training on multitasking and template responses
### Supervisor tools
#### Monitoring capabilities
- **Live capabilities**: Supervisors can silently monitor calls and chat conversations for quality assurance.
- **Barging capabilities**: Supervisors can **barge** (join the conversation when needed)
- **Supervisor state changes**: Supervisors can monitor agent states (with appropriate permissions given, also change the state of the agents), request agents to log out and adjust routing when service levels are at risk (moving agents to queues or deflecting calls to callbacks or voicemail if set up)