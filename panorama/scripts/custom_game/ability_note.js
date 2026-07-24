--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var base;
var tooltipManager;
var ability_tooltip;
var details;
var ad_label;
var ad_scepter_container;
var ad_scepter_label;
var ad_shard_container;
var ad_shard_label;
var ability_name;
var ability;
var ad_container;
var prev_ability_name;
var prev_time;
var prev_height;
var screen_height;
var l_arrow, r_arrow;

var registered_abilities = {};
var registered_abilities_list = {};// 存技能的index，abilityname对应index
var ability_key_values = {};

// const TorturePipeKv = GameUI.CustomUIConfig().TorturePipeKv;

function _ParseHeight(css_line) {
	const values = css_line.slice(css_line.indexOf("(") + 2, css_line.length - 1).split(" ");
	const height = values[1];
	return height.slice(0, height.length - 4);
}

function RegisterHoverableAbility(data) {
	var loc_name = $.Localize("#DOTA_Tooltip_ability_" + data.ability_name).toUpperCase()
	registered_abilities[loc_name.toUpperCase()] = data.ability_name;
	registered_abilities_list[data.ability_name] = data.ability_index;
}

function RequestClientLua(event, data) {
	const client_ability = CustomNetTables.GetTableValue("common", "client_ability");
	if (!client_ability) {
		return;
	}

	const ability_index = client_ability._;
	if (typeof ability_index != "number" || !Entities.IsValidEntity(ability_index)) {
		return;
	}

	GameEvents.SendEventClientSide("client_request_event", {
		event: event,
		data: JSON.stringify(data),
	});
	const result = Abilities.GetAbilityTextureName(ability_index);
	try {
		return JSON.parse(result);
	} catch (error) {
		return;
	}
}

function GetAbilityKeyValuesFromLua(ability_name) {
	if (ability_key_values[ability_name] != undefined) {
		return ability_key_values[ability_name];
	}

	const result = RequestClientLua("get_ability_key_values", { ability_name: ability_name });
	if (result && result.ability_key_values && typeof result.ability_key_values == "object") {
		ability_key_values[ability_name] = result.ability_key_values;
		return ability_key_values[ability_name];
	}
}

// real magic begins here, since tooltip is moved with translate3d instead of position set,
// we need to parse height value and reduce it to accomodate tooltip height changes
// but only if tooltip actually overflowing screen
function RealignTooltipBlock(fast_hover, value) {
	const parsed_height = _ParseHeight(ability_tooltip.style.transform);
	const float_value = parseFloat(parsed_height);
	let ad_content_height = value;
	if (!ad_content_height) {
		ad_content_height = ad_container.contentheight;
	}

	if (float_value + ability_tooltip.contentheight > screen_height && !fast_hover) {
		ability_tooltip.style.transform = ability_tooltip.style.transform
			.replace(parsed_height, float_value - ad_content_height)
			.replace(/x /g, "x,");

		// same goes for arrows, but only if they are visible
		// also style string from .transform is returned without commas
		// but setter for .transform requires them, otherwise throws errors
		// splendid system!
		if (l_arrow.visible) {
			const l_arrow_height = _ParseHeight(l_arrow.style.transform);
			l_arrow.style.transform = l_arrow.style.transform
				.replace(l_arrow_height, parseFloat(l_arrow_height) + ad_content_height)
				.replace(/x /g, "x,");
		}
		if (r_arrow.visible) {
			const r_arrow_height = _ParseHeight(r_arrow.style.transform);
			r_arrow.style.transform = r_arrow.style.transform
				.replace(r_arrow_height, parseFloat(r_arrow_height) + ad_content_height)
				.replace(/x /g, "x,");
		}
		return ad_content_height;
	}
}

