--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


function CloseRank() {
	$("#page_rank").ToggleClass("Hidden");
}


function refreshTopPanel(gamemode, data) {
	var parent = $("#" + gamemode);
	if (parent != undefined) {
		parent.RemoveAndDeleteChildren();
		for (var index in data) {
			var player = data[index];
			//$.Msg(player)
			var steamid = player.player_steam_id;
			var steamid64 = '765' + (parseInt(steamid) + 61197960265728).toString();

			if (gamemode == "pve_mode_players") {
				var time_cost = FormatSeconds(player.time_cost)
				var m_PlayerPanel = $.CreatePanel("Panel", parent, "");
				m_PlayerPanel.BLoadLayoutSnippet("PvePlayer");
				m_PlayerPanel.FindChildTraverse("player_avatar").steamid = steamid64;
				m_PlayerPanel.FindChildTraverse("player_user_name").steamid = steamid64;
				m_PlayerPanel.FindChildTraverse("rank_max_round").text = player.round_number;
				m_PlayerPanel.FindChildTraverse("rank_time_cost").text = time_cost;
				m_PlayerPanel.FindChildTraverse("rank_index").text = index;
			}
			//排行榜替换为Dota Mind分数
			if (gamemode == "solo_mode_players") {
				var m_PlayerPanel = $.CreatePanel("Panel", parent, "");
				m_PlayerPanel.BLoadLayoutSnippet("PvpPlayer");
				m_PlayerPanel.FindChildTraverse("player_avatar").steamid = steamid64;
				m_PlayerPanel.FindChildTraverse("player_user_name").steamid = steamid64;
				//m_PlayerPanel.FindChildTraverse("rank_text").text = player.rating;
				m_PlayerPanel.FindChildTraverse("rank_text").text = player.dota_mind_score;
				m_PlayerPanel.FindChildTraverse("rank_index").text = index;
			}

			if (gamemode == "duos_mode_players") {
				var m_PlayerPanel = $.CreatePanel("Panel", parent, "");
				m_PlayerPanel.BLoadLayoutSnippet("PvpPlayer");
				m_PlayerPanel.FindChildTraverse("player_avatar").steamid = steamid64;
				m_PlayerPanel.FindChildTraverse("player_user_name").steamid = steamid64;
				//m_PlayerPanel.FindChildTraverse("rank_text").text = player.rating;
				m_PlayerPanel.FindChildTraverse("rank_text").text = player.dota_mind_score;
				m_PlayerPanel.FindChildTraverse("rank_index").text = index;
			}

		}
	}
}

function RebuildRank() {
	var pve = CustomNetTables.GetTableValue("rank_data", 'pve');
	if (pve != undefined) {
		refreshTopPanel('pve_mode_players', pve)
	}

	var solo = CustomNetTables.GetTableValue("rank_data", 'solo');
	if (solo != undefined) {
		refreshTopPanel('solo_mode_players', solo);
	}

	var duos = CustomNetTables.GetTableValue("rank_data", 'duos');
	if (duos != undefined) {
		refreshTopPanel('duos_mode_players', duos);
	}
}

// (function () {
// 	RebuildRank();
// 	var now = new Date();
// 	var currentSeason = $("#current_season");
// 	currentSeason.SetDialogVariable("year", now.getFullYear().toString());
// 	currentSeason.SetDialogVariableInt("season", Math.ceil((now.getMonth() + 1) / 3));

// 	CustomNetTables.SubscribeNetTableListener("rank_data", RebuildRank);
// })();