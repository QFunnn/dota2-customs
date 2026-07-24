--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


class ChatWheelColor extends ChatWheelDND {
	constructor(parent, color_name, b_register_dnd = true) {
		super(parent, "CW_Color", b_register_dnd);

		const color = W_TYPE_DEF_GETTERS[W_TYPE.COLORS](color_name);

		this.copy_args = [parent, color_name, false];

		this.panel.SetDialogVariableLocString("cw_color", color_name);

		const label = this.panel.FindChildTraverse("CW_Color_Name");
		label.SwitchClass("color-class", color);
		label.GetParent().SwitchClass("color-class", color);

		CreateSubChannelsCW(label, color_name);

		this.panel.cw_type = W_TYPE.COLORS;
		this.panel.color_name = color_name;

		parent.sub_lines.add(this.panel);

		this.SavePath();
	}
}