# GPS and Linux

## Information

## Installation

### CentOS, Rocky Linux

```shell
sudo dnf install -y gpsd gpsd-clients
sudo systemctl enable gpsd
sudo systemctl start gpsd

# See data
cgps
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## GPSD data with Python

Not tested:

```python
import gpsd

gpsd.connect()

packet = gpsd.get_current()

if packet.mode >= 2:  # Have a signal
    print("Latitude:  {0:.6f}".format(packet.lat))
    print("Longitude: {0:.6f}".format(packet.lon))
else:
    print("No GPS signal.")

gpsd.disconnect()
```

Not tested:

```c++
#include <stdio.h>
#include <gps.h>

int main() {
    struct gps_data_t gps_data;
    if (gps_open("localhost", "2947", &gps_data) == -1) {
        printf("gps_open failed\n");
        return 1;
    }

    gps_stream(&gps_data, WATCH_ENABLE | WATCH_JSON, NULL);

    while (1) {
        if (gps_waiting(&gps_data, 5000000)) {
            if (gps_read(&gps_data) == -1) {
                printf("gps_read failed\n");
            } else {
                if (gps_data.status == STATUS_FIX) {
                    printf("Latitude: %lf, Longitude: %lf\n", gps_data.fix.latitude, gps_data.fix.longitude);
                } else {
                    printf("GPS signal not available\n");
                }
            }
        }
    }

    gps_stream(&gps_data, WATCH_DISABLE, NULL);
    gps_close(&gps_data);

    return 0;
}
```

## See also

[xxxx](http://yyyyy)
