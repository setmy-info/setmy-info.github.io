# ESP32 Development Board

## Information

### Introduction

The `ESP32` is a series of low-cost, low-power system on a chip (SoC) microcontrollers with integrated Wi-Fi and
dual-mode Bluetooth. It was developed by Espressif Systems and is a successor to the popular ESP8266.

The **ESP32 Development Board (CH340C Type C version)** is a specific variant that features:

* **ESP32-WROOM-32 Module**: The core module containing the dual-core processor and wireless capabilities.
* **CH340C USB-to-UART Bridge**: A chip that allows the computer to communicate with the ESP32 via USB. It is known for
  being reliable and having good driver support.
* **USB Type-C Connector**: Modern connector for power and programming, offering better durability and convenience
  compared to Micro-USB.

### Developer Setup

To start developing with the ESP32, follow these steps:

1. **Install USB Drivers**:
    * Download and install the **CH340** drivers for your operating system (Windows, macOS, or Linux).
    * Once installed, connecting the board via USB Type-C should create a new COM/Serial port.

2. **Install Development Environment**:
    * **Arduino IDE**: A popular choice for beginners. You must add the ESP32 board URL to the "Additional Board Manager
      URLs" in Preferences
      (`https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json`).
    * **PlatformIO**: A professional-grade extension for VS Code, ideal for larger projects.
    * **ESP-IDF**: The official IoT Development Framework by Espressif for advanced users.

3. **Select Board**:
    * In Arduino IDE, select `ESP32 Dev Module` or `DOIT ESP32 DEVKIT V1`.

### GC9A01 Display (7 Pin Version)

The **1.28" GC9A01 display** is a vibrant, round TFT LCD display module that is commonly paired with ESP32 and Arduino
projects for creating modern wearable or smart-home interfaces.

* **Specifications**:
    * **Size**: 1.28 Inch.
    * **Resolution**: 240x240 RGB.
    * **Driver IC**: GC9A01.
    * **Interface**: 4-Wire SPI.
    * **Form Factor**: Round PCB.
    * **Voltage**: 3.3V.

* **Pinout (7-Pin Version)**:
    1. **RES**: Reset.
    2. **CS**: Chip Select.
    3. **DC**: Data/Command.
    4. **SDA**: SPI Data (MOSI).
    5. **SCL**: SPI Clock (SCK).
    6. **GND**: Ground.
    7. **VCC**: Power (3.3V).

* **Recommended Libraries**:
    * `TFT_eSPI` (highly optimized for ESP32).
    * `Adafruit_GC9A01` (easy to use with Adafruit GFX).
    * `GFX Library for Arduino`.

## See also

* [Espressif Systems Official Website](https://www.espressif.com/)
* [ESP32 Documentation](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/)
* [CH340 Drivers (WCH)](https://www.wch-ic.com/downloads/CH341SER_EXE.html)
* [Micro Radar Round TFT Firmware Installer](https://lazydayscr.github.io/Micro-Radar-Round-TFT/)
* [Micro Radar Web Flasher](https://abidcg.blogspot.com/2026/07/micro-radar-web-flasher.html)
* [Adafruit 2.1" 480x480 Round RGB 666 TTL TFT Display](https://www.adafruit.com/product/5792)
* [ESP32 Development Board on AliExpress](https://www.aliexpress.com/item/1005010338533904.html)
* [1.28" Round TFT LCD on AliExpress](https://www.aliexpress.com/item/1005009957895831.html)
* [ESP32 Development Board Variant on AliExpress](https://www.aliexpress.com/item/1005008419095315.html)
* [ESP32 and Display Resources (Google Drive)](https://drive.google.com/drive/folders/13o45ZE3316V03Wc51TUJ4WUMsWZllBVz)
* [Arduino](arduino.md)
* [Raspberry Pi](rasberry-pi.md)

