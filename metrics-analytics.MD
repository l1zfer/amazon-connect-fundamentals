# Amazon Connect Metrics & Analytics
## Metrics Fundamentals
### Metrics Categories and Purposes
- **Queue metrics**: queue size (number of contacts waiting), longest queue wait time (longest time a contact waited in queue), abandonment rate (percentage of contacts that hang up before reaching an agent)
- **Agent metrics**: average handle time (the typical amount of time an agent spends with the contact), occupancy (percentage of time agents spend handling contacts compared to their total available time), agent activity state (an automatic status that reflects what an agent is currently doing within Amazon Connect [for example: *Incoming*, *Missed*, *On Contact*]), agent status (the availability setting an agent manually selects in the CCP - this indicates whether the agent is available to receive contacts)
- **Contact metrics**: channel type (voice, chat, and more), contact duration (total time of the contact from beginning to end), resolution time (how long it takes to resolve customer issues)
### Metric Purposes
- **Contact Dashboard**: by analyzing these related metrics, supervisors can identify trends and address issues before they impact customer satisfaction. This dashboard provides a holistic view of contact center performance, allowing supervisors to correlate different metrics and make data-driven decisions
- **Queue Metrics**: when reviewed alongside the decreased number of calls answered by agents and higher than expected call volumes, supervisors can identify the root cause of increased queue times. This could point to understaffing, unexpected call volume spikes, or other operational issues
- **Agent Metrics**: the decreased handle time coupled with increased answer time suggests a staffing issue. Agents appear to be working efficiently (lower handle times) but are likely overwhelmed by call volume, resulting in longer wait times. This pattern strongly indicates there are fewer agents available to handle incoming calls than needed
- **Agent Performance Summary**: If there are not enough agents to handle the incoming call volume, queue times will increase. When agents finally answer calls, they might rush through them to get to the next caller, resulting in shorter handle times
- **Contact Metrics**: The elevated contact volume compared to the forecast helps explain the discrepancy in queue times and agent performance metrics. This unexpected increase in volume, if not matched with appropriate staffing, leads to longer wait times despite efficient call handling by available agents
### Key Metrics and KPIs
- **Service level**: percentage of contacts answered within a target time (for example, 80 percent of calls answered within 30 seconds) - measures customer experience in terms of wait time
- **Average Handle Time (AHT)**: average time agents spend handling contacts, including talk or chat time, hold time, and after-contact work - impacts staffing needs and efficiency
- **First call resolution (FCR)**: percentage of contacts resolved without the customer needing to contact you again - measures effectiveness
- **Customer satisfaction (CSAT)**: post-contact survey results - measures customer's perspective on their experience
- **Occupancy rate**: percentage of time agents spend handling contacts compared to their total available time - helps balance agent productivity and burnout
#### Common real-time metrics
- **Contacts in queue**: the number of contacts currently waiting to be connected to agents
- **Oldest contact in queue**: how long the longest-waiting contact has been waiting
- **Available agents**: how many agents are ready to take on contacts
- **Abandonment rate**: the percentage of contacts that disconnect before reaching an agent
#### Common mistakes when using agent metrics
- **Over-emphasizing speed**: focusing too much on handle time can lead agents to rush customers, reducing satisfaction
- **Ignoring quality**: a fast agent isn't always a good agent if they are not resolving customer issues
- **Using metrics punitively**: metrics should be tools for improvement, not punishment
#### Using metrics to improve customer experience
- **Set realistic expectations**: if your average wait time is 5 minutes, tell customers upfront rather than saying "Just a moment"
- **Offer alternatives**: when queue metrics show long waits, [offer callback options or suggest digital channels](https://docs.aws.amazon.com/connect/latest/adminguide/setup-queued-cb.html)
- **Address root causes**: If abandonment rates are high, investigate whether certain issues could be resolved through self-service
### Making Data-Driven Decisions
- **Identifying peak times**: Review historical reports to find your busiest hours and days and use this information to adjust staffing schedules
- **Spotting training needs**: Look for agents with significantly higher/lower metrics than others - high handle times might indicate need for additional training. Exceptionally skilled agents can become mentors for others
- **Improving IVR flows**: Use "Self-service success rate" to see if customers can solve issues through your IVR. High transfer rates from self-service might indicate confusing menu options - adjust your flows based on common customer paths
    - Track where customers are dropping out of your IVR to identify frustration points, then redesign those specific paths to reduce abandoned contacts
- **Real-time adjustments**: Use real-time metrics to make immediate changes, share dashboard with supervisors for quick decision-making. If queue lengths suddenly increase, consider moving agents between queues
### Understanding Dashboards and Reports
#### Dashboards
- **Conversational analytics dashboard**: provides advanced insights into overall contact center performance
- **Queue and agent performance dashboard**: shows foundational real-time metrics about contact center operations
- **Flows performance dashboard**: offers basic insights into how contact flows are performing
- **Outbound campaigns performance dashboard**: tracks metrics related to outbound calling campaigns
- **Intraday forecast performance dashboard**: displays queue performance forecasts within the day
- **Agent performance evaluation dashboard**: shows detailed metrics about agent performance across different groups and timeframes
#### Common real-time metrics
- **Contacts in queue**: the number of contacts currently waiting to be connected to agents
- **Oldest contact in queue**: how long the longest-waiting contact has been waiting
- **Available agents**: how many agents are ready to take on contacts
- **Abandonment rate**: the percentage of contacts that disconnect before reaching an agent
#### Historical metrics report
- Average handle time over the past week
- Abandonment rate trends comparing this month to last month
- Service level achievement (percentage of contacts answered within target time) for different time periods
- https://docs.aws.amazon.com/connect/latest/adminguide/historical-metrics.html

## Real-time Monitoring
### Real-time Metrics Reports
- **Permissions to access metrics**: Access metrics: `Access`, Real-time metrics: `Access`
- **Permissions to access resources**: Routing profiles: `View`, Queues: `View`, Users: `View`
#### Key components
- **Time Range**: adjust how far back the real-time data should span - typically set for an amount of time between 15 minutes to 24 hours
- **Groupings**: determine how the data is aggregated in the rows of your table. Adding more groupings will show more granular data, and increase the number of rows displayed
- **Filters**: specify filters to scope the data to be included in the report. The available filters depend on the report type
    - **Queues**: includes data only for the queues that you select from Include
    - **Routing profiles**: includes data only for the routing profiles that you select from Include
    - **Agents**: includes data only for the agents that you select from Include
    - **Agent Hierarchies**: includes data only for the agent hierarchies that you select from Include
    - **Channel**: available for Queues and Routing Profile report type. Includes data only for Channels you select
- **Metrics**: show up as columns of table data - https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html
#### Multi-metric report functionality
- A queue-focused table showing waiting contacts and service levels
- An agent-focused table showing who's available and their current activities
- A routing profile table showing how different teams are performing
#### Real-time metric data refresh rate
- **Real-time metrics page**: refreshes every 15 seconds, as long as the page is active. For example, if you have multiple tabs open in your browser and navigate to a different tab, the real-time metric page won't be updated until you return to it
- **Queue Metrics** (Active and Availability): refresh as activity occurs, with a small system delay for processing the activity
- **Agent near real-time metrics** (Missed and Occupancy): refresh as activity occurs, with a small delay for processing
- **Contact near real-time metrics**: refresh about a minute after a contact ends
### Agent and Queue Performance Tracking
- **Agent statuses**: `Available` (ready to receive a contact), `On contact` (actively handling a customer), `After contact work` (completing post-contact tasks), `Custom states` (lunch, training, and so forth), `Error states` (a situation that needs immediate attention) - https://docs.aws.amazon.com/connect/latest/adminguide/metrics-agent-status.html
- **Current contact information**: how long the current contact has been active, which queue the contact came from, which channel the agent is using (such as voice or chat)
- **Real-time agent monitoring**: Listen-in (quietly monitor a call for quality assurance), barge (join an ongoing contact to provide assistance), take over (assume control of a difficult situation)
#### Queue monitoring techniques
- **Contact distribution**: monitor how contacts are distributed across queues - if one queue becomes overloaded while others remain manageable, consider reassigning agents
- **Wait time tracking**: monitor the average wait times and the longest current wait time in queues - the longest wait time identifies customers requiring immediate attention
- **Service level monitoring**: track real-time performance against service level targets
- **Channel comparison**: monitor metrics across voice, chat, and email channels
- **Custom thresholds and visual alerts**: configure metrics to highlight values outside acceptable ranges
#### Queue graph
- Visualize historical queue data using time series graphs to help identify patterns, trends, and outliers (service level, contacts queued, and average handle time)
- Queue dashboard automatically refreshes every 15 minutes - useful to configure a time range of up to 24 hours, select the channel of your choice or customize the service level thresholds
### Real-Time Decision-Making
- **Immediate staffing adjustments**: If queues are building, request agents on break to return early; if the volume is unexpectedly low, offer voluntary time off; shift agents between channels based on current demand
- **Queue interventions**: Implement queue callback options when wait times exceed thresholds; adjust routing priorities to focus on the oldest contacts; temporarily redirect new contacts to overflow queues
- **Agent support**: Provide real-time coaching to agents struggling with complex contacts; help agents who appear stuck in error states; recognize agents who are handling high volumes efficiently

## Custom Report Design and Management
### Creating Historical Metrics Reports
- **Contact record-driven metrics**: based on formed contact record records (for example, contact record-driven metrics are **Service level**, **Agent interaction time**, and **After contact work time**)
- **Agent activity-driven metrics**: based on agent activities like agent status changes, agent conversation changes (for example, an agent activity-driven metric is **Non-Productive Time**)
- **Access historical metrics**: Login to the Amazon Connect Admin Workspace and navigate to Analytics and optimization > Historical metrics
    - Requires permission to access metric data - security profiles `CallCenterManager` and `QualityAnalyst` include this permission
- **Choose report type**:
    - **Queue-based reports**: Focus on contact flow and wait times, such as `Contact` and `Agent metrics`
    - **Agent-based reports**: Focus on individual performance, such as `Agent performance` and `Agent activity audit report`
    - **Phone numbers report**: Analyze performance by contact entry point per number
    - **Email addresses report**: Analyze performance by contact entry point per email address
    - **Cases report**: Focus on case activities, such as `Interval` and `Snapshot metrics`
- **Selecting interval and time range**:
    - **Interval**: How to divide the data (15 minutes, 30 minutes, Daily, Total)
    - **Time Zone**: Select your time zone or location (UTC or London)
    - **Time range**: Rolling periods (Today, Last 24 hours, Yesterday, Last 2/3 days, or Custom time range)
- **Advanced customizations**:
    - On the **Groupings** tab, one can choose up to five groupings
        - For multiple grouping options, the data is grouped by the first grouping option and then by the subsequent grouping options
    - On the **Filters** tab, one can specify filters to scope the data to be included in the report
        - Available filters depend on the groupings selected
- **Choose report metrics and fields** to display on the report
    - An exclamation mark (!) is displayed next to any metrics that are not available based on the groupings selected
### Advanced Filtering and Grouping
#### Filtering options
- **Queue filters**: Include only specific queues (for example, Technical Support and Billing queues only)
    - When to use: When you want to focus analysis on particular service areas or compare performance between different types of contacts
    - Example: To analyze how your Premium Customer queue performs compared to standard queues, filter to include only those specific queue types
- **Agent filters**: Include only specific agents or teams
    - When to use: When evaluating individual performance or team comparisons or when tracking new hire progress
    - Example: To analyze how your new trainee team is performing, filter to include only agents hired in the last 30 days
- **Channel filters**: Focus on particular channels, such as voice, chat, or email
    - When to use: When comparing performance across different communication methods or troubleshooting issues with a specific channel
    - Example: If customer feedback suggests chat response times are too slow, create a report filtered to chat interactions only
- **Contact attribute filters**: Filter by custom attributes defined, such as customer tier or issue type
    - When to use: When analyzing performance for specific customer segments or contact types
    - Example: To analyze how efficiently your team resolves technical issues compared to billing questions, filter by the Contact reason attribute
- **Time filters**: Focus on specific time periods, such as business hours only
    - When to use: When analyzing performance differences between time periods or optimizing staffing for peak hours
    - Example: To improve staffing during your busiest period, create a report filtered to show only contacts between 10 am–2 pm
#### Grouping options
- **Queue grouping**: See metrics broken down by queue
    - When to use: When comparing performance between different service types or identifying which queues might need additional resources
    - Example: Grouping by queue might show that your Technical Support queue has a much longer average handle time than other queues, suggesting more complex issues or training needs
- **Agent grouping**: Compare individual agent performance
    - When to use: When conducting performance reviews, identifying coaching needs, or recognizing top performers
    - Example: Grouping by agent might reveal that certain agents have significantly higher customer satisfaction scores. The team could benefit from having those agents share their best practices
- **Team grouping**: Compare teams using agent hierarchy
    - When to use: When evaluating team leader effectiveness or comparing performance between different departments
    - Example: Grouping by team might show that Team A consistently achieves better service levels than Team B, prompting an investigation into different management approaches
- **Time period grouping**: See how metrics change over different time intervals
    - When to use: When analyzing trends, identifying patterns, or planning staffing needs
    - Example: Grouping by hour of day might reveal that handle times increase significantly after 3 pm, suggesting fatigue factors or shift planning opportunities
- **Channel grouping**: Compare performance across different contact channels
    - When to use: When evaluating channel strategy or identifying training needs for specific communication methods
    - Example: Grouping by channel might show that resolution rates are lower for chat than voice, suggesting a need for chat handling process improvements
- The grouping you choose affects how metrics are calculated (Average handle time grouped by queue shows the average across all agents in that queue, while grouping by agent shows individual agent averages, for example)
#### Advanced techniques
- Create reports that compare performance across different dimensions, such as the following:
    - This week compared to last week
    - Team A compared to Team B
    - Morning shift compared to Evening shift
- For nested grouping, group by multiple factors for deeper insights such as the following:
    - First by team, then by agent
    - First by queue, then by time period
### Report Management, Security and Troubleshooting
#### Custom report creation
- To start, navigate to your Amazon Connect log in page. Enter your credentials and sign in
- From the **Connect Administration console**, choose **Analytics and optimization** from the navigation sidebar. Next, choose **Real-time metrics**
- From the **Real-time Metrics** page, choose one of the report types shown. They group and order the data in different ways and include different metrics by default. For this demonstration, **Queues** will be chosen.
- Then, on the **Real-time Metrics Queues** page, you can optionally add more tables to the report by choosing the **New table** menu and choosing the table.
- Next, to configure the **Queues** table, choose the gear icon in the table header.
- On the **Time range** tab, choose **Trailing windows for time**, then choose the time range, in hours, for the data to include in the report. This demonstration will use a **1-hour** time range.
- Optionally, you can choose the **Filters** tab. There, you specify filters to scope the data to be included in the report. The available filters depend on the report type. The following possible filters for the Queues report are shown.
- Next, on the **Metrics** tab, select the metrics and fields to include in the report. The available metrics and fields depend on the report type and filters that you select. The Amazon Connect Administration guide contains definitions for all available metrics in Connect.
- When you are finished customizing the report, choose **Apply**.
- To optionally save your report for future reference, choose **Save report**.
- In the text box, provide a name for the report. Use a consistent naming convention for your reports.
- Then, choose **Save**.
- After you have saved your report, you will see the reports name in the title. Your report is now available for future use, but it is only available to you as the creator.
- To optionally share your report, return to the Connect Administration console home screen.
- From the navigation menu, choose **Analytics and optimization** and then choose **Dashboards and reports**.
- Next, choose the **Real-time metrics** tab, or optionally, choose **All reports**.
- Then on the **Real-time metrics reports** screen, you will see your saved report.
- Hover your cursor over the report name to reveal the **Share** and **Delete** functions for the report. Choose the **Share** icon.
- Next, in the **Share Report** pop-up, for the **Share setting**, turn on **Read-only**. Then, for **Publish report to organization**, turn on **Publish**. You will also notice that the **Save** option is inactive until you choose one or both of the settings.
- After you have turned on the share settings for your report, choose **Save**.
- Now on the **Dashboards and reports** page, you will see the report is now published and read-only. Your report is available to all users that have appropriate permissions to view, and you, as the owner, maintain full control. The read-only settings prevent other users from modifying the report
- Use consistent report naming conventions, for example: "Agent Performance - Team Name," to clearly identify ownership across your organization
#### Report management best practices
- **Regular review** – Schedule quarterly reviews of report relevance
- **Version control** – Consider including version numbers for major updates
- **Documentation** – Maintain brief descriptions of what each report is designed to show
- **Organization** – Create folder structures if your environment has many reports
- **Permission management** – Control who can edit and who can only view reports
#### Scheduling reports
- For reports that need to be reviewed regularly, use automated scheduling to help ensure consistent distribution:
    - Create a new report and save it, or open a saved report
    - Choose the **Actions** menu and choose **Schedule**
    - Read and acknowledge the note, which states all individuals who have proper permissions will be able to access the report. If you need to update permissions before scheduling your report, choose Cancel. Otherwise, choose Continue
    - On the **Recurrence** tab, specify how often this report should be run (for example, weekly on Saturdays). Also set the range (for example, from midnight for the previous 5 days)
    - On the **Delivery Options** tab, specify a prefix for the location in Amazon S3 to store the report files
#### Report limitations
- **Format** – Reports are delivered as CSV files only (no visualizations)
- **Storage** – Reports are stored in Amazon S3, not emailed directly
- **Notifications** – There are no automatic notifications when reports are generated
- **Failure alerts** – There are no alerts if scheduled reports fail to run
- To overcome these limitations, use the following strategies:
    - **Email distribution** – Set up an AWS Lambda function to email the CSV when it appears in Amazon S3
    - **Visualization** – Import scheduled report data into business intelligence tools
    - **Monitoring** – Create Amazon CloudWatch alerts to monitor for report generation failures
#### Access control implementation
- **Security profile permissions**:
    - Access metrics – Supports users to view metrics data
    - Create reports – Supports users to build new reports
    - Edit reports – Supports users to modify existing reports
    - Publish reports – Who can make reports available to others
    - Delete reports – Who can remove reports
- **Role-based access patterns**:
    - **Viewers** (agents, team leads) – Can only view published reports
    - **Analysts** (supervisors, analysts) – Can create and edit their own reports
    - **Publishers** (managers, lead analysts) – Can publish reports for wider use
    - **Administrators** (admins, directors) – Has full control over all reports
- Best practices for security permissions:
    - Apply the principle of least privilege—give users only the permissions they need
    - Create specialized security profiles for report creators and publishers
    - Review permissions quarterly to make sure that they remain appropriate
    - Document your permission structure for consistency
    - Use groups rather than individual permissions when possible
#### Metrics troubleshooting
- No data appearing in reports:
    - Time range – Confirm the selected period contains activity
    - Filters – Verify filters aren't too restrictive
    - Permissions – Confirm you have access to the metrics you're requesting
    - Data delay – Note that historical metrics might have a slight processing delay
- Unexpected metric values
    - Metric definition – Review the exact definition of the metric
    - Calculation method – Check if grouping affects how the metric is calculated
    - Time zone – Verify the time zone settings for the report
    - Filtering impact – Consider if filters are excluding relevant data
- Common metrics discrepancies
    - Service level – Remember this is the percentage of contacts answered within the threshold, not the average speed of answer
    - Occupancy – This excludes any time agents spend in custom states
    - Abandonment rate – Callbacks don't count as abandoned, which might make this metric look better than expected
    - Agent activity – Confirm agents are properly logging their activities for accurate reporting
- Report performance issues
    - Date range – Try reducing the timespan
    - Metrics quantity – Reduce the number of metrics included
    - Grouping complexity – Simplify grouping arrangements
    - Filter optimization – Use more targeted filters
    - Browser cache – Clear your browser cache