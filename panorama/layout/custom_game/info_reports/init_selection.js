--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig().InitItemsForPlayer = function InitItemsForPlayer(hero_name)
{
    $.GetContextPanel().RemoveClass("panel_hidden_right_items")
    $.GetContextPanel().AddClass("panel_open_right_items")
    $("#HeroListItemsSelection").RemoveAndDeleteChildren()
    $("#CategoryEffectsSelection").RemoveAndDeleteChildren()
    current_shop_hero_choose = hero_name
    UpdateShards()
    InitShopItemsForHero($("#HeroListItemsSelection"))
    SetHeroSelectionItemsMode("hero", true)
    UpdateSelectionChestInfo()
}

function SelectionChestCanOpen()
{
    let chest_data = CustomNetTables.GetTableValue("chest_data", Players.GetLocalPlayer())
    if (!chest_data) { return false }
    if (chest_data.poor_id != null) { return true }
    let sub = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer())
    return chest_data.rich_id != null && sub && sub.subscribed == 1
}

function OpenSelectionChest()
{
    if (!SelectionChestCanOpen()) { return }

    let chest_window = $.GetContextPanel().FindChildTraverse("ChestHudMainPanel")
    if (chest_window && chest_window.hittest) { return }
    Game.EmitSound("UI.Shop_Category_Open")
    Game.EmitSound("UI.Weekly_open")
    GameUI.CustomUIConfig().OpenChestPairWindow()
}

function UpdateSelectionChestInfo()
{
    let info_panel = $.GetContextPanel().FindChildTraverse("HeroSelectionChestInfo")
    let squares = $.GetContextPanel().FindChildTraverse("HeroSelectionChestSquares")
    let button = $.GetContextPanel().FindChildTraverse("HeroSelectionChestOpenButton")
    let alert = $("#HeroSelectionChestAlert")

    let button_text = $("#HeroSelectionChestOpenButtonLabel")
    if (!info_panel || !squares || !button) { return }

    let sub = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer())
    let chest_data = CustomNetTables.GetTableValue("chest_data", Players.GetLocalPlayer()) || {}
    let cfg = CustomNetTables.GetTableValue("shop_items", "chest_config")
    let required = (cfg && cfg.games_required) ? cfg.games_required : 3
    let counter = chest_data.counter ? chest_data.counter : 0

    let poor_exists = chest_data.poor_id != null
    let rich_exists = chest_data.rich_id != null
    let has_pending = poor_exists || rich_exists
    let can_open = SelectionChestCanOpen()
    let filled = can_open ? required : Math.min(counter, required)

    let icon = $.GetContextPanel().FindChildTraverse("HeroSelectionChestIcon")
    let cd_label = $.GetContextPanel().FindChildTraverse("HeroSelectionChestCdLabel")
    let chest_cd = chest_data.cd ? chest_data.cd : 0
    let on_cd = chest_cd > 0 && !can_open
    let display = ""

    if (cd_label)
    {
        cd_label.visible = on_cd
        if (on_cd)
        {
            let days = Math.floor(chest_cd / 86400)
            let hours = Math.max(0, Math.floor((chest_cd - days * 86400) / 3600))
            display = String(hours) + $.Localize("#pass_active_sub_hours")
            if (days >= 1)
            {
                display = String(days) + $.Localize("#pass_active_sub_days") + " " + String(hours) + $.Localize("#pass_active_sub_hours")
            }
            cd_label.text = $.Localize("#chest_cd_label") + display
        }
    }
    if (icon) { icon.visible = !on_cd }
    squares.visible = !on_cd

    squares.RemoveAndDeleteChildren()
    for (let i = 0; i < required; i++)
    {
        let sq = $.CreatePanel("Panel", squares, "")
        sq.AddClass("HeroSelectionChestSquare")
        if (i < filled) { sq.AddClass("HeroSelectionChestSquareFilled") }
    }

    button.SetHasClass("HeroSelectionChestOpenButton_available", can_open)
    button_text.SetHasClass("HeroSelectionChestOpenButtonLabel_available", can_open)
    button.SetHasClass("HeroSelectionChestOpenButton_locked", !can_open)
    info_panel.SetHasClass("HeroSelectionChestInfo_glow", can_open)
    alert.SetHasClass("panel_hidden", !can_open)

    info_panel.SetPanelEvent("onmouseover", () => 
    {
        Game.CustomTooltipOpened = true

        $.DispatchEvent(
            "UIShowCustomLayoutParametersTooltip",
            info_panel,
            "skill_tooltip",
            "file://{resources}/layout/custom_game/custom_tooltip.xml",
            "is_chest_info=1&rarity=chest&chest_cd=" + display + "&chest_games=" + counter + "/" + required,
        );
    });
    info_panel.SetPanelEvent("onmouseout", () => 
    {
        Game.CustomTooltipOpened = false
        $.DispatchEvent("UIHideCustomLayoutTooltip", info_panel, "skill_tooltip");
    });
}

