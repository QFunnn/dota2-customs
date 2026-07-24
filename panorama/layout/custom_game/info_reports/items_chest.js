--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var CURRENT_DROP_ID = null
var rarity_color = // Цвет рарности
{
    common : "#b0c3d9",
    uncommon : "#5e98d9", 
    rare: "#4b69ff",
    mythical : "#8847ff", 
    legendary : "#d32ce6", 
    immortal : "#e4ae39", 
} 
var DELAY_SPAWN_ITEMS_ANIM = 0.01 // 0 - off
var STARTING_SPEED = 5890
var DROP_SLOT = 70
var DROP_POS = [0,0] // Позиция дропнутого айтема
var SOUND_TICK_WIDTH = 128
var last_chest_info = null
var CHEST_ID_CURRENT = null

GameEvents.Subscribe_custom('shop_dota1x6_open_chest_information', shop_dota1x6_open_chest_information)
function shop_dota1x6_open_chest_information(data)
{
    last_chest_info = data.chest_info
    InitChest(data.chest_info)
}

GameEvents.Subscribe_custom('shop_dota1x6_open_chest_active', shop_dota1x6_open_chest_active)
function shop_dota1x6_open_chest_active(data)
{
    if (data.drop_id == null)
    {
        return
    }
    let item_position_in_drop_list = GetItemPositionInDropList(data.drop_id, data.items)
    if (item_position_in_drop_list == null)
    {
        return 
    }
    CURRENT_DROP_ID = item_position_in_drop_list
    OpenChest(data.items, data.is_retry_drop, data.shard_counter, data.is_reroll)
}

function InitChest(data, reopen)
{
    $("#ItemsInChestName").text = $.Localize("#chest_items_normal_2")
    $("#ItemDropRerollButton").visible = false
    $("#ChestHudMainPanel").SetHasClass("NoRareItems", true)
    ClearOldChest()
    CHEST_ID_CURRENT = data.chest_id
    $("#ChestName").text = $.Localize("#"+data.chest_name)
    ChestInitItemsInRoll(data.chest_items)
    ChestInitItemsInChest(data.chest_items)
    ButtonSet(data.chest_id, data.chest_cost, data.chest_items, data.is_no_buy, data.is_only_one_open, data.chest_item_id)
    $("#ChestHudMainPanel").style.opacity = "1"
    $("#ChestHudMainPanel").hittest = true
    $("#ChestCostIcon").visible = true

    $("#InfoOpenReroll").SetPanelEvent('onmouseover', function() 
    {
        $.DispatchEvent('DOTAShowTextTooltip', $("#InfoOpenReroll"), $.Localize("#reroll_chest_info_description")) 
    });

    $("#InfoOpenReroll").SetPanelEvent('onmouseout', function() 
    {
        $.DispatchEvent('DOTAHideTextTooltip', $("#InfoOpenReroll")); 
    });

    if (data.is_reroll)
    {
        $("#InfoOpenReroll").visible = true
    }
    else
    {
        $("#InfoOpenReroll").visible = false
    }

    if (data.is_no_buy && !HasItemInventory(data.chest_item_id))
    {
        $("#ChestCostIcon").visible = false
        $("#ChestCostLabel").text = $.Localize("#how_to_get_chest")
        $("#OpenChestButton").SetPanelEvent('onmouseover', function() 
        {
            $.DispatchEvent('DOTAShowTextTooltip', $("#OpenChestButton"), $.Localize(data.is_no_buy)) 
        });
        $("#OpenChestButton").SetPanelEvent('onmouseout', function() 
        {
            $.DispatchEvent('DOTAHideTextTooltip', $("#OpenChestButton")); 
        });
    }
    else if (data.is_only_one_open && IsChestOpened(data.chest_id))
    {
        $("#ChestCostIcon").visible = false
        $("#OpenChestButton").ClearPanelEvent( "onmouseover" )
        $("#ChestCostLabel").text = $.Localize("#chest_is_opened")
    }
    else if (HasItemInventory(data.chest_item_id))
    {
        $("#ChestCostIcon").visible = false
        $("#ChestCostLabel").text = $.Localize("#open_chest")
    }
    else
    {
        $("#OpenChestButton").ClearPanelEvent( "onmouseover" )
        $("#ChestCostLabel").text = data.chest_cost
    }

    $("#ChestHudMainPanel").SetPanelEvent("onactivate", function() {})
    $("#ChestHudMainPanel").SetHasClass("ChestHudAnimClose", false)
    $("#ChestHudMainPanel").SetHasClass("ChestHudAnimOpen", true)

    $("#OpenChestButton").style.opacity = "1"
    
    if (!reopen)
    {
        Game.EmitSound("UI.Shop_Buy_start")
    }

    let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
    blur_panel.RemoveClass("shop_window_blur_hidden")
    blur_panel.AddClass("shop_window_blur")

    blur_panel.SetPanelEvent("onactivate", function() 
    {
        CloseChest()
        blur_panel.SetPanelEvent("onactivate", function() {})
    })
}

