#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: install-browseros-skills.sh [--path DIR] [--overwrite] [--prune] [--dry-run]

Copies every skills/*/*/SKILL.md package into the BrowserOS skills directory.

Options:
  --path DIR    Target BrowserOS skills path. Default: $HOME/.browseros/skills
  --overwrite   Replace existing installed skill folders.
  --prune       Remove previously installed repo skills no longer present here.
  --dry-run     Print planned changes without copying files.
USAGE
}

target="${HOME}/.browseros/skills"
manifest_name=".browseros-linkedin-skills.manifest"
overwrite=0
prune=0
dry_run=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --path)
      target="${2:?missing value for --path}"
      shift 2
      ;;
    --overwrite)
      overwrite=1
      shift
      ;;
    --prune)
      prune=1
      shift
      ;;
    --dry-run)
      dry_run=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"
source_dir="${repo_root}/skills"

if [[ ! -d "${source_dir}" ]]; then
  echo "Cannot find source skills directory: ${source_dir}" >&2
  exit 1
fi

if [[ "${dry_run}" -ne 1 ]]; then
  mkdir -p "${target}"
fi

installed=0
skipped=0
seen_file="$(mktemp)"
trap 'rm -f "${seen_file}"' EXIT

while IFS= read -r manifest; do
  source_skill="$(dirname "${manifest}")"
  skill_name="$(basename "${source_skill}")"
  dest="${target}/${skill_name}"

  if grep -Fxq "${skill_name}" "${seen_file}"; then
    echo "Duplicate skill folder name found: ${skill_name}" >&2
    exit 1
  fi
  printf '%s\n' "${skill_name}" >> "${seen_file}"

  if [[ -d "${dest}" && "${overwrite}" -ne 1 ]]; then
    echo "= ${skill_name}"
    skipped=$((skipped + 1))
    continue
  fi

  echo "+ ${skill_name}"
  installed=$((installed + 1))

  if [[ "${dry_run}" -ne 1 ]]; then
    rm -rf "${dest}"
    mkdir -p "${dest}"
    cp -R "${source_skill}/." "${dest}/"
  fi
done < <(find "${source_dir}" -mindepth 3 -maxdepth 3 -type f -name SKILL.md -print | sort)

pruned=0
if [[ "${prune}" -eq 1 ]]; then
  manifest_path="${target}/${manifest_name}"
  if [[ -f "${manifest_path}" ]]; then
    while IFS= read -r installed_name; do
      if [[ -z "${installed_name}" || "${installed_name}" == "builtin" ]]; then
        continue
      fi
      if grep -Fxq "${installed_name}" "${seen_file}"; then
        continue
      fi
      installed_dir="${target}/${installed_name}"
      if [[ ! -d "${installed_dir}" ]]; then
        continue
      fi
      echo "- ${installed_name}"
      pruned=$((pruned + 1))
      if [[ "${dry_run}" -ne 1 ]]; then
        rm -rf "${installed_dir}"
      fi
    done < "${manifest_path}"
  else
    echo "Prune skipped: no previous repo manifest at ${manifest_path}"
  fi
fi

if [[ "${dry_run}" -ne 1 ]]; then
  cp "${seen_file}" "${target}/${manifest_name}"
fi

echo "BrowserOS skills path: ${target}"
echo "Installed or updated: ${installed}"
echo "Skipped existing: ${skipped}"
echo "Pruned stale repo skills: ${pruned}"

if [[ "${skipped}" -gt 0 && "${overwrite}" -ne 1 ]]; then
  echo "Run with --overwrite to update existing skill directories."
fi
