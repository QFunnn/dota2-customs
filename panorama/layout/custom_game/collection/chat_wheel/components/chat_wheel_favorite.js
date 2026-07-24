--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


class ChatWheelFavorite {
	constructor(parent, b_register_dnd = true) {
		this.panel = $.CreatePanel("Button", parent, "");
		this.panel.BLoadLayoutSnippet("CW_Button");
		this.panel.SetDialogVariable("phrase_line", " ");

		this.is_copy = !b_register_dnd;

		this.copy_args = [parent, false];

		this.emoji_container = this.panel.FindChildTraverse("CW_Button_Emoji_Icon_Container");
		this.text_label = this.panel.FindChildTraverse("CW_Button_Line");

		W_TYPE_HANDLERS[W_TYPE.COLORS].clear(this);

		if (!b_register_dnd) return;

		this.panel.SetDraggable(true);

		const register_event = (name) => {
			$.RegisterEventHandler(name, this.panel, (...args) => {
				this[`On${name}`](...args);
			});
		};

		register_event("DragLeave");
		register_event("DragEnter");
		register_event("DragDrop");
		register_event("DragStart");
		register_event("DragEnd");
	}
	Copy() {
		if (!this.copy_args) return;

		const copy = new this.constructor(...this.copy_args);
		copy.SetPhrase(this.phrase_name || "");
		copy.SetColor(this.color_name || "");
		copy.SetEmoji(this.emoji_name || "");

		return copy;
	}
	GetPanel() {
		return this.panel;
	}

	OnDragStart(_, drag_callbacks) {
		const b_has_sounds = W_TYPE_HANDLERS[W_TYPE.DEFAULT_SOUNDS].has(this);
		const b_has_colors = W_TYPE_HANDLERS[W_TYPE.COLORS].has(this);
		const b_has_emojies = W_TYPE_HANDLERS[W_TYPE.EMOJIES].has(this);

		if (!b_has_sounds && !b_has_colors && !b_has_emojies) return;

		$.DispatchEvent("DropInputFocus");
		$.DispatchEvent("DOTAHideAbilityTooltip");
		this.panel.SetHasClass("DragSource", true);

		const draggable_panel = this.Copy().GetPanel();
		drag_callbacks.displayPanel = draggable_panel;

		draggable_panel.original_link = this;
		draggable_panel.is_favorite = true;

		WHEEL_HUD.CONTEXT.SetHasClass("BStartChatWheelDrag_Remove", true);

		WHEEL_HUD.CONTEXT.SetHasClass("BStartChatWheelDrag_Remove_Sounds", b_has_sounds);
		WHEEL_HUD.CONTEXT.SetHasClass("BStartChatWheelDrag_Remove_Colors", b_has_colors);
		WHEEL_HUD.CONTEXT.SetHasClass("BStartChatWheelDrag_Remove_Emojies", b_has_emojies);
	}
	OnDragEnd(_, dragged_panel) {
		this.panel.SetHasClass("DragSource", false);
		WHEEL_HUD.CONTEXT.SetHasClass("BStartChatWheelDrag_Remove", false);
		dragged_panel.DeleteAsync(0);
	}

	OnDragLeave(_, dragged_panel) {
		if (dragged_panel.is_favorite) return;

		this.panel.RemoveClass("OnChatWheelComponentDragged");
		dragged_panel.RemoveClass("DragFocus");
	}
	OnDragEnter(_, dragged_panel) {
		if (dragged_panel.is_favorite) return;

		this.panel.AddClass("OnChatWheelComponentDragged");
		dragged_panel.AddClass("DragFocus");
	}

	OnDragDrop(_, dragged_panel) {
		if (dragged_panel.is_favorite) return;

		const handler = W_TYPE_HANDLERS[dragged_panel.cw_type];
		if (handler) handler.set(this, dragged_panel);
	}
	SetPhrase(phrase_name, is_drop = false) {
		const prev_empty = this.phrase_name == "" || !this.phrase_name;
		this.phrase_name = phrase_name;

		this.panel.SetDialogVariable("phrase_line", !!phrase_name ? LocalizeChatPhrase(phrase_name) : " ");

		if (this.is_copy || !is_drop || (this.phrase_name == "" && prev_empty)) return;

		this.SetColor(this.color_name || "");
		UpdateFavoritesSchedule();
	}

	SetEmoji(emoji_name, is_drop = false) {
		const prev_empty = this.emoji_name == "" || !this.emoji_name;
		this.emoji_container.Children().forEach((c) => c.DeleteAsync(0));
		this.emoji_name = emoji_name;

		if (!!emoji_name)
			$.CreatePanel("DOTAEmoticon", this.emoji_container, "", {
				emoticonid: W_TYPE_DEF_GETTERS[W_TYPE.EMOJIES](emoji_name),
			});

		if (this.is_copy || !is_drop || (this.emoji_name == "" && prev_empty)) return;
		UpdateFavoritesSchedule();
	}
	SetColor(color_name, is_drop = false) {
		const prev_empty = this.color_name == "" || !this.color_name;
		this.color_name = color_name;

		let color = W_TYPE_DEF_GETTERS[W_TYPE.COLORS](color_name);
		if (color == "") color = "CW_DefaultWhite";

		this.panel.SetHasClass("BHasNonDefaultColor", color != "CW_DefaultWhite");
		this.text_label.SwitchClass("color-class", color);
		this.text_label.GetParent().GetParent().SwitchClass("color-class", color);

		CreateSubChannelsCW(this.text_label, color_name);

		if (this.is_copy || !is_drop || (this.color_name == "" && prev_empty)) return;
		UpdateFavoritesSchedule();
	}
	GetSaveData() {
		return Object.fromEntries(
			Object.entries({
				phrase: this.phrase_name,
				emoji: this.emoji_name,
				color: this.color_name,
			}).filter(([, v]) => v),
		);
	}
}