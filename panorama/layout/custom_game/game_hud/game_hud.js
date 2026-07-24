--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// const
const HealthBarFront = $("#HealthBarFront")
const HealthBarLabel = $("#HealthBarLabel")
const HealthRegen = $("#HealthRegen")
const ManaBarFront = $("#ManaBarFront")
const ManaBarLabel = $("#ManaBarLabel")
const ManaRegen = $("#ManaRegen")
const HeroLevelCircleActive = $("#HeroLevelCircleActive")
const HeroLevelLabel = $("#HeroLevelLabel")
const HeroName = $("#HeroName")
const AbilitiesList = $("#AbilitiesList")
const ItemsList1 = $("#ItemsList1")
const ItemsList2 = $("#ItemsList2")
const StatsNavigation = $("#StatsNavigation")
const PlayersStatsEconomyList = $("#PlayersStatsEconomyList")
const StatsListParent = $("#StatsListParent")
const ItemsContainer = $("#ItemsContainer")
const UpgradeStatsLevel = $("#UpgradeStatsLevel")
const UpgradeStatsList = $("#UpgradeStatsList")
const ChooseCardList = $("#ChooseCardList")
const CardSelectorList = $("#CardSelectorList")
const PanelChooseBodyCard = $("#PanelChooseBodyCard")
const ChooseCardButtonReroll = $("#ChooseCardButtonReroll")
const ChooseCardButtonCancel = $("#ChooseCardButtonCancel")
const ChooseCardButtonInfoUpdater = $("#ChooseCardButtonInfoUpdater")
const PanelReplaceCard = $("#PanelReplaceCard")
const PanelReplaceCardData = $("#PanelReplaceCardData")
const CardButtonReplaceBack = $("#CardButtonReplaceBack")
const CardButtonReplaceCancel = $("#CardButtonReplaceCancel")
const PanelInventoryCard = $("#PanelInventoryCard")
const CardInventoryList = $("#CardInventoryList")

// vars
var save_level_table_exp = {}
var UPDATE_PLAYER_ABILITIES = true
var UPDATE_PLAYER_ITEMS = true
var DEFAULT_HUD_DISABLE = true
var LEVEL_UPGRADES_QUEUE = 0

function Init()
{
    let minimap_container = FindDotaHudElement("minimap_container")
    if (minimap_container)
    {
        minimap_container.visible = false
    }
    CreatePlayerItemsList()
    PlayerHeroThink()
    CreatePlayersStats()
}

async function UpdatePlayerAbilitiesList()
{
    const local_player_id = Game.GetLocalPlayerID()
    const local_hero = Players.GetPlayerHeroEntityIndex(local_player_id)
    if (AbilitiesList)
    {
        AbilitiesList.RemoveAndDeleteChildren()
        for (let i = 0; i <= 24; i++)
        {
            let ability_handle = Entities.GetAbility(local_hero, i)
            if (ability_handle && ability_handle != -1 && !Abilities.IsHidden(ability_handle) && Abilities.IsDisplayedAbility(ability_handle))
            {
                let behavior = Abilities.GetBehavior(ability_handle)
                if(!FlagExistsBig(behavior, 8796093022208)) 
                {  
                    CreateAbilitySlot(ability_handle, i, local_player_id)
                }
            }
        }
        CreateCardButton()
    }
}

async function UpdatePlayerItemsList()
{
    const local_player_id = Game.GetLocalPlayerID()
    const local_hero = Players.GetPlayerHeroEntityIndex(local_player_id)
    const ItemPanels = ItemsContainer.FindChildrenWithClassTraverse("ItemPanel")
    for (let item_panel of ItemPanels)
    {
        let item_slot = item_panel.item_slot
        let item_index = Entities.GetItemInSlot(local_hero, item_slot)
        let ItemPanelImage = item_panel.FindChildTraverse("ItemPanelImage")
        if (item_index && item_index != -1)
        {
            ShowAbilityDescriptionForHero(item_panel, Abilities.GetAbilityName(item_index), local_hero)
            ItemPanelImage.itemname = Abilities.GetAbilityName(item_index)
            item_panel.current_item = item_index
        }
        else
        {
            item_panel.ClearPanelEvent("onmouseover")
            ItemPanelImage.itemname = ""
            item_panel.current_item = null
        }
    }
}

function CreatePlayerItemsList()
{
    if (ItemsList1 && ItemsList2)
    {
        ItemsList1.RemoveAndDeleteChildren()
        ItemsList2.RemoveAndDeleteChildren()
        for (let i = 0; i <= 2; i++)
        {
            CreateItemSlot(i, ItemsList1)
        }
        for (let i = 3; i <= 5; i++)
        {
            CreateItemSlot(i, ItemsList2)
        }
    }
}

