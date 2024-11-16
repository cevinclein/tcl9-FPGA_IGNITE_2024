# Swap tcl versions for FPGA_IGNITE_2024

This script swaps tcl versions for `FPGA_IGNITE_2024`
We can swap between tcl 9 and tcl 8. You can run this
script anywhere on the system. 

## Swap to tcl 9 run:

```bash
./swap_tcl.sh tcl9
```

## Swap back to tcl 8 run:

```bash
./swap_tcl.sh tcl8
```

## Use the newest openlane image with tcl 9 run:

```bash
./swap_tcl.sh tcl9-latimg
```

## Always check which tcl version is currently active run:

```bash
./swap_tcl.sh tcl-vers
```

> You may need to be root if your current user is not in the docker group
