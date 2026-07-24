--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const NON_BREAKING_SPACE = "\u00A0";
const BASE_MESSAGE_INDENT = "<img src='file://{images}/custom_game/chat_separator.png'/>\u00A0";

const GUILD_TAG_COLORS = {
	[DOTATeam_t.DOTA_TEAM_GOODGUYS]: ["", "#3375FF", "#66FFBF", "#BF00BF", "#F3F00B", "#FF6B00"],
	[DOTATeam_t.DOTA_TEAM_BADGUYS]: ["", "#FE86C2", "#A1B447", "#65D9F7", "#008321", "#A46900"],
};
const DEFAULT_GUILD_TAG_COLOR = "#ffffff";

let PLAYER_GUILD_TAG_COLORS = {};
let GUILD_TAGS = {};

function ParseGuildTagColors(parsed_teams) {
	for (const [team_id, team] of Object.entries(parsed_teams)) {
		for (let [player_serial_n, player_id] of Object.entries(team)) {
			if (!GUILD_TAG_COLORS[team_id]) {
				PLAYER_GUILD_TAG_COLORS[player_id] = DEFAULT_GUILD_TAG_COLOR;
				continue;
			}

			const color_pull = GUILD_TAG_COLORS[team_id];
			if (!color_pull[player_serial_n]) {
				PLAYER_GUILD_TAG_COLORS[player_id] = DEFAULT_GUILD_TAG_COLOR;
				continue;
			}

			PLAYER_GUILD_TAG_COLORS[player_id] = color_pull[player_serial_n];
		}
	}
}

function GetPlayerGuildTagColor(player_id) {
	return PLAYER_GUILD_TAG_COLORS[player_id] || DEFAULT_GUILD_TAG_COLOR;
}

function ParseGuildTags(parsed_teams) {
	ParseGuildTagColors(parsed_teams);

	const _context = $.GetContextPanel();
	for (let player_id = 0; player_id <= 24; player_id++) {
		const player_info = Game.GetPlayerInfo(player_id);
		if (!player_info) continue;

		const temp = $.CreatePanel("DOTAUserName", _context, "", {
			steamid: player_info.player_steamid,
			style: "visibility:collapse;",
		});
		$.Schedule(2, () => {
			const full_name = temp.GetChild(0).text;
			GUILD_TAGS[player_id] = full_name.replace(player_info.player_name, "").trim();
			temp.DeleteAsync(0);
		});
	}
}

function GetPlayerNameWithTag(player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	if (!player_info) return "";

	let result = `<font color='${GetHEXPlayerColor(player_id)}'>${player_info.player_name}</font>`;
	result += ` <font color='${GetPlayerGuildTagColor(player_id)}'>${GUILD_TAGS[player_id] || ""}</font>`;

	return result;
}

function NewMessageWithData(event) {
	let text = BASE_MESSAGE_INDENT;
	let message = NewCustomChatEntry();

	if (event.PlayerID > -1) {
		const playerInfo = Game.GetPlayerInfo(event.PlayerID);

		text += event.isTeam ? `[${$.Localize("#DOTA_ChatCommand_GameAllies_Name")}] ` : NON_BREAKING_SPACE;
		text += `${GetPlayerNameWithTag(event.PlayerID)} : `;

		$.CreatePanel("Panel", message, "", { class: "HeroBadge", selectionpos: "auto" });

		const heroIcon = $.CreatePanel("Image", message, "", { class: "HeroIcon", selectionpos: "auto" });
		heroIcon.SetImage(GetPortraitImage(event.PlayerID, playerInfo.player_selected_hero));
	} else {
		text += event.isTeam ? `[${$.Localize("#DOTA_ChatCommand_GameAllies_Name")}] ` : NON_BREAKING_SPACE;
	}

	text += event.textData.replace(/%%\d*(.+?)%%/g, (_, token) => $.Localize(token));
	message.text = text;
}

