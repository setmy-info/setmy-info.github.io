# XBRL

Extensible Business Reporting Language

## Information

XBRL is an XML-based open standard for the electronic exchange of business and financial data. It is maintained by
XBRL International and adopted by regulators, stock exchanges, and government agencies worldwide to standardize
financial reporting.

Key concepts:

* **Taxonomy** — defines the elements (concepts) used in a report and their relationships: labels, calculations,
  presentation hierarchy, and references to authoritative standards.
* **Instance document** — an XML file containing the actual report data, referencing the taxonomy to identify what
  each value means.
* **Linkbases** — supplementary files bundled with a taxonomy that define labels (human-readable names), calculation
  rules, presentation order, and references to external standards.
* **iXBRL (Inline XBRL)** — XBRL data embedded directly inside an HTML document, making reports both human-readable
  and machine-readable from the same file.

### Estonian XBRL

In Estonia, XBRL is used for submitting annual reports to the Business Registry (Äriregister). Key details:

* The taxonomy is based on Estonian GAAP (ET-GAAP).
* Reports are submitted via the e-äriregister portal as XML or ZIP packages.
* The Estonian Statistics Board (Statistikaamet) also accepts XBRL-format data.
* Annual updates to the ET-GAAP taxonomy are published at [xbrl.eesti.ee](https://xbrl.eesti.ee/).

## Configuration

XBRL instance documents reference the taxonomy namespace in the root element:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xbrl xmlns="http://www.xbrl.org/2003/instance"
      xmlns:et-gaap="http://xbrl.eesti.ee/gaap/2022-01-01"
      xmlns:xbrli="http://www.xbrl.org/2003/instance">
    <context id="ctx1">
        <entity><identifier scheme="http://www.rik.ee">12345678</identifier></entity>
        <period><instant>2022-12-31</instant></period>
    </context>
    <et-gaap:Assets contextRef="ctx1" decimals="0" unitRef="EUR">1000000</et-gaap:Assets>
</xbrl>
```

## Usage, tips and tricks

* Use the official ET-GAAP taxonomy ZIP and the accompanying XLSX taxonomy overview when building an Estonian annual
  report submission tool.
* Validate instance documents against the taxonomy before submission using an XBRL validator tool.
* For automated batch submissions, generate instance documents programmatically and package them as ZIP for upload.
* iXBRL is increasingly preferred for regulatory submissions because it satisfies both human review and automated
  data extraction in one file.

## See also

* [XBRL Estonia](https://xbrl.eesti.ee/)
* [ET XBRL GAAP ZIP](http://xbrl.eesti.ee/wp-content/uploads/2021/12/et-gaap_2022.zip)
* [ET Taxonomy XLSX](http://xbrl.eesti.ee/wp-content/uploads/2023/03/Taksonoomia-2022-01-01.xlsx)
* [Riigiteataja act](https://www.riigiteataja.ee/akt/123122021026?leiaKehtiv)
* [Muudatused 2022](http://xbrl.eesti.ee/wp-content/uploads/2021/12/muudatused-2022.txt)
* [XBRL Estonia project background](https://xbrl.eesti.ee/projekti-taust/)
* [XBRL 2.1 specification](http://www.xbrl.org/Specification/XBRL-RECOMMENDATION-2003-12-31+Corrected-Errata-2008-07-02.htm)
* [XBRL Dimensions 1.0](http://www.xbrl.org/Specification/XDT-REC-2006-09-18+Corrected-Errata-2009-09-07.htm)
* [xbrl.org](https://www.xbrl.org/)
* [XBRL GL](http://www.xbrl.org/int/gl/2015-03-25/gl-framework-REC-2015-03-25.html)
* [Stat XBRL developers](https://www.stat.ee/en/statistikaamet/developers)
