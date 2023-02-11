# LibreOffice

## Usage, tips and tricks

### Remove remove all ruler tabs

Menu -> Format -> Paragraph... then -> Tabs

Delete all

### As service

```shell
"C:\Program Files\LibreOffice\program\soffice.exe" -accept="socket,host=0.0.0.0,port=8100;urp;StarOffice.ServiceManager" -headless -nodefault -nofirststartwizard -nolockcheck -nologo -norestore
```

```shell
libreoffice -env:UserInstallation=file:///tmp/conversion_file_name_#{timestamp} \
            --headless \
            --convert-to pdf \
            --outdir /tmp \
            /temp/input/dir/with/import_conversion_file.doc
```

## See also
