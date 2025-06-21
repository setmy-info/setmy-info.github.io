# MQTT reuirements

1. MQTT v5 should be used.
2. MQTT QoS=2 should be used.
3. Broker should persist messages.
4. Client (static, not random number) ID should be set.
5. Prefer not to use retained messages.
6. Sender should set proper, correct (by reality needs) TTL for messages.
7. Session Expiry Interval meaningful value should be set. Apply the same rules as TTL rules here. Should be set to
   replace MQTT 3.x clean session option. Clean session should not be used (aka clean session = false).
8. If possible, do not use user properties (headers). User property name should be short (1-3 characters). Tenant ID,
   content type can be passed with properties. Property name "t" that can be in short, int, long, UUID.
9. If possible, payload should be binary and compact. CBOR over JSON. Property name should be short (1-3 characters).
   Date and time, UUID, ... should be in binary format.
10. MQTT broker per tenant. On lower loads many tenants. Also higher loads many brokers per tenant. Because Mosquitto
    uses inner queues per subscriber/consumer.
11. Subscriber per topic.
12. Messages should be stored into schemaless DB (Mongo, ...), to avoid schema validation for better performance. Stored
    as is (no payload parsing) in binary form, coming with payload.
13. Broker should persist messages.
14. Payload message should contain message creation date and time in nanosecond precision (Java Instant in CBOR). Should
    stay the same in case of retries (for example, network connection problems. Value object theory.).
    Property name "c".
15. Should contain device id. Property name "i" that can be in short, int, long, UUID.