function CreateItemSlot(item_slot, parent)
{
    let ItemPanel = $.CreatePanel("Panel", parent, "ItemPanel"+item_slot)
    ItemPanel.AddClass("ItemPanel")
    ItemPanel.hittestchildren = false
    ItemPanel.item_slot = item_slot
    ItemPanel.current_item = null
    $.RegisterEventHandler( 'DragStart', ItemPanel, OnDragStart );
    $.RegisterEventHandler( 'DragDrop', ItemPanel, OnDragDrop );
    $.RegisterEventHandler( 'DragEnd', ItemPanel, OnDragEnd );
    ItemPanel.SetDraggable(true)
    SetPanelItemClick(ItemPanel, item_slot)

    let ItemData = $.CreatePanel("Panel", ItemPanel, "")
    ItemData.AddClass("ItemData")

    let ItemPanelImage = $.CreatePanel("DOTAItemImage", ItemData, "ItemPanelImage", {scaling:"stretch-to-fit-y-preserve-aspect"})
    ItemPanelImage.AddClass("ItemPanelImage")
    ItemPanelImage.itemname = ""

    let ItemBG = $.CreatePanel("Panel", ItemData, "")
    ItemBG.AddClass("ItemBG")

    let ItemHotkey = $.CreatePanel("Panel", ItemPanel, "")
    ItemHotkey.AddClass("ItemHotkey")

    let ItemHotkeyLabel = $.CreatePanel("Label", ItemHotkey, "ItemHotkeyLabel")
    ItemHotkeyLabel.AddClass("ItemHotkeyLabel")
    ItemHotkeyLabel.text = GetHokeyCustom(ITEMS_KEY_BINDS_SLOTS[item_slot])
}

function SetPanelItemClick(ItemPanel, item_slot)
{
    ItemPanel.SetPanelEvent("onactivate", function()
    {
        const local_player_id = Game.GetLocalPlayerID()
        const local_hero = Players.GetPlayerHeroEntityIndex(local_player_id)
        let item_index = Entities.GetItemInSlot(local_hero, item_slot)
        if (item_index)
        {
            Abilities.ExecuteAbility(item_index, local_hero, false)
            Game.ItemClickCast(item_index)
        }
    })
}

function SetPanelAbilityClick(AbilityPanel, ability_index)
{
    AbilityPanel.SetPanelEvent("onactivate", function()
    {
        if (ability_index)
        {
            Game.AbilityClickCast(ability_index)
        }
    })
}

function CreateCardButton()
{
    let CardButtonContainer = $.CreatePanel("Panel", AbilitiesList, "CardButtonContainer")
    CardButtonContainer.AddClass("CardButtonContainer")

    let CardButtonImage = $.CreatePanel("Panel", CardButtonContainer, "")
    CardButtonImage.AddClass("CardButtonImage")
    CardButtonImage.SetPanelEvent("onactivate", function()
    {
        SwitchInventoryCards()
    })

    let AbilityHotkey = $.CreatePanel("Panel", CardButtonContainer, "")
    AbilityHotkey.AddClass("AbilityHotkey")

    let AbilityHotkeyLabel = $.CreatePanel("Label", AbilityHotkey, "AbilityHotkeyLabel")
    AbilityHotkeyLabel.AddClass("AbilityHotkeyLabel")
    AbilityHotkeyLabel.text = "F"
}

