# ESTEID LDAP

## Information

The Estonian ID-card LDAP service was a public directory operated by SK ID Solutions (now part of SK ID Solutions AS).
It provided access to Estonian ID-card holder certificates and identity data (personal code, given name, surname)
via LDAP queries.

**The service at `esteid.ldap.sk.ee` has been permanently closed.** See the Closing LDAP link in See also for details.

Alternatives:

- **X-Road** — Estonia's data exchange layer; identity data can be queried via X-Road services.
- **AKI (Riigi Infosüsteemi Amet)** — Estonian Information System Authority; certificate validation is done via
  OCSP (Online Certificate Status Protocol) at `ocsp.sk.ee`.
- **MID-REST / Smart-ID REST API** — for mobile-ID and Smart-ID based authentication.

## Usage, tips and tricks

Historical reference — querying the now-closed LDAP service:

```shell
ldapsearch -H ldaps://esteid.ldap.sk.ee/ -x -b "c=EE" "(serialNumber=PNOEE-38001085718)"
```

## See also

* [SK ID Solutions LDAP documentation](https://www.skidsolutions.eu/resources/ldap/)
* [Closing LDAP — sk.ee LDAP catalogue closure announcement](https://www.id.ee/artikkel/ldap-sk-ee-andmekataloogi-sulgemine/)
* [Estonian ID-card software internal URLs](https://www.id.ee/artikkel/loetelu-urlidest-kuhu-id-kaardi-baastarkvara-sisemiselt-poordub/)
* [X-Road](https://x-road.global/)