function ButtonSet(chest_id, cost, chest_items, is_no_buy, is_only_one_open, chest_item_id)
{
    if (is_no_buy && !HasItemInventory(chest_item_id))
    {
        $("#OpenChestButton").SetHasClass("no_money", false)
        $("#OpenChestButton").SetHasClass("is_chest_no_buy", true)
        $("#OpenChestButton").SetPanelEvent('onactivate', function() {})
        return
    }
    $("#OpenChestButton").SetHasClass("is_chest_no_buy", false)
    if (is_only_one_open && IsChestOpened(chest_id))
    {
        $("#OpenChestButton").SetHasClass("is_chest_has_opened", true)
        $("#OpenChestButton").SetHasClass("no_money", false)
        $("#OpenChestButton").SetPanelEvent('onactivate', function() {})
        return
    }
    $("#OpenChestButton").SetHasClass("is_chest_has_opened", false)
    if (player_table_shop == null)
    {
        $("#OpenChestButton").SetPanelEvent('onactivate', function() {})
        $("#OpenChestButton").SetHasClass("no_money", true)
        $("#ChestCostLabel").SetHasClass("chest_cost_no_money", true)
        return
    }
    if (player_table_shop.points < cost)
    {
        $("#OpenChestButton").SetPanelEvent('onactivate', function() {})
        $("#OpenChestButton").SetHasClass("no_money", true)
        $("#ChestCostLabel").SetHasClass("chest_cost_no_money", true)
        return
    }
    $("#ChestCostLabel").SetHasClass("chest_cost_no_money", false)
    if (IsHeroHasAllItemsInChest(chest_items))
    {
        $("#OpenChestButton").SetPanelEvent('onactivate', function() {})
        $("#OpenChestButton").SetHasClass("has_all_items", true)
        return
    }
    $("#OpenChestButton").SetHasClass("no_money", false)
    $("#OpenChestButton").SetPanelEvent('onactivate', function()
    {
        GameEvents.SendCustomGameEventToServer_custom( "shop_dota1x6_open_chest_get_reward", { chest_id : chest_id } );
    })
}

function CloseChest()
{
    if (loop_sound != undefined)
    {
        Game.StopSound(loop_sound)
        loop_sound = undefined     
    }

    $("#ChestHudMainPanel").hittest = false
    $("#ChestHudMainPanel").style.opacity = "0"
    $("#DropItemPanel").SetHasClass("DropItemPanelVisible", false)
    last_chest_info = null

    PAIR_MODE = false
    PAIR_INFO = null
    PAIR_ANIM_RUNNING = false
    CHEST_SINGLE_MODE = false
    CHEST_SINGLE_INFO = null
    CHEST_SINGLE_WHICH = null
    $("#ChestHudMainPanel").RemoveClass("ChestHudPairMode")
    let roll2_close = $.GetContextPanel().FindChildTraverse("RollItemsListMain2")
    if (roll2_close) { roll2_close.RemoveAndDeleteChildren() }

    Game.EmitSound("UI.Shop_Category_Open")

    let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
    blur_panel.AddClass("shop_window_blur_hidden")
    blur_panel.RemoveClass("shop_window_blur")

    GameEvents.SendCustomGameEventToServer_custom( "shop_dota1x6_close_chest_checked_reward", {} );

    $("#ChestHudMainPanel").SetHasClass("ChestHudAnimClose", true)
    $("#ChestHudMainPanel").SetHasClass("ChestHudAnimOpen", false)

    $.Schedule( 0.35, function()
    {
        UpdateShards()
        UpdateSelectionSets()
        let ItemsList = $.GetContextPanel().FindChildTraverse("ItemsList")
        if (ItemsList)
        {
            InitItems()
            InitSounds()
            InitVote()
            CloseActiveChatBlock()
            InitShopItemsForHero(ItemsList)
        }
    })

    CHEST_ID_CURRENT = null
}

function ClearOldChest()
{
    $("#RollItemsListMain").RemoveAndDeleteChildren()
    $("#ItemsInChestBlock").RemoveAndDeleteChildren()
    $("#ItemsInChestBlockRare").RemoveAndDeleteChildren()
    $("#RarePanelName").style.visibility = "collapse"
    $("#RarePanelBorder").style.visibility = "collapse"
    $("#ItemsInChestBlockRare").style.visibility = "collapse"
    $("#RollItemsListMain").style.position = "0px 0px 0px"

    let poor_line = $.GetContextPanel().FindChildTraverse("RollLine")
    if (poor_line) { poor_line.RemoveClass("RollLineGray") }
    let rich_line = $.GetContextPanel().FindChildTraverse("RollLine2")
    if (rich_line) { rich_line.RemoveClass("RollLineGray"); rich_line.RemoveClass("RollLineLocked") }
}

function ChestInitItemsInRoll(items)
{
    $("#RollItemsListMain").RemoveAndDeleteChildren()
    let copy_table = []
    let has_all_items = true
    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        if (items[i] != null && !HasItemInventory(items[i].item_id) && items[i].chance == null)
        {
            has_all_items = false
        }
    }
    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        if (items[i] != null && (!HasItemInventory(items[i].item_id) || has_all_items))
        {
            copy_table.push(items[i])
        }
    }
    if (copy_table.length > 0)
    {
        for (let i = 0; i <= 100; i++)
        {
            let randomIndex = Math.floor(Math.random() * copy_table.length);
            let randomElement = copy_table[randomIndex];
            CreateItemInfo($("#RollItemsListMain"), randomElement, 0, true, DROP_SLOT == i, i)
        }
    }
    $("#RollItemsListMain").style.position = "0px 0px 0px"
}  

function ChestInitItemsInChest(items)
{
    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        let item_info = items[i]
        if (item_info)
        {
            CreateItemInfo($("#ItemsInChestBlock"), item_info, i)
        }
    }
}