function CreateAbilitySlot(ability_handle, ability_id, local_player_id)
{
    let ability_name = Abilities.GetAbilityName(ability_handle)

    let AbilityContainer = $.CreatePanel("Panel", AbilitiesList, "AbilitySlot"+ability_id)
    AbilityContainer.AddClass("AbilityContainer")
    
    let AbilityData = $.CreatePanel("Panel", AbilityContainer, "AbilityData_"+ability_name)
    AbilityData.AddClass("AbilityData")
    
    let AbilityIconContainer = $.CreatePanel("Panel", AbilityData, "")
    AbilityIconContainer.AddClass("AbilityIconContainer")
    
    let AbilityImage = $.CreatePanel("DOTAAbilityImage", AbilityIconContainer, "AbilityImage")
    AbilityImage.AddClass("AbilityImage")
    AbilityImage.abilityname = ability_name
    ShowAbilityDescriptionForHero(AbilityImage, ability_name, local_player_id)
    SetPanelAbilityClick(AbilityImage, ability_handle)

    let AbilityCooldownPanel = $.CreatePanel("Panel", AbilityImage, "")
    AbilityCooldownPanel.AddClass("AbilityCooldownPanel")
    AbilityContainer.AbilityCooldownPanel = AbilityCooldownPanel

    let AbilityCooldownLabel = $.CreatePanel("Label", AbilityImage, "AbilityCooldownLabel")
    AbilityCooldownLabel.AddClass("AbilityCooldownLabel")
    AbilityCooldownLabel.text = "0"
    AbilityContainer.AbilityCooldownLabel = AbilityCooldownLabel
    
    let AbilityBG = $.CreatePanel("Panel", AbilityIconContainer, "")
    AbilityBG.AddClass("AbilityBG")
    AbilityBG.hittest = false

    let CostContainer = $.CreatePanel("Panel", AbilityData, "")
    CostContainer.AddClass("CostContainer")
    
    let CostAbilityIcon = $.CreatePanel("Panel", CostContainer, "CostAbilityIcon")
    CostAbilityIcon.AddClass("CostAbilityIcon")
    
    let CostAbilityLabel = $.CreatePanel("Label", CostContainer, "CostAbilityLabel")
    CostAbilityLabel.AddClass("CostAbilityLabel")
    
    let AbilityHotkey = $.CreatePanel("Panel", AbilityContainer, "")
    AbilityHotkey.AddClass("AbilityHotkey")
    
    let AbilityHotkeyLabel = $.CreatePanel("Label", AbilityHotkey, "AbilityHotkeyLabel")
    AbilityHotkeyLabel.text = GetHokeyCustom(ABILITIES_KEY_BINDS_SLOTS[ability_id])

    if (ability_id == 0)
    {
        CostContainer.style.opacity = "1"
        CostAbilityIcon.AddClass("IconWood")
        CostAbilityLabel.text = "100"
        AbilityBG.AddClass("AbilityBGGold")
    }

    if (ability_id == 1)
    {
        CostContainer.style.opacity = "1"
        CostAbilityIcon.AddClass("IconGold")
        CostAbilityLabel.text = "200"
        AbilityBG.AddClass("AbilityBGGold")
    }

    SetAbilityThinker(AbilityContainer, ability_handle)
}

function PlayerHeroThink()
{
    const local_player_id = Game.GetLocalPlayerID()
    const local_hero = Players.GetPlayerHeroEntityIndex(local_player_id)
    if (local_hero == -1)
    {
        $.Schedule(0.1, PlayerHeroThink)
        return
    }
    const health_percent = Entities.GetHealthPercent(local_hero)
    const health_regen = Math.floor(Entities.GetHealthThinkRegen(local_hero))
    const health = Math.floor(Entities.GetHealth(local_hero))
    const max_health = Math.floor(Entities.GetMaxHealth(local_hero))
    const mana = Math.floor(Entities.GetMana(local_hero))
    const mana_regen = Math.floor(Entities.GetManaThinkRegen(local_hero))
    const max_mana = Math.floor(Entities.GetMaxMana(local_hero))
    const mana_percent = (mana / max_mana) * 100
    const player_level = Players.GetLevel(local_player_id)
    let player_current_exp = Entities.GetCurrentXP(local_hero)
    let player_next_exp = Entities.GetNeededXPToLevel(local_hero)
    
    if (!save_level_table_exp[player_level] && player_level > 0)
    {
        save_level_table_exp[player_level] = player_next_exp
    }

    if (save_level_table_exp[player_level-1])
    {
        player_current_exp = player_current_exp - save_level_table_exp[player_level-1]
        player_next_exp = player_next_exp - save_level_table_exp[player_level-1]
    }

    // Health Bar
    if (HealthBarFront && HealthBarLabel && HealthRegen)
    {
        HealthBarFront.style["width"] = `${health_percent}%`
        HealthBarLabel.text = `${health}/${max_health}`
        HealthRegen.text = `${health_regen}/s`
    }

    // Mana Bar
    if (ManaBarFront && ManaBarLabel && ManaRegen)
    {
        ManaBarFront.style["width"] = `${mana_percent}%`
        ManaBarLabel.text = `${mana}/${max_mana}`
        ManaRegen.text = `${mana_regen}/s`
    }

    // Exp Panel
    if (HeroLevelCircleActive && HeroLevelLabel)
    {
        const exp_clip_radial = (player_current_exp / player_next_exp) * -360
        if (exp_clip_radial != null && exp_clip_radial != "NaN" && !isNaN(exp_clip_radial))
        {
            HeroLevelCircleActive.style.clip = `radial(50% 50%, 0deg, ${exp_clip_radial}deg)`;
        }
        HeroLevelLabel.text = `${player_level}`
    }

    if (HeroName)
    {
        HeroName.text = $.Localize("#"+Entities.GetUnitName(local_hero))
    }

    if (UPDATE_PLAYER_ABILITIES)
    {
        UPDATE_PLAYER_ABILITIES = false
        UpdatePlayerAbilitiesList()
    }

    if (UPDATE_PLAYER_ITEMS)
    {
        UPDATE_PLAYER_ITEMS = false
        UpdatePlayerItemsList()
    }

    $.Schedule(0.03, PlayerHeroThink)
}

