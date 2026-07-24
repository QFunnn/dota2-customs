--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const WHEEL_HUD = {
	CONTEXT: $.GetContextPanel(),
	TEMP_CONTAINER: $("#CW_TempContainer"),
	SEARCH_ENTRY: $("#CW_AC_Search_Entry"),
	REMOVE_CONTENT_CONTAINER: $("#CW_RemoveContent_Zones"),

	[`${W_TYPE.DEFAULT_SOUNDS}_CONTAINER`]: $("#CW_AC_SoundsRoot_Default").GetChild(0),
	[`${W_TYPE.HEROES_SOUNDS}_CONTAINER`]: $("#CW_AC_SoundsRoot_Heroes").GetChild(0),
	[`${W_TYPE.NEW_SOUNDS}_CONTAINER`]: $("#CW_AC_SoundsRoot_New").GetChild(0),
	[`${W_TYPE.EMOJIES}_CONTAINER`]: $("#CW_AC_Emojies"),
	[`${W_TYPE.COLORS}_CONTAINER`]: $("#CW_AC_Colors"),

	[`${W_TYPE.DEFAULT_SOUNDS}_RADIO_BUTTON`]: $("#CW_AC_B_DefaultSounds"),
	[`${W_TYPE.HEROES_SOUNDS}_RADIO_BUTTON`]: $("#CW_AC_B_HeroesSounds"),
	[`${W_TYPE.NEW_SOUNDS}_RADIO_BUTTON`]: $("#CW_AC_B_NewSounds"),
	[`${W_TYPE.EMOJIES}_RADIO_BUTTON`]: $("#CW_AC_B_Emojies"),
	[`${W_TYPE.COLORS}_RADIO_BUTTON`]: $("#CW_AC_B_Colors"),
};

let CHAT_WHEEL_FAVORITES = {};
let CACHED_NEW_SOUNDS_GROUPS = {};
let CACHED_NEW_CONTENT = {};
let CACHED_SOUNDS_GROUPS_FOR_SEARCH = {
	[W_TYPE.DEFAULT_SOUNDS]: [],
	[W_TYPE.HEROES_SOUNDS]: [],
	[W_TYPE.NEW_SOUNDS]: [],
};

function ActivateAvailabeContent(type) {
	WHEEL_HUD.CONTEXT.SwitchClass("active-content", `BActiveContent_${W_TYPE_NAMES[type]}`);
	WHEEL_HUD.CONTEXT.SetDialogVariableLocString("type_hint", `chat_wheel_type_hint_${W_TYPE_NAMES[type]}`);

	switch (type) {
		case W_TYPE.DEFAULT_SOUNDS:
		case W_TYPE.HEROES_SOUNDS:
		case W_TYPE.NEW_SOUNDS:
			WHEEL_HUD.CONTEXT.SetDialogVariableLocString(
				"search_sound_hint",
				`chat_wheel_search_${W_TYPE_NAMES[type]}`,
			);
			search_type = type;
			DropSearchInput();
	}
}
function ClearContent() {
	for (const v of Object.values(W_TYPE)) {
		const container = WHEEL_HUD[`${v}_CONTAINER`];
		container?.RemoveAndDeleteChildren();

		switch (v) {
			case W_TYPE.EMOJIES:
				container.sub_lines = GenerateSublines(container, 6, 10, 10);
				break;
			case W_TYPE.COLORS:
				container.sub_lines = GenerateSublines(container, 4, 10, 10);
				break;
		}
	}

	DropSearchInput();
}

function CreatePhraseGroupInContent(parent, group_header_name, group_header_icon = "", skip_sort = false) {
	const group = $.CreatePanel("Panel", parent, "");
	group.group_header_name = $.Localize(group_header_name, group);

	group.BLoadLayoutSnippet("CW_SoundsGroup");
	group.SetDialogVariableLocString("cw_group_header", group_header_name);
	group.FindChildTraverse("CW_SG_HeaderIcon").SetImage(group_header_icon);

	group.sounds_container = group.FindChildTraverse("CW_SG_Container");

	if (!skip_sort) {
		$.Msg(`SORT: [${group_header_name}], [${group.group_header_name}]`);
		DefaultChildrenSort(parent, "group_header_name", true);
	}

	return group;
}

function CreatePhraseInContent(group, phrase_name, is_available_by_default = false, type, sound = "") {
	const phrase = new ChatWheelPhrase(group.sounds_container, phrase_name, true, type, sound);
	phrase.group_root = group;
	phrase.SetAvailable(is_available_by_default);

	return phrase;
}

