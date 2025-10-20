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
## Key Metrics and KPIs
- **Service level**: percentage of contacts answered within a target time (for example, 80 percent of calls answered within 30 seconds) - measures customer experience in terms of wait time
- **Average Handle Time (AHT)**: average time agents spend handling contacts, including talk or chat time, hold time, and after-contact work - impacts staffing needs and efficiency
- **First call resolution (FCR)**: percentage of contacts resolved without the customer needing to contact you again - measures effectiveness
- **Customer satisfaction (CSAT)**: post-contact survey results - measures customer's perspective on their experience
- **Occupancy rate**: percentage of time agents spend handling contacts compared to their total available time - helps balance agent productivity and burnout
### Common real-time metrics
- **Contacts in queue**: the number of contacts currently waiting to be connected to agents
- **Oldest contact in queue**: how long the longest-waiting contact has been waiting
- **Available agents**: how many agents are ready to take on contacts
- **Abandonment rate**: the percentage of contacts that disconnect before reaching an agent
### Common mistakes when using agent metrics
- **Over-emphasizing speed**: focusing too much on handle time can lead agents to rush customers, reducing satisfaction
- **Ignoring quality**: a fast agent isn't always a good agent if they are not resolving customer issues
- **Using metrics punitively**: metrics should be tools for improvement, not punishment
### Using metrics to improve customer experience
- **Set realistic expectations**: if your average wait time is 5 minutes, tell customers upfront rather than saying, "Just a moment"
- **Offer alternatives**: when queue metrics show long waits, [offer callback options or suggest digital channels](https://docs.aws.amazon.com/connect/latest/adminguide/setup-queued-cb.html)
- **Address root causes**: If abandonment rates are high, investigate whether certain issues could be resolved through self-service