function CreateItemInfo(main_panel, item_info, delay_count, roll, drop_slot, c)
{
    let rare = item_info.rare
    let name = item_info.item_name
    let icon = item_info.item_icon
    let chance = item_info.chance
    let is_rare = 0

    if (chance != null && roll == null)
    {
        $("#RarePanelName").style.visibility = "visible"
        $("#RarePanelBorder").style.visibility = "visible"
        $("#ItemsInChestBlockRare").style.visibility = "visible"
        $("#ItemsInChestName").text = $.Localize("#chest_items_normal")
        main_panel = $("#ItemsInChestBlockRare")
        is_rare = 1
        $("#ChestHudMainPanel").SetHasClass("NoRareItems", false)
    }

    $.Schedule( DELAY_SPAWN_ITEMS_ANIM * delay_count, function()
    {
        let panel_id = ""
        
        if (drop_slot)
        {
            panel_id = "dropped_item"
        }

        let item_panel = $.CreatePanel("Panel", main_panel, panel_id)

        if (roll)
        {
            item_panel.AddClass("item_panel_roll")
        }
        else
        {
            item_panel.AddClass("item_panel")

        }

        let item_icon = $.CreatePanel("Panel", item_panel, "item_icon")
        item_icon.AddClass("item_icon")
        item_icon.style.backgroundImage = 'url("' + icon + '")';
        item_icon.style.backgroundSize = "100%"

        if (ITEMS_TERRORBLADE_COLOR_GEM[item_info.item_id])
        {
            let item_icon_terrorblade_color = $.CreatePanel("Panel", item_icon, "item_icon_terrorblade_color")
            item_icon_terrorblade_color.AddClass("item_icon_terrorblade_color")
            item_icon_terrorblade_color.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[item_info.item_id]
        }

       // let item_panel_name = $.CreatePanel("Panel", item_panel, "item_panel_name")
        //item_panel_name.AddClass("item_panel_name")
        //item_panel_name.style.backgroundColor = rarity_color[rare]

        //let item_name = $.CreatePanel("Label", item_panel_name, "item_name")
        //item_name.AddClass("item_name")
        //item_name.text = name

        item_panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', item_panel, name) });
        
        item_panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', item_panel); });


        let item_panel_border = $.CreatePanel("Panel", item_panel, "item_panel_border")
        item_panel_border.AddClass("item_panel_border")
        item_panel_border.style.borderBrush = 'gradient( linear, 0% 100%, 0% 20%, from(' + rarity_color[rare] + '), to( rgba(0,0,0,0.1) ) )'

        if (!roll)
        {
            if (HasItemInventory(item_info.item_id))
            {
                item_panel.AddClass("has_dropped_item")
            }
            else
            {
                if (chance != null)
                {
                    $.Schedule( 0.2, function(){
                        item_panel.AddClass("item_panel_rare")})
                }
            }
        }

        $.Schedule( 0.1, function()
        {
            item_panel.style.opacity = "1" 

            if (roll && drop_slot)
            {
                let check_pos = item_panel.style.position
                let SpaceFind = check_pos.indexOf('px');
                let center_panel = Number(check_pos.substring(0, SpaceFind))
                SOUND_TICK_WIDTH = (item_panel.actuallayoutwidth / item_panel.actualuiscale_x) + (5 * 2) 
                DROP_POS[0] = -((Number(check_pos.substring(0, SpaceFind)) - ( (item_panel.actuallayoutwidth / item_panel.actualuiscale_x) * 3) - (5 * 4)) - (item_panel.actuallayoutwidth / item_panel.actualuiscale_x))
                DROP_POS[1] = -(Number(check_pos.substring(0, SpaceFind)) - ( (item_panel.actuallayoutwidth / item_panel.actualuiscale_x) * 3) - (5 * 4))
            }
        })
    }) 
}

var loop_sound = undefined

function OpenChest(items, retry_drop, shard_counter, is_reroll)
{
    $("#ItemDropRerollButton").visible = false
    Game.EmitSound("UI.Chest_open")
    loop_sound = Game.EmitSound("UI.Chest_open2")
    let current = 0
    // НУЖНО ПЕРЕДАТЬ ДРОП АЙДИ ШМОТКИ
    if (CURRENT_DROP_ID != null)
    {
        let drop_info = items[CURRENT_DROP_ID]
        let slot_drop = $("#RollItemsListMain").FindChildTraverse("dropped_item")
        if (slot_drop)
        {   
            let item_icon = slot_drop.FindChildTraverse("item_icon")
            if (item_icon)
            {
                item_icon.style.backgroundImage = 'url("' + drop_info.item_icon + '")';
            }
            let item_panel_name = slot_drop.FindChildTraverse("item_panel_name")
            if (item_panel_name)
            {
                item_panel_name.style.backgroundColor = rarity_color[drop_info.rare]
            }
            let item_name = slot_drop.FindChildTraverse("item_name")
            if (item_name)
            {
                item_name.text = drop_info.item_name
            }
            let item_panel_border = slot_drop.FindChildTraverse("item_panel_border")
            if (item_panel_border)
            {
                item_panel_border.style.borderBrush = 'gradient( linear, 0% 100%, 0% 20%, from(' + rarity_color[drop_info.rare] + '), to( rgba(0,0,0,0.1) ) )'
            }
            let item_icon_terrorblade_color = slot_drop.FindChildTraverse("item_icon_terrorblade_color")
            if (item_icon_terrorblade_color)
            {
                if (ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id])
                {
                    item_icon_terrorblade_color.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id]
                }
            }
        }
    }

    let randomly_max_distance = Math.floor(Math.random() * (DROP_POS[1] - DROP_POS[0] + 1) + DROP_POS[0]);
    ChestAnimate(current, randomly_max_distance, STARTING_SPEED, SOUND_TICK_WIDTH, items[CURRENT_DROP_ID], items, retry_drop, shard_counter, is_reroll)
    $("#OpenChestButton").style.opacity = "0"
}

function ChestAnimate(current, drop_distance, speed, sound_tick, item_drop_info, items, retry_drop, shard_counter, is_reroll)
{
    if ($("#ChestHudMainPanel").BHasClass("ChestHudAnimClose"))
    {
        CURRENT_DROP_ID = null
        CloseDropPanel()
        $.Schedule( 0.35, function()
        {
            UpdateShards()
            UpdateSelectionSets()
            let ItemsList = $.GetContextPanel().FindChildTraverse("ItemsList")
            if (ItemsList)
            {
                InitItems()
                InitSounds()
                InitVote()
                CloseActiveChatBlock()
                InitShopItemsForHero(ItemsList)
            }
        })
        return
    }


    if (current <= drop_distance)
    {
        $.Schedule(0.1, function() 
        {
            GiveItemDrop(item_drop_info, items, retry_drop, shard_counter, is_reroll)
        })
        return
    }
    current = current - (speed * Game.GetGameFrameTime())
    sound_tick = sound_tick - (speed * Game.GetGameFrameTime())
    if (sound_tick <= 0)
    {
        sound_tick = SOUND_TICK_WIDTH
        Game.EmitSound("random_wheel_lever")
    }
    if (current <= 0.37 * drop_distance)
    {
        speed = speed - (speed * Game.GetGameFrameTime())
    }
    speed = Math.max(30, speed);

    $("#RollItemsListMain").style.position = current + "px 0px 0px"
    $.Schedule(Game.GetGameFrameTime(), function() 
    {
		ChestAnimate(current, drop_distance, speed, sound_tick, item_drop_info, items, retry_drop, shard_counter, is_reroll)
	})
}

