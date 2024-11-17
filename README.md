# Swap tcl versions for FPGA_IGNITE_2024

This script swaps tcl versions for `FPGA_IGNITE_2024`
We can swap between tcl 9 and tcl 8. You can run this
script anywhere on the system.

## Quick start

The following is recommended. This swaps the tcl version
to tcl 9 and update the openlane image to the latest version.
With this the following errors should be fixed:

https://github.com/The-OpenROAD-Project/OpenLane/issues/914
https://github.com/The-OpenROAD-Project/OpenLane/issues/1489

```bash
git clone https://github.com/cevinclein/tcl9-FPGA_IGNITE_2024.git
cd tcl9-FPGA_IGNITE_2024

# if your user is not in the docker group use sudo or be root
./swap_tcl.sh tcl9-latimg 
``` 

## Swap to tcl 9 run:

```bash
./swap_tcl.sh tcl9
```

## Swap back to tcl 8 run:

```bash
./swap_tcl.sh tcl8
```

## Use the newest openlane image with tcl 9 run (recommended):

```bash
./swap_tcl.sh tcl9-latimg
```

## Always check which tcl version is currently active run:

```bash
./swap_tcl.sh tcl-vers
```

> You may need to be root if your current user is not in the docker group
