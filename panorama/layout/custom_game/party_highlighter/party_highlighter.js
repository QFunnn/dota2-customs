--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let parties;

function HighlightByParty(player_id, label) {
	let party_id = parties[player_id];

	if (party_id != undefined) {
		label.SetHasClass("Party_" + party_id, true);
	} else {
		label.SetHasClass("NoParty", true);
	}
}

SubscribeToNetTableKey("game_state", "parties", (value) => {
	parties = value;
});