--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let CACHED_GUILD_TAG_COLORS = {};
let GUILD_TAGS = {};
let hero_ranks = {};
let default_chat_area, redirect_chat_area;
let cached_names_width = {};

function UpdateHeroRanks(_hero_ranks) {
	hero_ranks = _hero_ranks;
}

function GetPlayerGuildTagColor(player_id) {
	return CACHED_GUILD_TAG_COLORS[player_id] || DEFAULT_GUILD_TAG_COLOR;
}

function ParseGuildTags() {
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
			GUILD_TAGS[player_id] = EscapeHTML(full_name.replace(player_info.player_name, "").trim());
			temp.DeleteAsync(0);

			CalcNameLength(player_id);
		});
	}
}

function GetPlayerNameWithTag(player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	if (!player_info) return "";

	let result = `<font color='${GetHEXPlayerColor(player_id)}'>${EscapeHTML(player_info.player_name)}</font>`;
	if (GUILD_TAGS[player_id] != "")
		result += ` <font color='${GetPlayerGuildTagColor(player_id)}'>${GUILD_TAGS[player_id] || ""}</font>`;

	return result;
}

let t = 0;
function NewCustomChatEntry() {
	const message = $.CreatePanel("Label", redirect_chat_area, "", {
		class: "ChatLine",
		html: "true",
		selectionpos: "auto",
		hittest: "false",
		hittestchildren: "false",
		text: "#custom_chat_basic_message",
	});
	message.style.flowChildren = "right";
	// message.style.color = "#faeac9";
	message.BLoadLayout("file://{resources}/layout/custom_game/custom_chat/custom_chat_filler.xml", false, false);

	// switch (t) {
	// 	case 0:
	// 		message.AddClass("ColorRGB1");
	// 		break;
	// 	case 1:
	// 		message.AddClass("ColorRed2");
	// 		break;
	// }

	ExpireMessageInTime(message);
	return message;
}

function AddHeroInfoToLine(player_id, message) {
	const player_info = Game.GetPlayerInfo(player_id);

	const hero_rank = hero_ranks[player_id];
	let rank_class = "";
	if (hero_rank != undefined) rank_class = rank_classes[hero_ranks[player_id]];

	$.CreatePanel("Panel", message, "", {
		class: `HeroBadge PlusHeroBadgeIconSmall ${rank_class}`,
		selectionpos: "auto",
	});
	$.CreatePanel("Image", message, "", {
		class: "HeroIcon",
		selectionpos: "auto",
		src: GetPortraitImage(player_id, player_info.player_selected_hero),
	});

	return `${GetPlayerNameWithTag(player_id)}<font color='#faeac9'> :</font> `;
}

function AddAbilitiesIcons(abilities = {}, message) {
	let text_value = "";

	for (const [index, ability] of Object.entries(abilities)) {
		const id = `${ability}_${index}`;

		text_value += `<child id="${id}">`;

		$.CreatePanel("DOTAAbilityImage", message, id, {
			abilityname: ability,
			style: `width: 23px; height: 23px; margin-left: 4px;`,
		});
	}

	return text_value;
}

function AddMasteryIcon(mastery, message) {
	if (!mastery) return;

	const icon = $.CreatePanel("Panel", CONTEXT, "Mastery");
	icon.BLoadLayoutSnippet("Mastery");
	icon.FindChild(
		"MasteryIcon",
	).style.backgroundImage = `url('file://{images}/custom_game/collection/mastery/icons/${mastery}.png')`;
	icon.SetParent(message);
}

function SetupPlayersInfo(message, data) {
	for (const [p_id, p_data] of Object.entries(data))
		for (const [p_k, p_v] of Object.entries(p_data))
			message.SetDialogVariable(p_k, C_CHAT_ACTIONS[p_v](parseInt(p_id)));
}

function SetupNotLocalizedTokens(message, data) {
	if (!data) return;

	for (const [nl_k, nl_v] of Object.entries(data)) message.SetDialogVariable(nl_k, nl_v);
}

function CheckMuteMessage(sender_id) {
	if (sender_id < 0) return false;
	if (Game.IsPlayerMutedText(sender_id)) return true;
	// const hero = Players.GetPlayerHeroEntityIndex(sender_id);
	// if (FindModifier(hero, "modifier_auto_attack") != -1 && GameUI.Player.GetSettingValue("mute_bots")) return true;

	return false;
}

function AddHeroChallenge(message, text, challenge_type) {
	const challenge = $.Localize(`#hero_challenges_${GetChallengeTypeName(challenge_type)}`, message);
	text = text.replaceAll("%challenge_desc%", challenge);
	text = text.replaceAll("<span class='ChallengeValue'>", "<font color='red'><span class='ChallengeValue'>");
	text = text.replaceAll("</span>", "</span></font>");

	return text;
}

