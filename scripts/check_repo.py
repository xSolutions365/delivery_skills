#!/usr/bin/env python3
"""Check that the marketplace, the plugins and the documentation agree.

Run from the repository root: python3 scripts/check_repo.py
Exits with a non-zero status if anything needs fixing.
"""
import json
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
DOCS = ["README.md", "CATALOGUE.md", "CONTRIBUTING.md", "drafts/README.md"]
NAME = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
problems = []


def problem(message):
    problems.append(message)


def frontmatter(path):
    text = path.read_text()
    if not text.startswith("---"):
        return {}
    block = text.split("---", 2)[1]
    return dict(
        (key.strip(), value.strip())
        for key, _, value in (line.partition(":") for line in block.splitlines())
        if value.strip()
    )


def anchors(path):
    found = set()
    for line in path.read_text().splitlines():
        if line.startswith("#"):
            title = line.lstrip("#").strip().lower()
            found.add(re.sub(r"[^\w\- ]", "", title).replace(" ", "-"))
    return found


# 1. Marketplace entries match the plugin folders.
marketplace = json.loads((ROOT / ".claude-plugin/marketplace.json").read_text())
listed = set()
for entry in marketplace["plugins"]:
    name, source = entry["name"], entry["source"]
    folder = ROOT / source
    listed.add(folder.resolve())
    if not NAME.match(name):
        problem(f"marketplace: '{name}' must be lowercase letters, numbers and hyphens")
    manifest_path = folder / ".claude-plugin/plugin.json"
    if not manifest_path.exists():
        problem(f"marketplace: '{name}' points at {source}, which has no plugin.json")
        continue
    manifest = json.loads(manifest_path.read_text())
    if manifest.get("name") != name:
        problem(f"{source}: plugin.json name '{manifest.get('name')}' differs from '{name}'")
    if "version" in entry and "version" in manifest and entry["version"] != manifest["version"]:
        problem(f"{source}: version {manifest['version']} differs from marketplace {entry['version']}")
for folder in sorted((ROOT / "plugins").iterdir()):
    if folder.is_dir() and folder.resolve() not in listed:
        problem(f"plugins/{folder.name} is not listed in the marketplace")

# 2. Every skill and command is described and appears in the catalogue.
catalogue = (ROOT / "CATALOGUE.md").read_text()
tools = sorted(ROOT.glob("plugins/*/skills/*/SKILL.md")) + sorted(ROOT.glob("plugins/*/commands/*.md"))
for tool in tools:
    relative = tool.relative_to(ROOT).as_posix()
    meta = frontmatter(tool)
    if not meta.get("description"):
        problem(f"{relative}: missing a description in its frontmatter")
    if tool.name == "SKILL.md" and meta.get("name") != tool.parent.name:
        problem(f"{relative}: frontmatter name should be '{tool.parent.name}'")
    if relative not in catalogue and tool.parent.relative_to(ROOT).as_posix() + "/)" not in catalogue:
        problem(f"{relative}: not linked from CATALOGUE.md")

# 3. Local links, anchors and code fences in the documentation.
documents = [ROOT / d for d in DOCS] + sorted((ROOT / "guides").glob("*.md"))
links = 0
for document in documents:
    text = document.read_text()
    shown = document.relative_to(ROOT).as_posix()
    if text.count("```") % 2:
        problem(f"{shown}: unbalanced code fence")
    for match in re.finditer(r"\]\(([^)\s]+)\)", text):
        target = match.group(1)
        if target.startswith(("http://", "https://", "mailto:")):
            continue
        links += 1
        path, _, fragment = target.partition("#")
        resolved = (document.parent / path) if path else document
        if not resolved.exists():
            problem(f"{shown}: link to {target} does not resolve")
        elif fragment and resolved.suffix == ".md" and fragment not in anchors(resolved):
            problem(f"{shown}: no heading for {target}")

print(f"{len(marketplace['plugins'])} plugins, {len(tools)} skills and commands, "
      f"{len(documents)} documents, {links} local links")
if problems:
    print(f"\n{len(problems)} problem(s):")
    for item in problems:
        print(f"  - {item}")
    sys.exit(1)
print("All checks passed")
