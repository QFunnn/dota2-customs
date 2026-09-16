--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


"""Offline Dota1x6 shop drafts from items_game.txt and a reviewed selection.

py generate_donate_items.py catalog --hero pangolier --output catalog.json
py generate_donate_items.py generate --manifest selection.json --output-dir drafts

Requires the same `vdf` package as test_dup_styled_fixed.py. Never edits live
shop files. Merge the generated entries, not entire existing hero tables.
"""
from __future__ import annotations

import argparse
import json
import math
import re
from collections.abc import Mapping
from pathlib import Path

import vdf


def hero_name(value):
    value = value if value.startswith("npc_dota_hero_") else "npc_dota_hero_" + value
    if not re.fullmatch(r"npc_dota_hero_[a-z0-9_]+", value):
        raise ValueError("Invalid hero name")
    return value


def load_items(path):
    # VDFDict is essential: ordinary dict silently drops repeated asset_modifier.
    with Path(path).open(encoding="utf-8-sig") as stream:
        data = vdf.load(stream, mapper=vdf.VDFDict, merge_duplicate_keys=False)
    return data.get("items_game", data)


def plain(value):
    if isinstance(value, Mapping):
        return {str(k): plain(v) for k, v in value.items()}
    return value


def modifiers(item):
    return [plain(value) for key, value in item.get("visuals", {}).items()
            if re.fullmatch(r"asset_modifier\d*", key) and isinstance(value, Mapping)]


def for_hero(item, hero):
    users = item.get("used_by_heroes") if isinstance(item, Mapping) else None
    return isinstance(users, Mapping) and str(users.get(hero)) == "1"


def catalog(data, hero):
    entries = []
    names = set()
    for key, item in data["items"].items():
        if not for_hero(item, hero):
            continue
        names.add(item.get("name"))
        entries.append({"id": int(key), "name": item.get("name"),
                        "prefab": item.get("prefab"), "slot": item.get("item_slot", "weapon"),
                        "model": item.get("model_player"), "icon": item.get("image_inventory"),
                        "rarity": item.get("item_rarity"),
                        "styles": plain(item.get("visuals", {}).get("styles", {})),
                        "modifiers": modifiers(item)})
    sets = [{"key": key, **plain(value)} for key, value in data.get("item_sets", {}).items()
            if isinstance(value, Mapping) and names.intersection(value.get("items", {}).keys())]
    return {"hero": hero, "items": entries, "sets": sets}


def lua(value, indent=0):
    if value is None:
        return "nil"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, str):
        # JSON's unicode escapes are not Lua 5.1 escapes. Keep Unicode literal.
        return '"' + ''.join('\\%03d' % ord(c) if ord(c) < 32 else
                             '\\' + c if c in '\\"' else c for c in value) + '"'
    if isinstance(value, (int, float)) and math.isfinite(value):
        return str(value)
    if isinstance(value, (list, dict)):
        pairs = enumerate(value, 1) if isinstance(value, list) else value.items()
        lines = ["{"]
        for key, entry in pairs:
            lines.append("    " * (indent + 1) + "[" + lua(key) + "] = " + lua(entry, indent + 1) + ",")
        return "\n".join(lines + ["    " * indent + "}"])
    raise ValueError(f"Unsupported Lua value: {value!r}")


def unique(values):
    return list(dict.fromkeys(values))


def pairs(value, field):
    if not isinstance(value, list) or any(not isinstance(row, list) or len(row) != 2 or
                                         any(not isinstance(x, str) or not x for x in row) for row in value):
        raise ValueError(f"{field} must contain [ability_name, texture] pairs")
    return value


