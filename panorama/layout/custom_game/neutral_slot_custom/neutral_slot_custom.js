--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let inventory_composition_layer_container = FindDotaHudElement("inventory_composition_layer_container")
if (inventory_composition_layer_container)
{
    $("#NeutralSlotCustom").SetParent(inventory_composition_layer_container)
}

function NeutralSlotUpdater()
{
    if (inventory_composition_layer_container)
    {
        let NeutralSlotCustom = inventory_composition_layer_container.FindChildTraverse("NeutralSlotCustom")
        if (NeutralSlotCustom)
        {
            let item = Entities.GetItemInSlot( Players.GetLocalPlayerPortraitUnit(), 17 );
            let item_name = ""
            if (item && item != -1)
            {
                item_name = Abilities.GetAbilityName( item );
            }
            NeutralSlotCustom.GetChild(0).itemname = item_name;
            NeutralSlotCustom.GetChild(0).contextEntityIndex = item;
            if (item && item != -1)
            {
                let level = Abilities.GetLevel( item )
                SetShowItemTooltip(NeutralSlotCustom.GetChild(0), item_name, level)
            }
            else
            {
                SetShowItemTooltipText(NeutralSlotCustom.GetChild(0), $.Localize("#DOTA_NeutralItemSlot_Title_custom"), $.Localize("#DOTA_NeutralItemSlot_Description_custom"))
            }
        }
    }
    $.Schedule(0.1, NeutralSlotUpdater)
}

function SetShowItemTooltip(panel, ability, level)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowAbilityInventoryItemTooltip', panel, Players.GetLocalPlayerPortraitUnit(), 17); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
        $.DispatchEvent('DOTAHideTextTooltip', panel);
        $.DispatchEvent('DOTAHideTitleTextTooltip', panel);
    });       
}

function SetShowItemTooltipText(panel, text, text2)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTitleTextTooltip', panel, text, text2 )});
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
        $.DispatchEvent('DOTAHideTitleTextTooltip', panel);
    });       
}

NeutralSlotUpdater()