--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


(function()
{
	$.CreatePanel("Movie", $("#loading_screen"), "Movie", { src: "file://{resources}/videos/custom_game/woda_loading.webm", style: "width:100%;height:100%;", controls: "none", repeat:"true", hittest: "false", autoplay:"onload" });
})();


var hittestBlocker = $.GetContextPanel().GetParent().FindChild("SidebarAndBattleCupLayoutContainer");
if (hittestBlocker) 
{
    hittestBlocker.hittest = false;
    hittestBlocker.hittestchildren = false;
}

var timer_info = -1
var hints_info = 
[
    // id, image_name, hint name, hint description
    ["1", "hints_1", "#hints_1_description"],
    ["1", "hints_2", "#hints_2_description"],
    ["1", "hints_3", "#hints_3_description"],
    ["1", "hints_4", "#hints_4_description"],
    ["1", "hints_5", "#hints_5_description"],
    ["1", "hints_6", "#hints_6_description"],
    ["1", "hints_7", "#hints_7_description"],
    ["1", "hints_8", "#hints_8_description"],
    ["1", "hints_9", "#hints_9_description"],
    ["1", "hints_10", "#hints_10_description"],
    ["1", "hints_11", "#hints_11_description"],
    ["1", "hints_12", "#hints_12_description"],
    ["1", "hints_13", "#hints_13_description"],
    ["1", "hints_14", "#hints_14_description"],
    ["1", "hints_15", "#hints_15_description"],
    ["1", "hints_16", "#hints_16_description"],
    ["1", "hints_17", "#hints_17_description"],
    ["1", "hints_18", "#hints_18_description"],
    ["1", "hints_19", "#hints_19_description"],
    ["1", "hints_20", "#hints_20_description"],
    ["1", "hints_21", "#hints_21_description"],
    ["1", "hints_22", "#hints_22_description"],
    ["1", "hints_23", "#hints_23_description"],
    ["1", "hints_24", "#hints_24_description"],
    ["1", "hints_25", "#hints_25_description"],
    ["1", "hints_26", "#hints_26_description"],
]

RestartUpdateInfo()

function RestartUpdateInfo()
{
    if (timer_info != -1) 
    {
        $.CancelScheduled(timer_info)
        timer_info = -1
    }

    for (var i = 0; i < hints_info.length; i++) 
    {
        var NavigationWidget = $.CreatePanel("Panel", $("#NavigationWidgets"), "");
        NavigationWidget.AddClass("NavigationWidget");
        if (i == 0)
        {
            NavigationWidget.AddClass("NavigationWidget_Active");
        }
    }

    current_info = getRandomInt(hints_info.length)

    $("#PanelHintsImage").style.backgroundImage = 'url("file://{images}/custom_game/talents/' + hints_info[current_info][1] + '.png")';
    $("#PanelHintsImage").style.backgroundSize = "100%"
    $("#PanelHintsDescription").text = $.Localize(hints_info[current_info][2])

    for (var i = 0; i < $("#NavigationWidgets").GetChildCount(); i++) 
    {
        if (i == current_info)
        {
            $("#NavigationWidgets").GetChild(i).SetHasClass("NavigationWidget_Active", true)
        }
        else
        {
            $("#NavigationWidgets").GetChild(i).SetHasClass("NavigationWidget_Active", false)
        }
    }

    timer_info = $.Schedule(20, RestartUpdateNext);
}

function getRandomInt(max) 
{
    return Math.floor(Math.random() * max);
}

function RestartUpdateNext()
{
    current_info = current_info + 1

    if (current_info > hints_info.length - 1)
    {
        current_info = 0
    }

    if (current_info < 0)
    {
        current_info = hints_info.length - 1
    }

    $("#PanelHintsImage").style.backgroundImage = 'url("file://{images}/custom_game/talents/' + hints_info[current_info][1] + '.png")';
    $("#PanelHintsImage").style.backgroundSize = "100%"
    $("#PanelHintsDescription").text = $.Localize(hints_info[current_info][2])

    for (var i = 0; i < $("#NavigationWidgets").GetChildCount(); i++) 
    {
        if (i == current_info) {
            $("#NavigationWidgets").GetChild(i).SetHasClass("NavigationWidget_Active", true)
        }
        else {
            $("#NavigationWidgets").GetChild(i).SetHasClass("NavigationWidget_Active", false)
        }
    }

    timer_info = $.Schedule(20, RestartUpdateNext);
}
function HintsSwap(style)
{
    if (timer_info != -1) 
    {
        $.CancelScheduled(timer_info)
        timer_info = -1
    }

    if (style == "right")
    {
        current_info = current_info + 1
    } else {
        current_info = current_info - 1
    }

    if (current_info > hints_info.length - 1) 
    {
        current_info = 0
    }

    if (current_info < 0) 
    {
        current_info = hints_info.length - 1
    }

    $("#PanelHintsImage").style.backgroundImage = 'url("file://{images}/custom_game/talents/' + hints_info[current_info][1] + '.png")';
    $("#PanelHintsImage").style.backgroundSize = "100%"
    $("#PanelHintsDescription").text = $.Localize(hints_info[current_info][2])

    for (var i = 0; i < $("#NavigationWidgets").GetChildCount(); i++) {
        if (i == current_info) {
            $("#NavigationWidgets").GetChild(i).SetHasClass("NavigationWidget_Active", true)
        }
        else {
            $("#NavigationWidgets").GetChild(i).SetHasClass("NavigationWidget_Active", false)
        }
    }

    timer_info = $.Schedule(20, RestartUpdateNext);
}

