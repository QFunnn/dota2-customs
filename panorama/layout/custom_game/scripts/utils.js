--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LOCAL_PLAYER_ID = Game.GetLocalPlayerID();
const LOCAL_STEAM_ID = Game.GetLocalPlayerInfo() ? Game.GetLocalPlayerInfo().player_steamid : "0";
const MAP_NAME = Game.GetMapInfo().map_display_name;

Object.defineProperties(Array.prototype, {
	random: {
		value: function () {
			return this[Math.floor(Math.random() * this.length)];
		},
	},
	includes: {
		value: function (searchElement, fromIndex) {
			return this.indexOf(searchElement, fromIndex) !== -1;
		},
	},
});

Object.defineProperties(String.prototype, {
	format: {
		value: function () {
			var args = arguments;
			return this.replace(/{(\d+)}/g, function (match, number) {
				return typeof args[number] != "undefined" ? args[number] : match;
			});
		},
	},
	includes: {
		value: function (searchString, position) {
			return this.indexOf(searchString, position) !== -1;
		},
	},
});

function SetInterval(callback, interval) {
	interval = interval / 1000;
	$.Schedule(interval, function reschedule() {
		$.Schedule(interval, reschedule);
		callback();
	});
}

function SubscribeToNetTableKey(tableName, key, callback) {
	var immediateValue = CustomNetTables.GetTableValue(tableName, key) || {};
	if (immediateValue != null) callback(immediateValue);
	CustomNetTables.SubscribeNetTableListener(tableName, function (_tableName, currentKey, value) {
		if (currentKey === key && value != null) callback(value);
	});
}

const FindDotaHudElement = (id) => dotaHud.FindChildTraverse(id);
const dotaHud = (() => {
	let panel = $.GetContextPanel();
	while (panel) {
		if (panel.id === "DotaHud") return panel;
		panel = panel.GetParent();
	}
})();
const RootParentCheck = (panel, check_id) => {
	panel = panel.GetParent();
	if ((panel?.id || "") == check_id) return true;
	while (panel) {
		panel = panel.GetParent();
		if ((panel?.id || "") == check_id) return true;
	}
	return false;
};

var useChineseDateFormat = $.Language() === "schinese" || $.Language() === "tchinese";
/** @param {Date} date */
function formatDate(date) {
	return useChineseDateFormat
		? date.getFullYear() + "-" + date.getMonth() + "-" + date.getDate()
		: date.getMonth() + "/" + date.getDate() + "/" + date.getFullYear();
}

let boostGlow = false;
let glowSchelude;
const CENTER_SCREEN_MENUS = ["CollectionDotaU"];

function _GetVarFromUniquePortraitsData(player_id, hero_name, path) {
	const unique_portraits = CustomNetTables.GetTableValue("game_state", "portraits");

	if (unique_portraits && unique_portraits[`${hero_name}${player_id}`]) {
		return `${path}${unique_portraits[`${hero_name}${player_id}`]}.png`;
	} else {
		return `${path}${hero_name}.png`;
	}
}

function GetPortraitImage(player_id, hero_name) {
	return _GetVarFromUniquePortraitsData(player_id, hero_name, "file://{images}/heroes/");
}
function GetPortraitIcon(player_id, hero_name) {
	return _GetVarFromUniquePortraitsData(player_id, hero_name, "file://{images}/heroes/icons/");
}

let colors_exceptions = {
	[-1]: "#ffffffff",
};
function GetHEXPlayerColor(player_id) {
	let player_color = Players.GetPlayerColor(player_id).toString(16);
	if (colors_exceptions[player_id]) player_color = colors_exceptions[player_id];

	return player_color == null
		? "#000000"
		: "#" +
				player_color.substring(6, 8) +
				player_color.substring(4, 6) +
				player_color.substring(2, 4) +
				player_color.substring(0, 2);
}

function LocalizeWithValues(line, kv) {
	let result = $.Localize(line);
	Object.entries(kv).forEach(([k, v]) => {
		result = result.replace(`%%${k}%%`, v);
	});
	return result;
}

