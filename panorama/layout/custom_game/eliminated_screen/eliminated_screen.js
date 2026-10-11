--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var ELIMINATED_DATA = null
var ELIMINATED_IS_DEFAULT_STATS = true

GameEvents.Subscribe_custom("woda_player_eliminated", OnPlayerEliminated)

function OnPlayerEliminated(data)
{
    if (!data) { return }
    ELIMINATED_DATA = data
    var delay = Number(data.delay) || 0
    $.Schedule(delay, function()
    {
        if (ELIMINATED_DATA === data)
        {
            EliminatedShow(data)
        }
    })
}

function EliminatedUpdateBackground()
{
    var CustomBg = $("#CustomBg")
    CustomBg.RemoveAndDeleteChildren()
    CustomBg.style.backgroundImage = "none"
    var PLAYER_DATA = Game.GetCustomTable ? Game.GetCustomTable("woda_player_data", String(Players.GetLocalPlayer())) : null
    if (PLAYER_DATA && PLAYER_DATA.background_id && typeof Background_Images !== "undefined" && Background_Images[PLAYER_DATA.background_id])
    {
        CustomBg.style.backgroundImage = 'url("' + Background_Images[PLAYER_DATA.background_id] + '")'
        CustomBg.style.backgroundSize = "100%"
        return
    }
    $.CreatePanel("MoviePanel", CustomBg, "MovieBackground", {
        class: "MovieBackground",
        src: "file://{resources}/videos/custom_game/woda_loading.webm",
        repeat: "true",
        hittest: "false",
        autoplay: "onload",
    })
}

function EliminatedShow(data)
{
    var root = $("#EliminatedRoot")
    var is_start_lose = data.reason == "report_ban"
    var reward_reason = data.reward_reason || ""
    root.SetHasClass("StartLose", is_start_lose)
    $("#EliminatedTitle").text = $.Localize(is_start_lose ? "#eliminated_title_start" : "#eliminated_title")

    var reason_text = ""
    if (is_start_lose || reward_reason == "reports")
    {
        reason_text = $.Localize("#player_banned_die")
    }
    else if (reward_reason == "not_enough_players")
    {
        reason_text = $.Localize("#player_connect_no_8")
    }
    else if (reward_reason == "free_disconnect")
    {
        reason_text = $.Localize("#is_game_free_disconnect")
    }
    var EliminatedReason = $("#EliminatedReason")
    EliminatedReason.text = reason_text
    EliminatedReason.visible = reason_text != ""

    ELIMINATED_IS_DEFAULT_STATS = true
    $.GetContextPanel().SetHasClass("AltStats", false)
    $("#EliminatedStatsButton").visible = IsPlayerHasSubscribe(Game.GetLocalPlayerID())

    var stats_panel = PlayerStatsPanel_Create($("#EliminatedStats"))
    PlayerStatsPanel_Fill(stats_panel, data)

    EliminatedUpdateBackground()
    root.SetHasClass("Visible", true)
}

function EliminatedChangeGameStats()
{
    ELIMINATED_IS_DEFAULT_STATS = !ELIMINATED_IS_DEFAULT_STATS
    $.GetContextPanel().SetHasClass("AltStats", !ELIMINATED_IS_DEFAULT_STATS)
}

function EliminatedClose()
{
    $("#EliminatedRoot").SetHasClass("Visible", false)
    $("#CustomBg").RemoveAndDeleteChildren()
}

function EliminatedLeave()
{
    $.DispatchEvent("DOTAHUDShowDashboard")
}

GameEvents.Subscribe("game_rules_state_change", function()
{
    if (Game.GetState() >= DOTA_GameState.DOTA_GAMERULES_STATE_POST_GAME)
    {
        EliminatedClose()
    }
})