function GenerateHeroesDefaultPhrases() {
	const heroes_tags = ["_laugh", "_thank", "_deny", "_1", "_2", "_3", "_4", "_5"];
	for (const [hero_name, hero_id] of Object.entries(heroes_ids)) {
		const short_hero_name = hero_name.replace(/^npc_dota_hero_/, "");

		const group = CreatePhraseGroupInContent(
			WHEEL_HUD[`${W_TYPE.HEROES_SOUNDS}_CONTAINER`],
			hero_name,
			GetPortraitIcon(LOCAL_PLAYER_ID, hero_name),
		);

		for (const tag of heroes_tags) {
			const phrase = CreatePhraseInContent(group, `${short_hero_name}${tag}`, true, W_TYPE.HEROES_SOUNDS);
			phrase.AddSearchTag(hero_name);
			phrase.AddSearchTag($.Localize(hero_name));
		}

		CACHED_SOUNDS_GROUPS_FOR_SEARCH[W_TYPE.HEROES_SOUNDS].push(group);
	}
}

function BuildFavoriteSlots() {
	for (let x = 1; x <= 8; x++) {
		const parent = $(`#CW_FavoriteSlot_${x}`);
		parent.RemoveAndDeleteChildren();
		CHAT_WHEEL_FAVORITES[x] = new ChatWheelFavorite(parent);
	}
}
function UpdateDefaultPhrases(default_phrases) {
	const order = [
		"battle_pass",
		"misc",
		"dota_plus",
		"epic_casters",
		"english_commentators",
		"chinese_commentators",
		"russian_commentators",
		"korean_commentators",
	];

	for (const group_name of order) {
		if (!default_phrases[group_name]) continue;

		const header_loc_key = `chat_wheel_${group_name}`;

		const group = CreatePhraseGroupInContent(
			WHEEL_HUD[`${W_TYPE.DEFAULT_SOUNDS}_CONTAINER`],
			header_loc_key,
			"",
			true,
		);

		for (const sound of Object.values(default_phrases[group_name])) {
			const phrase = CreatePhraseInContent(group, sound.text, true, W_TYPE.DEFAULT_SOUNDS, sound.sound);
			phrase.AddSearchTag($.Localize(header_loc_key));
		}

		CACHED_SOUNDS_GROUPS_FOR_SEARCH[W_TYPE.DEFAULT_SOUNDS].push(group);
	}

	$.Schedule(0.03, () => {
		GameUI.Player.RegisterForPlayerDataChanges(UpdateFavorites);
	});
}

function ChatWheelUpdateDefinition(definitions) {
	const prepared_names = Object.keys(definitions).map((name) => {
		if (definitions?.[name]?.unlocked_with?.other) return `~~~~${name}`;
		return name;
	});
	for (let name of prepared_names.sort()) {
		name = name.replace("~~~~", "");
		const definition = definitions[name];
		if (!definition) continue;

		const details = definition.chat_wheel_details;
		if (!details) continue;

		let content;

		if (details.sound) {
			const header_loc_key = `chat_wheel_${details.group}`;
			const sub_group = (CACHED_NEW_SOUNDS_GROUPS[details.group] ??= CreatePhraseGroupInContent(
				WHEEL_HUD[`${W_TYPE.NEW_SOUNDS}_CONTAINER`],
				header_loc_key,
			));

			content = CreatePhraseInContent(
				sub_group,
				name,
				false,
				W_TYPE.NEW_SOUNDS,
				definition.chat_wheel_details.sound,
			);

			CACHED_SOUNDS_GROUPS_FOR_SEARCH[W_TYPE.NEW_SOUNDS].push(sub_group);
			content.AddSearchTag($.Localize(header_loc_key));
		} else if (details.emoji_id) {
			content = new ChatWheelEmoji(WHEEL_HUD[`${W_TYPE.EMOJIES}_CONTAINER`], name);
		} else if (details.color) {
			content = new ChatWheelColor(WHEEL_HUD[`${W_TYPE.COLORS}_CONTAINER`], name);
		}

		if (!content) continue;

		// const def = GameUI.Inventory.GetItemDefinition(name);
		content.SetSource(definition?.unlocked_with);
		content.GetPanel().item_name = name;

		CACHED_NEW_CONTENT[name] = content;
	}
}
function ChatWheelUpdateOwned(items) {
	for (const c of Object.values(CACHED_NEW_CONTENT)) c.ResetSource();

	for (const [item_name, item_data] of Object.entries(items)) {
		const content = CACHED_NEW_CONTENT[item_name];
		if (!content) continue;

		content.SetAvailable(true);
	}
}

