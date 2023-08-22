# XSLT

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

XML file

```xml
<?xml version="1.0" encoding="UTF-8"?>

<curriculumVitae>
    <name>John Doe</name>
</curriculumVitae>
```

XSL file

```xml
<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/curriculumVitae">

        <h1>Curriculum Vitae</h1>
        <h2>Name:
            <xsl:value-of select="name"/>
        </h2>
    </xsl:template>

</xsl:stylesheet>
```

HTML to make XSLT (in past browser were by default also capable to do transform).

```html
<!DOCTYPE html>
<html>
<head>
    <title>XSLT Transformation Example</title>
</head>
<body>
<input type="file" id="xslFile" accept=".xsl">XSL</input>
<br>
<input type="file" id="xmlFile" accept=".xml">XML</input>
<br>
<button onclick="loadXSL()">Load XSL</button>
<button onclick="transformXML()">Transform XML</button>

<div id="output"></div>

<script type="text/javascript">
    var xsltProcessor, xmlDOM;

    function loadXSL() {
        var xslInput = document.getElementById('xslFile').files[0],
                reader = new FileReader();

        if (!xslInput) {
            alert('Choose XSL-file!');
            return;
        }

        reader.onload = function (e) {
            var xslString = e.target.result,
                    xsltParser = new DOMParser(),
                    xslDOM = xsltParser.parseFromString(xslString, 'text/xml');
            xsltProcessor = new XSLTProcessor();
            xsltProcessor.importStylesheet(xslDOM);
        };

        reader.readAsText(xslInput);
    }

    function transformXML() {
        var xmlInput = document.getElementById('xmlFile').files[0],
                reader = new FileReader();
        if (!xmlInput) {
            alert('Choose XML-fail!');
            return;
        }

        reader.onload = function (e) {
            var xmlString = e.target.result, parser = new DOMParser();
            xmlDOM = parser.parseFromString(xmlString, 'text/xml');

            if (xsltProcessor) {
                applyTransformation();
            } else {
                alert('XSLT is not loaded yet. Load XSL before XSLT.');
            }
        };
        reader.readAsText(xmlInput);
    }

    function applyTransformation() {
        var resultDocument = xsltProcessor.transformToDocument(xmlDOM),
                resultSerializer = new XMLSerializer(),
                transformedXML = resultSerializer.serializeToString(resultDocument),
                outputElement = document.getElementById('output');
        outputElement.innerHTML = transformedXML;
    }
</script>
</body>
</html>
```

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
