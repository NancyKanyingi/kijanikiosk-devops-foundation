# KijaniKiosk Service Level Objectives

## kk-api (API Service)

### SLIs

#### 1. Availability SLI
Measures the percentage of HTTP requests that receive successful (2xx) responses from the API. It is collected by monitoring HTTP response codes returned by the `/health` endpoint and application requests over a rolling time window.

#### 2. Latency SLI
Measures the percentage of requests served within 500 milliseconds (p95 latency). It is collected from nginx access logs by calculating the 95th percentile response time.

#### 3. Error Rate SLI
Measures the percentage of payment API requests that return HTTP 5xx responses. It is collected by counting 5xx responses for the `/api/payments` endpoint and comparing them to the total payment requests.

### SLOs

| SLI | Target | Window | Error Budget |
|-----|--------|--------|--------------|
| Availability | 99.9% successful requests | Rolling 30 days | 43.2 minutes downtime |
| Latency | 95% of requests under 500 ms | Rolling 30 days | 5% of requests may exceed 500 ms |
| Error Rate | Less than 0.1% 5xx responses | Rolling 30 days | 1 failed request per 1,000 |

### Rollback Threshold Justification

The rollback thresholds used by `post-deploy-monitor.sh` are intentionally more conservative than the service level objectives. Three consecutive failed health checks, response times above two seconds, or excessive errors trigger an immediate rollback before the long-term SLO is significantly affected. This approach protects the error budget by detecting deployment problems within seconds instead of allowing them to continue for the full measurement window.

---

## kk-payments (Payments Service)

### SLIs

#### 1. Availability SLI
Measures the percentage of successful payment API requests that receive HTTP 2xx responses. It is collected from payment request logs.

#### 2. Latency SLI
Measures the p95 response time for payment processing requests. It is collected from nginx access logs.

#### 3. Payment Transaction Error Rate SLI
Measures the percentage of payment transactions returning HTTP 5xx responses. It is collected by comparing failed payment requests with the total payment requests.

### SLOs

| SLI | Target | Window | Error Budget |
|-----|--------|--------|--------------|
| Availability | 99.9% | Rolling 30 days | 43.2 minutes downtime |
| Latency | 95% under 500 ms | Rolling 30 days | 5% of requests above target |
| Payment Error Rate | Less than 0.1% | Rolling 30 days | 1 failed request per 1,000 |

### Rollback Threshold Justification

The deployment monitor is designed to react much faster than the SLO measurement window. Detecting three consecutive failures or repeated slow responses allows the deployment to roll back within approximately 15 seconds, preventing significant consumption of the 30-day error budget.