function ChangeStatsWindow(id, id_panel)
{
    for (let child of StatsNavigation.Children())
    {
        child.SetHasClass("StatsNavigateActive", child.id == id)
    }
    if (StatsListParent)
    {
        for (let child of StatsListParent.Children())
        {
            child.visible = child.id == id_panel
        }
    }
}

function CreatePlayersStats()
{
    PlayersStatsEconomyList.RemoveAndDeleteChildren()
    for (let player_id = 0; player_id <= 10; player_id++)
    {
        if (Players.IsValidPlayerID(player_id))
        {
            CreatePlayerForStat(player_id)
        }
    }
}
  
function CreatePlayerForStat(player_id)
{
    let playerInfo = Game.GetPlayerInfo(player_id);
    if (playerInfo)
    {
        let PlayerStatPanel = $.CreatePanel("Panel", PlayersStatsEconomyList, "PlayerStatPanel_"+player_id)
        PlayerStatPanel.AddClass("PlayerStatPanel")
        PlayerStatPanel.player_id = player_id

        let PlayerStatAvatar = $.CreatePanel("DOTAAvatarImage", PlayerStatPanel, "", {style : "width: 40px;height: 40px;vertical-align: center;margin-left: 5px;"})
        PlayerStatAvatar.steamid = playerInfo.player_steamid

        let CurrencyStats = $.CreatePanel("Panel", PlayerStatPanel, "")
        CurrencyStats.AddClass("CurrencyStats")

        let CurrencyStatsColumn_1 = $.CreatePanel("Panel", CurrencyStats, "")
        CurrencyStatsColumn_1.AddClass("CurrencyStatsColumn")

        let CurrencyStatGold = $.CreatePanel("Panel", CurrencyStatsColumn_1, "")
        CurrencyStatGold.AddClass("CurrencyStat")

        let CurrencyStatIconGold = $.CreatePanel("Panel", CurrencyStatGold, "")
        CurrencyStatIconGold.AddClass("CurrencyStatIcon")
        CurrencyStatIconGold.AddClass("IconGold")

        let CurrencyStatLabelGold = $.CreatePanel("Label", CurrencyStatGold, "")
        CurrencyStatLabelGold.AddClass("CurrrencyStatLabel")
        CurrencyStatLabelGold.text = "0"

        let CurrencyStatWood = $.CreatePanel("Panel", CurrencyStatsColumn_1, "")
        CurrencyStatWood.AddClass("CurrencyStat")

        let CurrencyStatIconWood = $.CreatePanel("Panel", CurrencyStatWood, "")
        CurrencyStatIconWood.AddClass("CurrencyStatIcon")
        CurrencyStatIconWood.AddClass("IconWood")

        let CurrencyStatLabelWood = $.CreatePanel("Label", CurrencyStatWood, "")
        CurrencyStatLabelWood.AddClass("CurrrencyStatLabel")
        CurrencyStatLabelWood.text = "0"

        let CurrencyStatsColumn_2 = $.CreatePanel("Panel", CurrencyStats, "")
        CurrencyStatsColumn_2.AddClass("CurrencyStatsColumn")

        let CurrencyStatKills = $.CreatePanel("Panel", CurrencyStatsColumn_2, "")
        CurrencyStatKills.AddClass("CurrencyStat")

        let CurrencyStatIconKills = $.CreatePanel("Panel", CurrencyStatKills, "")
        CurrencyStatIconKills.AddClass("CurrencyStatIcon")
        CurrencyStatIconKills.AddClass("IconKills")

        let CurrencyStatLabelKills = $.CreatePanel("Label", CurrencyStatKills, "")
        CurrencyStatLabelKills.AddClass("CurrrencyStatLabel")
        CurrencyStatLabelKills.text = "0"

        let CurrencyStatChests = $.CreatePanel("Panel", CurrencyStatsColumn_2, "")
        CurrencyStatChests.AddClass("CurrencyStat")

        let CurrencyStatIconChests = $.CreatePanel("Panel", CurrencyStatChests, "")
        CurrencyStatIconChests.AddClass("CurrencyStatIcon")

        let CurrencyStatLabelChests = $.CreatePanel("Label", CurrencyStatChests, "")
        CurrencyStatLabelChests.AddClass("CurrrencyStatLabel")
        CurrencyStatLabelChests.text = "0"
    }
}

