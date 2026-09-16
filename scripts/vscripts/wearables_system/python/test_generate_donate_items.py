--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


"""Run: py test_generate_donate_items.py (uses local items_game.txt once)."""
import copy
import json
import os
from pathlib import Path
import re
import unittest

import vdf
import generate_donate_items as generator


class ShopGenerationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.source = Path(os.environ.get("DOTA1X6_ITEMS_GAME", Path(__file__).with_name("items_game.txt")))
        cls.data = generator.load_items(cls.source)
        cls.example = json.loads(Path(__file__).with_name("shop_selection.example.json").read_text(encoding="utf-8"))

    def test_existing_pangolier_records(self):
        hero, entries, patch, warnings = generator.build(self.data, self.example)
        self.assertEqual(warnings, [])
        self.assertEqual(set(entries), {12324, 9208, 13516, 13520, 13518, 13519})
        old = (self.source.parent.parent / "donate_items" / f"{hero}.lua").read_text(encoding="utf-8")
        # These ordinary Pangolier records have no nested Lua tables. Compare
        # actual existing values, including the apostrophe in Etienne's Revenge.
        for item_id, entry in entries.items():
            record = re.search(r"\[" + str(item_id) + r"\]\s*=\s*\{(.*?)\n\s*\},", old, re.S).group(1)
            for field in ("name", "icon", "ItemModel", "SlotType", "sets"):
                actual = re.search(r"\['" + field + r"'\]\s*=\s*(['\"])(.*?)\1", record).group(2)
                self.assertEqual(entry[field], actual)
            self.assertEqual(entry["price"], int(re.search(r"\['price'\]\s*=\s*(\d+)", record).group(1)))
        self.assertEqual(patch["ITEMS_EFFECTS_DATA"][hero]["pangolier_shield_crash_custom"], [12324])
        self.assertEqual(patch["ITEM_CHANGED_INFORMATION"]["9208"]["model"], 9208)
        self.assertEqual(patch["SETS_TEXTURE_FULL_ICON"]["windward_rogue"], "econ/sets/v2/tales_of_the_windward_rogue")

    def test_duplicate_asset_modifiers_survive(self):
        item = vdf.loads('"visuals"\n{\n"asset_modifier"\n{\n"type" "particle"\n"asset" "a"\n}\n'
                         '"asset_modifier"\n{\n"type" "ability_icon"\n"asset" "b"\n}\n}\n',
                         mapper=vdf.VDFDict, merge_duplicate_keys=False)
        self.assertEqual([m["asset"] for m in generator.modifiers(item)], ["a", "b"])
        mods = generator.modifiers(self.data["items"]["12324"])
        self.assertGreaterEqual(sum(m.get("type") == "particle" for m in mods), 4)
        self.assertTrue(any(m.get("type") == "ability_icon" for m in mods))

    def test_custom_shop_id_and_style(self):
        manifest = {"hero": "pangolier", "rare": [{"id": 12324, "shop_id": 9912324,
                    "price": 1000, "style": 1, "effects": [], "icons": [], "lua_fields": {"hide": 1}}]}
        _, entries, patch, _ = generator.build(self.data, manifest)
        self.assertEqual(entries[9912324]["dota_id"], 12324)
        self.assertEqual(entries[9912324]["ItemStyle"], "1")
        self.assertEqual(entries[9912324]["hide"], 1)
        self.assertEqual(patch["ITEM_CHANGED_INFORMATION"]["9912324"], {"model": 12324, "styles": 1})

    def test_no_guessed_effects(self):
        manifest = {"hero": "pangolier", "rare": [{"id": 12324, "price": 1000}]}
        _, _, patch, warnings = generator.build(self.data, manifest)
        self.assertNotIn("changed_effects", patch["ITEM_CHANGED_INFORMATION"]["12324"])
        self.assertTrue(any("review ability effects" in warning for warning in warnings))

    def test_rejects_wrong_hero_default_item_and_duplicate(self):
        wrong_hero = copy.deepcopy(self.example)
        wrong_hero["hero"] = "axe"
        duplicate = copy.deepcopy(self.example)
        duplicate["rare"].append(copy.deepcopy(duplicate["rare"][0]))
        default_id = next(int(k) for k, v in self.data["items"].items()
                          if generator.for_hero(v, "npc_dota_hero_pangolier") and v.get("prefab") == "default_item")
        default = {"hero": "pangolier", "rare": [{"id": default_id, "price": 1}]}
        for manifest in (wrong_hero, duplicate, default):
            with self.subTest(manifest=manifest), self.assertRaises(ValueError):
                generator.build(self.data, manifest)

    def test_requires_price_and_complete_priority(self):
        for change in ({"priority": ["rare"]}, {"rare": [{"id": 12324}]}):
            manifest = copy.deepcopy(self.example)
            manifest.update(change)
            with self.subTest(change=change), self.assertRaises(ValueError):
                generator.build(self.data, manifest)

    def test_lua_strings_and_nil(self):
        self.assertEqual(generator.lua('"\\\n\t'), '"\\"\\\\\\010\\009"')
        self.assertEqual(generator.lua(None), "nil")
        self.assertEqual(generator.lua(True), "true")


if __name__ == "__main__":
    unittest.main()