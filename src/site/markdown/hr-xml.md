# HR-XML, HR-JSON

## Information

HR-XML and HR-JSON are industry-standard schema formats for exchanging human resources data between software
systems. Common use cases include job postings, candidate applications, employee records, payroll, time and
attendance, and compensation data.

* **HR-XML**: The earlier XML-based standard developed by the HR-XML Consortium (now merged into HR Open Standards).
  Used in legacy ATS (Applicant Tracking Systems) and HRIS (Human Resources Information Systems).
* **HR-JSON / HR Open Standards**: The modern JSON-based evolution. Maintained by
  [HR Open Standards](https://www.hropenstandards.org/). Provides schemas for talent acquisition, workforce
  management, and payroll data exchange.

These standards are used by integrations between job boards, payroll providers, HR platforms, and enterprise ERP
systems.

## Usage, tips and tricks

### Coding tips and tricks

#### Example hr-xml

Need to verify by standards.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<employeeInformation>
  <personalDetails>
    <firstName>John</firstName>
    <lastName>Doe</lastName>
    <dateOfBirth>1975-12-31</dateOfBirth>
    <gender>Male</gender>
    <nationality>Estonian</nationality>
  </personalDetails>
  <employmentDetails>
    <employeeID>12345</employeeID>
    <jobTitle>Software Developer</jobTitle>
    <department>Software development</department>
    <startDate>2023-01-01</startDate>
    <salary>1000000</salary>
  </employmentDetails>
  <contactDetails>
    <email>john.doe@example.com</email>
    <phone>+372 6316331</phone>
    <address>
      <street>Lossi plats 1a</street>
      <city>Tallinn</city>
      <state>Harjumaa</state>
      <zipCode>15165</zipCode>
      <country>Estonia</country>
    </address>
  </contactDetails>
</employeeInformation>
```

## See also

* [HR Open Standards](https://www.hropenstandards.org)
* [HR Open Standards GitHub](https://github.com/hr-open-standards)
