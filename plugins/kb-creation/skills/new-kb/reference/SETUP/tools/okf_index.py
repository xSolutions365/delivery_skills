#!/usr/bin/env python3
"""okf_index.py - generate an OKF-style index.md for one vault folder.

Pilot. Reads each note's frontmatter (type, title, description) and writes
<folder>/index.md: headings by note type, each followed by a bulleted list of
links with the note's own description. Never invents text: a note with no
description is listed by title alone and reported.

Usage:
  python3 SETUP/tools/okf_index.py <folder>             write index.md
  python3 SETUP/tools/okf_index.py <folder> --check     report gaps, write nothing
  python3 SETUP/tools/okf_index.py <folder> --classified  add a one-line
                                            classification frontmatter
  python3 SETUP/tools/okf_index.py <folder> --by-filename  raw records: title from
                                            the filename, one flat list, no
                                            content read
  python3 SETUP/tools/okf_index.py --all                regenerate every index (the
                                            Stop hook runs this)
  python3 SETUP/tools/okf_index.py . --root             vault root: folder links
                                            only, with okf_version "0.2"

Default output is pure OKF (no frontmatter). The vault guard exempts index.md
from its classification rule, so --classified is only a fallback.

Output is deterministic, so re-running changes nothing unless a note changed.
"""
import os
import re
import sys
from urllib.parse import quote

RESERVED = {"index.md", "log.md"}
HEADINGS = {
    "interview-note": "Interview notes",
    "interview-synthesis": "Interview syntheses",
    "reference": "Reference",
    "source-summary": "Source summaries",
    "guide": "Guides",
    "register": "Registers",
    "raid-register": "RAID",
    "tracker": "Trackers",
    "records": "Records",
}


def parse(path):
    text = open(path, encoding="utf-8", errors="ignore").read()
    fm, body = {}, text
    m = re.match(r"---\n(.*?)\n---\n?", text, re.S)
    if m:
        body = text[m.end():]
        for line in m.group(1).split("\n"):
            k = re.match(r"^(type|title|description):\s*(.*)$", line)
            if k:
                fm[k.group(1)] = k.group(2).strip().strip("\"'")
    h1 = re.search(r"^#\s+(.+)$", body, re.M)
    return fm, (h1.group(1).strip() if h1 else None)


def build(folder, flags, root):
    """Return (index text, note count, missing descriptions, untyped notes)."""
    groups, missing, no_type = {}, [], []
    for name in sorted(os.listdir(folder)):
        if "--root" in flags:
            break
        if not name.endswith(".md") or name in RESERVED or name == "README.md":
            continue
        fm, h1 = parse(os.path.join(folder, name))
        ntype = fm.get("type")
        if not ntype:
            no_type.append(name)
            ntype = "untyped"
        title = fm.get("title") or h1 or name[:-3]
        if "--by-filename" in flags:
            title, ntype = name[:-3], "records"
        desc = fm.get("description")
        if not desc:
            missing.append(name)
        link = "/" + os.path.relpath(os.path.join(folder, name), root).replace(os.sep, "/")
        groups.setdefault(ntype, []).append((title, link, desc))
    subs = sorted(
        d for d in os.listdir(folder)
        if os.path.isfile(os.path.join(folder, d, "index.md"))
    )
    if subs:
        groups["\0folders"] = [
            (s, "/" + os.path.relpath(os.path.join(folder, s, "index.md"), root).replace(os.sep, "/"), None)
            for s in subs
        ]
    title = os.path.basename(folder).replace("-", " ").capitalize()
    out = []
    if "--root" in flags:
        title = "Vault index"
        out += ["---", 'okf_version: "0.2"', "---", ""]
    elif "--classified" in flags:
        out += ["---", "classification: internal", "---", ""]
    out += [f"# {title}", ""]
    for ntype in sorted(groups):
        out += [f"## {'Folders' if ntype == chr(0) + 'folders' else HEADINGS.get(ntype, ntype)}", ""]
        for t, link, d in groups[ntype]:
            out.append(f"- [{t}]({quote(link)})" + (f" - {d}" if d else ""))
        out.append("")
    total = sum(len(v) for k, v in groups.items() if k != chr(0) + "folders")
    return "\n".join(out).rstrip("\n") + "\n", total, missing, no_type


def write_if_changed(path, text):
    try:
        if open(path, encoding="utf-8").read() == text:
            return False
    except OSError:
        pass
    with open(path, "w", encoding="utf-8") as f:
        f.write(text)
    return True


SKIP = {"live-board", "node_modules", "__pycache__", ".git"}
# Gitignored private intake: never indexed, never linked from a shared index.
PRIVATE_TOP = {"00-inbox-local"}


def run_all(root):
    """Regenerate every index in the numbered vault folders, deepest first."""
    dirs = []
    for top in sorted(os.listdir(root)):
        if top in PRIVATE_TOP or not re.match(r"^0\d-", top) or not os.path.isdir(os.path.join(root, top)):
            continue
        for dp, dn, fn in os.walk(os.path.join(root, top)):
            dn[:] = sorted(d for d in dn if d not in SKIP)
            dirs.append(os.path.relpath(dp, root))
    wanted = set()
    for d in dirs:
        has_notes = any(
            f.endswith(".md") and f not in RESERVED and f != "README.md"
            for f in os.listdir(os.path.join(root, d))
        )
        if has_notes:
            parts = d.split(os.sep)
            while parts:
                wanted.add(os.sep.join(parts))
                parts.pop()
    changed = 0
    for d in sorted(wanted, key=lambda x: -x.count(os.sep)):
        flags = {"--by-filename"} if d.split(os.sep)[0] == "00-source-documents" else set()
        text, *_ = build(os.path.join(root, d), flags, root)
        changed += write_if_changed(os.path.join(root, d, "index.md"), text)
    text, *_ = build(root, {"--root"}, root)
    changed += write_if_changed(os.path.join(root, "index.md"), text)
    print(f"okf_index: {len(wanted) + 1} indexes, {changed} updated")


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    flags = {a for a in sys.argv[1:] if a.startswith("--")}
    root = os.getcwd()
    if "--all" in flags:
        return run_all(root)
    if not args:
        sys.exit(__doc__)
    folder = args[0].rstrip("/")
    text, total, missing, no_type = build(folder, flags, root)
    print(f"{folder}: {total} notes, {len(missing)} without description, {len(no_type)} without type")
    if "--check" in flags:
        for n in missing:
            print("  no description:", n)
        return
    write_if_changed(os.path.join(folder, "index.md"), text)
    print("wrote", os.path.join(folder, "index.md"))


if __name__ == "__main__":
    main()
