--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


import os
import re
from typing import Dict, Any

import vdf   # pip install vdf
import requests

# Глобальные данные
ALLITEMS_LIST: Dict[str, Any] | None = None
RAW_ITEMS_TEXT: str = ""
PARTICLE_SYSTEMS: dict[str, dict] = {}

def clean_kv_text(text: str) -> str:
    """
    Удаляем строки-комментарии, чтобы python-vdf не падал.
    - строки, начинающиеся с // или #
    """
    lines = []
    for line in text.splitlines():
        stripped = line.lstrip()
        if stripped.startswith("//") or stripped.startswith("#"):
            continue
        lines.append(line)
    return "\n".join(lines)

def parse_particle_systems(text: str) -> dict[str, dict]:
    """
    Парсит блок particle_systems из items_game.txt
    Возвращает:
    {
        "particles/xxx.vpcf": {
            "attach_type": "...",
            "attach_entity": "...",
            "control_points": [
                {...},
                ...
            ]
        }
    }
    """
    result: dict[str, dict] = {}

    pos = text.find('"attribute_controlled_attached_particles"')
    if pos == -1:
        return result

    brace_start = text.find("{", pos)
    if brace_start == -1:
        return result

    # вырезаем весь блок particle_systems
    depth = 0
    end = None
    for i in range(brace_start, len(text)):
        if text[i] == "{":
            depth += 1
        elif text[i] == "}":
            depth -= 1
            if depth == 0:
                end = i
                break

    if end is None:
        return result

    block = text[brace_start:end + 1]

    # каждый particle block
    entry_pattern = re.compile(r'"(\d+)"\s*{', re.MULTILINE)

    for m in entry_pattern.finditer(block):
        start = block.find("{", m.start())
        depth = 0
        entry_end = None

        for i in range(start, len(block)):
            if block[i] == "{":
                depth += 1
            elif block[i] == "}":
                depth -= 1
                if depth == 0:
                    entry_end = i
                    break

        if entry_end is None:
            continue

        entry = block[start:entry_end + 1]

        # вытаскиваем system
        system_match = re.search(r'"system"\s*"([^"]+)"', entry)
        if not system_match:
            continue

        system = system_match.group(1)

        data = {}

        for key in ("attach_type", "attach_entity"):
            m2 = re.search(rf'"{key}"\s*"([^"]+)"', entry)
            if m2:
                data[key] = m2.group(1)

        # control_points
        cps = []
        cp_block_match = re.search(r'"control_points"\s*{', entry)
        if cp_block_match:
            cp_start = entry.find("{", cp_block_match.start())
            depth = 0
            cp_end = None

            for i in range(cp_start, len(entry)):
                if entry[i] == "{":
                    depth += 1
                elif entry[i] == "}":
                    depth -= 1
                    if depth == 0:
                        cp_end = i
                        break

            if cp_end:
                cp_block = entry[cp_start:cp_end + 1]
                cp_entries = re.finditer(r'"(\d+)"\s*{', cp_block)

                for cp in cp_entries:
                    s = cp_block.find("{", cp.start())
                    depth = 0
                    e = None
                    for i in range(s, len(cp_block)):
                        if cp_block[i] == "{":
                            depth += 1
                        elif cp_block[i] == "}":
                            depth -= 1
                            if depth == 0:
                                e = i
                                break
                    if not e:
                        continue

                    cp_data = {}
                    pairs = re.findall(r'"([^"]+)"\s*"([^"]*)"', cp_block[s:e + 1])
                    for k, v in pairs:
                        cp_data[k] = v

                    cps.append(cp_data)

        if cps:
            data["control_points"] = cps

        result[system] = data

    return result

def load_keyvalues(path_or_url: str) -> Dict[str, Any]:
    r"""
    Аналог LoadKeyValues, но в Python.
    Сохраняем сырой текст, чтобы потом вручную разобрать visuals.
    """
    global RAW_ITEMS_TEXT

    # URL
    if path_or_url.startswith("http://") or path_or_url.startswith("https://"):
        resp = requests.get(path_or_url)
        resp.raise_for_status()
        text = resp.text
    else:
        if not os.path.exists(path_or_url):
            raise FileNotFoundError(f"Файл не найден: {path_or_url}")
        with open(path_or_url, "r", encoding="utf-8") as f:
            text = f.read()

    RAW_ITEMS_TEXT = text  # сохраняем сырой items_game.txt

    global PARTICLE_SYSTEMS
    PARTICLE_SYSTEMS = parse_particle_systems(RAW_ITEMS_TEXT)

    cleaned = clean_kv_text(text)
    # vdf здесь может терять дублирующиеся asset_modifier — не страшно,
    # visuals мы всё равно парсим из RAW_ITEMS_TEXT
    return vdf.loads(cleaned)