function GiveItemDrop(item_drop_info, items, retry_drop, shard_counter, is_reroll)
{
    $("#OpenChestButton").style.opacity = "1"
    $("#DropItemPanel").SetHasClass("DropItemPanelVisible", true)
    
    let item_icon_terrorblade_color = $("#ItemDropIcon").FindChildTraverse("item_icon_terrorblade_color")
    if (item_icon_terrorblade_color)
    {
        item_icon_terrorblade_color.DeleteAsync(0)
    }

    if (retry_drop == 1)
    {
        $("#ItemDropIcon").style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_5.png")';
        $("#ItemDropIcon").style.backgroundSize = "100%"
        $("#ItemDropName").text = shard_counter + $.Localize("#gift_name_shards")
    }
    else
    {
        $("#ItemDropIcon").style.backgroundImage = 'url("' + item_drop_info.item_icon + '")';
        $("#ItemDropIcon").style.backgroundSize = "100%"
        $("#ItemDropName").text = item_drop_info.item_name
        if (ITEMS_TERRORBLADE_COLOR_GEM[item_drop_info.item_id])
        {
            let item_icon_terrorblade_color = $.CreatePanel("Panel", $("#ItemDropIcon"), "item_icon_terrorblade_color")
            item_icon_terrorblade_color.AddClass("item_icon_terrorblade_color")
            item_icon_terrorblade_color.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[item_drop_info.item_id]
        }
    }

    $("#DropEffect").style.washColor = rarity_color[item_drop_info.rare]
    $("#DropEffect_top").style.washColor = rarity_color[item_drop_info.rare]
    $("#DropEffect_bottom").style.washColor = rarity_color[item_drop_info.rare]

    let item_drop_effect = $.CreatePanel("DOTAParticleScenePanel", $("#ChestHudMainPanel"), "", {particleName:"particles/ui/ui_generic_treasure_impact.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"0 0 300", lookAt:"0 0 0", fov:"60"})
    item_drop_effect.AddClass("item_drop_effect")
    item_drop_effect.hittest = false
    item_drop_effect.DeleteAsync(3)

    Game.EmitSound("ui.treasure_01")

    if (loop_sound != undefined)
    {
        Game.StopSound(loop_sound)  
        loop_sound = undefined   
    }
   
    $("#ItemDropClaimButton").SetPanelEvent('onactivate', function()
    {
        if (last_chest_info != null)
        {
            InitChest(last_chest_info, true)
        }
        CloseDropPanel()
        $.Schedule( 0.35, function()
        {
            UpdateShards()
            UpdateSelectionSets()
            let ItemsList = $.GetContextPanel().FindChildTraverse("ItemsList")
            if (ItemsList)
            {
                InitItems()
                InitSounds()
                InitVote()
                CloseActiveChatBlock()
                InitShopItemsForHero(ItemsList)
            }
        })
    })

    if (is_reroll == 1)
    {
        $("#ItemDropRerollButton").SetPanelEvent('onactivate', function()
        {
            InitChest(last_chest_info, true)
            $.Schedule( 0.25, function()
            {
                GameEvents.SendCustomGameEventToServer_custom( "shop_dota1x6_open_chest_get_reward", { chest_id : CHEST_ID_CURRENT, rerolled : true } );
            })
            CloseDropPanel(true)
        })
        $("#ItemDropRerollButton").visible = true
    }
    
    CURRENT_DROP_ID = null
}

function CloseDropPanel(is_reroll)
{
    if (!is_reroll)
    {
        GameEvents.SendCustomGameEventToServer_custom( "shop_dota1x6_close_chest_checked_reward", {} );
    }
    $("#RollItemsListMain").style.position = "0px 0px 0px"
    $("#DropItemPanel").SetHasClass("DropItemPanelVisible", false)
}

function GetItemPositionInDropList(id, items)
{
    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        let item_info = items[i]
        if (item_info && item_info.item_id == id)
        {
            return i
        }
    }
    return null
}

function IsHeroHasAllItemsInChest(items)
{
    let all_items = true
    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        let item_info = items[i]
        if (item_info && !HasItemInventory(item_info.item_id))
        {
            all_items = false
            break
        }
    }
    return all_items
}

// ===================== Связанные сундуки (бедный + богатый) =====================

function IsChestOwned(kind, index)
{
    let sub = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer())
    let pending = sub ? sub.pending_chest : null
    if (!pending || pending.poor_id == null) { return false }
    if (kind == "poor") { return Number(pending.poor_id) == Number(index) && pending.poor_opened != 1 }
    if (kind == "rich") { return Number(pending.rich_id) == Number(index) && pending.rich_opened != 1 }
    return false
}

function IsChestAvailableToOpen(kind, index)
{
    let sub = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer())
    if (!IsChestOwned(kind, index)) { return false }
    if (kind == "rich") { return sub && sub.subscribed == 1 }
    return true
}

function SortChestKeysAvailableFirst(pool, kind)
{
    let keys = []
    for (let k in pool) { keys.push(k) }
    keys.sort(function(a, b)
    {
        let av = IsChestOwned(kind, a) ? 0 : 1
        let bv = IsChestOwned(kind, b) ? 0 : 1
        if (av != bv) { return av - bv }
        return Number(a) - Number(b)
    })
    return keys
}

