--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const MMR_MAP = {
	ot3_necropolis_ffa: [28, 20, 12, 4, -4, -12, -20, -28],
	ot3_desert_octet: [30, 0, -30],
	ot3_gardens_duo: [30, 15, 0, -15, -30],
	ot3_jungle_quintet: [30, 0, -30],
};
function GetTeamBaseRatingChange(team_id) {
	return MMR_MAP[MAP_NAME][team_places[team_id]] || 0;
}

function GetPlayerRating(target_player_id) {
	let player_rating = 1500;

	const local_rating_data = CustomNetTables.GetTableValue("game_state", "player_stats");

	if (local_rating_data && local_rating_data[target_player_id.toString()])
		player_rating = local_rating_data[target_player_id.toString()].rating || 1500;

	return player_rating;
}

function GetOtherTeamsAverageRating(target_team) {
	let avg_rating = 1500;
	if (Game.IsInToolsMode()) return avg_rating;
	const local_players_stats = CustomNetTables.GetTableValue("game_state", "player_stats");
	if (!local_players_stats) return avg_rating;

	let rating_total = 0;
	let rating_count = 0;
	Object.entries(local_players_stats).forEach(([player_id, player_data]) => {
		player_id = parseInt(player_id);
		if (isNaN(player_id)) return;
		if (Players.GetTeam(player_id) == target_team) return;

		rating_total += player_data.rating || 1500;
		rating_count++;
	});
	if (rating_count > 0) avg_rating = rating_total / rating_count;

	return avg_rating;
}

function GetRatingChanges(input_player_id) {
	const player_team = Players.GetTeam(input_player_id);

	const multiplier = 0.0125;
	const base_change = GetTeamBaseRatingChange(player_team);
	const cap = 20;

	let other_teams_avg_rating = GetOtherTeamsAverageRating(player_team);
	let primary_rating = GetPlayerRating(input_player_id);

	let score_delta = Math.round((other_teams_avg_rating - primary_rating) * multiplier);

	const is_player_bot = () => {
		const player_info = Game.GetPlayerInfo(input_player_id);
		if (!player_info) return true;

		return player_info.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_NOT_YET_CONNECTED;
	};

	// $.Msg("RATING CHANGES: ");
	// $.Msg(`input_player_id: [${input_player_id}]`);
	// $.Msg(`other_teams_avg_rating: [${other_teams_avg_rating}]`);
	// $.Msg(`primary_rating: [${primary_rating}]`);
	// $.Msg(`score_delta: [${score_delta}]`);
	// $.Msg(`is_player_bot: [${is_player_bot()}]`);
	// $.Msg(`result: [${is_player_bot() ? 0 : base_change + Math.clamp(score_delta, -cap, cap)}]`);

	return is_player_bot() ? 0 : base_change + Math.clamp(score_delta, -cap, cap);
}