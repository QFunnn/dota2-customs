--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const MorphlingAttributes = {context: $.GetContextPanel(), container: null, progressBar: null, agiValue: null, strValue: null};

let dotaHud = GetDotaHud()

function CreateAttributePanel() 
{
    const statBranch = FindDotaHudElement("AbilitiesAndStatBranch");
    if (!statBranch) return;

    dotaHud.FindChildrenWithClassTraverse("__Morph_RemoveOnReload").forEach(i => i.DeleteAsync(0));
    const container = $.CreatePanel("Panel", MorphlingAttributes.context, "CustomMorphContainer", {class: "__Morph_RemoveOnReload", hittest: false, hittestchildren: false});
    MorphlingAttributes.container = container;
    container.AddClass("style_collapse");

    const progressBar = $.CreatePanel("ProgressBar", container, "CustomMorphProgress", {hittest: false, hittestchildren: false});
    MorphlingAttributes.progressBar = progressBar;
    progressBar.value = 0.5;
    progressBar.FindChildTraverse("CustomMorphProgress_Left").style.backgroundColor = "gradient( linear, 0% 0%, 0% 100%, from( #000000 ), color-stop( .35, #509431 ), color-stop( .65, #509431aa ), to( #000000 ) )";
    progressBar.FindChildTraverse("CustomMorphProgress_Right").style.backgroundColor = "gradient( linear, 0% 0%, 0% 100%, from( #000000 ), color-stop( .35, #880000 ), color-stop( .65, #880000aa ), to( #000000 ) )";

    const numberContainer = $.CreatePanel("Panel", container, "CustomMorphNumbers");
    MorphlingAttributes.agiValue = $.CreatePanel("Label", numberContainer, "CustomAgiValue", {class: "CustomHeroStatValue", text: "0", hittest: false});
    MorphlingAttributes.strValue = $.CreatePanel("Label", numberContainer, "CustomStrValue", {class: "CustomHeroStatValue", text: "0", hittest: false});
    container.SetParent(statBranch);
}

// Обновление значений
function RefreshValues(event) 
{
    if (event == undefined || event.agi == undefined || event.str == undefined) { return }

    const { container, agiValue, strValue, progressBar } = MorphlingAttributes;
    if (!agiValue || !strValue || !progressBar) 
    {
        CreateAttributePanel();
        if (!MorphlingAttributes.agiValue || !MorphlingAttributes.strValue || !MorphlingAttributes.progressBar) return;
    }

    if (container.BHasClass("style_collapse"))
        container.RemoveClass("style_collapse");

    const { agi: agility, str: strength } = event;

    const progress = agility / (agility + strength);
    if (!isNaN(progress))
        MorphlingAttributes.progressBar.value = progress;

    MorphlingAttributes.agiValue.text = agility.toFixed(0);
    MorphlingAttributes.strValue.text = strength.toFixed(0);
}

// Инициализация
(function InitMorphlingAttributes() {
    CreateAttributePanel();
    GameEvents.Subscribe_custom('morph_stats_refresh', RefreshValues);
    GameEvents.Subscribe_custom('morph_stats_replicated', (event) => {
        if (MorphlingAttributes.container)
            MorphlingAttributes.container.SetHasClass("Replicated", event.value === 1 || event.mod === 1);
    });
})();
 