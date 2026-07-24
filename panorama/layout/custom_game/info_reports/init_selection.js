--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
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

function OpenSelectionChest()
{
    Game.EmitSound("UI.Shop_Category_Open")
    GameUI.CustomUIConfig().OpenChestPairWindow()
}

function UpdateSelectionChestInfo()
{
    let label = $.GetContextPanel().FindChildTraverse("HeroSelectionChestInfoLabel")
    let button = $.GetContextPanel().FindChildTraverse("HeroSelectionChestOpenButton")
    if (!label || !button) { return }
    let sub = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer())
    let pending = sub ? sub.pending_chest : null
    if (pending && pending.poor_id != null)
    {
        label.text = $.Localize("#chest_pair_ready")
        button.visible = true
    }
    else
    {
        let counter = (sub && sub.chest_counter) ? sub.chest_counter : 0
        let cfg = CustomNetTables.GetTableValue("shop_items", "chest_config")
        let required = (cfg && cfg.games_required) ? cfg.games_required : 3
        label.text = $.Localize("#chest_games_to_go") + " " + counter + "/" + required
        button.visible = false
    }
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