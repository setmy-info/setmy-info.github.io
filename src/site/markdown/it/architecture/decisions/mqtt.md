# MQTT Requirements

1. **MQTT v5** should be used.
2. MQTT **QoS = 2** should be used.
3. Broker should **persist messages**.
4. Static, not random number **Client ID** should be set.
5. Prefer not to use retained messages. Use **non-retained** over retained messages.
6. Sender should set **message ID**.
    - Property name: **"i"**
    - Accepted types: short, int, long, or UUID
    - Default and quick choice: **UUID**
    - Should also be in properties/headers
    - Required for possible duplication detection
7. Sender should set proper, correct **TTL for messages**, based on reality needs and requirements.
8. Session Expiry Interval meaningful value should be set.
    - Apply the same rules as TTL
    - Replaces MQTT 3.x **clean session = false**
    - Do not use clean session = true equivalent (SEI = 0)
    - Default and quick choice: **3600**
9. Avoid user properties/headers, except required ones mentioned in this document.
    - If used, property names should be short (**1–3 characters**)
10. Tenant ID property should be set.
    - Property name: **"t"**
    - It Can be short, int, long, or UUID
    - Required for routing
11. Property/header names should **not be "X-"** prefixed.
    - See: [RFC 6648](https://www.rfc-editor.org/rfc/rfc6648)
12. Content type can be passed as a property.
    - Prefer **not to set it**
    - If absent, default is **"application/cbor"**
13. Payload should be binary and compact.
    - CBOR over JSON
    - Property names should be short (1–3 characters)
    - Timestamps, UUIDs, etc. should be in binary format (CBOR optimized)
14. MQTT broker per tenant
    - Under low loads: multiple tenants per broker
    - Under high loads: multiple brokers per tenant
    - Reason: Mosquitto uses inner queues per subscriber
15. Subscriber per topic
16. Messages should be stored in schemaless DB as fast as possible
    - E.g., MongoDB (NB! but requires payload to be parsed!)
        - To avoid schema validation for better performance
    - Store as-is in binary form (no payload parsing)
    - Without processing (separate thread or process)
    - DB check heartbeats (separate thread or process) should be applied (cleanup, re-start processing, failing DB
      records handling, etc.)
17. Payload must include message creation date/time
    - Precision: nanoseconds (e.g., Java Instant)
    - Encoding: CBOR
    - Timestamp must stay the same in case of retries
    - Required for value object immutability
    - Property name: **"c"**
18. MQTT (plugin) + RabbitMQ as one single process is acceptable.
