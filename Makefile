.PHONY: shell build flash clean help

help:
	@echo "ZMK Hummingbird Firmware Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  make shell  - Enter Nix development shell with all dependencies"
	@echo "  make build  - Build the firmware (creates build/zephyr/zmk.uf2)"
	@echo "  make flash  - Flash firmware to connected Hummingbird device"
	@echo "  make clean  - Remove build artifacts"
	@echo ""
	@echo "First time setup:"
	@echo "  1. Run 'make shell' to enter the development environment"
	@echo "  2. Run 'make build' to build the firmware"
	@echo "  3. Double-tap reset button on keyboard (appears as XIAO-SENSE)"
	@echo "  4. Run 'make flash' to install firmware"

shell:
	nix develop

build:
	@echo "Building ZMK firmware for Hummingbird..."
	@if [ ! -d "zmk" ]; then \
		echo "Initializing West workspace..."; \
		west init -l config; \
		west update; \
	fi
	@if [ ! -d "zephyr" ]; then \
		echo "ERROR: Zephyr not found. Run 'west update' first."; \
		exit 1; \
	fi
	@echo "Building firmware..."
	@bash -c "source zephyr/zephyr-env.sh && CMAKE_PREFIX_PATH=$$(pwd)/zephyr/share/zephyr-package/cmake west build -p -s zmk/app -b xiao_rp2040 -- -DSHIELD=hummingbird -DZMK_CONFIG=\"$$(pwd)/config\""
	@echo ""
	@echo "✓ Build complete!"
	@echo "Firmware: build/zephyr/zmk.uf2"
	@echo ""
	@echo "To flash:"
	@echo "  1. Double-tap reset button on keyboard"
	@echo "  2. Run 'make flash' or manually copy build/zephyr/zmk.uf2 to the USB drive"

flash:
	@echo "Looking for Hummingbird device..."
	@MOUNT_POINT=$$(lsblk -o NAME,LABEL,MOUNTPOINT | grep -i "RPI-RP2\|RPI_RP2" | awk '{print $$3}' | head -n1); \
	if [ -z "$$MOUNT_POINT" ]; then \
		echo "ERROR: Hummingbird device not found!"; \
		echo ""; \
		echo "Please:"; \
		echo "  1. Double-tap the reset button on your keyboard"; \
		echo "  2. Wait for it to appear as 'RPI-RP2' USB drive"; \
		echo "  3. Run 'make flash' again"; \
		exit 1; \
	fi; \
	if [ ! -f "build/zephyr/zmk.uf2" ]; then \
		echo "ERROR: Firmware not built yet!"; \
		echo "Run 'make build' first."; \
		exit 1; \
	fi; \
	if [ ! -d "$$MOUNT_POINT" ]; then \
		echo "ERROR: Mount point $$MOUNT_POINT does not exist!"; \
		exit 1; \
	fi; \
	if [ ! -w "$$MOUNT_POINT" ]; then \
		echo "ERROR: Mount point $$MOUNT_POINT is not writable!"; \
		echo "You may need to run with appropriate permissions."; \
		exit 1; \
	fi; \
	echo "Found device at: $$MOUNT_POINT"; \
	echo "Device label: $$(lsblk -o NAME,LABEL,MOUNTPOINT | grep -i "RPI-RP2\|RPI_RP2" | awk '{print $$2}')"; \
	echo ""; \
	read -p "Copy firmware to $$MOUNT_POINT? [y/N] " -n 1 -r; \
	echo ""; \
	if [[ ! $$REPLY =~ ^[Yy]$$ ]]; then \
		echo "Cancelled."; \
		exit 1; \
	fi; \
	echo "Copying firmware..."; \
	cp -v build/zephyr/zmk.uf2 "$$MOUNT_POINT/"; \
	sync; \
	echo ""; \
	echo "✓ Firmware flashed successfully!"; \
	echo "Device will reboot automatically."

clean:
	@echo "Cleaning build artifacts..."
	rm -rf build zmk .west modules bootloader
	@echo "✓ Clean complete"
