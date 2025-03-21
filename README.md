# VU Data Retrieval in Earth Observation (120.110)

These are the hand-outs of the Master course Data Retrieval in Earth Observation (120.110) at the TU Wien.

# Generate Jupyter Conda environment and Jupyter Kernel from `yml`

To re-create the environment as a Jupyter kernel for execution of the notebooks, do the following:

- Open a Terminal from the same level as this Markdown README file and the Makefile file.
- Type the following into the terminal.

```
make kernel
```

Select the kernel `dreo-env`.

# Clean-up

To remove Jupyter checkpoints run:

```
make clean
```

In order to remove the Conda environments and Jupyter kernels runL

```
make teardown
```
