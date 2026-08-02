# Post-Incident Review – Week 5 Monday Production Deployment Incident

## 1. Incident Summary

The KijaniKiosk API experienced approximately 48 seconds of downtime during an investor demonstration after a deployment was accidentally executed against the production environment instead of staging. Users experienced temporary service unavailability until the previous configuration was restored.

---

## 2. Timeline

| Time | Event |
|------|-------|
| 09:12 | Amina opened the deployment terminal. |
| 09:13 | Nia began the investor demonstration. |
| 09:15 | Amina executed `make configure ENV=production`. |
| 09:15 | The deployment pipeline started. |
| 09:16 | Production API restarted with the incorrect configuration. |
| 09:16 | Users began receiving service errors. |
| 09:17 | Nia notified Tendo of the outage. |
| 09:18 | Tendo identified the incorrect deployment target. |
| 09:19 | Previous configuration was restored. |
| 09:20 | Service returned to normal and monitoring confirmed recovery. |

---

## 3. Root Cause

### Five Whys

**Why did production become unavailable?**

Because the deployment targeted the production environment.

**Why was production targeted?**

Because `ENV=production` was entered manually.

**Why was the environment entered manually?**

Because the deployment accepted runtime environment parameters.

**Why was there no validation?**

Because the deployment process did not automatically derive the target environment from the Git branch or pipeline.

**Root Cause**

The deployment system allowed manual environment selection without validating it against the CI/CD pipeline context, making incorrect deployments possible.

---

## 4. Contributing Factors

- Manual environment selection during deployment.
- Lack of environment validation within the deployment process.
- Shared deployment credentials for multiple environments.

---

## 5. Prevention Mechanisms

- Use the **set-environment** job in `deploy.yml` to derive the deployment environment automatically.
- Remove manual `ENV=` parameters from deployment commands.
- Protect production deployments with GitHub Environment approval rules.

---

## 6. Action Items

| Action | Owner | Target |
|---------|-------|--------|
| Configure environment-specific GitHub secrets | Amina | End of Week 5 |
| Remove manual environment selection from the deployment workflow | Amina | End of Week 5 |
| Require approval before production deployments | Tendo | End of Week 5 |
