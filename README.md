# Taipo Layout for Hummingbird (Finnish)

ZMK configuration implementing [Taipo](https://inkeys.wiki/en/keymaps/taipo) chording layout for the Hummingbird keyboard with Finnish character support (å, ä, ö).

## Quick Start

1. **Fork this repository** or use it as a template
2. **Enable GitHub Actions** - firmware builds automatically
3. **Download** `.uf2` from Actions artifacts
4. **Flash**: Double-tap reset button, drag `.uf2` to USB drive

The keyboard will appear as "XIAO-SENSE" in bootloader mode.

## Configuration

- **Board**: `xiao_ble` (Seeed XIAO BLE)
- **Shield**: `hummingbird`
- **Layout**: Taipo with 30-key support
- **Extras**: Finnish å/ä/ö, Bluetooth, sticky modifiers

## Customization

### Adjust Combo Timing
Edit `config/hummingbird.keymap`:
```c
#define COMBO_TIMEOUT 70  // Increase to 100-150 for easier chording
```

### Modify Chords
Edit `config/taipo-finnish.dtsi`. Finnish characters map to:
- å → `LBKT` (needs Finnish OS layout)
- ä → `SQT` 
- ö → `SEMI`

### Change Board
If using different hardware, edit `build.yaml`:
```yaml
include:
  - board: xiao_ble         # or seeeduino_xiao, nice_nano_v2, etc.
    shield: hummingbird
```

## Local Build

```bash
docker run --rm -v $(pwd):/workspace zmkfirmware/zmk-build-arm:stable /bin/bash -c '
  cd /workspace &&
  west init -l config &&
  west update &&
  west build -p -s zmk/app -b xiao_ble -- -DSHIELD=hummingbird -DZMK_CONFIG="/workspace/config"
'
```

Firmware: `build/zephyr/zmk.uf2`

## Troubleshooting

**Finnish chars show as [ ' ;** → Set OS keyboard layout to Finnish or US-International

**Chords not registering** → Increase `COMBO_TIMEOUT` or press keys more simultaneously

**Build fails** → Check `build.yaml` has correct board name for your controller

## Resources

- [Taipo Layout](https://inkeys.wiki/en/keymaps/taipo) - Original layout documentation
- [TAIPO_GUIDE.md](TAIPO_GUIDE.md) - Visual chord reference
- [ZMK Docs](https://zmk.dev) - Firmware documentation
- [dlip/zmk-taipo](https://github.com/dlip/zmk-taipo) - Original Taipo implementation

## Credits

- Taipo layout by [dlip](https://github.com/dlip/zmk-taipo)
- Hummingbird keyboard by [PJE66](https://github.com/PJE66/hummingbird)
- Finnish adaptation for this config
