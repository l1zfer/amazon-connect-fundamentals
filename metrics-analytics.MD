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
- **Set realistic expectations**: if your average wait time is 5 minutes, tell customers upfront rather than saying, "Just a moment"
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