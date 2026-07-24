--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


class ChatWheelRemoveZone {
	constructor(type) {
		this.type = type;
		this.type_name = W_TYPE_REMOVE_NAMES[type];

		this.panel = $.CreatePanel("Panel", WHEEL_HUD.REMOVE_CONTENT_CONTAINER, `CW_RemoveZone_${this.type_name}`);
		this.panel.BLoadLayoutSnippet("CW_RemoveZone");

		this.panel.SetDialogVariableLocString("remove_type_content", `chat_wheel_remove_${this.type_name}`);

		const register_event = (name) => {
			$.RegisterEventHandler(name, this.panel, (...args) => {
				this[`On${name}`](...args);
			});
		};

		if (this.type == W_TYPE_REMOVE.ALL) this.panel.MoveChildAfter(this.panel.GetChild(0), this.panel.GetChild(1));

		register_event("DragLeave");
		register_event("DragEnter");
		register_event("DragDrop");
	}
	OnDragLeave(_, dragged_panel) {
		if (!dragged_panel.is_favorite) return;

		this.panel.RemoveClass("OnChatWheelFavoriteDragged");
		dragged_panel.RemoveClass("DragFocus");
	}
	OnDragEnter(_, dragged_panel) {
		if (!dragged_panel.is_favorite) return;

		this.panel.AddClass("OnChatWheelFavoriteDragged");
		dragged_panel.AddClass("DragFocus");
	}

	OnDragDrop(_, dragged_panel) {
		if (!dragged_panel.is_favorite) return;

		const link = dragged_panel.original_link;
		if (!link) return;

		switch (this.type) {
			case W_TYPE_REMOVE.SOUNDS:
				link.SetPhrase("", true);
				break;
			case W_TYPE_REMOVE.EMOJIES:
				link.SetEmoji("", true);
				break;
			case W_TYPE_REMOVE.COLORS:
				link.SetColor("", true);
				break;
			case W_TYPE_REMOVE.ALL:
				link.SetPhrase("", true);
				link.SetEmoji("", true);
				link.SetColor("", true);
		}
	}
}