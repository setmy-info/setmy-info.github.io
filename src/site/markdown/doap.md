# DOAP

Open software project presentation as RDF data.

## Information

DOAP (Description of a Project) is an RDF/XML vocabulary for describing open source software projects. It was
originally created by Edd Dumbill and is widely used by the Apache Software Foundation and other open source
communities to express project metadata in a machine-readable format.

DOAP describes projects with properties such as name, homepage, repository location, license, release versions,
developers, and programming languages. The namespace URI is `http://usefulinc.com/ns/doap#`.

## Configuration

Key DOAP properties:

| Property           | Purpose                                        |
|--------------------|------------------------------------------------|
| `doap:name`        | Project name                                   |
| `doap:homepage`    | Project homepage URL                           |
| `doap:description` | Short description of the project               |
| `doap:release`     | A specific release version                     |
| `doap:Version`     | Version string within a release                |
| `doap:developer`   | Developer (foaf:Person) contributing to project|
| `doap:license`     | License URI (e.g. Apache 2.0, MIT)             |
| `doap:repository`  | Source repository reference                    |
| `doap:programming-language` | Implementation language              |

## Usage, tips and tricks

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
* [DOAP namespace — usefulinc.com/ns/doap](http://usefulinc.com/ns/doap)
* [DOAP GitHub repository and examples](https://github.com/ewilderj/doap/tree/master/examples)
* [Apache DOAP usage](https://projects.apache.org/doap.html)
