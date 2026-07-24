--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const ability_config_root = $("#DevAbilityKVs");

let upgrades_definition;
let generic_upgrades_definition;

let current_upgrades_data;
let current_generic_upgrades_data;

function OnUpgradesLoaded(event) {
	// $.Msg("OnUpgradesLoaded");
	// $.Msg(event);
	ability_config_root.RemoveAndDeleteChildren();

	upgrades_definition = event.upgrades_data;
	generic_upgrades_definition = event.generic_upgrades_data;

	for (const [ability_name, ability_specials] of Object.entries(event.upgrades_data)) {
		const panel = $.CreatePanel("Panel", ability_config_root, ability_name);
		panel.BLoadLayoutSnippet("DevAbilityConfig");

		panel.GetChild(0).abilityname = ability_name;
		panel.GetChild(1).text = $.Localize(`#DOTA_Tooltip_ability_${ability_name}`);

		const kv_container = panel.GetChild(2);

		for (const [ability_special_name, kv] of Object.entries(ability_specials)) {
			const ability_special_panel = $.CreatePanel("Panel", kv_container, ability_special_name);
			ability_special_panel.BLoadLayoutSnippet("DevAbilitySpecial");

			const localization_token = `#DOTA_Tooltip_ability_${ability_name}_${ability_special_name}`;
			let localized_name = $.Localize(localization_token);
			if (localization_token == localized_name) {
				localized_name = ability_special_name;
			}
			if (ability_special_name == "cooldown_and_manacost") {
				localized_name = $.Localize("#cooldown_and_manacost_upgrade");
			}

			ability_special_panel.SetDialogVariable("special_name", localized_name);

			ability_special_panel.SetDialogVariable("base_value", Math.round(kv.value * 100) / 100);

			ability_special_panel.SetDialogVariableInt("upgrades_count", 0);
			ability_special_panel.SetDialogVariable("total_value", 0);

			const upgrade_ability = (dec_flag) => {
				let value = 1;
				if (GameUI.IsShiftDown()) value *= 5;
				if (GameUI.IsAltDown()) value *= 10;
				if (GameUI.IsControlDown()) value *= 50;
				GameEvents.SendCustomGameEventToServer("Upgrades:dev:add_upgrade", {
					ability_name: ability_name,
					ability_special_name: ability_special_name,
					value: value * dec_flag,
				});
			};
			ability_special_panel.GetChild(2).SetPanelEvent("onactivate", () => {
				upgrade_ability(-1);
			});
			ability_special_panel.GetChild(3).SetPanelEvent("onactivate", () => {
				upgrade_ability(1);
			});
		}
	}

	const panel = $.CreatePanel("Panel", ability_config_root, "GenericUpgrades");
	panel.BLoadLayoutSnippet("DevAbilityConfig");
	panel.GetChild(1).text = $.Localize(`Generic Upgrades`);
	const genericContainer = panel.GetChild(2);

	for (const [genericUpgradeName, genericUpgradeData] of Object.entries(generic_upgrades_definition)) {
		for (const [_, value] of Object.entries(genericUpgradeData.Specials)) {
			const genericUpgradePanel = $.CreatePanel("Panel", genericContainer, genericUpgradeName);
			genericUpgradePanel.BLoadLayoutSnippet("DevGenericSpecial");

			genericUpgradePanel.SetDialogVariable("boost_value", 1);
			genericUpgradePanel.SetDialogVariable("special_name", genericUpgradeName);

			generic_upgrades_definition[genericUpgradeName].base_value = Math.round(parseFloat(value) * 100) / 100;
			generic_upgrades_definition[genericUpgradeName].rarity = genericUpgradeData.Rarity;
			genericUpgradePanel.SetDialogVariable(
				"base_value",
				generic_upgrades_definition[genericUpgradeName].base_value,
			);

			genericUpgradePanel.SetDialogVariableInt("upgrades_count", 0);
			genericUpgradePanel.SetDialogVariable("total_value", 0);

			const upgrade_generic = (dec_flag) => {
				let value = 1;
				if (GameUI.IsShiftDown()) value *= 5;
				if (GameUI.IsAltDown()) value *= 10;
				if (GameUI.IsControlDown()) value *= 50;
				GameEvents.SendCustomGameEventToServer("Upgrades:dev:add_generic_upgrade", {
					generic_upgrade_name: genericUpgradeName,
					value: value * dec_flag,
				});
			};
			genericUpgradePanel.GetChild(2).SetPanelEvent("onactivate", () => {
				upgrade_generic(-1);
			});
			genericUpgradePanel.GetChild(3).SetPanelEvent("onactivate", () => {
				upgrade_generic(1);
			});
			break;
		}
	}
}