function TooltipTextChanged(data) {
	const new_text = ability_name.text;
	const fast_hover = Game.GetGameTime() - prev_time < 0.1;
	let AbilityName = registered_abilities[new_text]
	// filter calls that occur too fast (cause for some reason LocalizationChanged triggers 2 times per actual change)
	// and only if they have same name
	if (prev_ability_name == new_text && fast_hover) {
		return;
	}
	if (prev_height) {
		RealignTooltipBlock(fast_hover, -prev_height);
		prev_height = undefined;
	}

	if (!(new_text in registered_abilities)) {
		ability_tooltip.SetHasClass("AbilityDraftDetails", false);
		return;
	}
	let AbilityKv = GetAbilityKeyValuesFromLua(AbilityName);

	const ad_note_loc_token = `#DOTA_Tooltip_ability_${registered_abilities[new_text]}_ability_note`;
	let ad_note_loc_string = $.Localize(ad_note_loc_token);

	for (const abilityName in GameUI.CustomUIConfig().TorturePipeKv) {
		if (abilityName == registered_abilities[new_text]) {
			if (ad_note_loc_string == ad_note_loc_token) {
				ad_note_loc_string = ""
			}
			else {
				ad_note_loc_string + "\n"
			}
			ad_note_loc_string += $.Localize("#DOTA_AbilityTooltip_TorturePipe")
			break
		}
	}
	for (const abilityName in GameUI.CustomUIConfig().NoSpellAmpKv) {
		if (abilityName == registered_abilities[new_text]) {
			if (ad_note_loc_string == ad_note_loc_token) {
				ad_note_loc_string = ""
			}
			else {
				ad_note_loc_string + "\n"
			}
			ad_note_loc_string += $.Localize("#DOTA_AbilityTooltip_SkyStaff")
			break
		}
	}
	for (const abilityName in GameUI.CustomUIConfig().SealingAbilitiesKv) {
		if (abilityName == registered_abilities[new_text]) {
			if (ad_note_loc_string == ad_note_loc_token) {
				ad_note_loc_string = ""
			}
			else {
				ad_note_loc_string + "\n"
			}
			ad_note_loc_string += $.Localize("#DOTA_AbilityTooltip_Sealing")
			break
		}
	}
	for (const abilityName in GameUI.CustomUIConfig().ReflectionAbilitiesKv) {
		if (abilityName == registered_abilities[new_text]) {
			if (ad_note_loc_string == ad_note_loc_token) {
				ad_note_loc_string = ""
			}
			else {
				ad_note_loc_string + "\n"
			}
			ad_note_loc_string += $.Localize("#DOTA_AbilityTooltip_Reflection")
			break
		}
	}
	const ad_note_localized = ad_note_loc_token != ad_note_loc_string;

	if (ad_note_localized) {
		ad_note_loc_string = GameUI.ReplaceDOTAAbilitySpecialValues(registered_abilities[new_text], ad_note_loc_string); // Technically probably not needed, but just in case some ability will have an ability special somehow. Can't hurt ;)
		ad_label.SetDialogVariable("ability_draft_note", ad_note_loc_string);
		ad_label.style.visibility = "visible";
	} else {
		ad_label.style.visibility = "collapse";
	}
	const ad_scepter_loc_token = `#DOTA_Tooltip_ability_${registered_abilities[new_text]}_scepter_description`;
	let ad_scepter_loc_string = $.Localize(ad_scepter_loc_token);
	const ad_scepter_localized = ad_scepter_loc_token != ad_scepter_loc_string && ad_scepter_loc_string != "" && AbilityKv && AbilityKv.HasScepterUpgrade == "1";
	if (ad_scepter_localized) {
		ad_scepter_loc_string = ReplaceScepterShardKeyValues(registered_abilities[new_text], "special_bonus_scepter", ad_scepter_loc_string);
		// ad_scepter_loc_string = GameUI.ReplaceDOTAAbilitySpecialValues(
		// 	registered_abilities[new_text],
		// 	ad_scepter_loc_string,
		// );
		ad_scepter_container.style.visibility = "visible";
		ad_scepter_label.SetDialogVariable("ability_draft_scepter", ad_scepter_loc_string);
	} else {
		ad_scepter_container.style.visibility = "collapse";
	}

	const ad_shard_loc_token = `#DOTA_Tooltip_ability_${registered_abilities[new_text]}_shard_description`;
	let ad_shard_loc_string = $.Localize(ad_shard_loc_token);
	const ad_shard_localized = ad_shard_loc_token != ad_shard_loc_string && ad_shard_loc_string != "" && AbilityKv && AbilityKv.HasShardUpgrade == "1";
	if (ad_shard_localized) {
		ad_shard_loc_string = ReplaceScepterShardKeyValues(registered_abilities[new_text], "special_bonus_shard", ad_shard_loc_string);
		// ad_shard_loc_string = GameUI.ReplaceDOTAAbilitySpecialValues(
		// 	registered_abilities[new_text],
		// 	ad_shard_loc_string,
		// );
		ad_shard_container.style.visibility = "visible";
		ad_shard_label.SetDialogVariable("ability_draft_shard", ad_shard_loc_string);
	} else {
		ad_shard_container.style.visibility = "collapse";
	}



	const ad_block_present = ad_note_localized || ad_scepter_localized || ad_shard_localized;

	if (ad_block_present) {
		$.Schedule(Game.GetGameFrameTime(), () => {
			prev_height = RealignTooltipBlock(fast_hover);
		});
	} else {
		prev_height = undefined;
	}

	ability_tooltip.SetHasClass("AbilityDraftDetails", ad_block_present);
	prev_ability_name = new_text;
	prev_time = Game.GetGameTime();
}
function Init() {
	if (!base) {
		base = dotaHud;
	}
	if (!tooltipManager) {
		tooltipManager = base.FindChildTraverse("Tooltips");
	}
	ability_tooltip = tooltipManager.FindChildTraverse("DOTAAbilityTooltip");
	if (!ability_tooltip) {
		// tooltip for ability initializes first time ability is hovered
		$.Schedule(0.3, Init); // so search for it is not that reliable without retries
		return;
	}
	details = ability_tooltip.FindChildrenWithClassTraverse("TooltipRow")[0];
	l_arrow = details.GetChild(0);
	r_arrow = details.GetChild(2);
	details = details.GetChild(1);
	details = details.FindChildTraverse("AbilityDetails");
	ad_container = details.FindChildTraverse("AbilityDraftDescriptionContainer");
	ad_label = ad_container.GetChild(3);
	ability_name = details.FindChildTraverse("AbilityName");

	ad_scepter_container = details.FindChildTraverse("ScepterDesc");
	ad_scepter_label = ad_scepter_container.GetChild(1);

	ad_shard_container = details.FindChildTraverse("ShardDesc");
	ad_shard_label = ad_shard_container.GetChild(1);

	const header = details.FindChildTraverse("AbilityName");
	screen_height = Game.GetScreenHeight();
	$.RegisterEventHandler("LocalizationChanged", header, function () {
		$.Schedule(0.01, TooltipTextChanged);
	});
}