let update_favorites_schedule;
function UpdateFavoritesSchedule() {
	if (update_favorites_schedule) return;

	update_favorites_schedule = $.Schedule(CW_SAVE_DELAY, () => {
		update_favorites_schedule = undefined;

		const result = {};
		for (const [id, f] of Object.entries(CHAT_WHEEL_FAVORITES)) result[id] = f.GetSaveData();

		GameEvents.SendToServerEnsured("chat_wheel:update_favorites", { favorites: result });
	});
}

let is_favovorites_inited = false;
function UpdateFavorites() {
	let favorites = GameUI.Player.GetSettingValue("chat_wheel_favorites");
	if (is_favovorites_inited || !favorites) return;
	is_favovorites_inited = true;

	for (const [id, data] of Object.entries(favorites)) {
		const favorite = CHAT_WHEEL_FAVORITES[id];
		if (!favorite) continue;

		if (data.phrase && data.phrase != "") favorite.SetPhrase(data.phrase);
		if (data.color && data.color != "") favorite.SetColor(data.color);
		if (data.emoji && data.emoji != "") favorite.SetEmoji(data.emoji);
	}
}

let search_type;
function UpdateSoundSearch() {
	if (search_type == undefined) return;

	const search_text = WHEEL_HUD.SEARCH_ENTRY.text.trim().toLowerCase();

	for (const group of CACHED_SOUNDS_GROUPS_FOR_SEARCH[search_type]) {
		let b_group_has_visible_line = false;

		for (const phrase_line of group.sounds_container.Children()) {
			const b_visible = phrase_line.search_info.includes(search_text);
			if (b_visible) b_group_has_visible_line = true;
			phrase_line.visible = b_visible;
		}

		group.visible = b_group_has_visible_line;
	}
}
function FocusSearchInput() {
	WHEEL_HUD.CONTEXT.SetHasClass("BSearchInputFocus", true);
	WHEEL_HUD.SEARCH_ENTRY.SetFocus();
}
function DropSearchInput(type, skip_drop) {
	WHEEL_HUD.SEARCH_ENTRY.text = "";
	WHEEL_HUD.CONTEXT.SetHasClass("BSearchInputFocus", false);
	if (!skip_drop) $.DispatchEvent("DropInputFocus");
}

function OnSearchBlur() {
	if (WHEEL_HUD.SEARCH_ENTRY.text == "") DropSearchInput(true);
}

function MultiLineToggleContent(b_hide_locked, type, max_child_per_line) {
	const parent = WHEEL_HUD[`${type}_CONTAINER`];
	const lines = parent.Children();

	if (b_hide_locked) {
		let owned_children = [];
		for (const line of lines) {
			for (const child of line.Children()) {
				if (!child.BHasClass("BClosed")) owned_children.push(child);
			}
		}

		for (let i = 0; i < owned_children.length; i++)
			owned_children[i].SetParent(parent.GetChild(Math.floor(i / max_child_per_line)));
	} else {
		for (const line of lines) {
			for (const child of line.Children()) child.reset_parent();

			DefaultChildrenSort(line, "cached_pos_number", true);
		}
	}

	parent.sub_lines.force_restyle((c) => {
		if (b_hide_locked) return !c.BHasClass("BClosed");

		return true;
	});
}
function ToggleHiddenContent() {
	WHEEL_HUD.CONTEXT.ToggleClass("BHideLocked");

	let b_hide_locked = WHEEL_HUD.CONTEXT.BHasClass("BHideLocked");

	MultiLineToggleContent(b_hide_locked, W_TYPE.EMOJIES, 6);
	MultiLineToggleContent(b_hide_locked, W_TYPE.COLORS, 4);
}

function InitRemoveContentDND() {
	WHEEL_HUD.REMOVE_CONTENT_CONTAINER.RemoveAndDeleteChildren();

	for (const remove_type of Object.values(W_TYPE_REMOVE)) new ChatWheelRemoveZone(remove_type);
}

function CW_Init() {
	WHEEL_HUD.TEMP_CONTAINER.RemoveAndDeleteChildren();
	ClearContent();
	GenerateHeroesDefaultPhrases();
	BuildFavoriteSlots();
	InitRemoveContentDND();

	const frame = GameEvents.NewProtectedFrame(WHEEL_HUD.CONTEXT);
	frame.SubscribeProtected("chat_wheel:update_phrases_for_collection", UpdateDefaultPhrases);
	GameEvents.SendToServerEnsured("chat_wheel:get_phrases_for_collection", {});

	GameUI.Inventory.RegisterForDefinitionsChanges(ChatWheelUpdateDefinition);
	GameUI.Inventory.RegisterForInventoryChanges(ChatWheelUpdateOwned);

	$.Schedule(0, () => {
		$.DispatchEvent("Activated", WHEEL_HUD[`${W_TYPE.EMOJIES}_RADIO_BUTTON`], "mouse");
	});
}

CW_Init();