function OnDragStart( panelId, dragCallbacks )
{
    if (panelId.current_item == null || panelId.current_item == -1)
    {
        return false
    }
    var displayPanel = $.CreatePanel( "DOTAItemImage", $.GetContextPanel(), "ItemDragInventory", {scaling:"stretch-to-fit-y-preserve-aspect"});
    displayPanel.AddClass("ItemDragInventory")
    displayPanel.itemname = Abilities.GetAbilityName(panelId.current_item)
    displayPanel.current_item = panelId.current_item
    displayPanel.item_slot = panelId.item_slot;
    displayPanel.old_panel = panelId;
    dragCallbacks.displayPanel = displayPanel;
	dragCallbacks.offsetX = 0;
	dragCallbacks.offsetY = 0;
    $.DispatchEvent('DOTAHideAbilityTooltip', panelId);
	return true;
}

function OnDragDrop(panelId, draggedPanel )
{
    if (panelId && panelId != draggedPanel.old_panel && panelId.item_slot != undefined && panelId.current_item == null)
    {
        if (draggedPanel.current_item != null && draggedPanel.current_item != -1)
        {
            GameEvents.SendCustomGameEventToServer( "event_change_item_slots_custom", {item_index : draggedPanel.current_item, new_slot : panelId.item_slot} );
        }
    }
    draggedPanel.IsSuccess = true
    if (draggedPanel && draggedPanel.IsValid())
    {
        draggedPanel.DeleteAsync( 0 );
    }
	return true;
}

function OnDragEnd(panelId, draggedPanel)
{
    if (!draggedPanel.IsSuccess)
    {
        const local_player_id = Game.GetLocalPlayerID()
        const local_hero = Players.GetPlayerHeroEntityIndex(local_player_id)
        Game.DropItemAtCursor(local_hero, draggedPanel.current_item);
    }
    if (draggedPanel && draggedPanel.IsValid())
    {
        draggedPanel.DeleteAsync( 0 );
    }
	return true;
}

function SwitchHudDev()
{
    if (DEFAULT_HUD_DISABLE)
    {
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_PREGAME_STRATEGYUI, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_QUICKBUY, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_COURIER, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_PANEL, true );
        $("#TopHud").visible = false
        $("#LowerHud").visible = false
        $("#StatsPlayerPanel").visible = false
        let minimap_container = FindDotaHudElement("minimap_container")
        if (minimap_container)
        {
            minimap_container.visible = true
        }
    }
    else
    {
        $("#TopHud").visible = true
        $("#LowerHud").visible = true
        $("#StatsPlayerPanel").visible = true
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_PREGAME_STRATEGYUI, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_QUICKBUY, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_COURIER, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_PANEL, false );
        let minimap_container = FindDotaHudElement("minimap_container")
        if (minimap_container)
        {
            minimap_container.visible = false
        }
    }
    DEFAULT_HUD_DISABLE = !DEFAULT_HUD_DISABLE
}

function SetAbilityThinker(AbilityContainer, ability_handle)
{
    if (AbilityContainer == null || !AbilityContainer.IsValid())
    {
        return
    }
    const AbilityCooldownPanel = AbilityContainer.AbilityCooldownPanel
    const AbilityCooldownLabel = AbilityContainer.AbilityCooldownLabel
    if (!Abilities.IsCooldownReady(ability_handle)) 
    {
        if (AbilityContainer.maxCooldown == null) 
        {
            AbilityContainer.maxCooldown = Abilities.GetCooldownLength(ability_handle);
        }
        const remaining = Abilities.GetCooldownTimeRemaining(ability_handle);
        const progress = (remaining / AbilityContainer.maxCooldown) * -360;
        AbilityCooldownPanel.visible = true;
        if (!isNaN(progress))
        {
            AbilityCooldownPanel.style.clip = "radial( 50% 50%, 0deg, " + progress + "deg )";
        }
        AbilityCooldownLabel.text = Math.ceil(remaining);
        AbilityCooldownLabel.visible = true;
    } 
    else 
    {
        AbilityContainer.maxCooldown = null;
        AbilityCooldownLabel.visible = false;
        AbilityCooldownPanel.visible = false;
    }
    
    $.Schedule(0.1, function()
    {
        SetAbilityThinker(AbilityContainer, ability_handle)
    })
}

function OpenUpgradePanel(data)
{
    UpgradeStatsList.RemoveAndDeleteChildren()
    LEVEL_UPGRADES_QUEUE = data.upgrades_queue
    UpgradeStatsLevel.SetHasClass("OpenUpgrade", true)

    for (let upgrade_data of Object.values(data.upgrades_list))
    {
        let UpgradeStat = $.CreatePanel("Panel", UpgradeStatsList, "")
        UpgradeStat.AddClass("UpgradeStat")
        
        let UpgradeStatLabel = $.CreatePanel("Label", UpgradeStat, "")
        UpgradeStatLabel.text = FormatUpgradeLabel(upgrade_data, UpgradeStatLabel)

        UpgradeStat.SetPanelEvent("onactivate", function()
        {
            ActiveUpgradeEvent(upgrade_data.upgrade_id)
        })
    }
}