function UpdateUpgradesState(upgrades_data) {
	current_upgrades_data = upgrades_data;

	for (const [ability_name, ability_specials] of Object.entries(current_upgrades_data)) {
		const ability_container = ability_config_root.FindChild(ability_name);
		for (const [ability_special_name, kv] of Object.entries(ability_specials)) {
			if (!ability_container) continue;
			var ability_special_container = ability_container.GetChild(2);
			if (ability_special_container)
				ability_special_container = ability_special_container.FindChild(ability_special_name);
			if (!ability_special_container) continue;
			// upgrades_data.count * upgrades_data.base_value
			ability_special_container.SetDialogVariableInt("upgrades_count", kv.count);
			const definition = upgrades_definition[ability_name]
				? upgrades_definition[ability_name][ability_special_name]
				: undefined;
			if (definition && definition.operator == "OP_MULTIPLY") {
				let final_value = 1.0;
				let value_step = 1 - kv.base_value / 100;
				for (let i = 0; i < kv.count; i++) {
					final_value *= value_step;
				}
				ability_special_container.SetDialogVariable("total_value", (1 - final_value).toFixed(2));
			} else {
				ability_special_container.SetDialogVariable(
					"total_value",
					Math.round(kv.count * kv.base_value * 100) / 100,
				);
			}
		}
	}
}

function UpdateGenericUpgradesState(upgrades_data) {
	if (!generic_upgrades_definition) return;
	current_generic_upgrades_data = upgrades_data;
	for (const [genericUpgradeName, genericUpgradeData] of Object.entries(generic_upgrades_definition)) {
		const genericUpgradePanel = ability_config_root.FindChildTraverse(genericUpgradeName);
		if (genericUpgradePanel) {
			let count = 0;
			if (current_generic_upgrades_data[genericUpgradeName]) {
				count = current_generic_upgrades_data[genericUpgradeName].count;
			}
			genericUpgradePanel.SetDialogVariableInt("upgrades_count", count);
			let boostValue = 1;
			if (
				generic_upgrades_definition[genericUpgradeName].rarity == "rare" &&
				current_generic_upgrades_data["generic_rare_stat_boost"]
			) {
				boostValue = 1 + (current_generic_upgrades_data["generic_rare_stat_boost"].count * 75) / 100;
			}
			if (
				generic_upgrades_definition[genericUpgradeName].rarity == "common" &&
				current_generic_upgrades_data["generic_common_stat_boost"]
			) {
				boostValue = 1 + (current_generic_upgrades_data["generic_common_stat_boost"].count * 50) / 100;
			}
			genericUpgradePanel.SetDialogVariable("boost_value", boostValue);
			genericUpgradePanel.SetDialogVariable(
				"total_value",
				(generic_upgrades_definition[genericUpgradeName].base_value * count * boostValue).toFixed(2),
			);
		}
	}
}

function ToggleDevPanelVisible() {
	$.GetContextPanel().ToggleClass("HideDev");
}

(function () {
	if (!Game.IsInToolsMode()) {
		$.GetContextPanel()
			.Children()
			.forEach((panel) => {
				panel.DeleteAsync(0.0);
			});
	} else {
		$.GetContextPanel().SetHasClass("Hide", false);

		SubscribeToNetTableKey("ability_upgrades", String(Players.GetLocalPlayer()), UpdateUpgradesState);
		SubscribeToNetTableKey("generic_upgrades", String(Players.GetLocalPlayer()), UpdateGenericUpgradesState);

		const frame = GameEvents.NewProtectedFrame($.GetContextPanel());
		frame.SubscribeProtected("Upgrades:dev:upgrades_loaded", OnUpgradesLoaded);

		GameEvents.SendCustomGameEventToServer("Upgrades:dev:request_upgrades", {});
	}
})();