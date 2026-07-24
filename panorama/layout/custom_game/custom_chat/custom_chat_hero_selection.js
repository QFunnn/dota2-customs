--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


(() => {
	let default_players_colors = {};
	for (let player_id = 0; player_id <= 24; player_id++)
		default_players_colors[player_id] = GetHEXPlayerColor(player_id);

	GameEvents.SendToServerEnsured("custom_chat:update_guild_tag_colors", { colors: default_players_colors });
})();