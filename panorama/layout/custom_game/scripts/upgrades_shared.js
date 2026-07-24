--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const reverse_increment = ["cooldown_and_manacost"];

const DEFAULT_MULTIPLICATION_TARGET = 90;

function UppercaseConvert(line) {
	line = line.toLowerCase();
	line = line.charAt(0).toUpperCase() + line.substring(1);
	return line;
}

function CorrectRoundUpgradeValue(value) {
	const decimal = value.toString().split(".")?.[1];
	if (!decimal) return value;

	const count_of_zeroes = decimal.match(/^0+/)?.[0].length || 0;
	let round_c = 2;
	if (count_of_zeroes > 0 && value < 0) round_c = count_of_zeroes + 1;

	return Math.rd(value, round_c);
}

function GetMultiplyValueDiff(upgrade_definition, hero_idx, value, max, count_for_diff) {
	const multiply_value_calc = (count) => {
		return CalculateUpgradeValue(hero_idx, value, count, upgrade_definition, false);
	};
	return CorrectRoundUpgradeValue(multiply_value_calc(max) - multiply_value_calc(count_for_diff));
}
function CreateUpgrades(
	upgrade_info,
	basic_root,
	additional_root,
	b_check_hidden,
	b_check_repeat_localization_lines,
	hero_idx,
	upgrades_count_for_diff,
	max_upgrades_count,
	upgrade_value_snippet,
	root_for_basic_line,
	loc_prefix,
	check_multiplier_for_min_rarity_upgrades,
	b_force_generic_localization,
) {
	let upgrades_list = [];

	const is_generic_upgrade = upgrade_info.type == UPGRADE_TYPE.GENERIC;

	let default_definition = {
		ability_name: upgrade_info.ability_name,
		upgrade_name: upgrade_info.upgrade_name,
		operator: upgrade_info.operator,
		value: upgrade_info.value,
		multiplicative_target:
			upgrade_info.multiplicative_target !== undefined
				? upgrade_info.multiplicative_target
				: DEFAULT_MULTIPLICATION_TARGET,
		multiplicative_base_value: upgrade_info.multiplicative_base_value || undefined,
		talents: upgrade_info.talents || undefined,
		current_count: upgrade_info.count || undefined,
		increment: upgrade_info.increment || undefined,
	};

	if (is_generic_upgrade) {
		default_definition.generic_specials = {};
		Object.entries(upgrade_info.specials).forEach(([special_name, special_value]) => {
			if (!default_definition || special_name.search("fixed_") < 0) default_definition.value = special_value;

			default_definition.generic_specials[special_name] = special_value;
			basic_root.SetDialogVariable(
				special_name,
				GetMultiplyValueDiff(
					upgrade_info,
					hero_idx,
					special_value,
					max_upgrades_count,
					upgrades_count_for_diff,
				),
			);
		});
	}

	upgrades_list.push(default_definition);

	const create_definition = (values, _ability_name) => {
		Object.entries(values).forEach(([linked_upgrade_name, linked_upgrade_value]) => {
			let linked_upgrade_definition = {
				ability_name: _ability_name,
				upgrade_name: linked_upgrade_name,
				operator: OPERATOR.ADD,
				value: linked_upgrade_value,
			};
			if (typeof linked_upgrade_value == "object") {
				linked_upgrade_definition.value = linked_upgrade_value.value;
				if (linked_upgrade_value.operator) linked_upgrade_definition.operator = linked_upgrade_value.operator;

				if (linked_upgrade_value.multiplicative_target !== undefined)
					linked_upgrade_definition.multiplicative_target = linked_upgrade_value.multiplicative_target;

				if (linked_upgrade_value.multiplicative_base_value !== undefined)
					linked_upgrade_definition.multiplicative_base_value =
						linked_upgrade_value.multiplicative_base_value;
			}
			upgrades_list.push(linked_upgrade_definition);
		});
	};

	if (upgrade_info.linked_special_values) {
		create_definition(upgrade_info.linked_special_values, upgrade_info.ability_name);
	}
	if (upgrade_info.linked_abilities) {
		Object.entries(upgrade_info.linked_abilities).forEach(([linked_ability_name, linked_ability_definition]) => {
			create_definition(linked_ability_definition, linked_ability_name);
		});
	}

	let b_first_line_check = false;
	let localized_lines = {};
	const common_ability_name = upgrade_info.ability_name;

	let upgrades_lines = [];

	upgrades_list.forEach((upgrade_definition) => {
		let value = upgrade_definition.value;
		const ability_name = upgrade_definition.ability_name;
		const operator = upgrade_definition.operator;
		const upgrade_name = upgrade_definition.upgrade_name;

		let loc_upgrade = "";
		let multiply_value;
		if (operator == OPERATOR.ADD) {
			value = CalculateUpgradeValue(
				hero_idx,
				value,
				max_upgrades_count - upgrades_count_for_diff,
				upgrade_definition,
			);
		} else if (operator == OPERATOR.MULTIPLY) {
			multiply_value = GetMultiplyValueDiff(
				upgrade_definition,
				hero_idx,
				value,
				max_upgrades_count,
				upgrades_count_for_diff,
			);
		}
		if (b_check_hidden && GameUI.Upgrades.IsHiddenUpgrade(ability_name, upgrade_name)) return;

		localized_lines[ability_name] = localized_lines[ability_name] || {};

		const localize_upgrade = (_ability_name, _upgrade_name, b_check_orb_generic_localize) => {
			let check_localize = (key) => {
				let loc_line = $.Localize(key, basic_root);
				if (loc_line != key) loc_upgrade = loc_line;
			};

			check_localize(`${_upgrade_name}_upgrade`);
			check_localize(`DOTA_Tooltip_ability_${_ability_name}_${_upgrade_name}`);
			check_localize(`upgrade_DOTA_Tooltip_ability_${_ability_name}_${_upgrade_name}`);
			check_localize(`DOTA_Tooltip_ability_${_ability_name.replace("_lua", "")}_${_upgrade_name}`);
			check_localize(`upgrade_DOTA_Tooltip_ability_${_ability_name.replace("_lua", "")}_${_upgrade_name}`);
			if (b_check_orb_generic_localize) {
				check_localize(_upgrade_name);

				if (!b_check_hidden) {
					check_localize(`DOTA_Tooltip_demo_generic_orb_${_upgrade_name}`);
					loc_upgrade = loc_upgrade.replace(/<b>.*<\/b>/, "");
				}
			}
		};

		localize_upgrade(ability_name, upgrade_name);
		if (loc_upgrade == "") localize_upgrade(common_ability_name, upgrade_name);
		if (loc_upgrade == "" && is_generic_upgrade) localize_upgrade(common_ability_name, upgrade_name, true);
		if (!b_check_hidden && loc_upgrade == "") loc_upgrade = upgrade_name;
		if (loc_upgrade == "") return;

		const is_pct = loc_upgrade.charAt(0) == "%";

		loc_upgrade = loc_upgrade.replace(/%|:/g, "").trim();
		if (loc_prefix && !new RegExp(`/${loc_prefix}:\\$/`).test(loc_upgrade)) loc_upgrade += loc_prefix;

		let base_line_localized = $.Localize(
			`#upgrade_description_${value > 0 && reverse_increment.indexOf(upgrade_name) < 0 ? `inc` : `dec`}`,
		);

		// Round the value to two decimal places to avoid floating-point precision issues
		const rounded_value = Math.round((multiply_value || value) * 100) / 100;

		const line = `<b>${UppercaseConvert(loc_upgrade)}</b> ${base_line_localized} <b>${Math.abs(rounded_value)}${
			is_pct ? "%" : ""
		}</b>`;

		const fill_line = (line_label) => {
			const min_rarity = upgrade_info[is_generic_upgrade ? "rarity" : "min_rarity"] || 1;

			upgrades_lines.push(line_label);
			line_label.SetDialogVariable("special_name", loc_upgrade);
			if (b_force_generic_localization)
				line_label.SetDialogVariable("special_name", $.Localize(upgrade_info.upgrade_name, line_label));

			line_label.SetDialogVariable(
				"base_value",
				CalculateUpgradeValue(hero_idx, upgrade_definition.value, 1, upgrade_definition),
			);
			line_label.set_value_by_count = (count) => {
				line_label.SetDialogVariableInt(
					"upgrades_count",
					count / (is_generic_upgrade || !b_check_hidden ? 1 : min_rarity),
				);
				if (b_force_generic_localization) {
					Object.entries(upgrade_definition.generic_specials).forEach(([special_name, special_value]) => {
						let count_tooltip = count;
						if (special_name.search("fixed_") > -1) count_tooltip = 1;

						line_label.SetDialogVariable(
							special_name,
							CalculateUpgradeValue(hero_idx, special_value, count_tooltip, upgrade_definition),
						);

						if (b_force_generic_localization)
							line_label.SetDialogVariable(
								"special_name",
								$.Localize(upgrade_info.upgrade_name, line_label),
							);
					});
				} else
					line_label.SetDialogVariable(
						"total_value",
						`${CalculateUpgradeValue(hero_idx, upgrade_definition.value, count, upgrade_definition)}${
							is_pct ? "%" : ""
						}`,
					);
				basic_root.SetHasClass("BHasUpgrades", count > 0);
				if (upgrade_info.max_count) basic_root.SetHasClass("BFullUpgrade", count >= upgrade_info.max_count);
			};
			line_label.set_value_by_count(is_generic_upgrade ? max_upgrades_count - upgrades_count_for_diff : 0);
			basic_root.AddClass(`MinRarity_${min_rarity}`);

			if (is_generic_upgrade) {
				const generic_image = line_label.FindChildTraverse("GenericIconImage");
				if (generic_image)
					generic_image.SetImage(
						`file://{images}/custom_game/upgrades/generics/${upgrade_name.replace("generic_", "")}.png`,
					);
			}
			basic_root.min_rarity = min_rarity;

			if (upgrade_info.max_count) {
				line_label.AddClass("BHasMaxCountUpgrades");
				let max_count = upgrade_info.max_count;

				if (check_multiplier_for_min_rarity_upgrades) {
					max_count = is_generic_upgrade
						? upgrade_info.max_count
						: Number(upgrade_info.max_count / min_rarity);
				}
				line_label.SetDialogVariable("u_max_count", max_count);
			}
		};

		let line_for_edit = basic_root;

		const create_line_for_edit = (root) => {
			line_for_edit = $.CreatePanel("Panel", root, upgrade_name);
			line_for_edit.BLoadLayoutSnippet(upgrade_value_snippet);
			line_for_edit.SetDialogVariable("value", line);
			line_for_edit.localized_text = line;

			if (!basic_root.first_localized_upgrade) basic_root.first_localized_upgrade = line;

			fill_line(line_for_edit);
		};
		if (root_for_basic_line && !b_first_line_check) create_line_for_edit(root_for_basic_line);

		if (b_first_line_check) {
			if (b_check_repeat_localization_lines && !!localized_lines[ability_name][loc_upgrade]) return;
			create_line_for_edit(additional_root);

			basic_root.AddClass("BHasAdditionalValues");
			if (common_ability_name != ability_name) {
				line_for_edit.AddClass("BLinkedAbility");

				line_for_edit.FindChildTraverse("LinkedAbilityImage").SetAbilityImageToLocalHero(ability_name);
			}

			line_for_edit.AddClass("BLinked");

			let ability_name_for_sort = ability_name;
			if (common_ability_name == ability_name) ability_name_for_sort = "!!!!!";

			line_for_edit.localized_text = `${ability_name_for_sort}_${line}`;
		} else {
			b_first_line_check = true;
			if (!root_for_basic_line) fill_line(line_for_edit);
			if (is_generic_upgrade) {
				const generic_localized_text = $.Localize(`#${upgrade_name}`, line_for_edit);
				if (!basic_root.first_localized_upgrade) basic_root.first_localized_upgrade = generic_localized_text;
				line_for_edit.SetDialogVariable("base_value_desc", generic_localized_text);
			} else {
				if (!basic_root.first_localized_upgrade) basic_root.first_localized_upgrade = line;
				line_for_edit.SetDialogVariable("base_value_desc", line);
			}
		}
		localized_lines[ability_name][loc_upgrade] = true;
	});

	for (const linked_upgrade_for_sort of additional_root.Children().sort((a, b) => {
		return b.localized_text > a.localized_text ? 1 : b.localized_text == a.localized_text ? 0 : -1;
	})) {
		additional_root.MoveChildBefore(linked_upgrade_for_sort, additional_root.GetChild(0));
	}

	let linked_chd_counter = 0;
	for (const linked_upgrade of additional_root.Children())
		linked_upgrade.AddClass(`LinkedChd_${linked_chd_counter++}`);

	return upgrades_lines;
}