def lua_str(s: str) -> str:
    r"""
    Экранирует строку для вставки в Lua-таблицу: " → \", \ → \\.
    """
    if s is None:
        s = ""
    s = s.replace("\\", "\\\\").replace('"', '\\"')
    return f'"{s}"'


def extract_item_block(item_id: str, text: str) -> str | None:
    """
    Вытянуть текстовый блок предмета по item_id:

    "9757"
    {
        ...
    }
    """
    pattern = f'"{item_id}"'
    start = text.find(pattern)
    if start == -1:
        return None

    brace_start = text.find("{", start)
    if brace_start == -1:
        return None

    depth = 0
    for i in range(brace_start, len(text)):
        ch = text[i]
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                return text[brace_start:i + 1]

    return None


def extract_visuals_block(item_block: str) -> str | None:
    """
    Из блока предмета вытащить текст блока "visuals" { ... }.
    """
    pos = item_block.find('"visuals"')
    if pos == -1:
        return None

    brace_start = item_block.find("{", pos)
    if brace_start == -1:
        return None

    depth = 0
    for i in range(brace_start, len(item_block)):
        ch = item_block[i]
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                return item_block[brace_start:i + 1]

    return None


def create_empty_hero_list_file(hero_name: str, output_dir: str):
    """
    Создаёт файл <hero>_list.txt со стандартным Lua-шаблоном.
    """
    path = os.path.join(output_dir, f"{hero_name}_list.lua")

    content = "return\n{\n    \n}"

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)

    print("Создан файл списка:", path)

def save_hero_particles(hero_name: str, particles: dict, output_dir: str):
    path = os.path.join(output_dir, f"{hero_name}_pfx.lua")

    lines = ["return", "{"]

    for system, data in particles.items():
        lines.append(f'\t[{lua_str(system)}] = {{')

        for k in ("attach_type", "attach_entity"):
            if k in data:
                lines.append(f'\t\t[{lua_str(k)}] = {lua_str(data[k])},')

        cps = data.get("control_points")
        if cps:
            lines.append('\t\t["control_points"] = {')
            for cp in cps:
                lines.append('\t\t\t{')
                for k, v in cp.items():
                    lines.append(f'\t\t\t\t[{lua_str(k)}] = {lua_str(v)},')
                lines.append('\t\t\t},')
            lines.append('\t\t},')

        lines.append('\t},')

    lines.append("}")

    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print("Создан файл pfx:", path)


def parse_asset_modifier_blocks(visuals_block: str) -> list[dict[str, str]]:
    """
    Вырезать все блоки вида:

      "asset_modifier" / "asset_modifier0" / "asset_modifier17" / ...
      {
          "type"      "..."
          "asset"     "..."
          "modifier"  "..."
          ...
      }

    и превратить каждый в dict.
    """
    result: list[dict[str, str]] = []

    # Ищем ЛЮБОЙ ключ "asset_modifier" с опциональными цифрами
    # Пример совпадения:
    #   "asset_modifier17"
    #   {
    #       "type"   "particle"
    #       ...
    #   }
    pattern = re.compile(r'"asset_modifier\d*"\s*{', re.MULTILINE)

    for m in pattern.finditer(visuals_block):
        # m.start() указывает на начало "asset_modifier..."
        # Находим первую "{" после этого места
        brace_start = visuals_block.find("{", m.start())
        if brace_start == -1:
            continue

        depth = 0
        end = None
        for i in range(brace_start, len(visuals_block)):
            ch = visuals_block[i]
            if ch == "{":
                depth += 1
            elif ch == "}":
                depth -= 1
                if depth == 0:
                    end = i
                    break

        if end is None:
            continue

        block = visuals_block[brace_start:end + 1]

        # простенький парсер "key"  "value"
        pairs = re.findall(r'"([^"]+)"\s*"([^"]*)"', block)
        d: dict[str, str] = {}
        for k, v in pairs:
            d[k] = v

        result.append(d)

    return result


