# GIS

## Information

Geographic Information Systems (GIS) are software frameworks for capturing, storing, analyzing, and displaying
geographically referenced data. GIS data has a location component tied to a coordinate reference system (CRS)
and is used in mapping, spatial analysis, urban planning, logistics, and environmental science.

Key concepts:

- **Vector data**: Discrete geometry objects — Point, LineString, Polygon, MultiPolygon. Stored as coordinates.
- **Raster data**: Grid of cells (pixels) each holding a value (elevation, temperature, land cover).
- **CRS (Coordinate Reference System)**: Defines how coordinates map to real-world locations.
  - WGS84 / EPSG:4326 — geodetic (lat/lon degrees), used by GPS.
  - Web Mercator / EPSG:3857 — projected (meters), used by web tile maps (OpenStreetMap, Google Maps).
- **Geometry types**: Point, LineString, Polygon, GeometryCollection (OGC standard).
- **WKT / WKB**: Well-Known Text / Binary — standard formats for geometry serialization.
- **GeoJSON**: JSON encoding for geographic features widely used in web mapping.

## Installation

### OpenLayers (JavaScript mapping library)

```shell
npm install ol
```

### QGIS (desktop GIS application)

```shell
# Rocky Linux / Fedora
sudo dnf install qgis

# Debian / Ubuntu
sudo apt install qgis
```

### PostGIS (spatial extension for PostgreSQL)

```sql
CREATE EXTENSION postgis;
SELECT PostGIS_Version();
```

## Configuration

OpenLayers integrates with Vite or webpack with no extra configuration beyond installing the package. Import
modules directly from `ol/`:

```javascript
import Map from 'ol/Map.js';
import View from 'ol/View.js';
```

## Usage, tips and tricks

### Coding tips and tricks

#### OpenLayers

Create a map centered on Tallinn with an OpenStreetMap tile layer:

```javascript
import Map from 'ol/Map.js';
import View from 'ol/View.js';
import TileLayer from 'ol/layer/Tile.js';
import OSM from 'ol/source/OSM.js';
import { fromLonLat } from 'ol/proj.js';

const map = new Map({
    target: 'map',
    layers: [
        new TileLayer({ source: new OSM() }),
    ],
    view: new View({
        center: fromLonLat([24.7536, 59.4370]),
        zoom: 12,
    }),
});
```

Add a vector point feature:

```javascript
import VectorLayer from 'ol/layer/Vector.js';
import VectorSource from 'ol/source/Vector.js';
import Feature from 'ol/Feature.js';
import Point from 'ol/geom/Point.js';
import { fromLonLat } from 'ol/proj.js';

const marker = new Feature({
    geometry: new Point(fromLonLat([24.7536, 59.4370])),
    name: 'Tallinn',
});

map.addLayer(new VectorLayer({
    source: new VectorSource({ features: [marker] }),
}));
```

Coordinate conversion between EPSG:4326 (lat/lon) and EPSG:3857 (Web Mercator):

```javascript
import { fromLonLat, toLonLat } from 'ol/proj.js';

const webMercator = fromLonLat([24.7536, 59.4370]);
const lonLat = toLonLat(webMercator);
```

## See also

* CesiumJS
* Tangram
* MapLibre GL JS
* Mapbox GL JS

* [Wellknown](https://github.com/mapbox/wellknown)
* [OpenLayers](https://openlayers.org/)
* [OpenLayers Git](https://github.com/openlayers/openlayers)
* [OpenLayers Quick Start](https://openlayers.org/doc/quickstart.html)
* [QGIS](https://qgis.org/)
* [PostGIS](https://postgis.net/)
* [GeoJSON specification](https://geojson.org/)
* [EPSG registry](https://epsg.io/)
* [spatial.md](spatial.md)