function CreateChestPoolCard(panel, chest_info, kind, index)
{
    if (!chest_info) { return }

    let is_owned = IsChestOwned(kind, index)
    let is_openable = IsChestAvailableToOpen(kind, index)

    let BlockItem = $.CreatePanel("Panel", panel, "")
    BlockItem.AddClass("BlockItem")
    if (is_owned)
    {
        BlockItem.AddClass("BlockItem_owned_chest")
        let chest_new_badge = $.CreatePanel("Label", BlockItem, "block_new_badge")
        chest_new_badge.AddClass("BlockItem_new_badge")
        chest_new_badge.text = $.Localize("#chest_new_item")
    }

    let BlockItemImage = $.CreatePanel("Panel", BlockItem, "BlockItemImage")
    BlockItemImage.AddClass("BlockItemImage")
    BlockItemImage.style.backgroundImage = 'url("s2r://panorama/images/' + chest_info.chest_image + '.png")'
    BlockItemImage.style.backgroundSize = "100%"

    let BlockItemLabel = $.CreatePanel("Label", BlockItem, "")
    BlockItemLabel.AddClass("BlockItemLabel")
    BlockItemLabel.text = $.Localize("#" + chest_info.chest_name)

    let BlockItemBuyButton = $.CreatePanel("Panel", BlockItem, "button")
    BlockItemBuyButton.AddClass("BlockItemBuyButton")
    BlockItemBuyButton.AddClass(is_openable ? "BlockItemBuyButton_money" : "BlockItemBuyButton_is_chest_no_buy")

    let button_label = "#chest_pool_locked"
    if (is_openable) { button_label = "#open_chest" }
    else if (is_owned) { button_label = "#chest_pair_rich_locked" }

    let BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButton, "")
    BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel")
    BlockItemBuyButtonLabel.text = $.Localize(button_label)

    let open_view = function()
    {
        Game.EmitSound("UI.Shop_Category_Open")
        OpenPoolChestSingle(kind, index)
    }
    BlockItem.SetPanelEvent("onactivate", open_view)
    BlockItemBuyButton.SetPanelEvent("onactivate", open_view)
}

function CreateChestPairCard(panel)
{
    let BlockItem = $.CreatePanel("Panel", panel, "chest_pair_card")
    BlockItem.AddClass("BlockItem")

    let BlockItemImage = $.CreatePanel("Panel", BlockItem, "BlockItemImage")
    BlockItemImage.AddClass("BlockItemImage")
    BlockItemImage.style.backgroundImage = 'url("s2r://panorama/images/custom_game/shop/icons/sub_arcana.png")'
    BlockItemImage.style.backgroundSize = "100%"

    let BlockItemLabel = $.CreatePanel("Label", BlockItem, "")
    BlockItemLabel.AddClass("BlockItemLabel")
    BlockItemLabel.text = $.Localize("#chest_pair_title")

    let BlockItemBuyButton = $.CreatePanel("Panel", BlockItem, "button")
    BlockItemBuyButton.AddClass("BlockItemBuyButton")
    BlockItemBuyButton.AddClass("BlockItemBuyButton_money")

    let BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButton, "")
    BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel")
    BlockItemBuyButtonLabel.text = $.Localize("#open_chest")

    let open_pair = function()
    {
        Game.EmitSound("UI.Shop_Category_Open")
        GameUI.CustomUIConfig().OpenChestPairWindow()
    }
    BlockItem.SetPanelEvent("onactivate", open_pair)
    BlockItemBuyButton.SetPanelEvent("onactivate", open_pair)
}

var CHEST_SINGLE_MODE = false
var CHEST_SINGLE_INFO = null
var CHEST_SINGLE_WHICH = null

function OpenPoolChestSingle(kind, index)
{
    GameUI.CustomUIConfig().chest_popup_driving = false
    let pool = CustomNetTables.GetTableValue("shop_items", kind == "poor" ? "poor_chests" : "rich_chests")
    if (!pool || !pool[index]) { return }
    let chest = pool[index]
    let sub = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer())
    let pending = sub ? sub.pending_chest : null
    let which = null
    if (pending && pending.poor_id != null)
    {
        if (kind == "poor" && Number(pending.poor_id) == Number(index) && pending.poor_opened != 1) { which = "poor" }
        if (kind == "rich" && Number(pending.rich_id) == Number(index) && pending.rich_opened != 1) { which = "rich" }
    }
    let can_open = IsChestAvailableToOpen(kind, index)
    InitPoolChestSingle(chest, which, can_open)
}

function InitPoolChestSingle(chest, which, can_open)
{
    PAIR_MODE = false
    CHEST_SINGLE_MODE = true
    CHEST_SINGLE_INFO = chest
    CHEST_SINGLE_WHICH = which
    PAIR_ANIM_RUNNING = false

    ClearOldChest()
    let roll2 = $.GetContextPanel().FindChildTraverse("RollItemsListMain2")
    if (roll2) { roll2.RemoveAndDeleteChildren() }

    $("#ChestHudMainPanel").RemoveClass("ChestHudPairMode")
    $("#ItemDropRerollButton").visible = false
    $("#InfoOpenReroll").visible = false
    $("#ChestHudMainPanel").SetHasClass("NoRareItems", true)
    $("#ChestName").text = $.Localize("#" + chest.chest_name)
    $("#ChestCostIcon").visible = false

    ChestPairInitLine($("#RollItemsListMain"), chest.chest_items)
    ChestInitItemsInChest(chest.chest_items)

    if (can_open)
    {
        $("#ChestCostLabel").text = $.Localize("#open_chest")
        $("#OpenChestButton").SetHasClass("is_chest_has_opened", false)
        $("#OpenChestButton").SetHasClass("no_money", false)
        $("#OpenChestButton").SetPanelEvent("onactivate", function()
        {
            if (PAIR_ANIM_RUNNING) { return }
            PAIR_ANIM_RUNNING = true
            GameEvents.SendCustomGameEventToServer_custom("chest_pair_open", { which: which })
        })
    }
    else
    {
        if (which)
        {
            $("#ChestCostLabel").text = $.Localize("#chest_pair_rich_locked")
        }
        else
        {
            let sub2 = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer())
            let counter = (sub2 && sub2.chest_counter) ? sub2.chest_counter : 0
            let cfg = CustomNetTables.GetTableValue("shop_items", "chest_config")
            let required = (cfg && cfg.games_required) ? cfg.games_required : 3
            $("#ChestCostLabel").text = $.Localize("#chest_left_prefix") + " " + counter + "/" + required + " " + $.Localize("#chest_left_suffix")
        }
        $("#OpenChestButton").SetHasClass("is_chest_has_opened", true)
        $("#OpenChestButton").SetPanelEvent("onactivate", function() {})
    }

    $("#ChestHudMainPanel").style.opacity = "1"
    $("#ChestHudMainPanel").hittest = true
    $("#ChestHudMainPanel").SetHasClass("ChestHudAnimClose", false)
    $("#ChestHudMainPanel").SetHasClass("ChestHudAnimOpen", true)
    $("#OpenChestButton").style.opacity = "1"

    Game.EmitSound("UI.Shop_Buy_start")

    let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
    blur_panel.RemoveClass("shop_window_blur_hidden")
    blur_panel.AddClass("shop_window_blur")
    blur_panel.SetPanelEvent("onactivate", function()
    {
        CloseChest()
        blur_panel.SetPanelEvent("onactivate", function() {})
    })
}