function PortraitUnitChanged() {
	const unit = Players.GetLocalPlayerPortraitUnit();
	if (!Entities.IsRealHero(unit)) {
		return;
	}
	for (i = 0; i < Entities.GetAbilityCount(unit); i++) {
		const ability = Entities.GetAbility(unit, i);
		if (ability && ability != -1 && !Abilities.IsHidden(ability)) {
			const ability_name = Abilities.GetAbilityName(ability);
			if (ability_name.match("special_bonus")) {
				continue;
			}
			RegisterHoverableAbility({
				ability_name: ability_name,
				ability_index: ability,
			});
		}
	}
}

function FormatAbilityKeyValue(value) {
	return String(value).replace(/[+-]?\d+\.\d+/g, function (number) {
		return number.replace(/0+$/, "").replace(/\.$/, "");
	});
}

function DescReplace(Desc, key, value) {
	return Desc.replace(key, "<font color='#ffffff'>" + FormatAbilityKeyValue(value) + "</font>")
}

function ReplaceScepterShardKeyValues(sName, DescType, Desc) {
	let AbilityKv = GetAbilityKeyValuesFromLua(sName)
	if (!AbilityKv) {
		return Desc;
	}
	let keys = Desc.match(/\%[a-zA-Z_]+\%/g)
	if (!keys) {
		return Desc;
	}
	let special_prefix = [
		"shard_",
		"bonus_",
		"scepter_",
	]

	for (const i in keys) {
		let key_name = keys[i].replace(/\%/g, "")
		let kv
		let bRepalced = false

		//预处理key的名字
		if (key_name == 'abilitycastrange') {
			key_name = "AbilityCastRange"
		}
		else if (key_name == 'abilitycooldown') {
			key_name = "AbilityCooldown"
		}
		else if (key_name == 'abilitymanacost') {
			key_name = "AbilityManaCost"

		}

		//基本键名尝试直接取值
		if (AbilityKv[key_name] != undefined) {
			// Desc = Desc.replace(keys[i], AbilityKv[key_name])
			Desc = DescReplace(Desc, keys[i], AbilityKv[key_name])
			bRepalced = true
		}

		if (!bRepalced) {
			if (AbilityKv.AbilitySpecial != null) {
				kv = AbilityKv.AbilitySpecial
				for (const index in kv) {
					if (kv[index][key_name] != undefined) {
						// Desc = Desc.replace(keys[i], kv[index][key_name])
						Desc = DescReplace(Desc, keys[i], kv[index][key_name])
						break
					}
				}
			}
			else if (AbilityKv.AbilityValues != null) {
				kv = AbilityKv.AbilityValues

				if (kv[key_name] != undefined) {
					let value = ""
					let original_value = kv[key_name].value ?? 0
					let bonus_value = String(kv[key_name][DescType]) ?? 0

					if (kv[key_name] != undefined && typeof kv[key_name] == "number") {
						value = String(kv[key_name])
					}
					else if (kv[key_name][DescType] != undefined) {
						if (bonus_value.indexOf("%") != -1) {
							//含有百分比的要进行运算
							bonus_value = bonus_value.replace("+", "")
							bonus_value = bonus_value.replace("-", "")
							bonus_value = bonus_value.replace("%", "")
							bonus_value = bonus_value.replace("x", "")
							value = String(original_value * Number(bonus_value) * 0.01)
						}
						else {
							value = String(kv[key_name][DescType])
						}
					}
					else if (kv[key_name].value != undefined) {
						value = String(kv[key_name].value)
					}
					value = value.replace("+", "")
					value = value.replace("-", "")
					value = value.replace("%", "")
					value = value.replace("x", "")

					// Desc = Desc.replace(keys[i], value)
					Desc = DescReplace(Desc, keys[i], value)
					bRepalced = true
				}

				if (!bRepalced) {
					for (let j = 0; j < special_prefix.length; j++) {
						let prefix = special_prefix[j];
						if (kv[key_name.replace(prefix, "")] != undefined) {
							let value = ""
							let original_value_array = (String(kv[key_name.replace(prefix, "")].value) ?? "0").split(" ")
							let original_value = original_value_array[0]
							let bonus_value = String(kv[key_name.replace(prefix, "")][DescType]) ?? "0"

							if (bonus_value.indexOf("%") != -1 && original_value_array.length <= 1) {
								//含有百分比的要进行运算
								bonus_value = bonus_value.replace("+", "")
								bonus_value = bonus_value.replace("-", "")
								bonus_value = bonus_value.replace("%", "")
								bonus_value = bonus_value.replace("x", "")
								value = String(Number(original_value) * Number(bonus_value) * 0.01)
							}
							else {
								value = bonus_value
							}
							value = value.replace("+", "")
							value = value.replace("-", "")
							value = value.replace("%", "")
							value = value.replace("x", "")

							// Desc = Desc.replace(keys[i], value)
							Desc = DescReplace(Desc, keys[i], value)
							bRepalced = true
							break
						}
					}
				}

			}
		}
	}
	Desc = Desc.replace(/\%\%/g, "<font color='#ffffff'>%</font>")

	return Desc
}

(function () {


	$.Schedule(2, function () {
		GameEvents.Subscribe("RegisterHoverableAbility", RegisterHoverableAbility);
		GameEvents.Subscribe("dota_portrait_ability_layout_changed", PortraitUnitChanged);
		GameEvents.Subscribe("dota_player_update_selected_unit", PortraitUnitChanged);
	});
	$.Schedule(1, function () {
		Init();
	});
})();