def build(data, manifest):
    hero = hero_name(manifest["hero"])
    allowed = {"hero", "default_price", "ability_map", "rare", "sets", "priority"}
    if set(manifest) - allowed:
        raise ValueError(f"Unknown manifest fields: {set(manifest) - allowed}")
    ability_map = manifest.get("ability_map", {})
    if not isinstance(ability_map, dict) or any(not isinstance(v, str) or not v for v in ability_map.values()):
        raise ValueError("ability_map must map Valve ability names to actual addon ability names")
    effects_data = {ability: [] for ability in unique(ability_map.values())}
    changes, donated, textures, warnings = {}, {}, {}, []
    groups = []
    if manifest.get("rare"):
        groups.append(("rare", manifest["rare"]))
    for group in manifest.get("sets", []):
        if set(group) - {"key", "texture", "items"}:
            raise ValueError("Unknown set fields")
        key = group["key"]
        if not re.fullmatch(r"[a-z0-9_]+", key) or key == "rare" or key in textures:
            raise ValueError(f"Invalid/duplicate set key: {key}")
        if not group.get("items"):
            raise ValueError(f"Empty set: {key}")
        texture = group.get("texture")
        if not isinstance(texture, str) or not texture or texture.endswith((".png", ".vtex_c")):
            raise ValueError(f"Set {key} needs an existing texture path without extension")
        textures[key] = texture
        groups.append((key, group["items"]))
    if not groups:
        raise ValueError("No selected items")
    for group, selections in groups:
        for selection in selections:
            spec = {"id": selection} if isinstance(selection, int) else selection
            if not isinstance(spec, dict) or set(spec) - {"id", "shop_id", "price", "style", "effects", "icons", "lua_fields", "preview"}:
                raise ValueError(f"Invalid item selection: {spec}")
            item_id = spec["id"]
            shop_id = spec.get("shop_id", item_id)
            if any(type(n) is not int or n <= 0 for n in (item_id, shop_id)):
                raise ValueError("id and shop_id must be positive integers")
            if shop_id in donated:
                raise ValueError(f"Duplicate shop ID: {shop_id}")
            item = data["items"].get(str(item_id))
            if not for_hero(item, hero):
                raise ValueError(f"Item {item_id} is missing or does not belong to {hero}")
            if item.get("prefab") != "wearable" or not item.get("model_player") or not item.get("image_inventory"):
                raise ValueError(f"Item {item_id} is not a modeled wearable with an icon; handle special items explicitly")
            price = spec.get("price", manifest.get("default_price"))
            if isinstance(price, bool) or not isinstance(price, (int, float)) or not math.isfinite(price) or price < 0:
                raise ValueError(f"Item {item_id} needs an explicit non-negative price (or default_price)")
            entry = {"item_id": shop_id, "name": item["name"], "icon": item["image_inventory"],
                     "price": price, "HeroModel": None, "ArcanaAnim": None, "MaterialGroup": None,
                     "ItemModel": item["model_player"], "SetItems": None, "hide": 0,
                     "OtherItemsBundle": None, "SlotType": item.get("item_slot", "weapon"),
                     "RemoveDefaultItemsList": None, "Modifier": None, "sets": group}
            if shop_id != item_id:
                entry["dota_id"] = item_id
            style = spec.get("style", 0)
            if type(style) is not int or style < 0:
                raise ValueError(f"Invalid style for {item_id}")
            if "style" in spec:
                entry["ItemStyle"] = str(style)
            extra = spec.get("lua_fields", {})
            if not isinstance(extra, dict) or set(extra).intersection({"item_id", "dota_id", "sets", "price", "ItemStyle"}):
                raise ValueError("lua_fields cannot override identity, group, price or style")
            entry.update(extra)
            donated[shop_id] = entry
            preview = {"model": item_id}
            if "style" in spec:
                preview["styles"] = style
            active = [m for m in modifiers(item) if "style" not in m or str(m["style"]) == str(style)]
            icons = []
            for mod in active:
                if mod.get("type") == "ability_icon" and mod.get("asset") and mod.get("modifier"):
                    ability = mod["asset"]
                    if ability not in ability_map and "icons" not in spec:
                        warnings.append(f"{shop_id}: verify addon ability name for icon {ability}")
                    pair = [ability_map.get(ability, ability), mod["modifier"]]
                    if pair not in icons:
                        icons.append(pair)
            icons = pairs(spec.get("icons", icons), "icons")
            if icons:
                preview["changed_icons"] = icons
            effects = pairs(spec.get("effects", []), "effects")
            if "effects" not in spec and any(m.get("type") in {"particle", "particle_combined", "sound", "entity_model"} for m in active):
                warnings.append(f"{shop_id}: review ability effects; supply effects (empty [] means reviewed, none)")
            if effects:
                preview["changed_effects"] = effects
                for ability, _ in effects:
                    effects_data.setdefault(ability, []).append(shop_id)
            extra_preview = spec.get("preview", {})
            if not isinstance(extra_preview, dict) or set(extra_preview) - {"model", "styles"}:
                raise ValueError("preview overrides support only model and styles; use icons/effects for those fields")
            preview.update(extra_preview)
            changes[str(shop_id)] = preview
            styles = item.get("visuals", {}).get("styles", {})
            if styles and "style" not in spec:
                warnings.append(f"{shop_id}: source has styles; review ItemStyle, hide, OtherItemsBundle and preview styles")
    priority = manifest.get("priority", [name for name, _ in groups])
    expected = {name for name, _ in groups}
    if not isinstance(priority, list) or any(not isinstance(x, str) for x in priority) or len(priority) != len(set(priority)) or set(priority) != expected:
        raise ValueError("priority must contain each selected group exactly once")
    patch = {"ITEM_CHANGED_INFORMATION": changes, "SETS_PRIORITY": {hero: priority},
             "ITEMS_EFFECTS_DATA": {hero: {k: unique(v) for k, v in effects_data.items()}},
             "SETS_TEXTURE_FULL_ICON": textures}
    return hero, donated, patch, unique(warnings)


