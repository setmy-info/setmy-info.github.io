# Open-source Observability Stack

Open Observability Stack (OOS)

## Selected Stack

- OpenSearch
- Graylog
- Prometheus
- Grafana
- Fluent Bit

This is an open-source observability platform where logs, metrics, and visualization are separated into dedicated
components.

---

# Overall Architecture

```text
                 Applications / Servers / Kubernetes

                              |
                              |
                    +---------+---------+
                    |                   |
                  Logs              Metrics
                    |                   |
                    v                   v

               Fluent Bit          Prometheus
                    |                   |
                    v                   |
                 Graylog               |
                    |                   |
                    v                   |
               OpenSearch              |
                    |                   |
                    +---------+---------+
                              |
                              v

                           Grafana
                              |
                              v

                       TV / Dashboards
```

---

# Component Responsibilities

| Component  | Purpose                                                                |
|------------|------------------------------------------------------------------------|
| Fluent Bit | Collects logs from servers, files, containers, and Kubernetes          |
| Graylog    | Centralized log collection, search, filtering, audit logs, and alerts  |
| OpenSearch | Log indexing and fast search backend for Graylog                       |
| Prometheus | Metrics collection: CPU, RAM, JVM, API performance, Kubernetes metrics |
| Grafana    | Dashboards, graphs, TV/NOC views, and visualization                    |

---

# Log Collection Architecture

Graylog normally does not directly read application or server log files.

Instead, a **log collector agent** is used.

The agent runs on the server, Kubernetes node, or close to the application.

The agent:

- monitors log files
- reads new log entries
- sends logs to Graylog
- keeps track of already processed log positions
- adds metadata
- enables centralized log collection

Metadata examples:

- server name
- application name
- environment
- Kubernetes namespace
- pod name
- container name

Architecture:

```text
Application / Server / Kubernetes

             |
             v

          Log Files

             |
             v

       Fluent Bit Agent

             |
             v

           Graylog

             |
             v

         OpenSearch
```

---

# Fluent Bit

Fluent Bit is the selected log collection agent.

Fluent Bit is:

- open-source
- lightweight
- fast
- low resource usage
- suitable for Linux servers
- suitable for Kubernetes environments

Processing flow:

```text
Read logs
    |
    v
Process logs
    |
    v
Add metadata
    |
    v
Forward logs
```

---

# Fluent Bit on Servers

Example server architecture:

```text
Server

 Application

      |
      v

   app.log

      |
      v

 Fluent Bit Agent

      |
      v

   Graylog

      |
      v

 OpenSearch
```

The application does not need to know anything about Graylog.

The application only writes:

```text
app.log
```

Fluent Bit:

- monitors the file
- reads new lines
- forwards logs to Graylog
- reconnects automatically
- keeps file reading position

---

# Fluent Bit in Kubernetes

In Kubernetes, Fluent Bit normally runs as a **DaemonSet**.

This means:

- one Fluent Bit agent runs on every Kubernetes node
- container logs are collected automatically
- Kubernetes metadata is added
- logs are forwarded to Graylog

Architecture:

```text
              Kubernetes Cluster


        Node 1              Node 2              Node 3

          |                   |                   |
          v                   v                   v

     Fluent Bit         Fluent Bit          Fluent Bit

          |                   |                   |

          +-------------------+-------------------+

                              |

                              v

                           Graylog

                              |

                              v

                         OpenSearch
```

---

# Kubernetes Log Example

Application writes:

```text
ERROR Payment failed
```

Fluent Bit enriches the log:

```text
namespace=production
pod=payment-api-7f8d
container=backend
node=k8s-node-01
```

Graylog query example:

```text
namespace:production
pod:payment-api
level:ERROR
```

---

# Java / Spring Boot Integration

The Java application does not communicate directly with Graylog.

Recommended model:

```text
Spring Boot Application

          |
          v

       Log File

          |
          v

      Fluent Bit

          |
          v

       Graylog

          |
          v

      OpenSearch
```

