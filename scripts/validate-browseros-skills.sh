#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"

cd "${repo_root}"

ruby -ryaml -e '
  seen = {}
  Dir["skills/**/SKILL.md"].sort.each do |f|
    text = File.read(f)
    parts = text.split(/^---\s*$/)
    abort "bad frontmatter: #{f}" if parts.length < 3
    data = YAML.safe_load(parts[1], permitted_classes: [], aliases: false)
    abort "frontmatter is not a map: #{f}" unless data.is_a?(Hash)
    name = data["name"].to_s.strip
    desc = data["description"].to_s.strip
    folder = File.basename(File.dirname(f))
    abort "missing name: #{f}" if name.empty?
    abort "missing description: #{f}" if desc.empty?
    abort "name/folder mismatch: #{f} name=#{name}" if name != folder
    abort "duplicate skill name: #{name}" if seen[name]
    seen[name] = f
  end
  puts "frontmatter ok: #{seen.length} skills"
'

ruby -e '
  missing = []
  Dir["skills/**/SKILL.md"].sort.each do |f|
    text = File.read(f)
    skill_dir = File.dirname(f)
    text.scan(/`((?:references|templates|scripts|assets)\/[^`]+)`/).flatten.each do |rel|
      next if rel.include?("<") || rel.include?(">")
      path = File.expand_path(rel, skill_dir)
      missing << "#{f} -> #{rel}" unless File.exist?(path)
    end
  end
  if missing.any?
    abort "missing referenced skill files:\n#{missing.join("\n")}"
  end
  puts "referenced bundled files ok"
'

if command -v rg >/dev/null 2>&1; then
  echo "privacy scan:"
  found=0

  if rg -n -i '(/Users/|C:\\Users\\|[A-Z]:\\Users\\)' README.md docs skills scripts \
    --glob '!scripts/validate-browseros-skills.sh'; then
    found=1
  fi

  if rg -n -i '[[:alnum:]._%+-]+@[[:alnum:].-]+\.[[:alpha:]]{2,}' README.md docs skills scripts \
    --glob '!scripts/validate-browseros-skills.sh' | rg -v -i '(@example\.com|<[^>]*email[^>]*>)'; then
    found=1
  fi

  if [[ "${found}" -ne 0 ]]; then
    echo "privacy scan found possible private markers above; review before publishing" >&2
    exit 1
  fi

  echo "privacy scan ok"
else
  echo "rg not found; skipped privacy scan"
fi

git diff --check