function CreateCustomMessage(data) {
	if (CheckMuteMessage(data.sender_id)) return;

	const hero = Players.GetPlayerHeroEntityIndex(data.sender_id);

	const message = NewCustomChatEntry();

	if (data.abilities && data.abilities[0]) {
		const ability = Entities.GetAbilityByName(hero, data.abilities[0]);
		message.SetDialogVariable("value", Abilities.GetSpecialValueFor(ability, "value"));
	}

	if (data.tokens) {
		SetupNotLocalizedTokens(message, data.tokens.not_localize);

		for (const [k, v] of Object.entries(data.tokens)) {
			if (k == "not_localize" || k == "hard_replace") continue;

			if (k == "players") SetupPlayersInfo(message, v);
			else message.SetDialogVariable(k, $.Localize(v, message));
		}
	}

	// Dialog vars should be set before other stuff
	let chat_wheel_loc_message = LocalizeChatPhrase(data?.extra_data?.chat_wheel_phrase || "");
	message.SetDialogVariable("message", chat_wheel_loc_message);

	let text = "";
	const allies_tag = $.Localize("#DOTA_ChatCommand_GameAllies_Name");

	if (data.sender_id > -1) {
		text += `${BASE_MESSAGE_INDENT}${!!data.is_team ? `[${allies_tag}] ` : NON_BREAKING_SPACE}`;
		text += AddHeroInfoToLine(data.sender_id, message);
	} else if (!!data.is_team) {
		text += `(${allies_tag}) `;
	}

	text += $.Localize(data.main_token, message);

	if (data.tokens && data.tokens.hard_replace)
		for (const [hs_k, hs_v] of Object.entries(data.tokens.hard_replace))
			text = text.replaceAll(hs_k, $.LocalizeEngine(hs_v, message));

	text += AddAbilitiesIcons(data.abilities, message);

	const extra_data = data.extra_data;
	if (extra_data) {
		if (extra_data.mastery) AddMasteryIcon(extra_data.mastery, message);
		if (extra_data.remaining_time)
			text = text.replaceAll(extra_data.remaining_time.key, RemainingTimeToText(extra_data.remaining_time.value));
		if (extra_data.challenge_type != undefined) text = AddHeroChallenge(message, text, extra_data.challenge_type);

		if (extra_data.chat_wheel_color) {
			message.AddClass("BHasCWCustomColor");

			for (const c of message.Children()) if (c.BHasClass("CW_SubChannel")) c.DeleteAsync(0);

			const channels =
				GameUI.Inventory.GetItemDefinition(`chat_wheel_${extra_data.chat_wheel_color}`)?.chat_wheel_details
					?.channels || 0;
			$.Schedule(0, () => {
				const new_root = $.CreatePanel("Panel", message.GetParent(), "", {
					class: "ChatLine",
					style: "margin-left:0px;",
				});
				new_root.BLoadLayout(
					"file://{resources}/layout/custom_game/custom_chat/custom_chat_filler.xml",
					true,
					false,
				);
				message.SetParent(new_root);
				new_root.AddClass(extra_data.chat_wheel_color);

				for (let x = 0; x < channels; x++) {
					const l = $.CreatePanel("Label", new_root, "", {
						class: `CW_SubChannel CW_SubChannel_${x} ${x == 0 ? extra_data.chat_wheel_color : ``}`,
						hittest: false,
						html: true,
					});

					const nick_length = (cached_names_width[data.sender_id] || 0) / new_root.actualuiscale_x;
					const extra_padding = 4 / new_root.actualuiscale_x;

					$.CreatePanel("Panel", l, "ChatWheelFiller", {
						style: `height: 5px;width: ${FILLER_LENGTH + extra_padding + nick_length}px;`,
					});
					l.SetDialogVariable("channel_text", chat_wheel_loc_message);
					l.text = $.Localize("chat_wheel_color_channels_filler", l);
				}

				ExpireMessageInTime(new_root);
			});
		}
		if (extra_data.chat_wheel_emoji) {
			$.CreatePanel("DOTAEmoticon", message, "ChatWheelEmoji", {
				emoticonid: extra_data.chat_wheel_emoji,
				style: "height: 26px;width: 26px;",
			});
		}
	}

	text = text.replaceAll(
		"%ARROW%",
		"<img src='s2r://panorama/images/control_icons/chat_wheel_icon_png.vtex' class='ChatWheelIcon'/>",
	);

	text = text.replace(/ +(?= )/g, "");

	if (data.main_token == "chat_wheel_sound_message_chat") {
		$.CreatePanel("Image", message, "ChatWheelSoundIcon", {
			style: "width:20px;height:20px;",
			src: "s2r://panorama/images/hud/reborn/icon_scoreboard_mute_sound_psd.vtex",
		});
	}

	$.CreatePanel("Panel", message, "CustomChatFiller", {
		style: `height: 1px;width:${FILLER_LENGTH}px;`,
	});
	message.text = text;
}

