--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function FormatSeconds(v, b_hours) {
	let hours = 0;
	if (b_hours) {
		hours = Math.floor(v / 3600);
		v = v - 3600 * hours;
	}
	const minutes = Math.floor(v / 60);
	v = v - 60 * minutes;
	return `${b_hours ? hours.toString() + ":" : ""}${minutes.toString().padStart(2, "0")}:${Math.floor(v)
		.toString()
		.padStart(2, "0")}`;
}

const FindDotaHudElementInLS = (id) => dotaLoadingScreen.FindChildTraverse(id);
const dotaLoadingScreen = (() => {
	let panel = $.GetContextPanel();
	while (panel) {
		if (panel.id === "LoadingScreen") return panel;
		panel = panel.GetParent();
	}
})();