function NewHighFiveMessage(event) {
	let text = `(${$.Localize(`#DOTA_ChatCommand_Game${event.is_ally ? "Allies" : "All"}_Name`)}): ${$.Localize(
		"DOTA_HighFive_Completed",
	)}`;
	let message = NewCustomChatEntry();

	const set_player = (slot, player_id) => {
		if (player_id == undefined) return;

		text = text.replace(
			`%s${slot}`,
			`<font color='${GetHEXPlayerColor(player_id)}'>${Players.GetPlayerName(player_id)}</font>`,
		);
	};
	set_player(1, event.player_1);
	set_player(2, event.player_2);

	message.text = text;
}

function NewCustomChatEntry() {
	const chatLinesPanel = FindDotaHudElement("ChatLinesPanel");
	const message = $.CreatePanel("Label", chatLinesPanel, "", {
		class: "ChatLine",
		html: "true",
		selectionpos: "auto",
		hittest: "false",
		hittestchildren: "false",
	});
	message.style.flowChildren = "right";
	message.style.color = "#faeac9";
	message.style.opacity = 1;
	$.Schedule(7, () => {
		message.style.opacity = null;
	});
	return message;
}

const PING_TYPE = {
	NONE: -1,
	SELF_UNIT: 0,
	ALLY_HERO: 1,
	ALLY_UNIT: 2,
	ENEMY_HERO: 3,
	ENEMY_UNIT: 4,
	SELF_BH_TRACK: 5,
	ALLY_BH_TRACK: 6,
	ENEMY_BH_TRACK: 7,
	SELF_SB_CHARGE: 8,
	ALLY_SB_CHARGE: 9,
	ENEMY_SB_CHARGE: 10,
};

function RemainingTimeToText(remaining_time) {
	if (remaining_time > 0)
		return $.Localize(`DOTA_Modifier_Alert_Time_Remaining`).replace("%s1", Math.ceil(remaining_time));
	else return "";
}

let rank_classes = ["BronzeTier", "SilverTier", "GoldTier", "PlatinumTier", "MasterTier", "GrandmasterTier"];
const arrow_image = "<img src='s2r://panorama/images/control_icons/chat_wheel_icon_png.vtex' class='ChatWheelIcon'/>";
function PingModifier(event) {
	let message = NewCustomChatEntry();

	const player_info = Game.GetPlayerInfo(event.sender_id);

	let text = `${BASE_MESSAGE_INDENT}[${$.Localize("#DOTA_ChatCommand_GameAllies_Name")}] ${GetPlayerNameWithTag(
		event.sender_id,
	)} : `;

	$.CreatePanel("Panel", message, "", {
		class: `HeroBadge PlusHeroBadgeIconSmall ${rank_classes[event.hero_rank]}`,
		selectionpos: "auto",
	});

	const hero_icon = $.CreatePanel("Image", message, "", { class: "HeroIcon", selectionpos: "auto" });
	hero_icon.SetImage(GetPortraitImage(event.sender_id, player_info.player_selected_hero));

	text += $.Localize(event.main_key);

	const type = event.type;

	if (type == PING_TYPE.SELF_UNIT) {
		event.tokens.s4 = RemainingTimeToText(event.tokens.s4);
	} else if (
		type == PING_TYPE.ALLY_HERO ||
		type == PING_TYPE.ALLY_UNIT ||
		type == PING_TYPE.ENEMY_HERO ||
		type == PING_TYPE.ENEMY_UNIT
	) {
		event.tokens.s4 = GetHEXPlayerColor(event.target_id);
		event.tokens.s5 = $.Localize(event.tokens.s5);
		event.tokens.s6 = RemainingTimeToText(event.tokens.s6);
	} else if (type == PING_TYPE.SELF_BH_TRACK) {
		event.tokens.s7 = RemainingTimeToText(event.tokens.s7);
	} else if (type == PING_TYPE.ALLY_BH_TRACK || type == PING_TYPE.ENEMY_BH_TRACK) {
		event.tokens.s4 = GetHEXPlayerColor(event.target_id);
		event.tokens.s5 = $.Localize(event.tokens.s5);
		event.tokens.s7 = RemainingTimeToText(event.tokens.s7);
	} else if (type == PING_TYPE.SELF_SB_CHARGE || type == PING_TYPE.ALLY_SB_CHARGE) {
		event.tokens.s3 = arrow_image;
		event.tokens.s4 = GetHEXPlayerColor(event.target_id);
		event.tokens.s6 = GetHEXPlayerColor(event.tokens.s6);
		event.tokens.s7 = $.Localize(event.tokens.s7);
		if (type == PING_TYPE.ALLY_SB_CHARGE) event.tokens.s5 = $.Localize(event.tokens.s5);
	} else if (type == PING_TYPE.ENEMY_SB_CHARGE) {
		event.tokens.s2 = $.Localize(`DOTA_Tooltip_${event.tokens.s3}`);
		event.tokens.s3 = arrow_image;
		event.tokens.s4 = GetHEXPlayerColor(event.target_id);
		event.tokens.s5 = $.Localize(event.tokens.s5);
	}

	if (type < PING_TYPE.SELF_SB_CHARGE && event.tokens.s3)
		event.tokens.s3 = $.Localize(`DOTA_Tooltip_${event.tokens.s3}`);

	for (const [token, value] of Object.entries(event.tokens)) text = text.replaceAll(`%${token}`, value);

	text = text.replace(/ +(?= )/g, "");

	message.text = text;
}

(() => {
	const frame = GameEvents.NewProtectedFrame("custom_chat");
	frame.SubscribeProtected("custom_chat_message", NewMessageWithData);
	frame.SubscribeProtected("custom_hive_five", NewHighFiveMessage);
	frame.SubscribeProtected("custom_chat_ping_modifier", PingModifier);
	frame.SubscribeProtected("custom_chat:update_parsed_teams", ParseGuildTags);
	GameEvents.SendToServerEnsured("custom_chat:get_parsed_teams", {});
})();