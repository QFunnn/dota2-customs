--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const ability_config_root = $("#DevAbilityKVs");
const ability_parent = $("#OrbHeroContainer");
const generic_parent = $("#OrbGenericContainer");

let upgrades_definition;
const generic_upgrades_definition = CustomNetTables.GetTableValue("ability_upgrades", "generic_upgrades");

let last_selected_hero = -1;

function OnUpgradesLoaded(hero) {
	ability_parent.RemoveAndDeleteChildren();
	generic_parent.RemoveAndDeleteChildren();

	const player_id = Entities.GetPlayerOwnerID(hero);

	UpdateSelectedHeroName();

	upgrades_definition = CustomNetTables.GetTableValue("ability_upgrades", Entities.GetUnitName(hero));
	if (!upgrades_definition) return;

	const ability_order = {};
	for (i = 0; i < 32; i++) {
		const ability = Entities.GetAbility(hero, i);
		const ability_name = Abilities.GetAbilityName(ability);
		if (Entities.IsValidEntity(ability) && ability_name.search("special_bonus_") == -1) {
			ability_order[ability_name] = i;
		}
	}

	const hero_ent_idx = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID());
	for (let [ability_name, ability_specials] of Object.entries(upgrades_definition)) {
		const panel = $.CreatePanel("Panel", ability_parent, ability_name);
		panel.BLoadLayoutSnippet("DevAbilityConfig");
		const order_number = ability_order[ability_name];
		panel.order = order_number > -1 ? order_number : 99999;

		panel.FindChildTraverse("DevAbilityImage").SetAbilityImage(Entities.GetAbilityByName(hero, ability_name));

		panel.SetDialogVariableLocString("ability_name_header", `DOTA_Tooltip_ability_${ability_name}`);

		const ability_upgrades_container = panel.FindChild("DevAbilitySpecials");
		Object.entries(ability_specials).forEach(([ability_special_name, kv], idx) => {
			if (kv.disabled) return;

			const ability_special_panel = $.CreatePanel("Panel", ability_upgrades_container, ability_special_name);
			ability_special_panel.BLoadLayoutSnippet("DevAbilitySpecial");
			ability_special_panel.SetHasClass("DarkBG", idx % 2);

			const linked_list = ability_special_panel.FindChildTraverse("DevAbilitySpecial_Linked");
			ability_special_panel.linked_list = linked_list;

			CreateUpgrades(
				kv,
				ability_special_panel,
				linked_list,
				false,
				false,
				hero_ent_idx,
				0,
				0,
				"LinkedSpecial",
				null,
				null,
				false,
				false,
			);

			const upgrade_ability = (dec_flag) => {
				let value = 1;
				if (GameUI.IsShiftDown()) value *= 5;
				if (GameUI.IsAltDown()) value *= 10;
				if (GameUI.IsControlDown()) value *= 50;
				GameEvents.SendToServerEnsured("Upgrades:dev:add_upgrade", {
					ability_name: ability_name,
					ability_special_name: ability_special_name,
					value: value * dec_flag,
					target_player_id: player_id,
				});
			};
			ability_special_panel.FindChildTraverse("DevAbilityDecrement").SetPanelEvent("onactivate", () => {
				upgrade_ability(-1);
			});
			ability_special_panel.FindChildTraverse("DevAbilityIncrement").SetPanelEvent("onactivate", () => {
				upgrade_ability(1);
			});
		});

		for (const ability_specials_block of ability_upgrades_container.Children().sort((a, b) => {
			return b.first_localized_upgrade > a.first_localized_upgrade
				? 1
				: b.first_localized_upgrade == a.first_localized_upgrade
				? 0
				: -1;
		})) {
			ability_upgrades_container.MoveChildBefore(ability_specials_block, ability_upgrades_container.GetChild(0));
		}
	}
	for (const ability of ability_parent.Children().sort((a, b) => {
		return b.order - a.order;
	})) {
		ability_parent.MoveChildBefore(ability, ability_parent.GetChild(0));
	}

	const panel = $.CreatePanel("Panel", generic_parent, "GenericUpgrades");
	panel.BLoadLayoutSnippet("DevAbilityConfig");

	panel.SetDialogVariableLocString("ability_name_header", `Generic Upgrades`);

	panel.FindChildTraverse("DevAbilityImage").abilityname = "generic";
	const genericContainer = panel.FindChild("DevAbilitySpecials");

	Object.entries(generic_upgrades_definition).forEach(([genericUpgradeName, genericUpgradeData], idx) => {
		if (genericUpgradeData.disabled) return;

		const generic_panel = CreateUpgrades(
			genericUpgradeData,
			panel,
			genericContainer,
			false,
			false,
			hero_ent_idx,
			0,
			0,
			"DevGenericSpecial",
			genericContainer,
			null,
			false,
			false,
		)[0];

		const upgrade_generic = (dec_flag) => {
			let _value = 1;
			if (GameUI.IsShiftDown()) _value *= 5;
			if (GameUI.IsAltDown()) _value *= 10;
			if (GameUI.IsControlDown()) _value *= 50;
			GameEvents.SendToServerEnsured("Upgrades:dev:add_generic_upgrade", {
				generic_upgrade_name: genericUpgradeName,
				value: _value * dec_flag,
				target_player_id: player_id,
			});
		};
		generic_panel.FindChildTraverse("DevAbilityDecrement").SetPanelEvent("onactivate", () => {
			upgrade_generic(-1);
		});
		generic_panel.FindChildTraverse("DevAbilityIncrement").SetPanelEvent("onactivate", () => {
			upgrade_generic(1);
		});
	});

	genericContainer.Children().forEach((generic, idx) => {
		generic.SetHasClass("DarkBG", idx % 2);
	});

	const current_upgrades = CustomNetTables.GetTableValue("ability_upgrades", String(player_id));
	if (current_upgrades) UpdateUpgradesState(current_upgrades);
}

