--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


class ChatWheelPhrase extends ChatWheelDND {
	constructor(parent, phrase_name, b_register_dnd = true, type, sound) {
		super(parent, "CW_Phrase", b_register_dnd);

		this.copy_args = [parent, phrase_name, false, type, ""];

		this.phrase_localized = LocalizeChatPhrase(phrase_name);
		this.panel.search_info = "";

		this.AddSearchTag(this.phrase_localized);

		this.panel.SetDialogVariable("cw_phrase_line", this.phrase_localized);

		this.panel.FindChildTraverse("CW_Phrase_Preview").SetPanelEvent("onactivate", () => {
			if (sound == "") return;

			Game.EmitSound(sound);
		});

		this.panel.cw_type = type;
		this.panel.phrase_name = phrase_name;
		this.panel.parent = parent;
	}
	AddSearchTag(tag) {
		this.panel.search_info += `&${tag}`;
		this.panel.search_info = this.panel.search_info.trim().toLowerCase();
	}
	SetAvailable(state) {
		super.SetAvailable(state);

		if (state) this.group_root.AddClass("BHasOwnedContent");
	}
}