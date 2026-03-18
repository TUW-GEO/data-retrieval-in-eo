# Default command lists all available recipes
_default:
    @just --list --unsorted

alias c := clean
alias h := hooks
alias q := check
alias k := kernel
alias rk := remove-kernel
alias du := docker-up
alias dd := docker-down

# run the linter [arg:<full|concise|...>]
[group("style")]
lint arg="concise":
    uv run ruff check . --fix --output-format={{ arg }}

# run the formatter
[group("style")]
format:
    uv run ruff format .

# run the type checker [arg:<full|concise|...>]
[group("style")]
types arg="concise":
    uv run ty check --output-format={{ arg }}

# lint, format and type-check [arg:<full|concise|...>]
[group("style")]
check arg="concise":
    -@just lint {{ arg }}
    -@just format
    -@just types {{ arg }}

# setup the pre-commit hooks
[group("dev")]
hooks:
    uvx prek install

# clean all python build/compilation files and directories
[group("chore")]
clean: clean-build clean-pyc clean-test

# remove build artifacts
[private]
clean-build:
    rm -fr build/
    rm -fr _build/
    rm -fr dist/
    rm -fr .eggs/
    find . -name '*.egg-info' -exec rm -fr {} +
    find . -name '*.egg' -exec rm -f {} +

# remove Python file artifacts
[private]
clean-pyc:
    find . -name '*.pyc' -exec rm -f {} +
    find . -name '*.pyo' -exec rm -f {} +
    find . -name '*~' -exec rm -f {} +
    find . -name '__pycache__' -exec rm -fr {} +

# remove test and coverage artifacts
[private]
clean-test:
    rm -f .coverage
    rm -fr htmlcov/
    rm -fr .pytest_cache

# install dependencies in local venv
[group("dev")]
venv:
    uv sync --all-groups --all-extras

# create an ipython kernel
[group("kernel")]
kernel:
    uv run ipython kernel install --user --env VIRTUAL_ENV $(pwd)/.venv --name=data-retrieval

# remove the ipython kernel
[group("kernel")]
remove-kernel:
    uv run jupyter kernelspec uninstall data-retrieval

# update dependencies
[group("chore")]
update:
    uvx prek autoupdate
    uv lock --upgrade

# run a docker container
[group("docker")]
docker-up:
    docker compose up

# stop the docker container
[group("docker")]
docker-down:
    docker compose down
