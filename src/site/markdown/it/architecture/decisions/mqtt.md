# MQTT Requirements

1. **MQTT v5** should be used.
2. MQTT **QoS = 2** should be used.
3. Broker should **persist messages**.
4. Static, not random number **Client ID** should be set.
5. Prefer not to use retained messages. Use **non-retained** over retained messages. xcept well-analyzed and documented
   use cases where retained messages are specifically needed.
6. Sender should set **message ID**.
    - Property name: **"i"**
    - Accepted types: short, int, long, or UUID
    - Default and quick choice: **UUID**
    - Should also be in properties/headers
    - Required for possible duplication detection
7. Sender should set a message version into header.
    - Property name: **"v"**
    - Accepted types: int, long (with mask, like IPv4)
    - Use [semantic versioning](https://semver.org/)
8. Sender should set proper, correct **TTL for messages**, based on reality needs and requirements.
9. Session Expiry Interval meaningful value should be set.
    - Apply the same rules as TTL
    - Replaces MQTT 3.x **clean session = false**
    - Do not use clean session = true equivalent (SEI = 0)
    - Default and quick choice: **3600**
10. Avoid user properties/headers, except required ones mentioned in this document.
    - If used, property names should be short (**1–3 characters**)
11. Tenant ID property should be set.
    - Property name: **"t"**
    - It Can be short, int, long, or UUID
    - Required for routing
12. Property/header names should **not be "X-"** prefixed.
    - See: [RFC 6648](https://www.rfc-editor.org/rfc/rfc6648)
13. Content type can be passed as a property.
    - Prefer **not to set it**
    - If absent, default is **"application/cbor"**
14. Payload should be binary and compact.
    - CBOR over JSON
    - Property names should be short (1–3 characters)
    - Timestamps, UUIDs, etc. should be in binary format (CBOR optimized)
15. MQTT broker per tenant
    - Under low loads: multiple tenants per broker
    - Under high loads: multiple brokers per tenant
    - Reason: Mosquitto uses inner queues per subscriber
16. Subscriber per topic
17. Messages should be stored in schemaless DB as fast as possible
    - E.g., MongoDB (NB! but requires payload to be parsed!)
        - To avoid schema validation for better performance
        - Good DB sharding
    - Store as-is in binary form (no payload parsing)
    - Without processing (separate thread or process)
    - DB check heartbeats (separate thread or process) should be applied (cleanup, re-start processing, failing DB
      records handling, etc.)
18. Payload must include message creation date/time
    - Precision: nanoseconds (e.g., Java Instant)
    - Encoding: CBOR
    - Timestamp must stay the same in case of retries
    - Required for value object immutability
    - Property name: **"c"**
19. MQTT (plugin) + RabbitMQ as one single process is acceptable.
20. mTLS (client certificate authentication) should be applied for all clients.
21. RBAC must be configured for all topics, queues and exchanges.
22. Backpressure principles should be applied. Backpressure should be implemented via MQTT broker policies (e.g.,
    message rate limits, inflight window size, per-client buffer limits) to avoid overload during burst traffic.
23. Self-made (?) logging framework for error cases, for duplicate and continuous errors have to be developed.
24. Monitoring and metrics should be used. Use RabbitMQ Prometheus plugin and MQTT client metrics where applicable.
25. Use UTC for all timestamps and logging to avoid timezone-related issues.
26. Configuration and schema versioning must be maintained (Git, CI/CD based).
27. DevOps should define and document disaster recovery and backup procedures, including automated restore testing.
28. IP allow/deny lists should be configured on broker/network level.
29. Message maximum size should be measured, analyzed, decided and documented and set.
30. The MQTT broker, subscriber/consumer, and database should be treated as a **single logical unit** — a message queue
    processing system — and must be deployed in **high-availability (HA)** mode. All components should be monitored and
    failover-tested together to ensure message delivery, persistence, and processing continuity.
