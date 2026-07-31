Deployment Strategy Analysis
Scenario 1: Overnight Batch Processor

Selected Strategy: Rolling Deployment

Rolling deployment is the most appropriate strategy because the system runs on a single worker VM with a minimal infrastructure budget, making the low-cost approach the best fit. Although rollback is slower than Blue/Green, the scenario allows up to 24 hours for rollback, so the slower recovery time is acceptable.

Scenario 2: User-Facing Authentication Service

Selected Strategy: Blue/Green Deployment

Blue/Green deployment is the best choice because the authentication service is not backward compatible, so all servers must run the same version during deployment to prevent authentication failures. The team has budget for duplicate servers, and Blue/Green provides rollback in under five minutes by switching traffic back to the previous environment if failures exceed the acceptable threshold.

Scenario 3: Machine Learning Recommendation Engine

Selected Strategy: Canary Deployment

Canary deployment is the most appropriate strategy because it gradually exposes the new recommendation model to a small percentage of users while the stable version continues serving the rest, allowing safe evaluation under real production traffic. The team should monitor click-through rate, latency, error rate, and resource usage at each rollout stage; if performance improves without violating reliability targets, rollout should continue, otherwise traffic should immediately return to the previous model.