function FormatUpgradeLabel(upgrade_data, panel)
{
    const localizedToken = "#level_upgrade_" + upgrade_data.upgrade_name
    const valueText = ApplyNumberFormat(upgrade_data.value) + (upgrade_data.value_kind === "pct" ? "%" : "")

    if (panel)
    {
        panel.SetDialogVariable("value", valueText)
    }

    const localizedText = panel ? $.Localize(localizedToken, panel) : $.Localize(localizedToken)

    if (localizedText && localizedText !== localizedToken)
        return localizedText

    return valueText + " " + upgrade_data.upgrade_name
}

function ActiveUpgradeEvent(upgrade_id)
{
    if (!UpgradeStatsLevel.BHasClass("OpenUpgrade")) { return }
    LEVEL_UPGRADES_QUEUE = LEVEL_UPGRADES_QUEUE - 1
    GameEvents.SendCustomGameEventToServer("event_player_select_upgrade_custom", {upgrade_id : upgrade_id})
    if (LEVEL_UPGRADES_QUEUE <= 0)
    {
        UpgradeStatsLevel.SetHasClass("OpenUpgrade", false)
    }
}

function OpenCardPanel(data)
{
    ChooseCardList.RemoveAndDeleteChildren()
    PanelChooseBodyCard.SetHasClass("OpenCardPanel", true)
    let bundles_data = data.bundles_data
    let updates_card_counter = data.updates_card_counter
    let current_card_list = data.current_card_list
    let is_changer_type = Object.values(data.current_card_list).length >= 5

    for (let card_id in Object.values(data.card_list))
    {
        let card_data = Object.values(data.card_list)[card_id]
        let bundle_data = bundles_data[card_data.bundle_name]

        let ChooseCardBase = $.CreatePanel("Panel", ChooseCardList, "")
        ChooseCardBase.AddClass("ChooseCardBase")

        let ChooseCardBaseImage = $.CreatePanel("Image", ChooseCardBase, "")
        ChooseCardBaseImage.AddClass("ChooseCardBaseImage")
        ChooseCardBaseImage.SetImage("file://{images}/card_list/" + card_data.card_name + ".png")

        let ChooseCardBaseName = $.CreatePanel("Label", ChooseCardBase, "")
        ChooseCardBaseName.AddClass("ChooseCardBaseName")
        ChooseCardBaseName.text = $.Localize("#"+card_data.card_name)

        if (bundle_data)
        {
            let ChooseCardBaseBundleData = $.CreatePanel("Panel", ChooseCardBase, "")
            ChooseCardBaseBundleData.AddClass("ChooseCardBaseBundleData")

            let ChooseCardBaseBundleDataName = $.CreatePanel("Label", ChooseCardBaseBundleData, "")
            ChooseCardBaseBundleDataName.AddClass("ChooseCardBaseBundleDataName")
            ChooseCardBaseBundleDataName.text = $.Localize("#"+card_data.bundle_name)

            let ChooseCardBaseBundleDataCounter = $.CreatePanel("Label", ChooseCardBaseBundleData, "")
            ChooseCardBaseBundleDataCounter.AddClass("ChooseCardBaseBundleDataCounter")
            ChooseCardBaseBundleDataCounter.text = bundle_data.cards_counter_have + "/" + Object.values(bundle_data.card_list).length
        }

        let ChooseCardBaseBonusListPanel = $.CreatePanel("Panel", ChooseCardBase, "")
        ChooseCardBaseBonusListPanel.AddClass("ChooseCardBaseBonusListPanel")

        for (let bonus_name of Object.keys(card_data.bonus_list))
        {
            let bonus_list = card_data.bonus_list[bonus_name]
            for (let bonus_list_key of Object.keys(bonus_list))
            {
                let label_name = bonus_list_key
                let bonus_list_data = bonus_list[bonus_list_key]
                let value = bonus_list_data
                if (typeof bonus_list_data == "object")
                {
                    value = bonus_list_data[1]
                    label_name = bonus_list_data[2] + "_" + label_name
                }
                value = ApplyNumberFormat(value)

                let ChooseCardBaseBonusLine = $.CreatePanel("Panel", ChooseCardBaseBonusListPanel, "")
                ChooseCardBaseBonusLine.AddClass("ChooseCardBaseBonusLine")
                ChooseCardBaseBonusLine.SetDialogVariable("value", "<b><font color=\"gold\">" + String(value) + "</font></b>");

                let ChooseCardBaseBonusPin = $.CreatePanel("Panel", ChooseCardBaseBonusLine, "")
                ChooseCardBaseBonusPin.AddClass("ChooseCardBaseBonusPin")

                let ChooseCardBaseBonusLabel = $.CreatePanel("Label", ChooseCardBaseBonusLine, "")
                ChooseCardBaseBonusLabel.AddClass("ChooseCardBaseBonusLabel")
                ChooseCardBaseBonusLabel.html = true
                ChooseCardBaseBonusLabel.text = $.Localize("#levelup_card_stats_" + label_name, ChooseCardBaseBonusLine)
            }
        }

        if (bundle_data.bundle_description)
        {
            let ChooseCardBaseBundleBonusPanel = $.CreatePanel("Panel", ChooseCardBase, "")
            ChooseCardBaseBundleBonusPanel.AddClass("ChooseCardBaseBundleBonusPanel")

            for (let bonus_name of Object.keys(bundle_data.bonus_list))
            {
                let bonus_list = bundle_data.bonus_list[bonus_name]
                for (let bonus_list_key of Object.keys(bonus_list))
                {
                    let label_name = bonus_list_key
                    let bonus_list_data = bonus_list[bonus_list_key]
                    let value = bonus_list_data
                    if (typeof bonus_list_data == "object")
                    {
                        value = bonus_list_data[1]
                        label_name = bonus_list_data[2] + "_" + label_name
                    }
                    value = ApplyNumberFormat(value)
                    ChooseCardBaseBundleBonusPanel.SetDialogVariable("value_" + label_name, "<b><font color=\"gold\">" + String(value) + "</font></b>");
                }
            }

            let ChooseCardBaseBundleBonusHeaderLabel = $.CreatePanel("Label", ChooseCardBaseBundleBonusPanel, "")
            ChooseCardBaseBundleBonusHeaderLabel.AddClass("ChooseCardBaseBundleBonusHeaderLabel")
            ChooseCardBaseBundleBonusHeaderLabel.text = $.Localize("#"+card_data.bundle_name)

            let ChooseCardBaseBundleBonusLabel = $.CreatePanel("Label", ChooseCardBaseBundleBonusPanel, "")
            ChooseCardBaseBundleBonusLabel.AddClass("ChooseCardBaseBundleBonusLabel")
            ChooseCardBaseBundleBonusLabel.html = true
            ChooseCardBaseBundleBonusLabel.text = $.Localize("#"+bundle_data.bundle_description, ChooseCardBaseBundleBonusPanel)
        }

        ChooseCardBase.SetPanelEvent("onactivate", function()
        {
            if (is_changer_type)
            {
                ActiveCardChangerEvent(card_data, card_id, data)
            }
            else
            {
                ActiveCardEvent(card_id)
            }
        })
    }

    if (ChooseCardButtonInfoUpdater)
    {
        ChooseCardButtonInfoUpdater.SetDialogVariable("value", "<b><font color=\"gold\">" + String(updates_card_counter) + "</font></b>");
        ChooseCardButtonInfoUpdater.text = $.Localize("#levelup_card_replace_counter", ChooseCardButtonInfoUpdater)
    }

    if (ChooseCardButtonReroll)
    {
        ChooseCardButtonReroll.SetPanelEvent("onactivate", function()
        {
            if (!PanelChooseBodyCard.BHasClass("OpenCardPanel")) { return }
            if (updates_card_counter > 0)
            {
                AllClosedSelectorCard()
                GameEvents.SendCustomGameEventToServer("event_player_reroll_card_custom", {})
            }
        })
    }

    if (ChooseCardButtonCancel)
    {
        ChooseCardButtonCancel.SetPanelEvent("onactivate", function()
        {
            if (!PanelChooseBodyCard.BHasClass("OpenCardPanel")) { return }
            AllClosedSelectorCard()
            GameEvents.SendCustomGameEventToServer("event_player_close_card_custom", {}) 
        })
    }
}

