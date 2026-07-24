#!/usr/bin/env bash
set -euo pipefail

if python3 --version >/dev/null 2>&1; then
    python=(python3)
else
    python=(py -3)
fi

"${python[@]}" - "$1" <<'PY'
from collections import Counter
from pathlib import Path, PurePosixPath
import base64
import re
import sys

hex_wrapper = re.compile(
    r"""^(?P<prefix>(?:\s*--\[\[.*?\]\]\s*)*)return\s+"""
    r"""(?P<loader>[A-Za-z_]\w*(?:\.[A-Za-z_]\w*)*)\s*\(\s*"""
    r"""\[(?P<equals>=*)\[\s*(?P<payload>[0-9a-fA-F\s]+?)\s*"""
    r"""\](?P=equals)\]\s*,\s*(?P<quote>["'])(?P<source>[^"']+)"""
    r"""(?P=quote)\s*,\s*\.\.\.\s*\)\s*$""",
    re.DOTALL,
)
hex_definition = re.compile(
    r"""(?m)^\s*(?:_G\.)?(?P<loader>[A-Za-z_]\w*(?:\.[A-Za-z_]\w*)*)"""
    r"""\s*=\s*function\s*\(\s*(?P<payload>[A-Za-z_]\w*)"""
)
base64_wrapper = re.compile(
    r"""^(?P<prefix>(?:\s*--\[\[.*?\]\]\s*)*)local\s+"""
    r"""(?P<encoded>[A-Za-z_]\w*)\s*=\s*\[(?P<equals>=*)\["""
    r"""(?P<payload>[A-Za-z0-9+/=\s]*)\](?P=equals)\]\s*local\s+"""
    r"""(?P<alphabet>[A-Za-z_]\w*)\s*=\s*(?P<quote>["'])"""
    r"""ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\+/"""
    r"""(?P=quote)\s*local\s+function\s+(?P<decoder>[A-Za-z_]\w*)"""
    r"""\s*\(\s*(?P<input>[A-Za-z_]\w*)\s*\)\s*(?P<body>.*?)\bend\s*"""
    r"""local\s+(?P<decoded>[A-Za-z_]\w*)\s*=\s*(?P=decoder)"""
    r"""\s*\(\s*(?P=encoded)\s*\)\s*local\s+(?P<chunk>[A-Za-z_]\w*)"""
    r"""\s*=\s*loadstring\s*\(\s*(?P=decoded)\s*\)\s*if\s+(?P=chunk)"""
    r"""\s+then\s+(?P=chunk)\s*\(\s*\)\s+end\s*$""",
    re.DOTALL,
)
base64_candidate = re.compile(
    r"""local\s+[A-Za-z_]\w*\s*=\s*\[=*\[[A-Za-z0-9+/=\s]*\]=*\]\s*"""
    r"""local\s+[A-Za-z_]\w*\s*=\s*["']"""
    r"""ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\+/"""
    r"""["'].*?\bloadstring\s*\(""",
    re.DOTALL,
)
def matches_known_base64_decoder(body, input_name, alphabet_name):
    identifier = r"[A-Za-z_]\w*"
    data = re.escape(input_name)
    alphabet = re.escape(alphabet_name)
    pattern = re.compile(
        rf"""^\s*{data}\s*=\s*string\.gsub\s*\(\s*{data}\s*,\s*"""
        rf"""'\[\^'\s*\.\.\s*{alphabet}\s*\.\.\s*'=\]'\s*,\s*''\s*\)\s*"""
        rf"""return\s*\(\s*{data}\s*:\s*gsub\s*\(\s*'\.'\s*,\s*"""
        rf"""function\s*\(\s*(?P<char1>{identifier})\s*\)\s*"""
        r"""if\s+(?P=char1)\s*==\s*'='\s*then\s+return\s*''\s*end\s*"""
        rf"""local\s+(?P<bits>{identifier})\s*,\s*(?P<value>{identifier})"""
        rf"""\s*=\s*''\s*,\s*\(\s*{alphabet}\s*:\s*find\s*\(\s*"""
        r"""(?P=char1)\s*\)\s*-\s*1\s*\)\s*"""
        rf"""for\s+(?P<index1>{identifier})\s*=\s*6\s*,\s*1\s*,\s*-1"""
        r"""\s+do\s+(?P=bits)\s*=\s*(?P=bits)\s*\.\.\s*\(\s*"""
        r"""(?P=value)\s*%\s*2\s*\^\s*(?P=index1)\s*-\s*(?P=value)"""
        r"""\s*%\s*2\s*\^\s*\(\s*(?P=index1)\s*-\s*1\s*\)\s*>\s*0"""
        r"""\s+and\s*'1'\s*or\s*'0'\s*\)\s*end\s*"""
        r"""return\s+(?P=bits)\s*end\s*\)\s*:\s*gsub\s*\(\s*"""
        r"""'%d%d%d\?%d\?%d\?%d\?%d\?%d\?'\s*,\s*"""
        rf"""function\s*\(\s*(?P<char2>{identifier})\s*\)\s*"""
        r"""if\s*#\s*(?P=char2)\s*~=\s*8\s+then\s+return\s*''\s*end\s*"""
        rf"""local\s+(?P<byte>{identifier})\s*=\s*0\s*"""
        rf"""for\s+(?P<index2>{identifier})\s*=\s*1\s*,\s*8\s+do\s+"""
        r"""(?P=byte)\s*=\s*(?P=byte)\s*\+\s*\(\s*(?P=char2)\s*:\s*"""
        r"""sub\s*\(\s*(?P=index2)\s*,\s*(?P=index2)\s*\)\s*==\s*'1'"""
        r"""\s*and\s*2\s*\^\s*\(\s*8\s*-\s*(?P=index2)\s*\)\s*or\s*0"""
        r"""\s*\)\s*end\s*return\s+string\.char\s*\(\s*(?P=byte)\s*\)"""
        r"""\s*end\s*\)\s*\)\s*$""",
        re.DOTALL,
    )
    return pattern.fullmatch(body) is not None

