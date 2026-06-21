# Spatial Data and GIS

## Information

**Spatial data** is any data that has a geographic or location component — coordinates, geometries, or references to
places on Earth. **GIS (Geographic Information Systems)** is the field of software and methods for capturing, storing,
analysing, and visualising spatial data.

### Geometry Types

| Type       | Description                           | Example                    |
|------------|---------------------------------------|----------------------------|
| Point      | Single coordinate pair                | GPS fix, address           |
| LineString | Ordered sequence of points            | Road, river                |
| Polygon    | Closed ring of points (area)          | Building footprint, region |
| MultiXxx   | Collection of same geometry type      | Archipelago, multi-lane    |
| Raster     | Grid of cells with values             | Elevation model, satellite |

### Coordinate Reference Systems (CRS)

* **WGS84** (EPSG:4326) — global geographic CRS used by GPS; coordinates in decimal degrees (latitude, longitude).
* **ETRS89** — European Terrestrial Reference System; recommended for EU spatial data (INSPIRE).
* **UTM zones** — projected (metric) CRS useful for area/distance calculations; specific zone depends on location.
* **Estonian national grid** — L-EST97 (EPSG:3301); used in Estonian official datasets.

CRS conversions are done with GDAL/OGR (`ogr2ogr`), PROJ library, or PostGIS (`ST_Transform`).

### Common File Formats

| Format      | Type     | Notes                                              |
|-------------|----------|----------------------------------------------------|
| Shapefile   | Vector   | De-facto legacy standard; multiple files (.shp, .dbf, .shx, .prj) |
| GeoJSON     | Vector   | JSON-based; easy for web and APIs                  |
| GeoPackage  | Vector   | SQLite-based; modern single-file alternative to Shapefile |
| KML/KMZ     | Vector   | Google Earth format                                |
| GeoTIFF     | Raster   | TIFF with embedded CRS metadata                    |
| WKT / WKB   | Vector   | Well-Known Text / Binary; used in databases and APIs |

### OGC Web Service Standards

* **WMS** (Web Map Service) — returns pre-rendered map images.
* **WFS** (Web Feature Service) — returns vector feature data (GeoJSON, GML).
* **WCS** (Web Coverage Service) — returns raster coverage data.
* **WMTS** (Web Map Tile Service) — returns pre-rendered tiles (faster than WMS for display).
* **OGC API Features** — modern RESTful replacement for WFS.

## Installation

### QGIS (Desktop GIS)

```shell
# Rocky Linux / Fedora
sudo dnf install qgis qgis-python

# Debian / Ubuntu
sudo apt install qgis python3-qgis

# Windows / macOS
# Download installer from https://qgis.org/download/
```

### GDAL / OGR (Command-line tools)

```shell
# Rocky Linux / Fedora
sudo dnf install gdal gdal-tools

# Debian / Ubuntu
sudo apt install gdal-bin python3-gdal

# macOS
brew install gdal
```

### PostGIS (Spatial extension for PostgreSQL)

```shell
# Rocky Linux / Fedora
sudo dnf install postgis34_16

# Debian / Ubuntu
sudo apt install postgresql-16-postgis-3

# Enable in a database
psql -U postgres -d mydb -c "CREATE EXTENSION postgis;"
```

## Configuration

### PostGIS key functions

```sql
-- Check PostGIS version
SELECT PostGIS_Version();

-- Create a geometry column
ALTER TABLE places ADD COLUMN geom geometry(Point, 4326);

-- Insert a point (WGS84)
INSERT INTO places (name, geom) VALUES ('Tallinn', ST_GeomFromText('POINT(24.7536 59.4370)', 4326));

-- Spatial query: find places within 10 km
SELECT name FROM places
WHERE ST_DWithin(geom::geography, ST_MakePoint(24.7536, 59.4370)::geography, 10000);
```

### GDAL / OGR format conversion

```shell
# Shapefile to GeoJSON
ogr2ogr -f GeoJSON output.geojson input.shp

# Reproject from ETRS89 to WGS84
ogr2ogr -t_srs EPSG:4326 -s_srs EPSG:3301 output.geojson input.shp

# GeoTIFF info
gdalinfo dem.tif
```

## Usage, tips and tricks

* Always store and exchange data in a documented CRS; default to WGS84 (EPSG:4326) for web APIs and GeoJSON.
* Use **GeoPackage** instead of Shapefile for new projects — single file, supports longer field names, UTF-8.
* For metric calculations (area, distance) in Europe, reproject to a local projected CRS (e.g. ETRS89-TM35FIN or L-EST97).
* Use **PostGIS** `geography` type (not `geometry`) when working with global datasets to get accurate geodesic
  distance/area calculations without manual projection.
* GeoServer is the standard open-source OGC service server; use it to publish WMS/WFS from PostGIS or file sources.

## See also

* [QGIS](https://qgis.org/)
* [PostGIS](https://postgis.net/)
* [GDAL](https://gdal.org/)
* [GeoServer](https://geoserver.org/)
* [OGC standards](https://www.ogc.org/standards/)
* [EPSG registry](https://epsg.io/)
* [Estonian Geoportal](https://geoportaal.maaamet.ee/)
* [PostgreSQL](postgresql.md)
