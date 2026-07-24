--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CW_SAVE_DELAY = 1;

const W_TYPE = {
	DEFAULT_SOUNDS: 0,
	NEW_SOUNDS: 1,
	HEROES_SOUNDS: 2,
	EMOJIES: 3,
	COLORS: 4,
};
const W_TYPE_NAMES = Object.fromEntries(Object.entries(W_TYPE).map((a) => a.reverse()));

const W_TYPE_REMOVE = {
	SOUNDS: 0,
	EMOJIES: 1,
	COLORS: 2,
	ALL: 3,
};
const W_TYPE_REMOVE_NAMES = Object.fromEntries(Object.entries(W_TYPE_REMOVE).map((a) => a.reverse()));

const W_TYPE_HANDLERS = (() => {
	const sound_handler = {
		set: (self, dnd_panel) => self.SetPhrase(dnd_panel.phrase_name, true),
		clear: (self) => self.SetPhrase(""),
		has: (self) => !!self.phrase_name,
	};

	return {
		[W_TYPE.DEFAULT_SOUNDS]: sound_handler,
		[W_TYPE.NEW_SOUNDS]: sound_handler,
		[W_TYPE.HEROES_SOUNDS]: sound_handler,

		[W_TYPE.EMOJIES]: {
			set: (self, dnd_panel) => self.SetEmoji(dnd_panel.emoji_name, true),
			clear: (self) => self.SetEmoji(""),
			has: (self) => !!self.emoji_name,
		},
		[W_TYPE.COLORS]: {
			set: (self, dnd_panel) => self.SetColor(dnd_panel.color_name, true),
			clear: (self) => self.SetColor(""),
			has: (self) => !!self.color_name,
		},
	};
})();

const W_TYPE_DEF_GETTERS = (() => {
	return {
		[W_TYPE.NEW_SOUNDS]: (name) => {
			return GameUI.Inventory.GetItemDefinition(name)?.chat_wheel_details?.sound || "";
		},
		[W_TYPE.EMOJIES]: (name) => {
			return GameUI.Inventory.GetItemDefinition(name)?.chat_wheel_details?.emoji_id || -1;
		},
		[W_TYPE.COLORS]: (name) => {
			return GameUI.Inventory.GetItemDefinition(name)?.chat_wheel_details?.color || "";
		},
	};
})();

const W_SOURCE_TYPE = {
	NONE: -1,
	CURRENCY: 0,
	TREASURE: 1,
};
const W_SOURCE_TYPE_NAMES = Object.fromEntries(Object.entries(W_SOURCE_TYPE).map((a) => a.reverse()));