root = Path(sys.argv[1])
files = [(path, path.read_text(encoding="utf-8")) for path in root.rglob("*.lua")]
keyless_hex_loaders = set()
encrypted_hex_loaders = set()

for _, text in files:
    definitions = list(hex_definition.finditer(text))
    for index, match in enumerate(definitions):
        end = definitions[index + 1].start() if index + 1 < len(definitions) else len(text)
        body = text[match.start():end]
        payload_name = match.group("payload")
        payload = re.escape(payload_name)
        uses_key = re.search(
            r"\b(?:aeslua|GetDedicatedServerKey|GetDedicatedServerKeyV2|GetDedicatedServerKeyV3)\b",
            body,
        )
        executes_chunk = re.search(r"\b(?:RunPlainChunk|loadstring|load)\s*\(", body)
        mentions_hex = re.search(r"\bHexToString\s*\(", body)
        if mentions_hex and executes_chunk and uses_key:
            encrypted_hex_loaders.add(match.group("loader"))
            continue

        conversion = re.search(
            rf"\blocal\s+(?P<plain>[A-Za-z_]\w*)\s*=\s*HexToString\s*\(\s*{payload}\s*\)",
            body,
        )
        if not conversion:
            continue

        before_conversion = body[match.end():conversion.start()]
        plain = re.escape(conversion.group("plain"))
        direct_execution = re.match(
            rf"\s*return\s+RunPlainChunk\s*\(\s*{plain}(?:\s*,\s*[A-Za-z_]\w*)*\s*\)\s*end\b",
            body[conversion.end():],
        )
        payload_changed = re.search(rf"\b{payload}\b", before_conversion)
        if direct_execution and not payload_changed:
            keyless_hex_loaders.add(match.group("loader"))

hex_candidate = None
if keyless_hex_loaders:
    loader_names = "|".join(re.escape(loader) for loader in sorted(keyless_hex_loaders, key=len, reverse=True))
    hex_candidate = re.compile(
        rf"""return\s+(?:{loader_names})\s*\(\s*\[=*\[\s*[0-9a-fA-F\s]{{64,}}""",
        re.DOTALL,
    )

operations = []
errors = []

for path, text in files:
    match = hex_wrapper.fullmatch(text)
    if match:
        loader = match.group("loader")
        if loader in encrypted_hex_loaders:
            continue
        if loader not in keyless_hex_loaders:
            errors.append(f"{path}: unrecognized hex loader {loader!r}")
            continue
        parts = [part.lower() for part in path.parts]
        indexes = [
            index for index, part in enumerate(parts)
            if part == "vscripts" and index > 0 and parts[index - 1] == "scripts"
        ]
        if not indexes:
            errors.append(f"{path}: not under scripts/vscripts")
            continue

        relative = PurePosixPath(*path.parts[indexes[-1] + 1:]).as_posix()
        source = match.group("source").replace("\\", "/").removeprefix("./")
        expected = {relative, f"vscripts/{relative}", f"scripts/vscripts/{relative}"}
        if source not in expected:
            errors.append(f"{path}: wrapper path {source!r} does not match {relative!r}")
            continue

        encoded = "".join(match.group("payload").split())
        try:
            decoded = bytes.fromhex(encoded)
            decoded.decode("utf-8")
        except (UnicodeDecodeError, ValueError) as error:
            errors.append(f"{path}: invalid hex payload: {error}")
            continue

        operations.append((path, match.group("prefix").encode(), decoded, f"hex/{match.group('loader')}"))
        continue

    match = base64_wrapper.fullmatch(text)
    if match:
        if not matches_known_base64_decoder(
            match.group("body"),
            match.group("input"),
            match.group("alphabet"),
        ):
            errors.append(f"{path}: unsupported Base64 decoder implementation")
            continue

        encoded = "".join(match.group("payload").split())
        try:
            decoded = base64.b64decode(encoded, validate=True)
            decoded.decode("utf-8")
        except (UnicodeDecodeError, ValueError) as error:
            errors.append(f"{path}: invalid Base64 payload: {error}")
            continue

        operations.append((path, match.group("prefix").encode(), decoded, "base64"))
        continue

    if hex_candidate and hex_candidate.search(text):
        errors.append(f"{path}: unsupported wrapper for a keyless hex loader")
    elif base64_candidate.search(text):
        errors.append(f"{path}: unsupported Base64 wrapper")

if errors:
    raise SystemExit("\n".join(errors))

if not operations:
    raise SystemExit("no supported static wrappers found")

for path, prefix, decoded, _ in operations:
    path.write_bytes(prefix + decoded)

counts = Counter(kind for _, _, _, kind in operations)
summary = ", ".join(f"{kind}: {count}" for kind, count in sorted(counts.items()))
print(f"decoded {len(operations)} Lua files ({summary})")
PY