function RemainingTimeToText(remaining_time) {
	if (remaining_time > 0)
		return $.Localize(`DOTA_Modifier_Alert_Time_Remaining`).replace("%s1", Math.ceil(remaining_time));
	else return "";
}

let last_hero_rank = -2;
function UpdateSelectedPortrait() {
	const portrait_unit = Players.GetLocalPlayerPortraitUnit(LOCAL_PLAYER_ID);
	const owned_hero = Players.GetPlayerHeroEntityIndex(LOCAL_PLAYER_ID);
	if (portrait_unit != owned_hero) return;

	const unit_badge = FindDotaHudElement("unitbadge");

	const hero_rank = rank_classes.findIndex((class_name) => {
		return unit_badge.BHasClass(class_name);
	});

	if (last_hero_rank == hero_rank) return;
	last_hero_rank = hero_rank;

	GameEvents.SendToServerEnsured("custom_chat:update_hero_rank", { hero_rank: hero_rank });
}

function UpdateClient(event) {
	if (event.hero_ranks) UpdateHeroRanks(event.hero_ranks);
	if (event.guild_tag_colors) CACHED_GUILD_TAG_COLORS = event.guild_tag_colors;
	ParseGuildTags();
}

function ClearCustomChatAreas() {
	default_chat_area
		.GetParent()
		.Children()
		.forEach((c) => {
			if (c.custom_area) c.DeleteAsync(0);
		});
}
function ClearChatBuffer() {
	const chat_lines = redirect_chat_area.Children();
	const buffer_size = chat_lines.length;

	if (buffer_size > MAX_CHAT_SIZE)
		chat_lines.slice(0, chat_lines.length - MAX_CHAT_SIZE).forEach((l) => {
			l.DeleteAsync(0);
		});
	$.Schedule(5, ClearChatBuffer);
}
function RedirectMessages() {
	default_chat_area.Children().forEach((line, idx, children) => {
		if (line.paneltype == "Panel" || (children.length > 10 && idx != 15)) {
			line.DeleteAsync(0);
			return;
		}

		GameEvents.SendEventClientSide("CustomChat:update_history_size", {});

		line.SetParent(redirect_chat_area);
		ExpireMessageInTime(line);
	});

	$.Schedule(0, RedirectMessages);
}
function InitCustomChatOverrideArea() {
	const default_chat_area_parent = FindDotaHudElement("ChatLinesWrapper");
	if (!default_chat_area_parent) return void $.Schedule(0, InitCustomChatOverrideArea);
	default_chat_area_parent.Children().forEach((c) => {
		if (!c.custom_area) default_chat_area = c;
	});
	if (!default_chat_area) return void $.Schedule(0, InitCustomChatOverrideArea);

	ClearCustomChatAreas();

	const custom_chat_area = $.CreatePanel("Panel", default_chat_area_parent, "ChatLinesPanel", {
		hittest: false,
	});

	custom_chat_area.custom_area = true;
	redirect_chat_area = custom_chat_area;

	RedirectMessages();
	ClearChatBuffer();
}

function ExpireMessageInTime(panel) {
	$.Schedule(7, () => {
		if (panel.IsValid()) panel.AddClass("Expired");
	});
}

function CalcNameLength(player_id) {
	const name = $.CreatePanel("Label", CONTEXT, "", {
		text: `\u00A0${GetPlayerNameWithTag(player_id)} : <child id='ChatWheelSoundIcon'>\u00A0`,
		style: "font-size:18px;font-weight:bold;opacity:0.001;",
		html: true,
	});

	$.CreatePanel("Image", name, "ChatWheelSoundIcon", {
		style: "width:20px;height:20px;",
		src: "s2r://panorama/images/hud/reborn/icon_scoreboard_mute_sound_psd.vtex",
	});

	$.Schedule(0, () => {
		cached_names_width[player_id] = name.contentwidth;
		name.DeleteAsync(0);
	});
}

(function () {
	CONTEXT.RemoveAndDeleteChildren();

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());
	frame.SubscribeProtected("custom_chat:message", CreateCustomMessage);
	frame.SubscribeProtected("custom_chat:update_hero_ranks", UpdateHeroRanks);
	frame.SubscribeProtected("custom_chat:update_client", UpdateClient);

	GameEvents.SendToServerEnsured("custom_chat:update_client_request", {});

	GameEvents.Subscribe("dota_portrait_unit_stats_changed", UpdateSelectedPortrait);

	GameUI.CreateCustomMessage = CreateCustomMessage;
	InitCustomChatOverrideArea();
})();