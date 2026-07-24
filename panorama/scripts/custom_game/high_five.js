--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";


class HighFive {
    constructor() {
       // this.RemoveOnRestart();

        this.playerId = Players.GetLocalPlayer();
        this.button = this.CreateButton();
        this.background = this.button.FindChildTraverse("CooldownBackground");
        this.label = this.button.FindChildTraverse("CooldownLabel");
        this.HighFiveKeyButtonLabel = this.button.FindChildTraverse("HighFiveKeyButtonLabel")
        this.heroIndex = Game.GetPlayerInfo(this.playerId).player_selected_hero_entity_index;
        this.keybind_button = null;
        this.SetBuffs();
        this.Tick();
        this.SetKeyBind();
        this.CheckSubscription();
    }
    RemoveOnRestart() {
        dotaHud.FindChildrenWithClassTraverse("__HF_Remove__").forEach(panel => panel.DeleteAsync(0));
    }
    SetBuffs(margin = "196px") {
        var buffs = FindDotaHudElement("buffs");
        if (buffs)
            buffs.style.marginBottom = margin;
        var debuffs = FindDotaHudElement("debuffs");
        if (debuffs)
            debuffs.style.marginBottom = margin;
    }
    CreateButton() {


        var container = dotaHud.FindChildTraverse("HighFiveButton");
        if (!container)
            return;
        var high_five = $.CreatePanel("Button", $.GetContextPanel(), "HighFive", { class: "__HF_Remove__" });
        high_five.BLoadLayoutSnippet("HighFiveSnippet");
        high_five.SetPanelEvent("onactivate", () => this.HighFive());
        high_five.SetPanelEvent("onmouseover", () => {
            var entindex = Players.GetLocalPlayerPortraitUnit();
            $.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", this.button, "high_five_custom", entindex);
        });
        high_five.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideAbilityTooltip", high_five));
        high_five.SetParent(container);
        return high_five;
    }
    HighFive() 
    {
        var selected_index = Players.GetLocalPlayerPortraitUnit();
        if (this.heroIndex != selected_index)
            return;
        var ability = Entities.GetAbilityByName(this.heroIndex, "high_five_custom");
        if (ability)
            Abilities.ExecuteAbility(ability, this.heroIndex, false);
    } 
    HighFiveBind() 
    {
        let ability = Entities.GetAbilityByName(this.heroIndex, "high_five_custom");
        Abilities.ExecuteAbility( ability, this.heroIndex, true )
    } 
    SetKeyBind() 
    {
        if (this.keybind_button != Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP4))
        {
            this.keybind_button = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP4)
            const name_bind = "HighFiveBind" + Math.floor(Math.random() * 99999999);
            Game.AddCommand("+" + name_bind, () => this.HighFiveBind(), "", 0);
            Game.CreateCustomKeyBind(this.keybind_button, '+' + name_bind);
            this.HighFiveKeyButtonLabel.text = this.keybind_button
        }
    } 
    Tick() {
        
        var selected_index = Players.GetLocalPlayerPortraitUnit();
        this.button.SetHasClass("Hidden", !Entities.IsRealHero(selected_index));
        if (this.heroIndex == selected_index) {
            var ability = Entities.GetAbilityByName(selected_index, "high_five_custom");
            var cooldown = Abilities.GetCooldownTimeRemaining(ability);
            var cooldown_ready = Abilities.IsCooldownReady(ability);
            var max_cooldown = Abilities.GetCooldownLength(ability);
            this.label.text = cooldown_ready ? "" : String(Math.ceil(cooldown));
            this.background.visible = !cooldown_ready;
            this.label.visible = !cooldown_ready;
            if (!cooldown_ready) {
                var progress = (cooldown / max_cooldown) * -360;
                this.background.style.clip = `radial(50% 75%, 0deg, ${progress}deg)`;
            }
        }
        else {
            this.background.visible = false;
            this.label.visible = false;
        }
        this.SetKeyBind();
        this.heroIndex = Game.GetPlayerInfo(this.playerId).player_selected_hero_entity_index;
        $.Schedule(0.03, () => this.Tick());
    }
    CheckSubscription() 
    {

        let sub_table = CustomNetTables.GetTableValue("networth_players",  Players.GetLocalPlayer());
        var hasSubscription = false;

        if (sub_table && sub_table.subscribed && sub_table.subscribed == 1)
        {
            hasSubscription = true;
        }

        let data = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()));

        let lang = $.Localize("#lang")

        if ((data && data.total_games && data.total_games >= 5) || lang == "rus")
        {
            this.button.style.opacity = "1";
        }else 
        {
            this.button.style.opacity = "0";
            return
        }


        if (hasSubscription) 
        {
            this.button.style.brightness = "1.0";
            this.button.SetPanelEvent("onactivate", () => this.HighFive());
            this.button.SetPanelEvent("onmouseover", () => {
                var entindex = Players.GetLocalPlayerPortraitUnit();
                $.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", this.button, "high_five_custom", entindex);
            });
            this.button.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideAbilityTooltip", this.button));

        }
        else {
            this.button.style.brightness = "0.07";
            this.button.ClearPanelEvent("onactivate");
            this.button.SetPanelEvent("onmouseover", () => $.DispatchEvent("DOTAShowTextTooltip", this.button, $.Localize("#high_five_no_sub")));
            this.button.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip", this.button));
        }
        this.heroIndex = Game.GetPlayerInfo(this.playerId).player_selected_hero_entity_index;
        $.Schedule(5, () => this.CheckSubscription());
    }
}
var highfive = new HighFive();