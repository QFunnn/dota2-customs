--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

function HighFiveInit()
{
    let high_five_woda = FindDotaHudElement("high_five_woda")
    if (high_five_woda)
    {
        high_five_woda.DeleteAsync(0);
    }
    var container = GetDotaHud().FindChildrenWithClassTraverse("TertiaryAbilityContainer")[0];
    if (container)
    {
        var high_five = $.CreatePanel("Button", $.GetContextPanel(), "high_five_woda");
        high_five.BLoadLayoutSnippet("HighFiveSnippet");
        high_five.SetPanelEvent("onactivate", () => HighFive());
        high_five.SetPanelEvent("onmouseover", () => {
            var entindex = Players.GetLocalPlayerPortraitUnit();
            $.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", high_five, "high_five", entindex);
        });
        high_five.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideAbilityTooltip", high_five));
        high_five.SetParent(container);
    }
    SetBuffs()
    Tick()
}

function HighFive()
{
    var selected_index = Players.GetLocalPlayerPortraitUnit();
    let heroIndex = Game.GetPlayerInfo(Game.GetLocalPlayerID()).player_selected_hero_entity_index
    if (heroIndex != selected_index)
    {
        return;
    }
    GameEvents.SendCustomGameEventToServer_custom( "StartHighFive", {} );
}

function Tick() 
{
    let high_five_woda = FindDotaHudElement("high_five_woda")
    var selected_index = Players.GetLocalPlayerPortraitUnit();
    let heroIndex = Game.GetPlayerInfo(Game.GetLocalPlayerID()).player_selected_hero_entity_index
    if (high_five_woda)
    {
        let label = high_five_woda.FindChildTraverse("CooldownLabel")
        let background = high_five_woda.FindChildTraverse("CooldownBackground")
        high_five_woda.SetHasClass("Hidden", !Entities.IsRealHero(selected_index));
        if (heroIndex == selected_index) 
        {
            var ability = Entities.GetAbilityByName(selected_index, "high_five_custom");
            if (ability)
            {
                var cooldown = Abilities.GetCooldownTimeRemaining(ability);
                var cooldown_ready = Abilities.IsCooldownReady(ability);
                var max_cooldown = Abilities.GetCooldownLength(ability);
                label.text = cooldown_ready ? "" : String(Math.ceil(cooldown));
                background.visible = !cooldown_ready;
                label.visible = !cooldown_ready;
                if (!cooldown_ready) 
                {
                    var progress = (cooldown / max_cooldown) * -360;
                    background.style.clip = `radial(50% 75%, 0deg, ${progress}deg)`;
                }
            }
        }
        else
        {
            background.visible = false;
            label.visible = false;
        }
    }
    $.Schedule(0.03, () => Tick());
}

function SetBuffs() 
{
    var buffs = FindDotaHudElement("buffs");
    if (buffs)
        buffs.style.marginBottom = "196px";
    var debuffs = FindDotaHudElement("debuffs");
    if (debuffs)
        debuffs.style.marginBottom = "196px";
}

HighFiveInit()