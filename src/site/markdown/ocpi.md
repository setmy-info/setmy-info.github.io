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

### `OCPI` protocol versions

When people refer to the `OCPI` protocol, they may mean one of several released versions of the specification.
In practice, version alignment matters because connected parties must support compatible endpoints, fields, and
module behavior.

Commonly referenced versions include:

* `OCPI 2.1.1`, which became widely used in production roaming integrations,
* `OCPI 2.2.1`, which is one of the most common versions in current real-world deployments,
* `OCPI 2.3.0`, which extends the model further and is represented by the specification linked below.

Different deployments may adopt versions at different speeds, so integration projects usually need to confirm the
exact protocol version and supported modules on both sides.

### Main `OCPI` modules

`OCPI` is organized into modules. A deployment does not always start with every module at once, but the module model
helps define which functional areas a party exposes or consumes.

Important `OCPI` modules commonly discussed in implementations include:

* `Credentials`: used to establish and manage trust and connection details between parties,
* `Locations`: publishes locations, `EVSEs`, connectors, facilities, and operational metadata,
* `Tariffs`: shares pricing definitions used for charging sessions,
* `Sessions`: exchanges active and completed charging session information,
* `CDRs`: communicates finalized charge detail records for billing and settlement,
* `Tokens`: supports identifier and authorization-related token exchange,
* `Commands`: supports actions such as remote start, remote stop, unlock, or reservation-related commands,
* `Charging Profiles`: supports smart charging and power profile coordination,
* `Hub Client Info`: used in hub-based topologies to exchange information about connected parties.

Depending on the business role, a `CPO`, `eMSP`, or roaming hub may implement different subsets of these modules.
For example, `Locations`, `Sessions`, and `CDRs` are especially important on the operator side, while `Tokens` and
customer-facing consumption of location and tariff data are especially relevant on the mobility provider side.

### Why it matters

Without a protocol such as `OCPI`, every charging operator and mobility provider would need custom integrations. With
`OCPI`, the ecosystem becomes easier to scale, drivers get broader access to charging networks, and companies can
exchange operational and commercial data more consistently.

## See also

* [OCPI 2.3.0 specification (PDF)](https://evroaming.org/wp-content/uploads/2025/02/OCPI-2.3.0.pdf)
* [EV Roaming Foundation](https://evroaming.org/)
* [OCPI Protocol](https://ocpi-protocol.com/)
* [Open Charge Alliance](https://openchargealliance.org/)
* [Powerfill](https://powerfill.io/)
* [SteVe on GitHub](https://github.com/steve-community/steve)
* [Open Charge Point Protocol (`OCPP`) on Wikipedia](https://en.wikipedia.org/wiki/Open_Charge_Point_Protocol)
* [Direct Payment](directpayment.md)
* [Direct Payment 2.2.1 EV Roaming Foundation version (PDF)](https://evroaming.org/wp-content/uploads/2024/10/DirectPayment_2_2_1___EVRF_version.pdf)
