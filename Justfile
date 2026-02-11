# Default command lists all available recipes
_default:
    @just --list --unsorted

alias b := bump
alias c := clean
alias h := hooks
alias q := check
alias t := test

PROJ := `uv version --short`

# lint python code using ruff
[private]
check-lint:
    uv run ruff check . --fix

# format python code using ruff
[private]
check-format:
    uv run ruff format .

# run the type checker ty
[private]
check-types:
    uv run ty check

# lint, format with ruff and type-check with ty
[group("dev")]
check: check-lint check-format check-types

# run tests with coverage
[group("dev")]
test:
    uv run pytest tests/

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

[confirm("Do you really want to bump? (y/n)")]
[private]
prompt-confirm:

# bump the version, commit and add a tag <major|minor|patch|...>
[group("chore")]
bump INCREMENT="patch": && tag
    @uv version --bump {{ INCREMENT }} --dry-run
    @just prompt-confirm
    uv version --bump {{ INCREMENT }}

# tag the latest version
[group("chore")]
tag VERSION=`uv version --short`:
    git add pyproject.toml
    git add uv.lock
    git commit -m "Bumped version to {{ VERSION }}"
    git tag -a "v{{ VERSION }}"
    @echo "{{ GREEN }}{{ BOLD }}Version has been bumped to {{ VERSION }}.{{ NORMAL }}"

# preview the documentation locally (serve the myst website)
[group("dev")]
docs:
    uv sync --group book
    uv run myst

# initialize a git repo and add all files
[group("chore")]
init: venv
    git init --initial-branch=main
    git add .
    git commit -m "initial commit"
    @echo "{{ GREEN }}{{ BOLD }}Git has been initialized{{ NORMAL }}"

# update dependencies
[group("chore")]
update:
    uvx prek autoupdate
    uv lock --upgrade

# write the changelog
[group("chore")]
changelog VERSION="auto":
    uvx git-changelog -Tio CHANGELOG.md -B="{{ VERSION }}" -c angular

# run a docker container
[group("docker")]
docker-up:
    docker compose up

# stop the docker container
[group("docker")]
docker-down:
    docker compose down
