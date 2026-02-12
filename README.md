# VU Data Retrieval in Earth Observation (120.110)

These are the hand-outs of the Master course Data Retrieval in Earth Observation (120.110) at the TU Wien.

# Development

## Prerequisites

Make sure you have [`uv`][uv] installed.

Then run the following to install the taskrunner. (or copy the command from the justfile):

```bash
uv tool install rust-just
```

## Kernel Setup

To re-create the environment as a Jupyter kernel for execution of the notebooks, do the following:

- Open a Terminal from the same level as this Markdown README file and the Makefile file.
- Type the following into the terminal.

```bash
just kernel
```

Select the kernel `data-retrieval`.

## Clean-up

To remove Jupyter checkpoints run:

```bash
just clean
```

In order to remove the Jupyter kernel run:

```bash
just remove-kernel
```

[uv]: https://docs.astral.sh/uv/
