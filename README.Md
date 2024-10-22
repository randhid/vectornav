# [`<INSERT MODULE NAME>` module](<INSERT LINK TO MODULE REPO>)

This [module](https://docs.viam.com/registry/modular-resources/) implements the [`rdk:components:movement_sensor` API](https://docs.viam.com/components/movement-sensor/) in an <rand:vectornav:vn100-spi> model.
With this model, you can integreate an IMU manufactured by [VectorNav](https://www.vectornav.com/products) that support SPI connection.


## Requirements

This module has been tested with a spi-connected [VN-100 SMD](https://www.vectornav.com/products/detail/vn-100) unit. You will have to soder the MOSI, MISO and SCLK pads on the unit to connect it to a single board computer.

This module is only avaialble for linux platforms that have a spi bus avaialble for external connections.


## Configure your <rand:vectornav:vn100-spi> <rdk:components:movement_sensor>

Navigate to the [**CONFIGURE** tab](https://docs.viam.com/configure/) of your [machine](https://docs.viam.com/fleet/machines/) in [the Viam app](https://app.viam.com/).
[Add <rdk:components:movement_sensor / rand:vectornav:vn100-spi> to your machine](https://docs.viam.com/configure/#components).

On the new component panel, copy and paste the following attribute template into your <Irand:vectornav:vn100-spi>’s attributes field:

```json
  "components": [
    {
      "name": "movement_sensor-1",
      "namespace": "rdk",
      "type": "movement_sensor",
      "model": "imu-vectornav",
      "attributes": {
        "chip_select_pin": "0",
        "polling_freq_hz": 200,
        "spi_baud_rate": 115200,
        "spi_bus": "0"
      }
    }
  ],
  "modules": [
    {
      "type": "registry",
      "name": "rand_vectornav",
      "module_id": "rand:vectornav",
      "version": "0.0.1"
    }
  ]
```

### Attributes

The following attributes are available for `<rand:vectornav:vn100-spi>` <rdk:components:movement_sensor>s:

| Name | Type | Required? | Description |
| ---- | ---- | --------- | ----------- |
| `board` | string | **Required** | The `name` of the [board](/components/board/) to which the device is wired. |
| `spi_bus` | string | **Required** | The index of the SPI bus over which the device communicates with the board. |
| `chip_select_pin` | string | **Required** | The ({{< glossary_tooltip term_id="pin-number" text="pin number" >}}) of the pin on the board (other than the SPI bus pins) connected to the IMU chip. Used to tell the chip whether the current SPI message is meant for it or for another device. |
| `spi_baud_rate` | int | **Optional** | The rate at which data is sent from the IMU. <br> Default: `9600` |
| `polling_frequency_hz` | int | **Optional** | How many times per second the sensor is polled. <br> Default: `200` |

## Troubleshooting

If you are not seeing readings with a configured baud rate or polling frequency, try using our defaults. SPI bus capabilities differ between from single baord computers when accessed from `/dev/spi-devXXX`. Our defaults are tested on the Raspberry-Pi single board computer. You may increment the baurate and polling frequency from the default values to higher values once you see data returning from the device when configured. 