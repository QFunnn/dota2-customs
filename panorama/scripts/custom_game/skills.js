--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LPID = Players.GetLocalPlayer();
const SkillSelectorSkillBody = $("#SkillSelectorSkillBody")
const SkillSelectorPanelRoot = $("#SkillSelectorPanelRoot")
const info_panel_hover = $("#info_panel_hover")

let SKILLS_LIST_TABLE = {}
let PLAYERS_SKILLS_INFO = {}

// let parentHUDElements = FindDotaHudElement("HUDElements");
// $.GetContextPanel().SetParent(parentHUDElements);

SubscribeAndFireNetTableByKey("globals", `skills_info`, function(v){
    SKILLS_LIST_TABLE = v
})

for (const PlayerID of Game.GetAllPlayerIDs()) {
    SubscribeAndFireNetTableByKey("players", `player_${PlayerID}_skills`, function(v){
        PLAYERS_SKILLS_INFO[PlayerID] = v
    })
}

SubscribeAndFirePlayerTableByKey(`player_${LPID}`, `skills_selecting`, function(v, bIsDelete){
    if(!bIsDelete){
        CreateSkills(toArray(v))
    }else{
        CloseSkillSelecting()
    }
})

SetShowText(info_panel_hover, "#skill_selected_upgrade_round")

function CreateSkills(List){
    UpdateAbilityMask()
    let i = 0
    for (const SkillName of List) {
        let SkillInfo = SKILLS_LIST_TABLE[SkillName]
        if(SkillInfo == undefined){continue}

        let p = GetOrCreateSkill(i)

        let SkillPanel = p.FindChildTraverse("SkillPanel")
        if(SkillPanel){
            SkillPanel.style.backgroundImage = 'url("file://{images}/items/' + SkillInfo.icon + '.png")';
            SkillPanel.style.backgroundSize = "100%"
        }

        let Pct = ""
        if(SkillInfo.is_percent == 1){
            Pct = "%"
        }

        let SkillDesc = `<font color='gold'>${ModifyPlus(SkillInfo.value)}${Pct}</font>${$.Localize(`#SKILL_${SkillName}_desc`)}`

        p.SetDialogVariable("skill_desc", SkillDesc)

        p.SetPanelEvent("onactivate", function(){
            GameEvents.SendCustomGameEventToServer( "builder_skill_selected", {skill_name : SkillName} );
        })

        i++;
    }
}

function ShowSkillSelecting(){
    SkillSelectorPanelRoot.AddClass("ShowCustom")
}

GameUI.CustomUIConfig().ShowSkillSelecting = ShowSkillSelecting

function CloseSkillSelecting(){
    SkillSelectorPanelRoot.RemoveClass("ShowCustom")
}

GameUI.CustomUIConfig().CloseSkillSelecting = CloseSkillSelecting

function IsOpened(){
    return SkillSelectorPanelRoot.BHasClass("ShowCustom")
}

GameUI.CustomUIConfig().IsOpened = IsOpened

function UpdateAbilityMask() 
{
    if (SkillSelectorSkillBody.cooldown == undefined) 
    {
        SkillSelectorSkillBody.cooldown = 0.8
        for (var i = 0; i < 5; i++) 
        {
            var panelID = "Skill_"+i;
            var panel = SkillSelectorSkillBody.FindChildTraverse(panelID);
            if (panel!=undefined)
            {
                panel.enabled = false;
                panel.FindChildTraverse("CooldownOverlay").RemoveClass("Hidden");
            }
        }
    }

    var angle = SkillSelectorSkillBody.cooldown / 0.8 * 360;
    SkillSelectorSkillBody.cooldown = SkillSelectorSkillBody.cooldown - 0.04

    if (SkillSelectorSkillBody.cooldown<=0)
    {
        SkillSelectorSkillBody.cooldown = undefined
        for (var i = 0; i < 5; i++) 
        {
            var panelID = "Skill_"+i;
            var panel = SkillSelectorSkillBody.FindChildTraverse(panelID);
            if (panel!=undefined)
            {
                panel.enabled = true;
                panel.FindChildTraverse("CooldownOverlay").AddClass("Hidden");
            }
        }
    }
    else 
    {
        for (var i = 0; i < 5; i++) 
        {
            var panelID = "Skill_"+i;
            var panel = SkillSelectorSkillBody.FindChildTraverse(panelID);
            if (panel!=undefined)
            {
                panel.FindChildTraverse("CooldownOverlay").style.clip="radial( 50.0% 50.0%, 0.0deg, -"+angle+"deg)";
            }               
        }
        $.Schedule(0.04, UpdateAbilityMask)
    } 
}

function SetShowText(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, text); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function ModifyPlus(num)
{
    if (num > 0)
    {
        return "+"+num
    }
    return num
}

function GetOrCreateSkill(Num){
    let f = SkillSelectorSkillBody.FindChildTraverse(`Skill_${Num}`)
    if(f){
        return f
    }else{
        let p = $.CreatePanel("Panel", SkillSelectorSkillBody, `Skill_${Num}`, {})
        p.BLoadLayoutSnippet("SkillRow")

        return p
    }
}