def get_hero_items_to_file(
    hero_name: str,
    items_kv_path_or_url: str,
    output_lua_path: str,
    hero_particles: dict[str, dict] = {}
):
    r"""
    Читает items_game.txt, находит все предметы для hero_name
    и сохраняет их в Lua-файл:

    return
    {
        ["9757"] = {
            ...
        },
        ...
    }
    """
    global ALLITEMS_LIST

    print("Загружаю items_game...")

    ALLITEMS_LIST = load_keyvalues(items_kv_path_or_url)
    all_items = ALLITEMS_LIST

    # Если структура вида { "items_game": { "items": {...} } }
    if "items_game" in all_items and isinstance(all_items["items_game"], dict):
        all_items = all_items["items_game"]

    items_dict = all_items.get("items", all_items)
    print("Всего предметов в items_game:", len(items_dict))

    lines: list[str] = []
    lines.append("return")
    lines.append("{")

    matched_items_with_model = 0
    matched_any_for_hero = 0

    global RAW_ITEMS_TEXT

    for itemDef, item in items_dict.items():
        if not isinstance(item, dict):
            continue

        used_by_heroes = item.get("used_by_heroes")
        item_slot = item.get("item_slot") or "weapon"
        item_rarity = item.get("item_rarity") or "common"
        prefab = item.get("prefab")
        is_persona = "persona" in str(item_slot).lower()

        # --- фильтр по герою ---
        for_this_hero = False

        if isinstance(used_by_heroes, dict) and prefab in ("wearable", "default_item"):
            for heroname, activated in used_by_heroes.items():
                if (
                    heroname == hero_name
                    and str(activated).lower() in ("1", "true")
                ):
                    for_this_hero = True
                    break

        # если этот айтем не для нужного героя — вообще не трогаем visuals
        if not for_this_hero:
            continue

        matched_any_for_hero += 1
        is_default_item = prefab == "default_item" and not is_persona

        # интересуют предметы с model_player
        model_player = item.get("model_player")

        # --- РАЗБОР VISUALS ИЗ СЫРОГО ТЕКСТА ---
        visuals_list = {
            "ability_icons": {},
            "particles_list": [],
            "particles_list_loadout": [],
            "particles_abilities": {},
            "sound_replace": {},
            "models": {},
            "models_refit" : {},
        }

        activity_list: list[str] = []
        item_hero_model: str | None = None

        item_block = extract_item_block(str(itemDef), RAW_ITEMS_TEXT or "")
        visuals_block = None
        asset_modifiers: list[dict[str, str]] = []

        if item_block is not None:
            visuals_block = extract_visuals_block(item_block)

        if visuals_block is not None:
            asset_modifiers = parse_asset_modifier_blocks(visuals_block)

        for visual_data in asset_modifiers:
            v_type = visual_data.get("type")
            modifier = visual_data.get("modifier")
            spawn_in_loadout_only = visual_data.get("spawn_in_loadout_only") or "0"
            asset = visual_data.get("asset")
            style = visual_data.get("style") or "0"

            if v_type == "entity_model" and modifier:
                if asset and asset != hero_name:
                    visuals_list["models"][asset] = modifier
                else:
                    item_hero_model = modifier

            if v_type == "activity" and modifier:
                activity_list.append(modifier)

            if v_type == "ability_icon" and asset and modifier:
                if style == "0":
                    visuals_list["ability_icons"][asset] = modifier

            if v_type == "inventory_icon" and asset and modifier:
                if style == "0":
                    visuals_list["ability_icons"][asset] = modifier

            if v_type == "model" and asset and modifier:
                if style == "0":
                    visuals_list["models_refit"][asset] = modifier

            if v_type == "sound" and asset and modifier:
                if style == "0":
                    visuals_list["sound_replace"][asset] = modifier

            if v_type == "particle_create" and modifier:
                if spawn_in_loadout_only == "0":
                    if style == "0":
                        visuals_list["particles_list"].append(modifier)
                else:
                    visuals_list["particles_list_loadout"].append(modifier)

                if modifier in PARTICLE_SYSTEMS:
                    hero_particles[modifier] = PARTICLE_SYSTEMS[modifier]


            if v_type in ("particle", "particle_combined") and asset and modifier:
                if style == "0":
                    visuals_list["particles_abilities"][asset] = modifier
        # --- /РАЗБОР VISUALS ---

        matched_items_with_model += 1

        item_name = item.get("name", "")
        image_inventory = item.get("image_inventory")

        lines.append(f'\t["{itemDef}"] = {{')
        lines.append(f'\t["item_id"] = {itemDef},')
        lines.append(f'\t["item_name"] = {lua_str(item_name)},')

        if image_inventory:
            lines.append(f'\t["item_icon"] = {lua_str(image_inventory)},')

        lines.append('\t["item_cost"] = 1,')

        if item_hero_model is not None:
            lines.append(f'\t["item_hero_model"] = {lua_str(item_hero_model)},')
        else:
            lines.append('\t["item_hero_model"] = nil,')

        if activity_list:
            lines.append('\t["activity_list"] = {')
            for act in activity_list:
                lines.append(f'\t\t{lua_str(act)},')
            lines.append('\t},')
        else:
            lines.append('\t["activity_list"] = nil,')

        lines.append('\t["item_material_group"] = nil,')
        lines.append(f'\t["item_model"] = {lua_str(model_player)},')
        lines.append(f'\t["item_slot"] = {lua_str(item_slot)},')
        lines.append(f'\t["item_rarity"] = {lua_str(item_rarity)},')

        if is_default_item:
            lines.append('\t["IsDefaultItem"] = true,')

        lines.append('\t["Modifier"] = nil,')

        lines.append('\t["visuals_list"] = {')

        # ability_icons
        lines.append('\t\t["ability_icons"] = {')
        for ability, mod in visuals_list["ability_icons"].items():
            lines.append(f'\t\t\t[{lua_str(ability)}] = {lua_str(mod)},')
        lines.append('\t\t},')

        # particles_list
        lines.append('\t\t["particles_list"] = {')
        for particle in visuals_list["particles_list"]:
            lines.append(f'\t\t\t{lua_str(particle)},')
        lines.append('\t\t},')

        # particles_list_loadout
        lines.append('\t\t["particles_list_loadout"] = {')
        for particle in visuals_list["particles_list_loadout"]:
            lines.append(f'\t\t\t{lua_str(particle)},')
        lines.append('\t\t},')

        # models
        lines.append('\t\t["models"] = {')
        for ability, mod in visuals_list["models"].items():
            lines.append(f'\t\t\t[{lua_str(ability)}] = {lua_str(mod)},')
        lines.append('\t\t},')

        # models_refit
        lines.append('\t\t["models_refit"] = {')
        for ability, mod in visuals_list["models_refit"].items():
            lines.append(f'\t\t\t[{lua_str(ability)}] = {lua_str(mod)},')
        lines.append('\t\t},')

        # sound_replace
        lines.append('\t\t["sound_replace"] = {')
        for ability, particle in visuals_list["sound_replace"].items():
            lines.append(f'\t\t\t[{lua_str(ability)}] = {lua_str(particle)},')
        lines.append('\t\t},')

        # particles_abilities
        lines.append('\t\t["particles_abilities"] = {')
        for ability, particle in visuals_list["particles_abilities"].items():
            lines.append(f'\t\t\t[{lua_str(ability)}] = {lua_str(particle)},')
        lines.append('\t\t},')

        lines.append('\t},')  # конец visuals_list
        lines.append('\t},')  # конец предмета

    lines.append("}")

    with open(output_lua_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    save_hero_particles(hero_name, hero_particles, os.path.dirname(output_lua_path))
    print("====================================")
    print("Всего предметов, где герой фигурирует в used_by_heroes:", matched_any_for_hero)
    print("Всего предметов для героя", hero_name, "с model_player:", matched_items_with_model)
    print("Файл сохранён как:", output_lua_path)
    

def get_hero_items_for_many(
    hero_names: list[str],
    items_kv_path_or_url: str,
    output_dir: str = ".",
):
    """
    Генерирует Lua-файл для каждого героя из списка.
    """

    # >>> ВАЖНО: создаём папку, если её нет <<<
    os.makedirs(output_dir, exist_ok=True)

    # грузим items_game ОДИН РАЗ
    load_keyvalues(items_kv_path_or_url)

    for hero in hero_names:
        output_path = os.path.join(output_dir, f"{hero}.lua")
        print("\n====================================")
        print("Обрабатываю героя:", hero)

        hero_particles = {}

        get_hero_items_to_file(
            hero_name=hero,
            items_kv_path_or_url=items_kv_path_or_url,
            output_lua_path=output_path,
            hero_particles=hero_particles  # передаем свежий словарь
        )
        
        # create_empty_hero_list_file(hero, output_dir)

if __name__ == "__main__":
    HEROES = [
        "npc_dota_hero_juggernaut",
    ]

    get_hero_items_for_many(
        hero_names=HEROES,
        items_kv_path_or_url="items_game.txt",
        output_dir="heroes_lua",
    )
    