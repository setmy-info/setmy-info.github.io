# TSD

## Information

**TSD** (Tulu- ja sotsiaalmaksu deklaratsioon) is the Estonian monthly employer tax declaration submitted to the
Estonian Tax and Customs Board (EMTA). It reports income payments made to individuals and the associated taxes
withheld and paid by the employer.

Every employer or person who pays income to natural persons must submit TSD by the **10th calendar day of the month
following the payment month** (e.g., payments made in January must be reported by February 10th).

### TSD form structure

The TSD declaration consists of a main form and several annexes (INF sheets):

| Annex  | Content                                                                       |
|--------|-------------------------------------------------------------------------------|
| INF 1  | Wages, salaries, and other employment income; income tax and social tax       |
| INF 2  | Fringe benefits (erisoodustused) and associated taxes                         |
| INF 3  | Payments to non-residents                                                     |
| INF 4  | Dividends paid to residents                                                   |
| INF 5  | Other income paid to residents (e.g., service fees, rent)                     |
| INF 6  | Payments under contracts for services (võlaõiguslik leping)                   |

### Taxes reported in TSD

* **Income tax (tulumaks)** — withheld from employee wages at the applicable rate.
* **Social tax (sotsiaalmaks)** — paid by the employer on gross wages at 33%.
* **Unemployment insurance premium (töötuskindlustusmakse)** — employee share (1.6%) and employer share (0.8%).
* **Funded pension (kohustuslik kogumispension)** — employee contribution (2% or 4%) where applicable.

## Usage, tips and tricks

### Submission via e-MTA

The standard submission channel is the e-MTA self-service portal:

1. Log in at [e-MTA](https://www.emta.ee/eraklient/amet-registreerimine-ja-tegutsemise-alustamine/e-mta-teenused)
   using ID card, Mobile-ID, or Smart-ID.
2. Navigate to: Declarations → TSD.
3. Fill in the relevant INF annexes or upload an XML file.
4. Submit and save the confirmation.

### XML automated submission

For payroll systems and accounting software, TSD can be submitted as an XML file conforming to the EMTA schema.
The XML schema and documentation are published by EMTA and versioned annually.

Typical workflow:

```
1. Generate TSD XML from the payroll or accounting system.
2. Validate against the current EMTA XSD schema.
3. Upload via e-MTA file import or EMTA API (X-Road).
```

### Deadlines

* Monthly declaration: **10th of the following month**.
* If the 10th falls on a weekend or public holiday, the deadline moves to the next working day.
* Late submission results in interest on unpaid tax (0.06% per day).

## See also

* [EMTA — TSD guide (Estonian)](https://www.emta.ee/ariklient/tulu-kulu-kaive-kasum/tululiigid-maksustamine/palgast-kinnipeetav-maks/tsd-deklaratsioon)
* [e-MTA self-service portal](https://www.emta.ee/)
* [Accounting](accounting.md)