function Stacktrace(name) {
	$.Msg(new Error(name).stack);
}
function FormatBigNumber(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function GetModifierStackCount(unit_index, m_name) {
	for (var i = 0; i < Entities.GetNumBuffs(unit_index); i++) {
		var buff_name = Buffs.GetName(unit_index, Entities.GetBuff(unit_index, i));
		if (buff_name == m_name) {
			return Buffs.GetStackCount(unit_index, Entities.GetBuff(unit_index, i));
		}
	}
}

JSON.print = (object) => {
	let result_string;
	try {
		result_string = JSON.stringify(
			object,
			(key, value) => {
				return value;
			},
			"	",
		);
	} catch (e) {
		$.Msg(e);
	}
	let result_array = result_string.split("\n");
	while (result_array.length) {
		$.Msg(result_array.splice(0, 50).join("\n"));
	}
};
Math.clamp = function (num, min, max) {
	return this.min(this.max(num, min), max);
};

Math.float_interpolate = function (min, max, float) {
	return Math.round(min + (max - min) * float);
};

const _default_context_for_localization = $.GetContextPanel();
if (!$.LocalizeEngine) {
	$.LocalizeEngine = $.Localize;
	$.Localize = function (text, panel) {
		if (typeof text == "number") text = Math.round(text).toString();

		const token = text.startsWith("#") ? text : `#${text}`;
		const localized_text = $.LocalizeEngine(token, panel || _default_context_for_localization);
		return localized_text == token ? token.substring(1) : localized_text;
	};
}
function FormatSeconds(v, b_hours) {
	let hours = 0;
	if (b_hours) {
		hours = Math.floor(v / 3600);
		v = v - 3600 * hours;
	}
	const minutes = Math.floor(v / 60);
	v = v - 60 * minutes;
	return `${b_hours ? hours.toString() + ":" : ""}${minutes.toString().padStart(2, "0")}:${Math.floor(v)
		.toString()
		.padStart(2, "0")}`;
}

function IsSpectating() {
	return (
		(Game.GetLocalPlayerInfo() &&
			Game.GetLocalPlayerInfo().player_team_id &&
			Game.GetLocalPlayerInfo().player_team_id == 1) ||
		!Game.GetLocalPlayerInfo()
	);
}

function Distance2D(A, B) {
	const x_diff = A[0] - B[0];
	const y_diff = A[1] - B[1];
	return Math.sqrt(x_diff * x_diff + y_diff * y_diff);
}

Game.GetTeamScore = function (team) {
	const nt = CustomNetTables.GetTableValue("game_state", "team_score");

	if (!nt || !nt[team]) return 0;

	return nt[team];
};

function _Notify(listeners_array, data) {
	// filter invalid callbacks out
	listeners_array = listeners_array.filter((item) => {
		return typeof item == "function";
	});
	for (const callback of listeners_array) {
		try {
			callback(data);
		} catch (e) {
			$.Msg("Error in _Notify: ", e);
		}
	}
}
Object.fromEntries = (entries) => {
	let result_object = {};
	for (let [key, value] of entries) {
		result_object[key] = value;
	}
	return result_object;
};

function BuildTooltipParams(object) {
	let array = [];
	Object.entries(object).forEach(([k, v]) => {
		if (k && v) {
			v = typeof v == "object" ? JSON.stringify(v) : v.toString();
			array.push(`${k.toString()}=${v}`);
		}
	});
	return array.join("&");
}

function RandomInt(min, max) {
	let rand = min + Math.random() * (max + 1 - min);
	return Math.floor(rand);
}

function HasModifierByName(unit_ent_idx, name) {
	for (var i = 0; i < Entities.GetNumBuffs(unit_ent_idx); i++) {
		var buffName = Buffs.GetName(unit_ent_idx, Entities.GetBuff(unit_ent_idx, i));

		if (buffName == name) return true;
	}

	return false;
}

Entities.HasShard = function (unit) {
	return HasModifierByName(unit, "modifier_item_aghanims_shard");
};

function GetChildByPath(parent, ...child_path) {
	for (const id of child_path) {
		parent = parent.GetChild(id);
		if (!parent) return;
	}
	return parent;
}

Object.defineProperties(Object.prototype, {
	IsDOTAAbilityImage: {
		value: function () {
			return this.type === "DOTAAbilityImage";
		},
	},
	SetAbilityImage: {
		value: function (ability_entity_idx) {
			if (!this.IsDOTAAbilityImage()) return;

			const ability_name = Abilities.GetAbilityName(ability_entity_idx);
			if (ability_name) this.abilityname = ability_name;
			this.contextEntityIndex = ability_entity_idx;

			// const texture = Abilities.GetAbilityTextureName(ability_entity_idx || -1);
			// if (texture) {
			// 	this.SetImage("");
			// 	this.style.backgroundSize = "100%";
			// 	this.SetImage(`raw://resource/flash3/images/spellicons/${texture}.png`);
			//
			// 	let default_path = `url("s2r://panorama/images/spellicons/${texture}_png.vtex")`;
			//
			// 	this.style.backgroundImage = default_path;
			// }
		},
	},
	SetAbilityImageToPlayer: {
		value: function (player_id, ability_name) {
			if (!this.IsDOTAAbilityImage()) return;

			this.abilityname = ability_name;

			const player_info = Game.GetPlayerInfo(player_id);
			if (!player_info) return;

			const hero_ent_idx = player_info.player_selected_hero_entity_index;
			if (!hero_ent_idx) return;

			this.SetAbilityImage(Entities.GetAbilityByName(hero_ent_idx, ability_name));
		},
	},
	SetAbilityImageToLocalHero: {
		value: function (ability_name) {
			if (!this.IsDOTAAbilityImage()) return;

			this.SetAbilityImageToPlayer(LOCAL_PLAYER_ID, ability_name);
		},
	},
});

function EscapeHTML(string) {
	return string.replace(
		/[&<>'"]/g,
		(tag) =>
			({
				"&": "&amp;",
				"<": "&lt;",
				">": "&gt;",
				"'": "&#39;",
				'"': "&quot;",
			}[tag] || tag),
	);
}

const _context = $.GetContextPanel();
_context.custom_tickers = _context.custom_tickers || {};
class CustomTicker {
	constructor(name, refresh_rate) {
		this.name = name;
		if (_context.custom_tickers[name]) _context.custom_tickers[name].RemoveSelf();
		_context.custom_tickers[name] = this;

		this.refresh_rate = refresh_rate;
		this.callbacks = {};
		this.pause = false;
		this.pause_delay_schedule = undefined;
		this.Update();
	}
	Update() {
		if (this.interrupt) return;

		if (!this.pause)
			Object.values(this.callbacks).forEach((_function) => {
				_function();
			});
		$.Schedule(this.refresh_rate, () => {
			this.Update();
		});
	}
	Add(name, callback) {
		this.callbacks[name] = callback;
	}
	Remove(name) {
		if (this.callbacks[name]) delete this.callbacks[name];
	}
	SetPause(state) {
		this.pause = state;
	}
	PauseIn(delay_for_pause) {
		if (this.pause_delay_schedule !== undefined) $.CancelScheduled(this.pause_delay_schedule);

		this.pause_delay_schedule = $.Schedule(delay_for_pause, () => {
			this.SetPause(true);
			this.pause_delay_schedule = undefined;
		});
	}
	SetRefreshRate(refresh_rate) {
		this.refresh_rate = refresh_rate;
	}
	RemoveSelf() {
		this.callbacks = {};
		this.interrupt = true;
		delete _context.custom_tickers[this.name];
	}
}

function DefaultChildrenSort(root, param_name, reverse) {
	for (const child of root.Children().sort((a, b) => {
		const av = Number(a[param_name]) || String(a[param_name]);
		const bv = Number(b[param_name]) || String(b[param_name]);

		if (typeof av == "string" && typeof bv == "string") return av == bv ? 0 : (av < bv) ^ reverse ? -1 : 1;

		if (reverse) return (bv || 0) - (av || 0);
		return (av || 0) - (bv || 0);
	})) {
		root.MoveChildBefore(child, root.GetChild(0));
	}
}

Math.rd = (num, chars_after_dot = 0) => {
	const rd_n = Math.pow(10, chars_after_dot);
	return Math.round(num * rd_n) / rd_n;
};

function CSSLineToObjectCamelCase(style_string) {
	return style_string.split(";").reduce((obj, declaration) => {
		const [prop, val] = declaration.split(":").map((part) => part.trim());
		if (prop && val) obj[prop.replace(/-([a-z])/g, (_, l) => l.toUpperCase())] = val + ";";
		return obj;
	}, {});
}

function GenerateSublines(container, max_childs_per_line, margin_b_lines = 0, margin_b_childs = 0) {
	container.RemoveAndDeleteChildren();
	let line;
	let counter = 0;
	let line_counter = 0;
	container.style.flowChildren = "down";

	const check_line = () => {
		if (!line || counter >= max_childs_per_line) {
			line = $.CreatePanel("Panel", container, "");
			line.style.flowChildren = "right";
			line.style.horizontalAlign = "center";
			if (margin_b_lines > 0 && line_counter > 0) line.style.marginTop = `${margin_b_lines}px`;
			counter = 0;
			line_counter++;
		}
	};
	return {
		add: function (child) {
			check_line();
			counter++;
			child.SetParent(line);
			for (const [k, v] of Object.entries(CSSLineToObjectCamelCase(this.style()))) child.style[k] = v;
		},
		style: function () {
			const style = [margin_b_childs > 0 && counter > 1 ? `margin-left: ${margin_b_childs}px` : undefined].filter(
				(s) => s != undefined,
			);
			return style.length > 0 ? `${style.join(";")};` : "";
		},
		create: function (type, id = "", props = {}) {
			const line = this.line();
			props.style = (props.style || "") + this.style();
			return $.CreatePanel(type, line, id, props);
		},
		line: () => {
			check_line();
			counter++;
			return line;
		},
	};
}

const heroes_ids = {
	npc_dota_hero_antimage: 1,
	npc_dota_hero_axe: 2,
	npc_dota_hero_bane: 3,
	npc_dota_hero_bloodseeker: 4,
	npc_dota_hero_crystal_maiden: 5,
	npc_dota_hero_drow_ranger: 6,
	npc_dota_hero_earthshaker: 7,
	npc_dota_hero_juggernaut: 8,
	npc_dota_hero_mirana: 9,
	npc_dota_hero_nevermore: 11,
	npc_dota_hero_morphling: 10,
	npc_dota_hero_phantom_lancer: 12,
	npc_dota_hero_puck: 13,
	npc_dota_hero_pudge: 14,
	npc_dota_hero_razor: 15,
	npc_dota_hero_sand_king: 16,
	npc_dota_hero_storm_spirit: 17,
	npc_dota_hero_sven: 18,
	npc_dota_hero_tiny: 19,
	npc_dota_hero_vengefulspirit: 20,
	npc_dota_hero_windrunner: 21,
	npc_dota_hero_zuus: 22,
	npc_dota_hero_kunkka: 23,
	npc_dota_hero_lina: 25,
	npc_dota_hero_lich: 31,
	npc_dota_hero_lion: 26,
	npc_dota_hero_shadow_shaman: 27,
	npc_dota_hero_slardar: 28,
	npc_dota_hero_tidehunter: 29,
	npc_dota_hero_witch_doctor: 30,
	npc_dota_hero_riki: 32,
	npc_dota_hero_enigma: 33,
	npc_dota_hero_tinker: 34,
	npc_dota_hero_sniper: 35,
	npc_dota_hero_necrolyte: 36,
	npc_dota_hero_warlock: 37,
	npc_dota_hero_beastmaster: 38,
	npc_dota_hero_queenofpain: 39,
	npc_dota_hero_venomancer: 40,
	npc_dota_hero_faceless_void: 41,
	npc_dota_hero_skeleton_king: 42,
	npc_dota_hero_death_prophet: 43,
	npc_dota_hero_phantom_assassin: 44,
	npc_dota_hero_pugna: 45,
	npc_dota_hero_templar_assassin: 46,
	npc_dota_hero_viper: 47,
	npc_dota_hero_luna: 48,
	npc_dota_hero_dragon_knight: 49,
	npc_dota_hero_dazzle: 50,
	npc_dota_hero_rattletrap: 51,
	npc_dota_hero_leshrac: 52,
	npc_dota_hero_furion: 53,
	npc_dota_hero_life_stealer: 54,
	npc_dota_hero_dark_seer: 55,
	npc_dota_hero_clinkz: 56,
	npc_dota_hero_omniknight: 57,
	npc_dota_hero_enchantress: 58,
	npc_dota_hero_huskar: 59,
	npc_dota_hero_night_stalker: 60,
	npc_dota_hero_broodmother: 61,
	npc_dota_hero_bounty_hunter: 62,
	npc_dota_hero_weaver: 63,
	npc_dota_hero_jakiro: 64,
	npc_dota_hero_batrider: 65,
	npc_dota_hero_chen: 66,
	npc_dota_hero_spectre: 67,
	npc_dota_hero_doom_bringer: 69,
	npc_dota_hero_ancient_apparition: 68,
	npc_dota_hero_ursa: 70,
	npc_dota_hero_spirit_breaker: 71,
	npc_dota_hero_gyrocopter: 72,
	npc_dota_hero_alchemist: 73,
	npc_dota_hero_invoker: 74,
	npc_dota_hero_silencer: 75,
	npc_dota_hero_obsidian_destroyer: 76,
	npc_dota_hero_lycan: 77,
	npc_dota_hero_brewmaster: 78,
	npc_dota_hero_shadow_demon: 79,
	npc_dota_hero_lone_druid: 80,
	npc_dota_hero_chaos_knight: 81,
	npc_dota_hero_meepo: 82,
	npc_dota_hero_treant: 83,
	npc_dota_hero_ogre_magi: 84,
	npc_dota_hero_undying: 85,
	npc_dota_hero_rubick: 86,
	npc_dota_hero_disruptor: 87,
	npc_dota_hero_nyx_assassin: 88,
	npc_dota_hero_naga_siren: 89,
	npc_dota_hero_keeper_of_the_light: 90,
	npc_dota_hero_wisp: 91,
	npc_dota_hero_visage: 92,
	npc_dota_hero_slark: 93,
	npc_dota_hero_medusa: 94,
	npc_dota_hero_troll_warlord: 95,
	npc_dota_hero_centaur: 96,
	npc_dota_hero_magnataur: 97,
	npc_dota_hero_shredder: 98,
	npc_dota_hero_bristleback: 99,
	npc_dota_hero_tusk: 100,
	npc_dota_hero_skywrath_mage: 101,
	npc_dota_hero_abaddon: 102,
	npc_dota_hero_elder_titan: 103,
	npc_dota_hero_legion_commander: 104,
	npc_dota_hero_techies: 105,
	npc_dota_hero_ember_spirit: 106,
	npc_dota_hero_earth_spirit: 107,
	npc_dota_hero_abyssal_underlord: 108,
	npc_dota_hero_terrorblade: 109,
	npc_dota_hero_phoenix: 110,
	npc_dota_hero_oracle: 111,
	npc_dota_hero_winter_wyvern: 112,
	npc_dota_hero_arc_warden: 113,
	npc_dota_hero_monkey_king: 114,
	npc_dota_hero_dark_willow: 119,
	npc_dota_hero_pangolier: 120,
	npc_dota_hero_grimstroke: 121,
	npc_dota_hero_hoodwink: 123,
	npc_dota_hero_void_spirit: 126,
	npc_dota_hero_snapfire: 128,
	npc_dota_hero_mars: 129,
	npc_dota_hero_dawnbreaker: 135,
	npc_dota_hero_marci: 136,
	npc_dota_hero_primal_beast: 137,
	npc_dota_hero_muerta: 138,
	npc_dota_hero_largo: 155,
	npc_dota_hero_ringmaster: 131,

	//Custom heroes

	// npc_angel_arena_hero_joe_black: 200,
	// npc_angel_arena_hero_hola: 201,
	// npc_angel_arena_hero_satan: 202,
	// npc_angel_arena_hero_charon: 203,
};
const heroes_names_by_ids = Object.fromEntries(Object.entries(heroes_ids).map((a) => a.reverse()));
function GetHeroID(hero_name) {
	return heroes_ids[hero_name] || -1;
}
function GetHeroName(hero_id) {
	return heroes_names_by_ids[hero_id] || "";
}

function CheckLocalize(key) {
	let loc_line = $.CanLocalize(key) && $.Localize(key);
	return loc_line;
}
function CheckLocalizeArray(keys_array, default_value) {
	let result = default_value;

	for (const key of keys_array) {
		if (!key) continue;

		const l = CheckLocalize(key);
		if (!!l) result = l;
	}

	return result;
}

function LocalizeChatPhrase(phrase) {
	return CheckLocalizeArray(
		[
			phrase,
			phrase.replace(/^chat_wheel_/, ""),
			phrase.replace(/^c_chat_wheel_/, ""),
			`dota_chatwheel_label_${phrase}`,
			`dota_chatwheel_label_${phrase.replace("npc_dota_hero_", "")}`,
			`dota_chatwheel_label_${phrase.replace(/^chat_wheel_/, "")}`,
		],
		phrase,
	);
}

function CreateSubChannelsCW(label, color_name) {
	for (const c of label.Children()) if (c.BHasClass("CW_SubChannel")) c.DeleteAsync(0);

	const channels = GameUI.Inventory.GetItemDefinition(color_name)?.chat_wheel_details?.channels || -1;
	if (channels <= 1) return;

	$.Schedule(0, () => {
		if (!label.IsValid()) return;
		for (let x = 0; x < channels - 1; x++) {
			$.CreatePanel("Label", label, "", {
				text: label.text,
				class: `CW_SubChannel CW_SubChannel_${x + 1}`,
				hittest: false,
			});
		}
	});
}

// =========================================
// =========================================
// ========== Overthrow 3.0 UTILS ==========
// =========================================
// =========================================

const UPGRADE_TYPE = {
	DEFAULT: 1,
	GENERIC: 2,
};
const RARITY = {
	COMMON: 1,
	RARE: 2,
	EPIC: 4,
};
const OPERATOR = {
	ADD: 1,
	MULTIPLY: 2,
};

function InferAbilityValue(ent_index, upgrade_data) {
	// FIXME: GetSpecialValue and GetLevelSpecialValueFor fetching values with upgrades applied
	// and there's no apparent way to get around this without sending base values from lua, which kinda sucks
	// for now special value is considered 0

	const ability_name = upgrade_data.ability_name;
	const upgrade_name = upgrade_data.upgrade_name;

	if (!ability_name) return 0;
	if (upgrade_name == "cooldown_and_manacost" || ability_name == "generic") return 0;

	const ability = Entities.GetAbilityByName(ent_index, ability_name);
	if (!ability || ability == -1) return 0;

	const value = Abilities.GetLevelSpecialValueFor(ability, upgrade_name, Abilities.GetLevel(ability));

	return value;
}

function CalculateIncrementValue(base_value, upgrade_data, count = 0) {
	let result = base_value * count;

	result = result + (count * ((count - 1) * upgrade_data.increment)) / 2.0;

	return result;
}

function CalculateUpgradeValue(ent_index, value, count, upgrade_data, round = true) {
	upgrade_data.operator = upgrade_data.operator || OPERATOR.ADD;
	let result = 0;
	let final_multiplier = 1;

	if (upgrade_data.talents && ent_index) {
		Object.entries(upgrade_data.talents).forEach(([talent_name, operation]) => {
			let operator, value;
			if (typeof operation == "number") {
				operator = "+";
				value = operation;
			} else {
				operator = operation.charAt(0);
				value = Number(operation.slice(1));
			}
			const talent = Entities.GetAbilityByName(ent_index, talent_name);
			if (Abilities.GetLevel(talent) > 0) {
				if (operator == "+") result += value;
				else if (operator == "x") final_multiplier *= value;
			}
		});
	}

	let upgrade_value = value * final_multiplier;

	if (upgrade_data.operator == OPERATOR.ADD) {
		if (upgrade_data.increment) {
			if (upgrade_data.current_count == undefined) upgrade_data.current_count = 0;
			const total_count = upgrade_data.current_count + count;
			result += upgrade_value * total_count;

			result =
				CalculateIncrementValue(upgrade_value, upgrade_data, total_count) -
				CalculateIncrementValue(upgrade_value, upgrade_data, upgrade_data.current_count);
		} else result += upgrade_value * count;
	} else if (upgrade_data.operator == OPERATOR.MULTIPLY) {
		let target =
			upgrade_data.multiplicative_target !== undefined
				? upgrade_data.multiplicative_target
				: DEFAULT_MULTIPLICATION_TARGET;
		result += upgrade_data.multiplicative_base_value || 0;

		const abs_upgrade_value = Math.abs(upgrade_value / (result - target));
		result = (target - result) * (1 - Math.pow(1 - abs_upgrade_value, count));
	}

	return isNaN(result) ? 0 : round ? Math.rd(result, 2) : result;
}

Game.IsDemoMode = () => {
	return MAP_NAME == "ot3_demo";
};