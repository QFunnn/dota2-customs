--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameUI.Keybinds = {};

function GetCommandName(name) {
	return `custom_hotkey_${name}_${Math.random().toString(36).substring(2, 15)}`;
}

GameUI.Keybinds.CreateKeyBind = function (key, command_name, on_press, on_release) {
	const _command_name = GetCommandName(command_name);
	if (on_press) {
		Game.AddCommand(`+${_command_name}`, on_press, "", 0);
	}
	if (on_release) {
		Game.AddCommand(`-${_command_name}`, on_release, "", 0);
	}
	Game.CreateCustomKeyBind(key, `+${_command_name}`);
};