function OpenSingleChestLine(drop_id, is_dup, shards)
{
    if (!CHEST_SINGLE_INFO) { PAIR_ANIM_RUNNING = false; return }
    let roll_panel = $("#RollItemsListMain")
    let drop_pos = GetItemPositionInDropList(drop_id, CHEST_SINGLE_INFO.chest_items)
    let drop_info = drop_pos != null ? CHEST_SINGLE_INFO.chest_items[drop_pos] : null
    if (!drop_info) { PAIR_ANIM_RUNNING = false; return }

    let slot_drop = roll_panel.FindChildTraverse("dropped_item")
    if (slot_drop)
    {
        let item_icon = slot_drop.FindChildTraverse("item_icon")
        if (item_icon) { item_icon.style.backgroundImage = 'url("' + drop_info.item_icon + '")' }
        let item_panel_border = slot_drop.FindChildTraverse("item_panel_border")
        if (item_panel_border) { item_panel_border.style.borderBrush = 'gradient( linear, 0% 100%, 0% 20%, from(' + rarity_color[drop_info.rare] + '), to( rgba(0,0,0,0.1) ) )' }
        let item_icon_terrorblade_color = slot_drop.FindChildTraverse("item_icon_terrorblade_color")
        if (item_icon_terrorblade_color && ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id])
        {
            item_icon_terrorblade_color.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id]
        }
    }

    Game.EmitSound("UI.Chest_open")
    loop_sound = Game.EmitSound("UI.Chest_open2")

    ChestPairRecomputeDropPos(roll_panel)

    let dist = Math.floor(Math.random() * (PAIR_DROP_POS[1] - PAIR_DROP_POS[0] + 1) + PAIR_DROP_POS[0])
    ChestPairAnimate(roll_panel, 0, dist, STARTING_SPEED, PAIR_SOUND_TICK_WIDTH, "single", drop_info, is_dup, shards)
    $("#OpenChestButton").style.opacity = "0"
}

var PAIR_MODE = false
var PAIR_INFO = null
var PAIR_ANIM_RUNNING = false
var PAIR_DROP_POS = [0, 0]
var PAIR_SOUND_TICK_WIDTH = 128

GameUI.CustomUIConfig().OpenChestPairWindow = OpenChestPairWindow
function OpenChestPairWindow()
{
    GameUI.CustomUIConfig().chest_popup_driving = false
    GameEvents.SendCustomGameEventToServer_custom("chest_pair_get_info", {})
}

GameEvents.Subscribe_custom('chest_pair_info', chest_pair_info)
function chest_pair_info(data)
{
    if (GameUI.CustomUIConfig().chest_popup_driving) { return }
    if (!data || !data.chest_info) { return }
    InitChestPair(data.chest_info)
}

GameEvents.Subscribe_custom('chest_pair_roll_result', chest_pair_roll_result)
function chest_pair_roll_result(data)
{
    if (GameUI.CustomUIConfig().chest_popup_driving) { return }
    if (data == null || data.drop_id == null) { PAIR_ANIM_RUNNING = false; return }
    if (CHEST_SINGLE_MODE)
    {
        OpenSingleChestLine(data.drop_id, data.is_dup, data.shards)
    }
    else
    {
        OpenChestPairLine(data.which, data.drop_id, data.is_dup, data.shards)
    }
}

GameEvents.Subscribe_custom('chest_pair_granted', chest_pair_granted_flag)
function chest_pair_granted_flag(data)
{
    GameUI.CustomUIConfig().chest_popup_pending = true
}

function ChestPairRecomputeDropPos(roll_panel)
{
    if (!roll_panel) { return }
    let dropped = roll_panel.FindChildTraverse("dropped_item")
    if (!dropped) { return }
    let check_pos = dropped.style.position
    if (!check_pos) { return }
    let spaceFind = check_pos.indexOf('px')
    if (spaceFind < 0) { return }
    let width = dropped.actuallayoutwidth / dropped.actualuiscale_x
    if (!width || width <= 0) { return }
    let center = Number(check_pos.substring(0, spaceFind))
    PAIR_SOUND_TICK_WIDTH = width + (5 * 2)
    PAIR_DROP_POS[0] = -((center - (width * 3) - (5 * 4)) - width)
    PAIR_DROP_POS[1] = -(center - (width * 3) - (5 * 4))
}

