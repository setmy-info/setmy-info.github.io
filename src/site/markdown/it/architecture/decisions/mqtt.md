# MQTT reuirements

1. MQTT v5 should be used.
1. MQTT QoS=2 should be used.
1. Broker should persist messages.
1. Static, not random number client ID should be set.
1. Prefer not to use retained messages. Non-retained over retained messages.
1. Sender should set proper, correct (by reality needs) TTL for messages.
1. Sender should set message id. Property name "i" that can be in short, int, long or UUID. Default and quick choice
   UUID. Should be also in properties/headers. It is required for possible duplication detection.
1. Session Expiry Interval meaningful value should be set. Apply the same rules as TTL rules here. Should be set to
   replace MQTT 3.x clean session = false option. Clean session should not be used (aka clean session = false).
1. If possible, do not use user properties/headers, except required (mentioned in the current document)
   properties/headers. User property name should be short (1-3 characters).
1. Tenant ID property should be set. Property name "t" that can be in short, int, long, UUID. Required for possible
   routing.
1. properties/headers names should not be "X-" prefixed [rfc6648](https://www.rfc-editor.org/rfc/rfc6648).
1. Content type can be passed with properties, but prefer not to set it. If absent by default content type is
   "application/cbor".
1. If possible, payload should be binary and compact. CBOR over JSON. Property names should be short (1-3 characters).
   Date and time, timestamps, UUID, ... should be in binary format (CBOR data optimization).
1. MQTT broker per tenant. On lower loads many tenants. Also higher loads many brokers per tenant. Because Mosquitto
   uses inner queues per subscriber/consumer.
1. Subscriber per topic.
1. Messages should be stored into schemaless DB (Mongo, ...), to avoid schema validation for better performance. Stored
   as is (no payload parsing) in binary form, coming with payload.
1. Broker should persist messages.
1. Payload message should contain message creation date and time in nanosecond precision (Java Instant in CBOR). Should
   stay the same in case of retries (for example, network connection problems. Value object theory.).
   Property name "c".


. Saving to Infinispan cache to (2-nd level cache or "manually" - self-made caching code ?)

4. Sender should set ID for possible duplication detection.
5. Sender sets message preparation date time/timestamp. Every hour into separate DB table partition (24 partitions) by
   preparation date time?
6. Heartbeat thread, to initiate failing DB records handling.
