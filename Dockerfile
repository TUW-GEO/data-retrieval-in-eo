FROM registry.datalab.tuwien.ac.at/jaas/base-notebook:latest

USER root

RUN apt-get update && \
    apt-get install -yq --no-install-recommends git build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

USER $NB_UID
COPY --chown=1000:1000 .. /home/jovyan/data-retrieval-in-eo
WORKDIR /home/jovyan/data-retrieval-in-eo

RUN uv pip install .[book] --system
