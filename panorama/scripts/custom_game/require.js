--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const root = $.GetContextPanel();
const modules = GameUI.__modules = {};
GameUI.__loadModule = function (name, exports) {
	if (modules[name]) {
		$.Msg(`Reload module: ${name} `, exports ? '👏' : '☠️');
	}
	modules[name] = exports;
};
GameUI.__require = function (name) {
	name = name.slice(2, name.length - 3);
	if (!modules[name]) {
		const m = $.CreatePanel('Panel', root, name);
		m.BLoadLayout(`file://{resources}/layout/custom_game/${name}.xml`, false, false);
		$.Msg(`Load module: ${name} `, modules[name] ? '👏' : '☠️');
	}
	return modules[name];
};
root.AddClass($.Language());