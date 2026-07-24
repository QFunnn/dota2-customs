--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

const dotaHud = GetDotaHud()

class HighFive {
    constructor() {
        this.RemoveOnRestart();
        this.playerId = Players.GetLocalPlayer();
        this.button = this.CreateButton();
        this.background = this.button.FindChildTraverse("CooldownBackground");
        this.label = this.button.FindChildTraverse("CooldownLabel");
        this.HighFiveKeyButtonLabel = this.button.FindChildTraverse("HighFiveKeyButtonLabel")
        this.heroIndex = Game.GetPlayerInfo(this.playerId).player_selected_hero_entity_index;
        this.keybind_button = null;
        this.SetBuffs();
        this.Tick();
        this.CheckSubscription()
    }
    RemoveOnRestart() {
        dotaHud.FindChildrenWithClassTraverse("__HF_Remove__").forEach(panel => panel.DeleteAsync(0));
    }
    CreateButton() {
        var container = dotaHud.FindChildrenWithClassTraverse("TertiaryAbilityContainer")[0];
        if (!container)
            return;
        var high_five = $.CreatePanel("Button", $.GetContextPanel(), "HighFive", { class: "__HF_Remove__" });
        high_five.BLoadLayoutSnippet("HighFiveSnippet");
        high_five.SetPanelEvent("onactivate", () => this.HighFive());
        high_five.SetPanelEvent("onmouseover", () => {
            var entindex = Players.GetLocalPlayerPortraitUnit();
            $.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", this.button, "high_five", entindex);
        });
        high_five.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideAbilityTooltip", high_five));
        high_five.SetParent(container);
        return high_five;
    }
    SetBuffs(margin = "186px") {
        var buffs = FindDotaHudElement("buffs");
        if (buffs)
            buffs.style.marginBottom = margin;
        var debuffs = FindDotaHudElement("debuffs");
        if (debuffs)
            debuffs.style.marginBottom = margin;
    }
    HighFive() 
    {
        var selected_index = Players.GetLocalPlayerPortraitUnit();
        if (this.heroIndex != selected_index)
            return;
        GameEvents.SendCustomGameEventToServer( "StartHighFive", {} );
    } 
    HighFiveBind() 
    {
        GameEvents.SendCustomGameEventToServer( "StartHighFive", {} );
    } 
    FindModifierCustom(unit, modifier)
    {
        for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
        {
            if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
            {
                return Entities.GetBuff(unit, i);
            }
        }
        return "none"
    }
    Tick() 
    {
        var selected_index = Players.GetLocalPlayerPortraitUnit();
        this.button.SetHasClass("Hidden", !Entities.IsRealHero(selected_index));
        this.heroIndex = Game.GetPlayerInfo(this.playerId).player_selected_hero_entity_index;
        let modifier_cha_high_cooldown = this.FindModifierCustom(selected_index, "modifier_cha_high_cooldown")

        if (this.heroIndex == selected_index && modifier_cha_high_cooldown != "none") 
        {
            var cooldown = Buffs.GetRemainingTime( selected_index, modifier_cha_high_cooldown );
            var max_cooldown = Buffs.GetDuration( selected_index, modifier_cha_high_cooldown );
            if (cooldown > 0)
            {
                this.label.text = String(Math.ceil(cooldown));
                this.background.visible = true;
                this.label.visible = true;
                let current_deg = -360 * (cooldown / max_cooldown)
                this.background.style.clip = "radial( 50.0% 50.0%, 0deg, " + current_deg + "deg)"
            }
            else
            {
                this.label.text = "";
                this.background.visible = false;
                this.label.visible = false;
            }
        }
        else 
        {
            this.background.visible = false;
            this.label.visible = false;
        }

        $.Schedule(0.03, () => this.Tick());
    }
    CheckSubscription() 
    {
        let player_table = CustomNetTables.GetTableValue("players_server_info", `player_${Players.GetLocalPlayer()}`)
        let bBattlePassActive = player_table && player_table.profile && player_table.profile.battle_pass && player_table.profile.battle_pass.status == 1
        if (bBattlePassActive) 
        {
            this.button.style.brightness = "1.0";
            this.button.SetPanelEvent("onactivate", () => this.HighFive());
            this.button.SetPanelEvent("onmouseover", () => {
                var entindex = Players.GetLocalPlayerPortraitUnit();
                $.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", this.button, "high_five", entindex);
            });
            this.button.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideAbilityTooltip", this.button));
            return;
        }
        else {
            this.button.style.brightness = "0.5";
            this.button.ClearPanelEvent("onactivate");
            this.button.SetPanelEvent("onmouseover", () => $.DispatchEvent("DOTAShowTextTooltip", this.button, "Для использовании нужен боевой пропуск!"));
            this.button.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip", this.button));
            $.Msg("ddd")
        }
        $.Schedule(5, () => this.CheckSubscription);
    }
}
var highfive = new HighFive();