--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var DATA_TABLE_SERVER = 
{
    "end_game_score" : {},
}

GameEvents.Subscribe_custom( 'event_update_scoreboard_data', event_update_scoreboard_data );
function event_update_scoreboard_data(data)
{
    if (DATA_TABLE_SERVER[data.table_name])
    {
        UpdateEndGameScore(data.key, data.data)
    }
}

function UpdateEndGameScore(key, data) 
{
    $("#EndDuelScore").style.visibility = "visible"
    if (Game.GetMapInfo().map_display_name == "rating_duo" || Game.GetMapInfo().map_display_name == "rating_duo_300")
    {
        if (key == "player_1")
        {
            let count = 0
            var teamPlayers = Game.GetPlayerIDsOnTeam(data.team)
            for (var playerId of teamPlayers) 
            {
                count = count + 1
                if (count == 1)
                {
                    let playerInfo = Game.GetPlayerInfo(playerId);
                    $("#PlayerIcon1").style.backgroundImage = 'url( "file://{images}/heroes/icons/' + GetPortraitHero(playerInfo.player_selected_hero) + '.png" );'
                    $("#PlayerIcon1").style.backgroundSize = "100%"
                }
                else if (count == 2)
                {
                    let playerInfo = Game.GetPlayerInfo(playerId);
                    $("#PlayerIcon1_1").style.backgroundImage = 'url( "file://{images}/heroes/icons/' + GetPortraitHero(playerInfo.player_selected_hero) + '.png" );'
                    $("#PlayerIcon1_1").style.backgroundSize = "100%"
                    $("#PlayerIcon1_1").style.visibility = "visible"
                }
            }
            $("#PlayerScore1").text = String(data.score || 0)
        }
        if (key == "player_2")
        {
            let count = 0
            var teamPlayers = Game.GetPlayerIDsOnTeam(data.team)
            for (var playerId of teamPlayers) 
            {
                count = count + 1
                if (count == 1)
                {
                    let playerInfo = Game.GetPlayerInfo(playerId);
                    $("#PlayerIcon2").style.backgroundImage = 'url( "file://{images}/heroes/icons/' + GetPortraitHero(playerInfo.player_selected_hero) + '.png" );'
                    $("#PlayerIcon2").style.backgroundSize = "100%"
                }
                else if (count == 2)
                {
                    let playerInfo = Game.GetPlayerInfo(playerId);
                    $("#PlayerIcon2_2").style.backgroundImage = 'url( "file://{images}/heroes/icons/' + GetPortraitHero(playerInfo.player_selected_hero) + '.png" );'
                    $("#PlayerIcon2_2").style.backgroundSize = "100%"
                    $("#PlayerIcon2_2").style.visibility = "visible"
                }
            }
            $("#PlayerScore2").text = String(data.score || 0)
        }
        return
    }
    if (key == "player_1")
    {
        $("#PlayerScore1").text = String(data.score || 0)
        $("#PlayerIcon1").style.backgroundImage = 'url( "file://{images}/heroes/icons/' + GetPortraitHero(data.hero) + '.png" );'
        $("#PlayerIcon1").style.backgroundSize = "100%"
    }
    if (key == "player_2")
    {
        $("#PlayerScore2").text = String(data.score || 0)
        $("#PlayerIcon2").style.backgroundImage = 'url( "file://{images}/heroes/icons/' + GetPortraitHero(data.hero) + '.png" );'
        $("#PlayerIcon2").style.backgroundSize = "100%"
    }
}