function FindDotaHudElementLoading(id) 
{
    var hudRoot;
    for (panel = $.GetContextPanel(); panel != null; panel = panel.GetParent()) {
        hudRoot = panel;
    }
    var comp = hudRoot.FindChildTraverse(id);
    return comp;
}

let loading_chat = FindDotaHudElementLoading('LoadingScreenChat')
if (loading_chat) 
{
    loading_chat.style.opacity = "0"
}

function CreateEventLinks()
{
    if (!GameEvents.Subscribe_custom)
    {
        $.Schedule(0.2, CreateEventLinks)
        return
    }
    GameEvents.Subscribe_custom("event_woda_open_links", event_woda_open_links)
    function event_woda_open_links()
    {
        $("#LinksButtons").style.opacity = "1"
    }
}

function LinkToStore()
{
    let localplayer_data = Game.GetCustomTable("woda_player_data", String(Players.GetLocalPlayer()));
    if (localplayer_data)
    {
        if (localplayer_data.games >= 1 || Game.IsInToolsMode())
        {
            XsollaOpenProducts()
        }
    }
}

WodaShowAdBanner($("#WowBanner"))

CreateEventLinks()

var WODA_ROSTER_STATE_KEYS = {
    waiting: "#woda_roster_waiting",
    connecting: "#woda_roster_connecting",
    loaded: "#woda_roster_loaded",
    left: "#woda_roster_left"
}
var g_WodaRosterRows = {}

function WodaRosterPlayers(data)
{
    var players = []
    if (!data || !data.players || data.phase === "started")
    {
        return players
    }
    var keys = Object.keys(data.players).sort(function(a, b) { return Number(a) - Number(b) })
    for (var i = 0; i < keys.length; i++)
    {
        var player = data.players[keys[i]]
        if (player && player.id)
        {
            players.push(player)
        }
    }
    return players
}

function WodaRosterRow(list, id)
{
    var row = g_WodaRosterRows[id]
    if (row && row.IsValid())
    {
        return row
    }
    row = $.CreatePanel("Panel", list, "")
    row.AddClass("WodaRosterPlayer")
    var avatar = $.CreatePanel("DOTAAvatarImage", row, "", { accountid: id })
    avatar.AddClass("WodaRosterAvatar")
    var name = $.CreatePanel("DOTAUserName", row, "", { accountid: id })
    name.AddClass("WodaRosterName")
    var state = $.CreatePanel("Label", row, "WodaRosterState")
    state.AddClass("WodaRosterState")
    g_WodaRosterRows[id] = row
    return row
}

function WodaRosterTime(seconds)
{
    var rest = seconds % 60
    return Math.floor(seconds / 60) + ":" + (rest < 10 ? "0" : "") + rest
}

function WodaLoadingRoster()
{
    var root = $("#WodaRoster")
    var list = $("#WodaRosterList")
    var data = CustomNetTables.GetTableValue("woda_connect", "expected")
    var players = WodaRosterPlayers(data)
    if (root && list)
    {
        root.SetHasClass("Visible", players.length > 0)
        root.SetHasClass("Cancelled", !!data && data.phase === "cancelled")
        var keep = {}
        var previous = null
        for (var i = 0; i < players.length; i++)
        {
            var id = String(players[i].id)
            var state = WODA_ROSTER_STATE_KEYS[players[i].state] ? players[i].state : "waiting"
            var row = WodaRosterRow(list, id)
            keep[id] = true
            if (previous)
            {
                list.MoveChildAfter(row, previous)
            }
            else if (list.GetChild(0) !== row)
            {
                list.MoveChildBefore(row, list.GetChild(0))
            }
            previous = row
            for (var key in WODA_ROSTER_STATE_KEYS)
            {
                row.SetHasClass("State_" + key, key === state)
            }
            var label = row.FindChildTraverse("WodaRosterState")
            if (label)
            {
                label.text = $.Localize(WODA_ROSTER_STATE_KEYS[state])
            }
        }
        for (var rowId in g_WodaRosterRows)
        {
            if (!keep[rowId])
            {
                if (g_WodaRosterRows[rowId].IsValid())
                {
                    g_WodaRosterRows[rowId].DeleteAsync(0)
                }
                delete g_WodaRosterRows[rowId]
            }
        }
        if (players.length > 0)
        {
            var count = $("#WodaRosterCount")
            count.SetDialogVariableInt("loaded", Number(data.loaded) || 0)
            count.SetDialogVariableInt("total", Number(data.total) || players.length)
            count.text = $.Localize("#woda_roster_count", count)
            var seconds = Math.max(0, Math.floor(Number(data.seconds_left) || 0))
            var countdown = $("#WodaRosterCountdown")
            countdown.text = seconds > 0 ? WodaRosterTime(seconds) : ""
        }
    }
    $.Schedule(1.0, WodaLoadingRoster)
}

WodaLoadingRoster()

function WodaLoadingArenaLogo()
{
    var info = Game.GetMapInfo()
    var map = info && info.map_display_name
    if (!map)
    {
        $.Schedule(0.5, WodaLoadingArenaLogo)
        return
    }
    $("#PanelHintsImageLogo").SetHasClass("ArenaLogo", /^(arena|1_player|4_player)$/.test(map))
}

WodaLoadingArenaLogo()