The application writes normal log files.

Example:

```text
/var/log/orders/application.log
```

Fluent Bit collects and forwards the logs.

Structured log example:

```json
{
    "service": "orders",
    "environment": "production",
    "level": "ERROR",
    "requestId": "abc123",
    "message": "Order processing failed"
}
```

Graylog search example:

```text
service:orders AND level:ERROR
```

---

# Log File Rotation and Cleanup

Graylog should normally not delete local log files.

Local log lifecycle should be handled by:

- application logging framework
- log rotation
- operating system policies

---

## Linux

Use:

```text
logrotate
```

Example:

```text
/var/log/myapp/app.log
```

Policy:

- rotate daily
- keep 14 days
- compress old logs
- delete expired logs

Result:

```text
app.log
app.log.1.gz
app.log.2.gz
```

---

## Windows

For Java applications:

- Logback RollingPolicy
- Windows Scheduled Task
- PowerShell cleanup jobs

Example:

```text
app.log
app-2026-07-14.log
app-2026-07-13.log
```

Old files are removed according to retention policy.

---

# Metrics

Logs and metrics are separate systems.

Java / Spring Boot:

```text
Spring Boot

      |
      v

 Micrometer

      |
      v

Prometheus Endpoint
```

Example:

```text
/actuator/prometheus
```

Prometheus collects:

```text
http_server_requests_seconds
jvm_memory_used_bytes
jvm_gc_pause_seconds
```

---

# Server Metrics

Node Exporter:

```text
Linux Server

      |
      v

Node Exporter

      |
      v

Prometheus
```

Collects:

- CPU usage
- RAM usage
- disk usage
- network traffic
- system statistics

---

# Kubernetes Metrics

Kubernetes monitoring:

```text
Kubernetes Cluster

        |
        v

 kube-state-metrics

        |
        v

    Prometheus

        |
        v

     Grafana
```

Metrics include:

- pod status
- deployment health
- node resources
- container CPU usage
- container memory usage
- restart counts

---

# Alerting

Prometheus Alertmanager:

```text
Prometheus

      |
      v

Alertmanager

      |
      +--> Slack
      |
      +--> Microsoft Teams
      |
      +--> Email
      |
      +--> Telegram
```

Examples:

- server is down
- CPU too high
- JVM memory problem
- Kubernetes pod restarting
- too many ERROR logs
- application health check failed

---

# Final Architecture

```text
                    OBSERVABILITY STACK


LOGS:

Applications / Servers / Kubernetes

              |
              v

          Fluent Bit

              |
              v

           Graylog

              |
              v

         OpenSearch



METRICS:

Java Applications
        |
        v
   Micrometer


Servers
        |
        v
 Node Exporter


Kubernetes
        |
        v
 Prometheus



VISUALIZATION:

Prometheus + OpenSearch

              |
              v

            Grafana

              |
              v

        TV / Dashboard View



ALERTS:

Prometheus

      |
      v

Alertmanager

      |
      v

Slack / Teams / Email
```

---

# Installation Order

1. Install OpenSearch
2. Install Graylog
3. Install Prometheus
4. Install Grafana
5. Install Fluent Bit agents
6. Deploy Fluent Bit DaemonSet in Kubernetes
7. Connect Java application logs
8. Configure log retention and rotation
9. Create Grafana dashboards
10. Configure alerts
11. Configure TV/NOC dashboard screens

---

# Final Result

With this stack you get:

- centralized log management
- fast log search
- user activity audit logs
- Java application JVM monitoring
- Kubernetes log collection
- server health monitoring
- infrastructure dashboards
- TV/NOC monitoring screens
- automatic alerts
- fully self-controlled observability platform

Open-source alternatives to commercial solutions:

- Datadog
- Dynatrace
- New Relic
- Splunk

The entire solution remains open-source and under your own infrastructure control.