function ChestPairInitLine(roll_panel, items)
{
    roll_panel.RemoveAndDeleteChildren()
    let copy_table = []
    let has_all_items = true
    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        if (items[i] != null && !HasItemInventory(items[i].item_id) && items[i].chance == null)
        {
            has_all_items = false
        }
    }
    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        if (items[i] != null && (!HasItemInventory(items[i].item_id) || has_all_items))
        {
            copy_table.push(items[i])
        }
    }
    if (copy_table.length > 0)
    {
        for (let i = 0; i <= 100; i++)
        {
            let randomIndex = Math.floor(Math.random() * copy_table.length)
            let randomElement = copy_table[randomIndex]
            CreateItemInfo(roll_panel, randomElement, 0, true, DROP_SLOT == i, i)
        }
    }
    roll_panel.style.position = "0px 0px 0px"
    $.Schedule(0.12, function()
    {
        PAIR_DROP_POS[0] = DROP_POS[0]
        PAIR_DROP_POS[1] = DROP_POS[1]
        PAIR_SOUND_TICK_WIDTH = SOUND_TICK_WIDTH
    })
}

function InitChestPair(info)
{
    PAIR_MODE = true
    PAIR_INFO = info
    PAIR_ANIM_RUNNING = false

    ClearOldChest()
    let roll2 = $.GetContextPanel().FindChildTraverse("RollItemsListMain2")
    if (roll2) { roll2.RemoveAndDeleteChildren() }

    $("#ItemDropRerollButton").visible = false
    $("#ChestHudMainPanel").AddClass("ChestHudPairMode")
    $("#ChestHudMainPanel").SetHasClass("NoRareItems", true)
    $("#ChestName").text = $.Localize("#chest_pair_title")
    $("#ChestCostIcon").visible = false
    $("#ChestCostLabel").text = $.Localize("#open_chest")

    if (info.poor)
    {
        ChestPairInitLine($("#RollItemsListMain"), info.poor.chest_items)
    }
    if (info.rich && roll2)
    {
        ChestPairInitLine(roll2, info.rich.chest_items)
    }

    let poor_line = $.GetContextPanel().FindChildTraverse("RollLine")
    if (poor_line)
    {
        poor_line.SetHasClass("RollLineGray", info.poor != null && info.poor.opened == 1)
    }

    let rich_line = $.GetContextPanel().FindChildTraverse("RollLine2")
    if (rich_line)
    {
        rich_line.SetHasClass("RollLineLocked", info.is_sub != 1)
        rich_line.SetHasClass("RollLineGray", info.is_sub != 1 || (info.rich != null && info.rich.opened == 1))
    }

    UpdateChestPairButton()

    $("#ChestHudMainPanel").style.opacity = "1"
    $("#ChestHudMainPanel").hittest = true
    $("#ChestHudMainPanel").SetHasClass("ChestHudAnimClose", false)
    $("#ChestHudMainPanel").SetHasClass("ChestHudAnimOpen", true)
    $("#OpenChestButton").style.opacity = "1"

    Game.EmitSound("UI.Shop_Buy_start")

    let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
    blur_panel.RemoveClass("shop_window_blur_hidden")
    blur_panel.AddClass("shop_window_blur")
    blur_panel.SetPanelEvent("onactivate", function()
    {
        CloseChest()
        blur_panel.SetPanelEvent("onactivate", function() {})
    })
}

function ChestPairNextSlot()
{
    if (!PAIR_INFO) { return null }
    if (PAIR_INFO.poor && PAIR_INFO.poor.opened != 1) { return "poor" }
    if (PAIR_INFO.rich && PAIR_INFO.is_sub == 1 && PAIR_INFO.rich.opened != 1) { return "rich" }
    return null
}

function UpdateChestPairButton()
{
    if (!PAIR_INFO) { return }
    let poorBtn = $.GetContextPanel().FindChildTraverse("OpenChestButtonPoor")
    let richBtn = $.GetContextPanel().FindChildTraverse("OpenChestButtonRich")
    let poorLbl = $.GetContextPanel().FindChildTraverse("OpenChestButtonPoorLabel")
    let richLbl = $.GetContextPanel().FindChildTraverse("OpenChestButtonRichLabel")

    let poor_open = PAIR_INFO.poor && PAIR_INFO.poor.opened != 1
    let rich_present = PAIR_INFO.rich && PAIR_INFO.rich.opened != 1
    let rich_active = rich_present && PAIR_INFO.is_sub == 1

    if (poorBtn)
    {
        poorBtn.SetHasClass("chest_btn_hidden", PAIR_ANIM_RUNNING || !poor_open)
        poorBtn.SetHasClass("is_chest_has_opened", false)
        if (poorLbl) { poorLbl.text = $.Localize("#open_chest") }
        poorBtn.SetPanelEvent("onactivate", function()
        {
            if (PAIR_ANIM_RUNNING) { return }
            if (!(PAIR_INFO.poor && PAIR_INFO.poor.opened != 1)) { return }
            PAIR_ANIM_RUNNING = true
            UpdateChestPairButton()
            GameEvents.SendCustomGameEventToServer_custom("chest_pair_open", { which: "poor" })
        })
    }
    if (richBtn)
    {
        richBtn.SetHasClass("chest_btn_hidden", PAIR_ANIM_RUNNING || !rich_present)
        richBtn.SetHasClass("is_chest_has_opened", !rich_active)
        if (richLbl) { richLbl.text = $.Localize(PAIR_INFO.is_sub != 1 ? "#chest_pair_rich_locked" : "#open_chest") }
        richBtn.SetPanelEvent("onactivate", function()
        {
            if (PAIR_ANIM_RUNNING) { return }
            if (!(PAIR_INFO.rich && PAIR_INFO.rich.opened != 1 && PAIR_INFO.is_sub == 1)) { return }
            PAIR_ANIM_RUNNING = true
            UpdateChestPairButton()
            GameEvents.SendCustomGameEventToServer_custom("chest_pair_open", { which: "rich" })
        })
    }
}

