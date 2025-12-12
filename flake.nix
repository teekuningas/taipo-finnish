{
  description = "ZMK firmware build environment for Hummingbird keyboard";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # ZMK build dependencies
        zmkBuildInputs = with pkgs; [
          cmake
          ninja
          python3
          python3Packages.pip
          python3Packages.west
          python3Packages.pyelftools
          dtc
          wget
          git
          
          # ARM toolchain for embedded builds
          gcc-arm-embedded
          
          # Additional Python packages needed by ZMK
          python3Packages.pyserial
          python3Packages.pyyaml
          python3Packages.pykwalify
          python3Packages.colorama
          python3Packages.pillow
          python3Packages.cbor
          python3Packages.intelhex
          python3Packages.click
          python3Packages.cryptography
          python3Packages.canopen
          python3Packages.packaging
          python3Packages.progress
          python3Packages.psutil
          python3Packages.pylink-square
        ];

      in {
        devShells.default = pkgs.mkShell {
          buildInputs = zmkBuildInputs;
          
          shellHook = ''
            # Set up Zephyr environment variables
            export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
            export GNUARMEMB_TOOLCHAIN_PATH="${pkgs.gcc-arm-embedded}"
            export ZEPHYR_BASE="$(pwd)/zephyr"
            
            echo "ZMK build environment loaded"
            echo "Available commands:"
            echo "  make shell  - Enter this development shell"
            echo "  make build  - Build the firmware"
            echo "  make flash  - Flash firmware to connected device"
            echo "  make clean  - Clean build artifacts"
            echo ""
            echo "Firmware will be built to: build/zephyr/zmk.uf2"
          '';
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "zmk-hummingbird-firmware";
          version = "0.1.0";
          
          src = ./.;
          
          nativeBuildInputs = zmkBuildInputs;
          
          buildPhase = ''
            export HOME=$TMPDIR
            west init -l config
            west update
            west build -p -s zmk/app -b xiao_ble -- -DSHIELD=hummingbird -DZMK_CONFIG="$(pwd)/config"
          '';
          
          installPhase = ''
            mkdir -p $out
            cp build/zephyr/zmk.uf2 $out/
          '';
        };
      }
    );
}
