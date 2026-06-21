# LibreOffice

## Information

LibreOffice is a free, open-source office productivity suite maintained by The Document Foundation. It includes:

* **Writer** — word processor (compatible with .docx)
* **Calc** — spreadsheet (compatible with .xlsx)
* **Impress** — presentation tool (compatible with .pptx)
* **Draw** — vector graphics and diagrams
* **Base** — database front-end
* **Math** — formula editor

LibreOffice supports headless mode for server-side batch document conversion (e.g. .doc to PDF), which makes it
useful as a backend service in document processing pipelines.

## Installation

### CentOS, Rocky Linux

```shell
sudo dnf install libreoffice -y
```

### Fedora

```shell
sudo dnf install libreoffice -y
```

### Debian, Ubuntu

```shell
sudo apt install libreoffice -y
```

### Windows

Download the installer from [libreoffice.org](https://www.libreoffice.org/download/).

## Usage, tips and tricks

### Remove all ruler tabs

Menu -> Format -> Paragraph... then -> Tabs

Delete all

### As a background service (Windows)

```shell
"C:\Program Files\LibreOffice\program\soffice.exe" -accept="socket,host=0.0.0.0,port=8100;urp;StarOffice.ServiceManager" -headless -nodefault -nofirststartwizard -nolockcheck -nologo -norestore
```

### Headless document conversion

Convert a document to PDF using LibreOffice headlessly:

```shell
libreoffice -env:UserInstallation=file:///tmp/conversion_file_name_#{timestamp} \
            --headless \
            --convert-to pdf \
            --outdir /tmp \
            /temp/input/dir/with/import_conversion_file.doc
```

```shell
soffice --headless --convert-to pdf --outdir /tmp/ "$template_file"
soffice --headless --norestore --nolockcheck --invisible --nodefault --view /tmp/"$template_file" &
unoconv --server=localhost --port=2002 --format=pdf --output=/tmp/ "$input_data"
soffice --headless --convert-to pdf --outdir /tmp/ /tmp/"$template_file"
mv /tmp/"$template_file" "$output_file"
rm /tmp/"$template_file"
```

## See also

* [LibreOffice official site](https://www.libreoffice.org/)
* [LibreOffice documentation](https://documentation.libreoffice.org/)
* [unoconv](https://github.com/unoconv/unoconv)
