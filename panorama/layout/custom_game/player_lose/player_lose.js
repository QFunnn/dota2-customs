--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function Confirm() 
{
    $("#PlayerLosePanel").AddClass("Hidden");
}

function ShowPlayerLose(keys) 
{
    $("#PlayerLosePanel").RemoveClass("Hidden");
    $("#RankInner2").text = keys.game_rank;
    $("#RankInner3").text = " / "+keys.valid_team;
    DotaMindScoreChanged();
}

function GetCurrentSeason()
{
    // let tbl = CustomNetTables.GetTableValue("cha_server_data", "current_season")
    // if (tbl && tbl.season)
    // {
    //     return tbl.season
    // }
    return 1
}

function DotaMindScoreChanged() 
{
     var player_data = CustomNetTables.GetTableValue("mmr_player", String(Players.GetLocalPlayer()));
     let player_data_main = CustomNetTables.GetTableValue("players_server_info", `player_${Players.GetLocalPlayer()}`)

     if ( player_data && player_data_main)
     {
        $("#DotaMindLabel").text = $.Localize("#dota_mind_score");
     	$("#DotaMindInner1").text = parseInt(player_data.original_rating);
        $("#DotaMindInner3").text = parseInt(player_data.new_rating);

	    if (parseInt(player_data.original_rating) >= parseInt(player_data.new_rating))
	    {
	    	$("#DotaMindInner2").AddClass("Red")
	    	$("#DotaMindInner3").AddClass("Red")
	    }
	    if (parseInt(player_data.original_rating) < parseInt(player_data.new_rating))
	    {
	    	$("#DotaMindInner2").AddClass("Green")
	    	$("#DotaMindInner3").AddClass("Green")
	    }
    }
}

(function () {
    GameEvents.Subscribe("ShowPlayerLose", ShowPlayerLose);
    CustomNetTables.SubscribeNetTableListener("mmr_player", DotaMindScoreChanged);
})();