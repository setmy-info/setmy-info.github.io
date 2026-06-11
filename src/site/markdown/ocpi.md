# Open Charge Point Interface (OCPI)

## Information

The Open Charge Point Interface (`OCPI`) is an open protocol used in the electric vehicle (`EV`) charging ecosystem.
It is designed to let different charging platforms exchange data in a standardized way, especially when multiple
companies participate in charging, roaming, operations, billing, and smart charging flows.

In practice, `OCPI` is mostly used so that:

* one charging network can make its charge points visible to other mobility providers,
* `EV` drivers can use a single app, card, or contract across multiple charging networks,
* charging session, tariff, token, and location data can be exchanged consistently,
* smart charging and remote operations can be coordinated between systems.

`OCPI` is widely associated with `EV` roaming. It enables interoperability between software platforms rather than
between the physical charger and the car directly. For charger-to-backend communication, protocols such as `OCPP`
are typically used, while `OCPI` is used more for backend-to-backend communication between market participants.

### What `OCPI` is mostly about

At a high level, `OCPI` defines APIs and data models for exchanging information such as:

* charging station and connector locations,
* availability and status information,
* driver tokens and authorization data,
* charging tariffs and pricing,
* charging session records,
* charge detail records (`CDRs`) for settlement and billing,
* commands such as remote start or remote stop,
* smart charging related data.

This makes `OCPI` important for companies building:

* charging point operator platforms,
* `EV` mobility apps,
* roaming hubs,
* billing and settlement services,
* fleet charging platforms,
* energy and smart charging integrations.

### Top terminology

#### Roaming

In `EV` charging, roaming means a driver can use charging infrastructure outside their direct provider's own network,
while the involved companies still exchange authorization, session, and billing data in the background.

#### Location

A `Location` represents a physical place where charge points are available, for example a parking area, shopping
center, office site, or roadside charging area.

#### EVSE

An `EVSE` (`Electric Vehicle Supply Equipment`) is a specific charging unit within a location. A single location can
have multiple `EVSEs`.

#### Connector

A `Connector` is the actual socket or cable type exposed by an `EVSE`, such as `CCS`, `Type 2`, or `CHAdeMO`.

#### Token

A `Token` identifies the driver or contract used to access charging. It can represent an `RFID` card, app-based
identifier, or another contract credential.

#### Session

A `Session` is the active or completed charging event that tracks start time, end time, consumed energy, and related
status details.

#### CDR

A `CDR` (`Charge Detail Record`) is the finalized charging record used for billing, reimbursement, or settlement after
the session ends.

#### Tariff

A `Tariff` describes how charging is priced. It may include energy-based pricing, time-based pricing, parking fees,
reservation fees, or combinations of these.

#### Authorization

Authorization is the process of checking whether a token or user is allowed to start a charging session.

#### Smart charging

Smart charging refers to controlling charging behavior based on business rules, power limits, grid constraints, energy
optimization, or price optimization.

### Main participants

#### Charge Point Operator (`CPO`)

A `CPO` operates the physical charging infrastructure. This party usually manages stations, `EVSEs`, connectors,
availability, maintenance, and the backend that controls charging operations.

#### eMobility Service Provider (`eMSP`)

An `eMSP` is the company that has the customer relationship with the driver. It typically provides the mobile app,
customer contract, token, billing view, and access to roaming networks.

#### Roaming hub

A roaming hub acts as an intermediary that helps many `CPOs` and `eMSPs` connect at scale instead of building many
separate bilateral integrations.

#### Driver / EV user

The end user is the person or organization that actually consumes the charging service.

#### Fleet operator

In business charging scenarios, a fleet operator may manage many vehicles, contracts, charging policies, and internal
cost allocation.

### Roles in `OCPI`

The most important `OCPI` roles are:

* `CPO` (`Charge Point Operator`)
* `eMSP` (`eMobility Service Provider`)

These roles exchange data directly or through a hub.

#### `CPO` role responsibilities

Typical `CPO` responsibilities in `OCPI` include:

* publishing locations, `EVSEs`, and connector information,
* sharing live status and availability,
* accepting remote commands where supported,
* reporting charging sessions,
* providing `CDRs` for settlement,
* exposing tariff information where relevant.

#### `eMSP` role responsibilities

Typical `eMSP` responsibilities in `OCPI` include:

* managing customer contracts and driver tokens,
* requesting authorization for charging access,
* showing locations and pricing to drivers,
* receiving session and `CDR` information,
* handling customer billing and customer support.

### How `OCPI` is usually used together with other protocols

`OCPI` is often mentioned together with other charging standards, but each one has a different purpose:

* `OCPP` is typically charger-to-backend communication,
* `OCPI` is typically backend-to-backend interoperability and roaming,
* `ISO 15118` is related to vehicle-to-charger communication, including advanced charging features.

Because of this, a real-world charging platform may use several standards at once.

### Why it matters

Without a protocol such as `OCPI`, every charging operator and mobility provider would need custom integrations. With
`OCPI`, the ecosystem becomes easier to scale, drivers get broader access to charging networks, and companies can
exchange operational and commercial data more consistently.

## See also
