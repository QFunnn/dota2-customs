--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const SkillsPlayer = $("#SkillsPlayer")
const LPID = Players.GetLocalPlayer();

let LastSkills = undefined

var parentHUDElements = FindDotaHudElement("HUDElements");
if (parentHUDElements)
{
    var center_block = parentHUDElements.FindChildTraverse("center_block");
    var StatBranch = FindDotaHudElement("AbilitiesAndStatBranch")
    $.GetContextPanel().SetParent(center_block);
    let SkillsPlayerFind = StatBranch.FindChildTraverse("SkillsPlayer")
    if (SkillsPlayerFind && SkillsPlayerFind.IsValid())
    {
        SkillsPlayerFind.DeleteAsync(0.0)
    }
    SkillsPlayer.SetParent(StatBranch.GetChild(0));
}

function UpdateHeroHudBuffs()
{
    let select_target = Players.GetLocalPlayerPortraitUnit()
    if (select_target == null)
    {
        $.Schedule(0.01, UpdateHeroHudBuffs)
        return
    }
    if (!Entities.IsHero( select_target ))
    {
        if (SkillsPlayer)
        {
            SkillsPlayer.style.visibility = "collapse"
        }
        $.Schedule(0.01, UpdateHeroHudBuffs)
        return
    }

    if (SkillsPlayer)
    {
        SkillsPlayer.style.visibility = "visible"
        let SkillsIcon = SkillsPlayer.FindChildTraverse("SkillsIcon")
        if(SkillsIcon){
            SetShowText(SkillsIcon,Entities.GetPlayerOwnerID( select_target ))
        }
    }
    $.Schedule(0.01, UpdateHeroHudBuffs)
}

UpdateHeroHudBuffs()

function SetShowText(panel, player_id)
{   
    panel.SetPanelEvent("onmouseover", () => 
    {
        $.DispatchEvent(
            "UIShowCustomLayoutParametersTooltip",
            panel,
            "skill_tooltip",
            "file://{resources}/layout/custom_game/skill_block/skill_tooltip.xml",
            "player_id=" + player_id,
        );
    });

    panel.SetPanelEvent("onmouseout", () => 
    {
        $.DispatchEvent("UIHideCustomLayoutTooltip", panel, "skill_tooltip");
    });
}

SubscribeAndFirePlayerTableByKey(`player_${LPID}`, `skills_selecting`, function(v, bIsDelete){
    if(bIsDelete){
        LastSkills = undefined
    }else{
        LastSkills = v
    }
    SkillsPlayer.SetHasClass("HasSkills", !bIsDelete)
    if(LastSkills == undefined){
        if(GameUI.CustomUIConfig().CloseSkillSelecting){
            GameUI.CustomUIConfig().CloseSkillSelecting()
        }
    }
})

function ToggleSkills(){
    if(GameUI.CustomUIConfig().IsOpened && GameUI.CustomUIConfig().IsOpened()){
        if(GameUI.CustomUIConfig().CloseSkillSelecting){
            GameUI.CustomUIConfig().CloseSkillSelecting()
        }
        SkillsPlayer.RemoveClass("Opened")
    }else{
        if(GameUI.CustomUIConfig().ShowSkillSelecting && LastSkills != undefined){
            GameUI.CustomUIConfig().ShowSkillSelecting(toArray(LastSkills))
        }
        SkillsPlayer.AddClass("Opened")
    }
}

// [NP-24] Пинг навыков (мод-механика, выдаётся каждые 5 ур.): «Посмотрите мои навыки» / «навыки
// героя X» + иконка навыков (talents2.png — её же использует #SkillsIcon).
function PingSkills(){
    let cfg = GameUI.CustomUIConfig()
    if(!cfg || !cfg.SendPingTextToChat){ return }
    let unit = Players.GetLocalPlayerPortraitUnit()
    if(unit == undefined || unit == -1 || !Entities.IsHero(unit)){ return }
    let icon = "<img class='PingSkillIcon' src='file://{images}/custom_game/talents2.png'/>"
    let msg
    if(Entities.GetPlayerOwnerID(unit) == LPID){
        msg = icon + $.Localize("#PING_SHOW_MY_SKILLS")
    }else{
        msg = icon + $.Localize("#PING_SHOW_HERO_SKILLS").replace("%s1", $.Localize("#"+Entities.GetUnitName(unit)))
    }
    cfg.SendPingTextToChat(msg)
}

// Alt-клик по «+» (OpenButton) → пинг; обычный клик — открыть выбор навыков (как было).
let _OpenButton = SkillsPlayer.FindChildTraverse("OpenButton")
if(_OpenButton){
    _OpenButton.SetPanelEvent("onactivate", function(){
        if(IsDotaAltPressed()){ PingSkills() } else { ToggleSkills() }
    })
}
// Alt-клик по иконке навыков → пинг (обычный клик по иконке ничего не делал).
let _SkillsIconP = SkillsPlayer.FindChildTraverse("SkillsIcon")
if(_SkillsIconP){
    _SkillsIconP.hittest = true
    _SkillsIconP.SetPanelEvent("onactivate", function(){ if(IsDotaAltPressed()){ PingSkills() } })
}