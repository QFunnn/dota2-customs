--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


class ChatWheelEmoji extends ChatWheelDND {
	constructor(parent, emoji_name, b_register_dnd = true) {
		super(parent, "CW_Emoji", b_register_dnd);

		const emoji_id = W_TYPE_DEF_GETTERS[W_TYPE.EMOJIES](emoji_name);

		this.copy_args = [parent, emoji_name, false];

		$.CreatePanel("DOTAEmoticon", this.panel.FindChildTraverse("CW_Emoji_Icon_Container"), "", {
			emoticonid: emoji_id,
		});

		this.panel.cw_type = W_TYPE.EMOJIES;
		this.panel.emoji_name = emoji_name;

		parent.sub_lines.add(this.panel);

		this.SavePath();
	}
}