GameUI.CustomUIConfig().CloseItemsPanelSelection = function CloseItemsPanelSelection()
{
    $.GetContextPanel().RemoveClass("panel_open_right_items")
    $.GetContextPanel().AddClass("panel_close_right_items")
    $.Schedule(0.65, function() 
    {
        $.GetContextPanel().RemoveClass("panel_close_right_items")
        $.GetContextPanel().AddClass("panel_hidden_right_items")
    })
}

function OpenItemsPanelSelection()
{
    $("#HeroSelectionItemsPreview").SetHasClass("ButtonSwapPreviewClosed", !$("#HeroSelectionItemsPreview").BHasClass("ButtonSwapPreviewClosed"))
}

function SetHeroSelectionItemsMode(mode, silent)
{
    let hero_items = $("#HeroListItemsSelection")
    let effects = $("#CategoryEffectsSelection")
    let hero_button = $("#HeroSelectionItemsModeHero")
    let effects_button = $("#HeroSelectionItemsModeEffects")

    if (!hero_items || !effects) { return }
    if (!silent)
    {
        Game.EmitSound("UI.Click")
    }

    let is_effects = mode == "effects"
    hero_items.style.visibility = is_effects ? "collapse" : "visible"
    effects.style.visibility = is_effects ? "visible" : "collapse"

    if (hero_button)
    {
        hero_button.SetHasClass("HeroSelectionItemsModeButtonActive", !is_effects)
    }
    if (effects_button)
    {
        effects_button.SetHasClass("HeroSelectionItemsModeButtonActive", is_effects)
    }

    if (is_effects)
    {
        selected_effect_category = null
        InitEffectsItems(effects)
    }
}

function activate_but_button()
{
    Game.EmitSound("UI.Shop_Category_Open")
    GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "shards"});  
}

function shop_update_tips_and_fives_selection(data)
{
    player_table_shop = data.sub_data

    let effects = $("#CategoryEffectsSelection")
    if (effects && effects.style.visibility == "visible")
    {
        InitEffectsItems(effects)
    }
}

GameEvents.Subscribe_custom('shop_update_tips_and_fives', shop_update_tips_and_fives_selection)

CustomNetTables.SubscribeNetTableListener("sub_data", function(table_name, key, data)
{
    if (key != Players.GetLocalPlayer()) { return }
    let effects = $("#CategoryEffectsSelection")
    if (effects && effects.style.visibility == "visible")
    {
        InitEffectsItems(effects)
    }
    UpdateSelectionChestInfo()
})

CustomNetTables.SubscribeNetTableListener("chest_data", function(table_name, key, data)
{
    if (key != Players.GetLocalPlayer()) { return }
    UpdateSelectionChestInfo()
})

GameUI.CustomUIConfig().PlayerHasItemInSelection = function PlayerHasItemInSelection(hero_name)
{
    if (!SAVE_DATA_SETS_ITEMS[String(hero_name)])
    {
        SAVE_DATA_SETS_ITEMS[String(hero_name)] = CustomNetTables.GetTableValue("heroes_items_info", String(hero_name));
    }
    let items = SAVE_DATA_SETS_ITEMS[String(hero_name)]
    if (!items)
    {
        return false
    }
    let data = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()));
    let lang = $.Localize("#lang")
    if ((data && data.total_games && data.total_games >= max_games) || lang == "rus")
    {
        return true
    }
    else 
    {
        return false
    }
}