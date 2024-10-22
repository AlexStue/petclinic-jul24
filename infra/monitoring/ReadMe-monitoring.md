
# ReadMe of Monitoring

## Configuration as code:

pmth-svr-ConfigMap.yml:

- Creation of "prometheus.yml" to scrape all the /metrics from the exporter.
- Creation of "prometheus.rules" where alerts and limits are defined.

pmth-almg-ConfigMap.yml:

- Definiton of the channels for notification. In this case only notifications to our Slack-Channel is used.
- Slack uses for this connection a API. The URL for the API is handeld like a secret in GitHub.

grfa-ConfigMap.yml:

- Creation of "prometheus.yaml" for connection to prometheus.
- Creation of "dashboardProviders.yaml" to configure the directory or group for the dashboards.
- Creation of "dashboard.json" defines the individual dasboards.

## Trigger Stresstest of CPU

Run on server:

```bash
stress --cpu 2 --timeout 60s
```