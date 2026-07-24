--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let CACHED_LINES = {};
let RINGS_DATA;
let favorites = [];

function FillRing(key) {
	const hero_name = Players.GetPlayerSelectedHero(LOCAL_PLAYER_ID);
	HUD.HERO_IMAGE.SetImage(GetPortraitIcon(LOCAL_PLAYER_ID, hero_name));

	let ring = RINGS_DATA.rings[key];
	const is_hero_ring = key == hero_name;
	const is_favorites_ring = key == "favorites";

	if (is_hero_ring) ring = RINGS_DATA.hero_phrases;
	if (is_favorites_ring) ring = favorites;

	if (!ring) return FillRing("default");

	let is_has_sound_no_favorite = false;
	let is_available_remove_favorite = false;
	let is_any_visible_line = false;

	for (let idx = 1; idx <= 8; idx++) {
		let phrase = is_favorites_ring ? ring[idx]?.phrase : ring[idx];
		const line = CACHED_LINES[idx];
		line.text_label.SwitchClass("collection-color", "");
		line.text_label.RemoveAndDeleteChildren();

		if (!phrase) {
			line.visible = false;
			continue;
		}

		// $.Msg("phrase");
		// $.Msg(phrase);
		// $.Msg(ring[idx]);
		const is_sound = typeof phrase == "object";
		// const is_favorite_phrase = favorites.includes(phrase);

		if (phrase == "local_hero") phrase = hero_name;

		let base_text = `${is_sound ? phrase[1] : phrase}`;
		let localized_line = LocalizeChatPhrase(base_text);

		let is_valid = phrase != "";
		if (is_sound && localized_line == "") is_valid = false;

		line.visible = is_valid;
		if (is_valid) is_any_visible_line = true;

		line.SetDialogVariable("phrase_text", localized_line);
		line.ClearPanelEvent("onactivate");
		line.SetPanelEvent("onactivate", () => {
			if (RINGS_DATA.rings[phrase] || phrase == hero_name || phrase == "favorites") FillRing(phrase);
			else
				GameEvents.SendToServerEnsured("chat_wheel:say", {
					phrase_key: base_text,
					is_favorite: is_favorites_ring,
					fav_index: idx,
				});
		});

		line.RemoveClass("BAddedToFavorite");
		// line.SetPanelEvent("oncontextmenu", () => {
		// 	if (!is_sound) return;
		//
		// 	let is_has_changes = false;
		//
		// 	if (!is_favorites_ring && !is_favorite_phrase) {
		// 		line.AddClass("BAddedToFavorite");
		// 		line.SetPanelEvent("oncontextmenu", () => {}); //ClearPanelEvent work's incorrect
		// 		AddOnFavorites(phrase);
		// 		is_has_changes = true;
		// 	} else if (is_favorites_ring && is_favorite_phrase) {
		// 		favorites = favorites.filter((_phrase) => _phrase[1] != phrase[1]);
		// 		FillRing("favorites");
		// 		is_has_changes = true;
		// 	}
		//
		// 	if (is_has_changes) GameEvents.SendToServerEnsured("chat_wheel:update_favorites", { favorites: favorites });
		// });

		line.SetHasClass("BSound", (is_sound || is_favorites_ring) && localized_line != "");
		line.SetHasClass("BFolder", !is_sound && localized_line != "");
		line.SetHasClass("BFavorite", phrase == "favorites");
		line.SetHasClass("BMutedFavorite", false);

		const muted_hero_source = RINGS_DATA?.muted_heroes_lines?.[base_text];

		if (is_favorites_ring && muted_hero_source) {
			line.SetHasClass("BMutedFavorite", true);
			line.FindChildTraverse("CW_HeroIcon").SetImage(
				`file://{images}/heroes/icons/npc_dota_hero_${muted_hero_source}.png`,
			);
		}

		if (is_favorites_ring) {
			line.emoji_container.Children().forEach((c) => {
				c.DeleteAsync(0);
			});

			const emoji_name = ring[idx].emoji;
			const emoji_id = GameUI.Inventory.GetItemDefinition(emoji_name)?.chat_wheel_details?.emoji_id;

			if (emoji_id)
				$.CreatePanel("DOTAEmoticon", line.emoji_container, "", {
					emoticonid: emoji_id,
				});

			const color_name = ring[idx].color;
			const color_class = GameUI.Inventory.GetItemDefinition(color_name)?.chat_wheel_details?.color;

			if (color_class) {
				line.text_label.SwitchClass("collection-color", color_class);
				CreateSubChannelsCW(line.text_label, color_name);
			}
		}

		// if (is_sound && !is_favorite_phrase) is_has_sound_no_favorite = true;
		// if (is_favorites_ring && is_favorite_phrase) is_available_remove_favorite = true;
	}
	// HUD.CONTEXT.SetHasClass("BCanAddFavorite", is_has_sound_no_favorite);
	// HUD.CONTEXT.SetHasClass("BCanRemoveFavorite", is_available_remove_favorite);
	// HUD.CONTEXT.SetHasClass("BEmptyFavorits", is_favorites_ring && !is_any_visible_line);
	HUD.CONTEXT.SetHasClass("BFavoriteRing", is_favorites_ring);
}

// function AddOnFavorites(phrase) {
// 	favorites.unshift(phrase);
//
// 	favorites = favorites.filter((item, key, self) => key == self.findIndex((t) => t[1] == item[1]));
//
// 	if (favorites.length > 8) favorites.pop();
// 	Game.EmitSound("ui.crafting_gem_create");
// }

