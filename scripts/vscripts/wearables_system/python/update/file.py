--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


# clean_lua_items.py
from pathlib import Path
import re

INPUT = "npc_dota_hero_phantom_assassin.lua"
OUTPUT = "npc_dota_hero_phantom_assassin.cleaned.lua"

KEYS_TO_REMOVE = [
    "ArcanaAnim",
    "MaterialGroup",
    "ParticlesHero",
    "SetItems",
    "RemoveDefaultItemsList",
    "Modifier",
    "ParticlesSkills",
    "OtherModelsPrecache",
    "ParticlesItems",
]

def count_braces_outside_strings(s: str):
    # Считаем { и } игнорируя то, что внутри '...' и "..." (достаточно для таких lua-таблиц)
    in_sq = False
    in_dq = False
    esc = False
    opens = closes = 0
    for ch in s:
        if esc:
            esc = False
            continue
        if ch == "\\":
            esc = True
            continue
        if not in_dq and ch == "'":
            in_sq = not in_sq
            continue
        if not in_sq and ch == '"':
            in_dq = not in_dq
            continue
        if in_sq or in_dq:
            continue
        if ch == "{":
            opens += 1
        elif ch == "}":
            closes += 1
    return opens, closes

def clean_lua_remove_keys(text: str, keys_to_remove):
    key_set = set(keys_to_remove)
    lines = text.splitlines(True)
    out_lines = []
    depth = 0
    i = 0

    # ловит: ['Key'] =  или ["Key"] =  или Key =
    key_pat = re.compile(r'^\s*(?:\[\s*["\'](?P<k1>[^"\']+)["\']\s*\]|(?P<k2>[A-Za-z_]\w*))\s*=')

    while i < len(lines):
        line = lines[i]

        # В твоём файле структура: return { [id] = { ... } }
        # то есть глубина:
        # depth=1 -> общий return { ... }
        # depth=2 -> конкретный item { ... }  <-- тут и режем ключи
        if depth == 2:
            m = key_pat.match(line)
            if m:
                k = m.group("k1") or m.group("k2")
                if k in key_set:
                    # пропускаем этот ключ целиком, но depth поддерживаем корректным
                    eq_pos = line.find("=")
                    remainder = line[eq_pos + 1:] if eq_pos != -1 else ""

                    o, c = count_braces_outside_strings(line)
                    depth += o - c
                    i += 1

                    o_rem, c_rem = count_braces_outside_strings(remainder)
                    bal = o_rem - c_rem
                    started = (o_rem > 0)  # таблица началась на этой строке?

                    if not started:
                        # бывает: ["ParticlesSkills"] =
                        #         {
                        #         ...
                        #         }
                        while i < len(lines):
                            ln = lines[i]
                            o2, c2 = count_braces_outside_strings(ln)

                            # если тут начинается таблица-значение
                            if o2 > 0 and "{" in ln:
                                started = True
                                bal += o2 - c2
                                depth += o2 - c2
                                i += 1
                                break

                            depth += o2 - c2
                            i += 1

                            # если это просто однострочное/многострочное значение и тут заканчивается
                            if "," in ln:
                                break

                    if started and bal > 0:
                        while i < len(lines) and bal > 0:
                            ln = lines[i]
                            o3, c3 = count_braces_outside_strings(ln)
                            bal += o3 - c3
                            depth += o3 - c3
                            i += 1

                    continue  # ключ удалён

        # обычная строка — сохраняем
        out_lines.append(line)
        o, c = count_braces_outside_strings(line)
        depth += o - c
        i += 1

    return "".join(out_lines)

def main():
    inp = Path(INPUT)
    out = Path(OUTPUT)

    text = inp.read_text(encoding="utf-8", errors="replace")
    cleaned = clean_lua_remove_keys(text, KEYS_TO_REMOVE)

    out.write_text(cleaned, encoding="utf-8")
    print(f"OK: saved -> {out.resolve()}")

if __name__ == "__main__":
    main()