function OnDeactivateCards()
{
    for (let child of ChooseCardList.Children())
    {
        child.ClearPanelEvent("onactivate")
    }
}

function ActiveCardEvent(card_id, card_replace)
{
    if (!PanelChooseBodyCard.BHasClass("OpenCardPanel")) { return }
    AllClosedSelectorCard()
    GameEvents.SendCustomGameEventToServer("event_player_select_card_custom", {card_id : card_id, card_replace_id : card_replace})
}

function ActiveCardChangerEvent(replace_card_data, card_id, data)
{
    PanelChooseBodyCard.visible = false
    PanelReplaceCard.visible = true
    PanelReplaceCard.SetHasClass("IsOpenedReplace", true)

    PanelReplaceCardData.RemoveAndDeleteChildren()

    CreatePanelCardReplace(replace_card_data, PanelReplaceCardData)

    let ReplaceCardArrow = $.CreatePanel("Panel", PanelReplaceCardData, "")
    ReplaceCardArrow.AddClass("ReplaceCardArrow")

    let ReplaceCardStashList = $.CreatePanel("Panel", PanelReplaceCardData, "")
    ReplaceCardStashList.AddClass("ReplaceCardStashList")

    for (let stash_card_place in Object.values(data.current_card_list))
    {
        let stash_card_data = Object.values(data.current_card_list)[stash_card_place]
        let callback_replace = function()
        {
            ActiveCardEvent(card_id, stash_card_place)
        }
        CreatePanelCardReplace(stash_card_data, ReplaceCardStashList, callback_replace)
    }

    if (CardButtonReplaceBack)
    {
        CardButtonReplaceBack.SetPanelEvent("onactivate", function()
        {
            if (!PanelReplaceCard.BHasClass("IsOpenedReplace")) { return }
            PanelChooseBodyCard.visible = true
            PanelReplaceCard.visible = false
        })
    }

    if (CardButtonReplaceCancel)
    {
        CardButtonReplaceCancel.SetPanelEvent("onactivate", function()
        {
            if (!PanelReplaceCard.BHasClass("IsOpenedReplace")) { return }
            AllClosedSelectorCard()
            GameEvents.SendCustomGameEventToServer("event_player_close_card_custom", {}) 
        })
    }
}

