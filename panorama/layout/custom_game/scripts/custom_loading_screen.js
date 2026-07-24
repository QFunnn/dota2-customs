--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
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
            $("#ChoosePayMethode").SetHasClass("IsOpacity", false)
        }
    }
}

function PaymentClose()
{
    $("#ChoosePayMethode").SetHasClass("IsOpacity", true)
}

function RequestUrl(xsolla)
{
    if (xsolla)
    {
        $.DispatchEvent('ExternalBrowserGoToURL', 'https://shop.world-of-dota.com/ru-RU');
    }
    else
    {
        $.DispatchEvent('ExternalBrowserGoToURL', 'https://funpay.com/users/19824830/');
    }
}

if ($.Language() == "russian")
{
    $("#WowBanner").style.opacity = "1"
}

CreateEventLinks()