function FillChatWheelRings(data) {
	RINGS_DATA = data;
	FillRing("default");

	$.Schedule(2, () => {
		GameUI.Keybinds.CreateKeyBind("L", "+WheelButton", StartWheel, StopWheel);
	});
}
function FillBasicPhrases() {
	HUD.PHRASES_CONTAINER_CENTER.RemoveAndDeleteChildren();
	HUD.PHRASES_CONTAINER_RIGHT.RemoveAndDeleteChildren();
	HUD.PHRASES_CONTAINER_LEFT.RemoveAndDeleteChildren();

	let container;
	for (let x = 0; x < 8; x++) {
		if (x == 0 || x == 4) container = HUD.PHRASES_CONTAINER_CENTER;
		if (x == 1) container = HUD.PHRASES_CONTAINER_RIGHT;
		if (x == 5) container = HUD.PHRASES_CONTAINER_LEFT;

		const line = $.CreatePanel("Panel", container, `Phrase_${x}`);
		line.BLoadLayoutSnippet("CW_Phrase");
		line.emoji_container = line.FindChildTraverse("CW_EmojiContainer");
		line.text_label = line.FindChildTraverse("CW_Phrase_Text");

		CACHED_LINES[x + 1] = line;

		line.SetPanelEvent("onmouseover", () => {
			HUD.CONTEXT.SwitchClass("focus_phrase_id", `FocusPhrase_${x}`);
		});
		line.SetPanelEvent("onmouseout", () => {
			HUD.CONTEXT.SwitchClass("focus_phrase_id", `BNoFocusPhrase`);
		});
	}
}

let CURSOR_SCHEDULE;
function StartWheel() {
	FillRing("default");
	HUD.CONTEXT.SetHasClass("Show", true);
	HUD.HERO_IMAGE.ResetPosition();
	const max_delta = 25;
	let original_image_pos = {
		x: HUD.HERO_IMAGE.center_x,
		y: HUD.HERO_IMAGE.center_y,
	};
	const update_icon_pos = () => {
		CURSOR_SCHEDULE = $.Schedule(0, () => {
			CURSOR_SCHEDULE = undefined;
			let cursor_x = GameUI.GetCursorPosition()[0] / HUD.CONTEXT.actualuiscale_x - HUD.HERO_IMAGE.half_w;
			let cursor_y = GameUI.GetCursorPosition()[1] / HUD.CONTEXT.actualuiscale_y - HUD.HERO_IMAGE.half_h;

			let delta_x = cursor_x - original_image_pos.x;
			let delta_y = cursor_y - original_image_pos.y;

			let current_delta = Math.min(Math.hypot(delta_x, delta_y), max_delta);
			let current_angle = Math.atan2(delta_y, delta_x);
			let diff_pos_x = current_delta * Math.cos(current_angle);
			let diff_pos_y = current_delta * Math.sin(current_angle);

			const new_pos_x = original_image_pos.x + diff_pos_x;
			const new_pos_y = original_image_pos.y + diff_pos_y;

			HUD.HERO_IMAGE.style.position = `${new_pos_x}px ${new_pos_y}px 0`;

			update_icon_pos();
		});
	};
	update_icon_pos();
}
function StopWheel() {
	CURSOR_SCHEDULE = $.CancelScheduled(CURSOR_SCHEDULE);
	HUD.CONTEXT.SwitchClass("focus_phrase_id", `BNoFocusPhrase`);
	$.DispatchEvent("DropInputFocus");
	HUD.CONTEXT.SetHasClass("Show", false);
}

function InitIconPos() {
	const x_center = Game.GetScreenWidth() / HUD.CONTEXT.actualuiscale_x / 2;
	const y_center = Game.GetScreenHeight() / HUD.CONTEXT.actualuiscale_y / 2;

	// 40x40 is CW_HeroImage size. Just incorrect on game start and need delay for record size run-time
	HUD.HERO_IMAGE.half_w = 40 / 2;
	HUD.HERO_IMAGE.half_h = 40 / 2;

	HUD.HERO_IMAGE.center_y = y_center - HUD.HERO_IMAGE.half_h;
	HUD.HERO_IMAGE.center_x = x_center - HUD.HERO_IMAGE.half_w;

	HUD.HERO_IMAGE.ResetPosition = () => {
		HUD.HERO_IMAGE.style.position = `${HUD.HERO_IMAGE.center_x}px ${HUD.HERO_IMAGE.center_y}px 0`;
	};
	HUD.HERO_IMAGE.ResetPosition();
}
function EmitSoundFromServer(data) {
	const sound_name = data.sound;
	if (sound_name == undefined) return;
	Game.EmitSound(sound_name);
}

(function () {
	StopWheel();
	FillBasicPhrases();
	InitIconPos();

	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);
	frame.SubscribeProtected("chat_wheel:fill_rings", FillChatWheelRings);
	frame.SubscribeProtected("chat_wheel:emit_sound", EmitSoundFromServer);

	GameEvents.SendToServerEnsured("chat_wheel:get_rings", {});

	GameUI.Player.RegisterForPlayerDataChanges(() => {
		let s_favorites = GameUI.Player.GetSettingValue("chat_wheel_favorites");
		if (!s_favorites) return;

		favorites = s_favorites;
	});
})();