function UpdateUpgradesState(upgrades_data) {
	if (!upgrades_definition) {
		$.Msg("Missing upgrade definitions1.");
		return;
	}

	for (const [ability_name, ability_specials] of Object.entries(upgrades_data)) {
		if (ability_name == "generic") {
			for (const [ability_special_name, kv] of Object.entries(ability_specials)) {
				const generic_root = generic_parent.FindChildTraverse(ability_special_name);
				if (!generic_root) return;
				generic_root.set_value_by_count(kv.count);
			}
		} else {
			const ability_container = ability_parent.FindChild(ability_name);
			if (!ability_container) continue;
			for (const [ability_special_name, kv] of Object.entries(ability_specials)) {
				const special_root = ability_container.FindChildTraverse(ability_special_name);
				if (!special_root) continue;
				special_root.set_value_by_count(kv.count);
				if (special_root.linked_list)
					special_root.linked_list.Children().forEach((_l) => {
						_l.set_value_by_count(kv.count);
					});
			}
		}
	}
}

function ToggleDevPanelVisible() {
	$.GetContextPanel().ToggleClass("HideDev");
}

function RequestUpgrades() {
	GameEvents.SendToServerEnsured("Upgrades:dev:load_upgrades", {
		hero_name: Game.GetPlayerInfo(0).player_selected_hero,
	});
	GameEvents.SendToServerEnsured("Upgrades:dev:request_upgrades", {});
}

function GetCurrentSelectedHero() {
	let unit = Players.GetLocalPlayerPortraitUnit();

	if (!Entities.IsRealHero(unit)) {
		unit = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID());
	}

	return unit;
}

function OnPortraitUnitChanged() {
	const hero = GetCurrentSelectedHero();

	if (hero !== last_selected_hero) {
		last_selected_hero = hero;
		OnUpgradesLoaded(hero);
	}
}

function OnAbilityUpgradesChanged(table_name, key, value) {
	if (Entities.GetUnitName(last_selected_hero) == key) {
		OnUpgradesLoaded(last_selected_hero);
		return;
	}

	if (Entities.GetPlayerOwnerID(last_selected_hero) == key) UpdateUpgradesState(value);
}

(function () {
	if (!Game.IsInToolsMode() && Game.GetMapInfo().map_display_name != "ot3_demo") return;

	CustomNetTables.SubscribeNetTableListener("ability_upgrades", OnAbilityUpgradesChanged);

	const hero = GetCurrentSelectedHero();
	const hero_name = Entities.GetUnitName(GetCurrentSelectedHero());
	const upgrades_data = CustomNetTables.GetTableValue("ability_upgrades", hero_name);
	if (upgrades_data) OnUpgradesLoaded(hero);
	last_selected_hero = hero;

	GameEvents.Subscribe("dota_player_update_query_unit", OnPortraitUnitChanged);
	GameEvents.Subscribe("dota_player_update_selected_unit", OnPortraitUnitChanged);
})();