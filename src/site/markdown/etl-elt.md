# ETL and ELT

* ETL - Extract → Transform → Load
* ELT - Extract → Load → Transform

## Information

| Aspect               | **ETL**                                                                   | **ELT**                                                                                                        |
|----------------------|---------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
| **Processing order** | Data is **transformed** before being **loaded** into the data warehouse   | Data is **loaded first** into the warehouse and **transformed later**                                          |
| **Data storage**     | Only **transformed data** is stored, so some original details may be lost | **Raw (initial, original, as-is)** data is also stored, allowing **transformed views** to be generated anytime |
| **Flexibility**      | Less flexible – changes require re-running the entire pipeline            | Highly flexible – raw data can always be reprocessed in new ways                                               |
| **Typical use case** | Traditional BI, dashboards, static reporting                              | Machine Learning (ML), AI, Data Science, and analytical experimentation                                        |

## See also

* [ETL](https://en.wikipedia.org/wiki/Extract,_transform,_load)
* [ELT](https://en.wikipedia.org/wiki/Extract,_load,_transform)
* [Data warehouse](https://en.wikipedia.org/wiki/Data_warehouse)
* [Data lake](https://en.wikipedia.org/wiki/Data_lake)