function AllClosedSelectorCard()
{
    PanelChooseBodyCard.SetHasClass("OpenCardPanel", false)
    PanelReplaceCard.SetHasClass("IsOpenedReplace", false)
    PanelReplaceCard.visible = false
    PanelChooseBodyCard.visible = true
}

function CreatePanelCardReplace(card_data, parent, callback)
{
    let ReplaceCardBasePanel = $.CreatePanel("Panel", parent, "")
    ReplaceCardBasePanel.AddClass("ReplaceCardBasePanel")

    let ReplaceCardBasePanelBundle = $.CreatePanel("Label", ReplaceCardBasePanel, "")
    ReplaceCardBasePanelBundle.AddClass("ReplaceCardBasePanelBundle")
    ReplaceCardBasePanelBundle.text = $.Localize("#"+card_data.bundle_name)

    let ReplaceCardBasePanelImgBox = $.CreatePanel("Panel", ReplaceCardBasePanel, "")
    ReplaceCardBasePanelImgBox.AddClass("ReplaceCardBasePanelImgBox")

    let ReplaceCardBasePanelImg = $.CreatePanel("Image", ReplaceCardBasePanelImgBox, "")
    ReplaceCardBasePanelImg.AddClass("ReplaceCardBasePanelImg")
    ReplaceCardBasePanelImg.SetImage("file://{images}/card_list/" + card_data.card_name + ".png")

    let ReplaceCardBasePanelCardName = $.CreatePanel("Label", ReplaceCardBasePanel, "")
    ReplaceCardBasePanelCardName.AddClass("ReplaceCardBasePanelCardName")
    ReplaceCardBasePanelCardName.text = $.Localize("#"+card_data.card_name)

    if (callback)
    {
        ReplaceCardBasePanelImgBox.AddClass("ReplaceCardBasePanelImgBoxActive")
        ReplaceCardBasePanelImgBox.SetPanelEvent("onactivate", callback)
    }
}

function UpdateCardStashList(data)
{
    let server_card_list = data
    for (let child of CardSelectorList.Children())
    {
        let get_child_slot = Number(child.id.replace("CardStashPanel_", ""))
        if (child.current_card && server_card_list[get_child_slot] == null)
        {
            child.RemoveAndDeleteChildren()
            child.current_card = null
        }
        else if (!child.current_card && server_card_list[get_child_slot] == null)
        {
            child.current_card = null   
        }
        else if (!child.current_card || child.current_card != server_card_list[get_child_slot].card_name)
        {
            child.RemoveAndDeleteChildren()
            let CardBGStashImage = $.CreatePanel("Image", child, "")
            CardBGStashImage.AddClass("CardBGStashImage")
            CardBGStashImage.SetImage("file://{images}/card_list/" + server_card_list[get_child_slot].card_name + ".png")
            child.current_card = server_card_list[get_child_slot].card_name
        }
    }
}

function SwitchInventoryCards()
{
    PanelInventoryCard.ToggleClass("VisibleInventoryCard")
}

function UpdateCardInventoryList(data)
{
    for (card_id of Object.keys(data))
    {
        let card_data = data[card_id]
        let card_panel = CardInventoryList.FindChildTraverse("inventory_card_" + card_id)
        if (card_panel == null)
        {
            let InventoryCardChild = $.CreatePanel("Panel", CardInventoryList, "inventory_card_" + card_id)
            InventoryCardChild.AddClass("InventoryCardChild")

            let InventoryCardChildImg = $.CreatePanel("Image", InventoryCardChild, "")
            InventoryCardChildImg.AddClass("InventoryCardChildImg")
            InventoryCardChildImg.SetImage("file://{images}/card_list/" + card_data.card_name + ".png")
        }
    }
}

Init()