def write_json(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=4) + "\n", encoding="utf-8")


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--items-game", type=Path, default=Path(__file__).resolve().with_name("items_game.txt"))
    commands = parser.add_subparsers(dest="command", required=True)
    cat = commands.add_parser("catalog", help="List hero items, duplicate-safe modifiers and set membership")
    cat.add_argument("--hero", required=True)
    cat.add_argument("--output", type=Path, required=True)
    gen = commands.add_parser("generate", help="Generate review files; never modify existing shop tables")
    gen.add_argument("--manifest", type=Path, required=True)
    gen.add_argument("--output-dir", type=Path, required=True)
    args = parser.parse_args(argv)
    data = load_items(args.items_game)
    if args.command == "catalog":
        if args.output.exists():
            raise ValueError(f"Output exists: {args.output}; choose a new file")
        result = catalog(data, hero_name(args.hero))
        args.output.parent.mkdir(parents=True, exist_ok=True)
        write_json(args.output, result)
        print(f"Catalog: {len(result['items'])} items, {len(result['sets'])} sets -> {args.output}")
        return
    manifest = json.loads(args.manifest.read_text(encoding="utf-8-sig"))
    hero, donated, patch, warnings = build(data, manifest)
    out = args.output_dir
    if out.exists() and any(out.iterdir()):
        raise ValueError("Output directory must be empty; existing files will not be overwritten")
    out.mkdir(parents=True, exist_ok=True)
    (out / f"{hero}.lua").write_text("return\n" + lua(donated) + "\n", encoding="utf-8")
    write_json(out / "panorama.patch.json", patch)
    (out / "panorama.entries.js").write_text(
        "// REVIEW ENTRIES: merge into existing variables; do not replace the live config.\n" +
        "\n\n".join("var " + name + " = " + json.dumps(value, ensure_ascii=False, indent=4) + ";"
                     for name, value in patch.items()) + "\n", encoding="utf-8")
    (out / "added_shop_heroes.entry.lua").write_text(f"[{lua(hero)}] = true,\n", encoding="utf-8")
    write_json(out / "selection.json", manifest)
    write_json(out / "review.json", {"hero": hero, "items_game": str(args.items_game.resolve()),
               "item_count": len(donated), "warnings": warnings,
               "integration": ["Merge Lua entries preserving existing prices, IDs and custom fields.",
                               "Merge all four Panorama tables, preserving existing groups and effect IDs.",
                               "Verify actual addon ability names and set textures before integrating.",
                               "Check items_list/<hero>.lua AND <hero>_pfx.lua before enabling added_shop_heroes."]})
    print(f"Generated {len(donated)} items for {hero}: {out}")
    for warning in warnings:
        print("REVIEW: " + warning)


if __name__ == "__main__":
    try:
        main()
    except (ValueError, KeyError, OSError) as error:
        raise SystemExit(f"Error: {error}")