function OpenChestPairLine(which, drop_id, is_dup, shards)
{
    let slot_info = which == "poor" ? PAIR_INFO.poor : PAIR_INFO.rich
    if (!slot_info)
    {
        PAIR_ANIM_RUNNING = false
        return
    }
    let roll_panel = which == "poor" ? $("#RollItemsListMain") : $.GetContextPanel().FindChildTraverse("RollItemsListMain2")
    if (!roll_panel)
    {
        PAIR_ANIM_RUNNING = false
        return
    }

    let drop_pos_in_list = GetItemPositionInDropList(drop_id, slot_info.chest_items)
    let drop_info = drop_pos_in_list != null ? slot_info.chest_items[drop_pos_in_list] : null
    if (!drop_info)
    {
        PAIR_ANIM_RUNNING = false
        return
    }

    let slot_drop = roll_panel.FindChildTraverse("dropped_item")
    if (slot_drop)
    {
        let item_icon = slot_drop.FindChildTraverse("item_icon")
        if (item_icon) { item_icon.style.backgroundImage = 'url("' + drop_info.item_icon + '")' }
        let item_panel_border = slot_drop.FindChildTraverse("item_panel_border")
        if (item_panel_border) { item_panel_border.style.borderBrush = 'gradient( linear, 0% 100%, 0% 20%, from(' + rarity_color[drop_info.rare] + '), to( rgba(0,0,0,0.1) ) )' }
        let item_icon_terrorblade_color = slot_drop.FindChildTraverse("item_icon_terrorblade_color")
        if (item_icon_terrorblade_color && ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id])
        {
            item_icon_terrorblade_color.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id]
        }
    }

    Game.EmitSound("UI.Chest_open")
    loop_sound = Game.EmitSound("UI.Chest_open2")

    ChestPairRecomputeDropPos(roll_panel)

    let randomly_max_distance = Math.floor(Math.random() * (PAIR_DROP_POS[1] - PAIR_DROP_POS[0] + 1) + PAIR_DROP_POS[0])
    ChestPairAnimate(roll_panel, 0, randomly_max_distance, STARTING_SPEED, PAIR_SOUND_TICK_WIDTH, which, drop_info, is_dup, shards)
    $("#OpenChestButton").style.opacity = "0"
}

function ChestPairAnimate(roll_panel, current, drop_distance, speed, sound_tick, which, drop_info, is_dup, shards)
{
    if ($("#ChestHudMainPanel").BHasClass("ChestHudAnimClose"))
    {
        PAIR_ANIM_RUNNING = false
        return
    }
    if (current <= drop_distance)
    {
        $.Schedule(0.1, function()
        {
            ChestPairGiveDrop(which, drop_info, is_dup, shards)
        })
        return
    }
    current = current - (speed * Game.GetGameFrameTime())
    sound_tick = sound_tick - (speed * Game.GetGameFrameTime())
    if (sound_tick <= 0)
    {
        sound_tick = PAIR_SOUND_TICK_WIDTH
        Game.EmitSound("random_wheel_lever")
    }
    if (current <= 0.37 * drop_distance)
    {
        speed = speed - (speed * Game.GetGameFrameTime())
    }
    speed = Math.max(30, speed)
    roll_panel.style.position = current + "px 0px 0px"
    $.Schedule(Game.GetGameFrameTime(), function()
    {
        ChestPairAnimate(roll_panel, current, drop_distance, speed, sound_tick, which, drop_info, is_dup, shards)
    })
}

function ChestPairGiveDrop(which, drop_info, is_dup, shards)
{
    $("#OpenChestButton").style.opacity = "1"
    $("#DropItemPanel").SetHasClass("DropItemPanelVisible", true)
    $("#ItemDropRerollButton").visible = false

    let old_color = $("#ItemDropIcon").FindChildTraverse("item_icon_terrorblade_color")
    if (old_color) { old_color.DeleteAsync(0) }

    if (is_dup == 1)
    {
        $("#ItemDropIcon").style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_5.png")'
        $("#ItemDropIcon").style.backgroundSize = "100%"
        $("#ItemDropName").text = $.Localize("#chest_already_have") + " +" + shards + $.Localize("#gift_name_shards")
        $("#DropEffect").style.washColor = rarity_color["rare"]
        $("#DropEffect_top").style.washColor = rarity_color["rare"]
        $("#DropEffect_bottom").style.washColor = rarity_color["rare"]
    }
    else
    {
        $("#ItemDropIcon").style.backgroundImage = 'url("' + drop_info.item_icon + '")'
        $("#ItemDropIcon").style.backgroundSize = "100%"
        $("#ItemDropName").text = drop_info.item_name
        if (ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id])
        {
            let color_panel = $.CreatePanel("Panel", $("#ItemDropIcon"), "item_icon_terrorblade_color")
            color_panel.AddClass("item_icon_terrorblade_color")
            color_panel.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id]
        }
        $("#DropEffect").style.washColor = rarity_color[drop_info.rare]
        $("#DropEffect_top").style.washColor = rarity_color[drop_info.rare]
        $("#DropEffect_bottom").style.washColor = rarity_color[drop_info.rare]
    }

    let drop_effect = $.CreatePanel("DOTAParticleScenePanel", $("#ChestHudMainPanel"), "", {particleName:"particles/ui/ui_generic_treasure_impact.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"0 0 300", lookAt:"0 0 0", fov:"60"})
    drop_effect.AddClass("item_drop_effect")
    drop_effect.hittest = false
    drop_effect.DeleteAsync(3)

    Game.EmitSound("ui.treasure_01")
    if (loop_sound != undefined)
    {
        Game.StopSound(loop_sound)
        loop_sound = undefined
    }

    if (which == "poor" || which == "rich")
    {
        if (PAIR_INFO && PAIR_INFO[which])
        {
            PAIR_INFO[which].opened = 1
        }
        let opened_line = $.GetContextPanel().FindChildTraverse(which == "poor" ? "RollLine" : "RollLine2")
        if (opened_line)
        {
            opened_line.AddClass("RollLineGray")
        }
    }

    $("#ItemDropClaimButton").SetPanelEvent('onactivate', function()
    {
        $("#DropItemPanel").SetHasClass("DropItemPanelVisible", false)
        PAIR_ANIM_RUNNING = false
        if (which == "single")
        {
            CloseChest()
        }
        else
        {
            UpdateChestPairButton()
        }
        UpdateShards()
        UpdateSelectionSets()
    })
}