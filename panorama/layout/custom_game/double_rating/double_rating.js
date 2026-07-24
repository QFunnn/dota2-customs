--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom( 'open_win_predict', open_win_predict);

function open_win_predict()
{
    var PLAYER_DATA = Game.GetCustomTable("woda_player_data", String(Players.GetLocalPlayer()));
    let visible = false
    if (PLAYER_DATA && PLAYER_DATA.double_tokens && PLAYER_DATA.double_tokens > 0) 
    { 
        visible = true
        $("#RewardRefreshCount").text = PLAYER_DATA.double_tokens
    }
    if (!visible) 
    { 
        return 
    }
    $("#WinPredict").SetHasClass("open", true)
    $.Schedule(1, function()
    {
        $("#WinPredict").SetHasClass("Pulse", true)
    })
}

GameEvents.Subscribe_custom( 'win_predict_timer', win_predict_timer);
function win_predict_timer(data)
{
    $("#RewardTimeCount").text = data.time
    let radial_number = -360 * ( data.time / 30 )
    $("#RewardTime").style.clip = 'radial( 50.0% 50.0%, 0.0deg, ' + radial_number + 'deg);'
}

GameEvents.Subscribe_custom( 'close_win_predict', close_win_predict);
function close_win_predict()
{
    $("#WinPredict").SetHasClass("open", false)
}

function WinCondition()
{
    if (!$("#WinPredict").BHasClass("open")) { return }
    $("#WinPredict").SetHasClass("open", false)
    GameEvents.SendCustomGameEventToServer_custom( "win_condition_predict", {} );
    $("#RewardRefreshCount").text = Number($("#RewardRefreshCount").text) - 1
}
 
//open_win_predict()