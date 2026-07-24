--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

const dotaHud = (() => {
    let panel = $.GetContextPanel();
    while (panel) {
        if (panel.id === "DotaHud")
            return panel;
        panel = panel.GetParent();
    }
    return panel;
})();

const FindDotaHudElement = (id) => {
    return dotaHud.FindChildTraverse(id);
};

class MorphlingAttributes {
    constructor() {
        this.context = $.GetContextPanel();
        dotaHud.FindChildrenWithClassTraverse("__Morph_RemoveOnReload")
            .forEach(i => i.DeleteAsync(0));

        this.CreateAttributePanel();

        GameEvents.Subscribe_custom('morph_stats_refresh', (event) => this.RefreshValues(event));
        GameEvents.Subscribe_custom('morph_stats_replicated', (event) => this.container.SetHasClass("Replicated", event.value === 1));
    }
    CreateAttributePanel() {
        const statBranch = FindDotaHudElement("AbilitiesAndStatBranch");
        if (!statBranch) return;

        const container = $.CreatePanel("Panel", this.context, "CustomMorphContainer", {
            class: "__Morph_RemoveOnReload",
            hittest: false,
            hittestchildren: false
        });
        this.container = container;

        this.container.AddClass("style_collapse")

        // progress bar
        const progressBar = $.CreatePanel("ProgressBar", container, "CustomMorphProgress", {
            hittest: false,
            hittestchildren: false
        });
        this.progressBar = progressBar;
        progressBar.value = 0.5;
        progressBar.FindChildTraverse("CustomMorphProgress_Left").style.backgroundColor = "gradient( linear, 0% 0%, 0% 100%, from( #000000 ), color-stop( .35, #509431 ), color-stop( .65, #509431aa ), to( #000000 ) )";
        progressBar.FindChildTraverse("CustomMorphProgress_Right").style.backgroundColor = "gradient( linear, 0% 0%, 0% 100%, from( #000000 ), color-stop( .35, #880000 ), color-stop( .65, #880000aa ), to( #000000 ) )";

        // numbers
        const numberContainer = $.CreatePanel("Panel", container, "CustomMorphNumbers");

        this.agiValue = $.CreatePanel("Label", numberContainer, "CustomAgiValue", {
            class: "CustomHeroStatValue",
            text: "0",
            hittest: false
        });
        
        this.strValue = $.CreatePanel("Label", numberContainer, "CustomStrValue", {
            class: "CustomHeroStatValue",
            text: "0",
            hittest: false
        });

        container.SetParent(statBranch);
    }
    RefreshValues(event) {
        if (!this.agiValue || !this.strValue || !this.progressBar) {
            this.CreateAttributePanel();
            if (!this.agiValue || !this.strValue || !this.progressBar) return;
        }

        if (this.container.BHasClass("style_collapse"))
            this.container.RemoveClass("style_collapse")

        if (event.has_legendary && event.has_legendary == 1 && !this.container.BHasClass("NewAbility"))
             this.container.AddClass("NewAbility")

        const { agi: agility, str: strength } = event;

        const progress = (agility / (agility + strength));
        if (!isNaN(progress))
            this.progressBar.value = progress;

        this.agiValue.text = agility.toFixed(0);
        this.strValue.text = strength.toFixed(0);
    }

}
const morphling_attributes = new MorphlingAttributes();