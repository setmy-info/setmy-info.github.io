# Direct Payment

## Information

`Direct Payment` in the `EV` charging context refers to payment flows where a driver can pay for charging directly at
or around the charging service without first needing a long-term roaming contract or a dedicated `eMSP` relationship.

In practice, direct payment matters when:

* an ad-hoc user wants to start charging immediately,
* regulation requires easy public access to charging without subscription lock-in,
* operators need a consistent customer experience for guests, tourists, or occasional drivers,
* payment must work alongside, but independently from, classic roaming scenarios.

`Direct Payment` is related to the broader `EV` charging interoperability landscape, but it solves a different problem
from `OCPI` roaming itself. `OCPI` focuses mainly on backend-to-backend interoperability between market participants,
while direct payment focuses on how an end user can pay directly for a charging session.

### What `Direct Payment` is mostly about

At a high level, a direct payment specification or profile usually covers topics such as:

* how a user discovers pricing and payment terms,
* how a charging session can be started without a roaming contract,
* how payment can be initiated through card, web, app, QR, or other user-facing methods,
* how the charging operator presents session, tariff, and receipt information,
* how user experience and compliance requirements are aligned across operators.

### Typical use cases

* public charging for occasional drivers,
* guest charging where the user has no roaming agreement,
* tourist or cross-border charging where a local app is not practical,
* regulatory compliance for public `EV` charging accessibility,
* fallback payment when roaming is unavailable or not preferred.

### How it relates to `OCPI`

`Direct Payment` and `OCPI` are complementary:

* `OCPI` is mostly about interoperability, roaming, locations, tokens, sessions, and settlement between market
  participants,
* `Direct Payment` is mostly about the end-user payment path for ad-hoc or contract-free charging access.

In a real charging platform, both can coexist. One user may charge through an `eMSP` roaming agreement, while another
user at the same site may use direct payment for immediate access.

### Practical notes

* Clear tariff presentation is critical before charging starts.
* The direct payment flow should be simple on mobile devices and easy to discover on site.
* Operators often need to consider local regulation, receipt requirements, and supported payment instruments.
* Direct payment should not be confused with the lower-level charger-to-backend communication protocols used to control
  the station itself.

## See also

* [Direct Payment 2.2.1 EV Roaming Foundation version (PDF)](https://evroaming.org/wp-content/uploads/2024/10/DirectPayment_2_2_1___EVRF_version.pdf)
* [OCPI (Open Charge Point Interface)](ocpi.md)