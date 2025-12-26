# DOAP

Open software project presentation as RDF data.

## Information

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

```xml

<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:doap="http://usefulinc.com/ns/doap#">

    <doap:Project>
        <doap:name>Example Project</doap:name>

        <!-- DEV env (installed software URL) -->
        <doap:release>
            <doap:Version>3.0.0-alpha</doap:Version>
            <doap:description>Development environment</doap:description>
            <doap:homepage rdf:resource="https://dev.example.com"/>
        </doap:release>

        <!-- TEST env -->
        <doap:release>
            <doap:Version>2.5.1-beta</doap:Version>
            <doap:description>Testing environment</doap:description>
            <doap:homepage rdf:resource="https://test.example.com"/>
        </doap:release>

        <!-- LIVE env -->
        <doap:release>
            <doap:Version>2.1.0</doap:Version>
            <doap:description>Production environment (live)</doap:description>
            <doap:homepage rdf:resource="https://www.example.com"/>
        </doap:release>

    </doap:Project>
</rdf:RDF>
```

## See also

* [DOAP Wikipedia](https://en.wikipedia.org/wiki/DOAP)
* https://github.com/ewilderj/doap/wiki
* https://github.com/ewilderj/doap/tree/master/examples
