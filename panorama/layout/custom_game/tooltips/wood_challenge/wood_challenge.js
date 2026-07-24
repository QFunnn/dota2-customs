--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const TOOLTIP_PANELS =
{
    TooltipHeaderLabel : $("#TooltipHeaderLabel"),
    TooltipDescriptionLabel : $("#TooltipDescriptionLabel"),
}

function UpdateTooltip()
{
    let parent = $.GetContextPanel().GetParent().GetParent();
    let ArrowHidden = (name) => 
    {
        parent.FindChildTraverse(name).visible = false;
    };
    ArrowHidden("TopArrow");
    ArrowHidden("RightArrow");
    ArrowHidden("BottomArrow");
    ArrowHidden("LeftArrow");

    $("#Text_17").SetDialogVariable("value", "<font color='#b87ffd'>" + GetLevelUpKeyBind("ability", 8) + "</font>")
    $("#Text_17").text = $.Localize("#abyss_challange_label_15", $("#Text_17"))

    UpdateAutocastStatus()
}

function UpdateAutocastStatus()
{
    let ctx = $.GetContextPanel()
    if (!ctx || !ctx.IsValid()) { return }

    let statusWindow = $("#WoodAutocastWindow")
    let statusLabel = $("#WoodAutocastStatus")
    if (statusWindow && statusLabel)
    {
        let st = Game.GetCustomTable("abyss_state", String(Game.GetLocalPlayerID())) || {}
        let unlocked = Number(st.autocast_unlocked || 0) === 1
        let enabled = Number(st.autocast_enabled || 0) === 1
        statusWindow.SetHasClass("AutocastWindowHidden", !unlocked)
        if (unlocked)
        {
            statusLabel.text = $.Localize(enabled ? "#trial_autocast_enabled" : "#trial_autocast_disabled")
            statusLabel.SetHasClass("AutocastOn", enabled)
            statusLabel.SetHasClass("AutocastOff", !enabled)
        }
    }

    $.Schedule(0.1, UpdateAutocastStatus)
}