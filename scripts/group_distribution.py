import logging
import sys
from pathlib import Path
from shutil import copy2

COURSE_NAME = "120-110-data-retrieval-2026s"

log = logging.getLogger(__name__)
logging.basicConfig(
    format="{asctime} {levelname} {message}",
    style="{",
    datefmt="%Y/%m/%d %H:%M",
    level=logging.INFO,
)


def copy_payload(payload: list[Path], target: Path) -> None:
    for src_file in payload:
        target_file = target / src_file.name
        if target_file.exists():
            log.error("file already exists in target: %s", target_file)
            continue
        copy2(src=src_file, dst=target_file)


def main() -> None:  # noqa: D103
    home = Path.home()
    source_dir = home / f"shared/{COURSE_NAME}/remote"
    group_dir = home / f"groups/{COURSE_NAME}"

    payload: list[Path] = list((source_dir / "notebooks").glob("*.ipynb"))
    payload.append(source_dir / "paths.yml")
    log.info("payload: %s", payload)

    group_folders: list[Path] = list(group_dir.glob("Group*"))
    for group_folder in group_folders:
        log.info("process %s", group_folder)
        copy_payload(payload, target=group_folder)
        log.info("completed %s", group_folder)


if __name__ == "__main__":
    sys.exit(main())
