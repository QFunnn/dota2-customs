--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


function $C(id)
{
    return $.GetContextPanel().FindChildTraverse(id)
}

function InitChestWindowLayout()
{
    let holder = $.GetContextPanel().FindChildTraverse("chest_window_holder")
    if (!holder) { return }
    holder.BLoadLayout("file://{resources}/layout/custom_game/info_reports/chest_window.xml", false, false)
    let chest_window = $C("ChestHudMainPanel")
    if (chest_window) { chest_window.hittest = false }
    let close_icon = $C("CloseChestHudIcon")
    if (close_icon)
    {
        close_icon.SetPanelEvent("onactivate", function() { CloseChest() })
    }
}

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
    $C("ItemsInChestName").text = $.Localize("#chest_items_normal_2")
    $C("ItemDropRerollButton").visible = false
    $C("ChestHudMainPanel").SetHasClass("NoRareItems", true)
    ClearOldChest()
    CHEST_ID_CURRENT = data.chest_id
    $C("ChestName").text = $.Localize("#"+data.chest_name)
    ChestInitItemsInRoll(data.chest_items)
    ChestInitItemsInChest(data.chest_items)
    ButtonSet(data.chest_id, data.chest_cost, data.chest_items, data.is_no_buy, data.is_only_one_open, data.chest_item_id)
    $C("ChestHudMainPanel").style.opacity = "1"
    $C("ChestHudMainPanel").hittest = true
    $C("ChestCostIcon").visible = true

    $C("InfoOpenReroll").SetPanelEvent('onmouseover', function() 
    {
        $.DispatchEvent('DOTAShowTextTooltip', $C("InfoOpenReroll"), $.Localize("#reroll_chest_info_description")) 
    });

    $C("InfoOpenReroll").SetPanelEvent('onmouseout', function() 
    {
        $.DispatchEvent('DOTAHideTextTooltip', $C("InfoOpenReroll")); 
    });

    if (data.is_reroll)
    {
        $C("InfoOpenReroll").visible = true
    }
    else
    {
        $C("InfoOpenReroll").visible = false
    }

    if (data.is_no_buy && !HasItemInventory(data.chest_item_id))
    {
        $C("ChestCostIcon").visible = false
        $C("ChestCostLabel").text = $.Localize("#how_to_get_chest")
        $C("OpenChestButton").SetPanelEvent('onmouseover', function() 
        {
            $.DispatchEvent('DOTAShowTextTooltip', $C("OpenChestButton"), $.Localize(data.is_no_buy)) 
        });
        $C("OpenChestButton").SetPanelEvent('onmouseout', function() 
        {
            $.DispatchEvent('DOTAHideTextTooltip', $C("OpenChestButton")); 
        });
    }
    else if (data.is_only_one_open && IsChestOpened(data.chest_id))
    {
        $C("ChestCostIcon").visible = false
        $C("OpenChestButton").ClearPanelEvent( "onmouseover" )
        $C("ChestCostLabel").text = $.Localize("#chest_is_opened")
    }
    else if (HasItemInventory(data.chest_item_id))
    {
        $C("ChestCostIcon").visible = false
        $C("ChestCostLabel").text = $.Localize("#open_chest")
    }
    else
    {
        $C("OpenChestButton").ClearPanelEvent( "onmouseover" )
        $C("ChestCostLabel").text = data.chest_cost
    }

    $C("ChestHudMainPanel").SetPanelEvent("onactivate", function() {})
    $C("ChestHudMainPanel").SetHasClass("ChestHudAnimClose", false)
    $C("ChestHudMainPanel").SetHasClass("ChestHudAnimOpen", true)

    $C("OpenChestButton").style.opacity = "1"
    
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
        $C("OpenChestButton").SetHasClass("no_money", false)
        $C("OpenChestButton").SetHasClass("is_chest_no_buy", true)
        $C("OpenChestButton").SetPanelEvent('onactivate', function() {})
        return
    }
    $C("OpenChestButton").SetHasClass("is_chest_no_buy", false)
    if (is_only_one_open && IsChestOpened(chest_id))
    {
        $C("OpenChestButton").SetHasClass("ChestLocked", true)
        $C("OpenChestButton").SetHasClass("no_money", false)
        $C("OpenChestButton").SetPanelEvent('onactivate', function() {})
        return
    }
    $C("OpenChestButton").SetHasClass("ChestLocked", false)
    if (player_table_shop == null)
    {
        $C("OpenChestButton").SetPanelEvent('onactivate', function() {})
        $C("OpenChestButton").SetHasClass("no_money", true)
        $C("ChestCostLabel").SetHasClass("chest_cost_no_money", true)
        return
    }
    if (player_table_shop.points < cost)
    {
        $C("OpenChestButton").SetPanelEvent('onactivate', function() {})
        $C("OpenChestButton").SetHasClass("no_money", true)
        $C("ChestCostLabel").SetHasClass("chest_cost_no_money", true)
        return
    }
    $C("ChestCostLabel").SetHasClass("chest_cost_no_money", false)
    if (IsHeroHasAllItemsInChest(chest_items))
    {
        $C("OpenChestButton").SetPanelEvent('onactivate', function() {})
        $C("OpenChestButton").SetHasClass("has_all_items", true)
        return
    }
    $C("OpenChestButton").SetHasClass("no_money", false)
    $C("OpenChestButton").SetPanelEvent('onactivate', function()
    {
        GameEvents.SendCustomGameEventToServer_custom( "shop_dota1x6_open_chest_get_reward", { chest_id : chest_id } );
    })
}

function RefreshShopListsAfterChest()
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
    let selection_list = $.GetContextPanel().FindChildTraverse("HeroListItemsSelection")
    if (selection_list)
    {
        InitShopItemsForHero(selection_list)
    }
}

function CloseChest()
{
    if (loop_sound != undefined)
    {
        Game.StopSound(loop_sound)
        GameUI.CustomUIConfig().chest_loop_sound = undefined
        loop_sound = undefined     
    }

    $C("ChestHudMainPanel").hittest = false
    $C("ChestHudMainPanel").style.opacity = "0"
    $C("DropItemPanel").SetHasClass("DropItemPanelVisible", false)
    last_chest_info = null

    PAIR_MODE = false
    PAIR_INFO = null
    PAIR_ANIM_RUNNING = false
    PAIR_REQUESTED = false
    CHEST_SINGLE_MODE = false
    CHEST_SINGLE_INFO = null
    CHEST_SINGLE_WHICH = null
    $C("ChestHudMainPanel").RemoveClass("ChestHudPairMode")
    let roll2_close = $.GetContextPanel().FindChildTraverse("RollItemsListMain2")
    if (roll2_close) { roll2_close.RemoveAndDeleteChildren() }

    Game.EmitSound("UI.Shop_Category_Open")

    let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
    blur_panel.AddClass("shop_window_blur_hidden")
    blur_panel.RemoveClass("shop_window_blur")

    GameEvents.SendCustomGameEventToServer_custom( "shop_dota1x6_close_chest_checked_reward", {} );

    $C("ChestHudMainPanel").SetHasClass("ChestHudAnimClose", true)
    $C("ChestHudMainPanel").SetHasClass("ChestHudAnimOpen", false)

    $.Schedule( 0.35, function()
    {
        RefreshShopListsAfterChest()
    })

    CHEST_ID_CURRENT = null
}

function ClearOldChest()
{
    $C("RollItemsListMain").RemoveAndDeleteChildren()
    $C("ItemsInChestBlock").RemoveAndDeleteChildren()
    $C("ItemsInChestBlockRare").RemoveAndDeleteChildren()
    $C("RarePanelName").style.visibility = "collapse"
    $C("RarePanelBorder").style.visibility = "collapse"
    $C("ItemsInChestBlockRare").style.visibility = "collapse"
    $C("ItemsInChestName").text = $.Localize("#chest_items_normal_2")
    $C("RollItemsListMain").style.position = "0px 0px 0px"

    let poor_line = $C("RollLineBack")
    if (poor_line) { poor_line.RemoveClass("RollLineGray") }
    let rich_line = $C("RollLineBack2")
    if (rich_line) { rich_line.RemoveClass("RollLineGray"); rich_line.RemoveClass("RollLineLocked") }
    let lock_label = $C("RollLineLockLabel")
    if (lock_label) { lock_label.RemoveClass("RollLineLocked") }
    let poor_icon = $C("RollLineChestIconPoor")
    if (poor_icon) { poor_icon.RemoveClass("RollLineGray") }
    let rich_icon = $C("RollLineChestIconRich")
    if (rich_icon) { rich_icon.RemoveClass("RollLineGray") }

    let open_button = $C("OpenChestButton")
    if (open_button)
    {
        open_button.ClearPanelEvent("onmouseover")
        open_button.ClearPanelEvent("onmouseout")
        open_button.RemoveClass("is_chest_no_buy")
        open_button.RemoveClass("no_money")
        open_button.RemoveClass("has_all_items")
        open_button.RemoveClass("ChestLocked")
    }
    let cost_label = $C("ChestCostLabel")
    if (cost_label) { cost_label.RemoveClass("chest_cost_no_money") }
}

function ChestInitItemsInRoll(items)
{
    $C("RollItemsListMain").RemoveAndDeleteChildren()
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
            CreateItemInfo($C("RollItemsListMain"), randomElement, 0, true, DROP_SLOT == i, i)
        }
    }
    $C("RollItemsListMain").style.position = "0px 0px 0px"
}  

function ChestInitItemsInChest(items, no_rare_split)
{
    let total_chance = 0
    let normal_count = 0
    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        let it = items[i]
        if (!it) { continue }
        if (it.chance != null) { total_chance += Number(it.chance) }
        else { normal_count += 1 }
    }
    let normal_chance = normal_count > 0 ? Math.max(1, Math.round((100 - total_chance) / normal_count)) : 0

    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        let item_info = items[i]
        if (item_info)
        {
            item_info.display_chance = (item_info.chance != null) ? Number(item_info.chance) : normal_chance
            item_info.no_rare_panel = no_rare_split ? 1 : null
            CreateItemInfo($C("ItemsInChestBlock"), item_info, i)
        }
    }
}

function CreateItemInfo(main_panel, item_info, delay_count, roll, drop_slot, c)
{
    let rare = item_info.rare
    let name = GetChestItemDisplayName(item_info)
    let icon = item_info.item_icon
    let chance = item_info.chance
    let is_rare = 0

    if (chance != null && roll == null && item_info.no_rare_panel == null)
    {
        $C("RarePanelName").style.visibility = "visible"
        $C("RarePanelBorder").style.visibility = "visible"
        $C("ItemsInChestBlockRare").style.visibility = "visible"
        $C("ItemsInChestName").text = $.Localize("#chest_items_normal")
        main_panel = $C("ItemsInChestBlockRare")
        is_rare = 1
        $C("ChestHudMainPanel").SetHasClass("NoRareItems", false)
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

        let real_icon = item_icon

        if (item_info.drop_type == "category_tip")
        {
            let tip_icon = $.CreatePanel("Panel", item_panel, "item_icon_tip")
            tip_icon.AddClass("item_icon_tip")
            real_icon = tip_icon
        }

        real_icon.style.backgroundImage = 'url("' + icon + '")';
        real_icon.style.backgroundRepeat = 'no-repeat'
        real_icon.style.backgroundSize = "100%"


        if (ITEMS_TERRORBLADE_COLOR_GEM[item_info.item_id])
        {
            let item_icon_terrorblade_color = $.CreatePanel("Panel", item_icon, "item_icon_terrorblade_color")
            item_icon_terrorblade_color.AddClass("item_icon_terrorblade_color")
            item_icon_terrorblade_color.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[item_info.item_id]
        }

        if (item_info.is_sound == 1)
        {
            let item_sound_name = $.CreatePanel("Label", item_panel, "item_sound_name")
            item_sound_name.AddClass("item_sound_name")
            item_sound_name.text = name
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
var CHEST_SOUND_GUARD_RUNNING = false

function StartChestLoopSoundGuard()
{
    if (CHEST_SOUND_GUARD_RUNNING) { return }
    CHEST_SOUND_GUARD_RUNNING = true
    $.Schedule(1, ChestLoopSoundGuardTick)
}

function ChestLoopSoundGuardTick()
{
    let cfg = GameUI.CustomUIConfig()
    if (cfg.chest_loop_sound === undefined)
    {
        CHEST_SOUND_GUARD_RUNNING = false
        return
    }
    if (Game.GetState() >= DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME)
    {
        Game.StopSound(cfg.chest_loop_sound)
        cfg.chest_loop_sound = undefined
        CHEST_SOUND_GUARD_RUNNING = false
        return
    }
    $.Schedule(1, ChestLoopSoundGuardTick)
}

if (GameUI.CustomUIConfig().chest_loop_sound !== undefined)
{
    StartChestLoopSoundGuard()
}

function OpenChest(items, retry_drop, shard_counter, is_reroll)
{
    $C("ItemDropRerollButton").visible = false
    Game.EmitSound("UI.Chest_open")
    loop_sound = Game.EmitSound("UI.Chest_open2")
    GameUI.CustomUIConfig().chest_loop_sound = loop_sound
    let current = 0
    // НУЖНО ПЕРЕДАТЬ ДРОП АЙДИ ШМОТКИ
    if (CURRENT_DROP_ID != null)
    {
        let drop_info = items[CURRENT_DROP_ID]
        let slot_drop = $C("RollItemsListMain").FindChildTraverse("dropped_item")
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
            SetDropSlotSoundName(slot_drop, drop_info)
        }
    }

    let randomly_max_distance = Math.floor(Math.random() * (DROP_POS[1] - DROP_POS[0] + 1) + DROP_POS[0]);
    ChestAnimate(current, randomly_max_distance, STARTING_SPEED, SOUND_TICK_WIDTH, items[CURRENT_DROP_ID], items, retry_drop, shard_counter, is_reroll)
    $C("OpenChestButton").style.opacity = "0"
}

function ChestAnimate(current, drop_distance, speed, sound_tick, item_drop_info, items, retry_drop, shard_counter, is_reroll)
{
    if ($C("ChestHudMainPanel").BHasClass("ChestHudAnimClose"))
    {
        CURRENT_DROP_ID = null
        CloseDropPanel()
        $.Schedule( 0.35, function()
        {
            RefreshShopListsAfterChest()
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

    $C("RollItemsListMain").style.position = current + "px 0px 0px"
    $.Schedule(Game.GetGameFrameTime(), function() 
    {
		ChestAnimate(current, drop_distance, speed, sound_tick, item_drop_info, items, retry_drop, shard_counter, is_reroll)
	})
}

function SetDropCategory(drop_type, shards)
{
    let category = $C("ItemDropCategory")
    if (!category) { return }
    category.SetHasClass("panel_hidden", drop_type == null)
    if (drop_type == null) { return }
    let text = $C("ItemDropCategoryText")
    let icon = $C("ItemDropCategoryIcon")
    if (drop_type == "category_dup_shards")
    {
        text.text = ((shards > 0) ? ($.Localize("#chest_already_have2") + shards) : "") + $.Localize("#" + drop_type)
    }
    else
    {
        text.text = $.Localize("#" + drop_type)
    }

    icon.SetHasClass("panel_hidden", !drop_type.startsWith("npc_") && !drop_type.startsWith("item_"))
    icon.SetHasClass("ItemDropCategoryIconItem", drop_type.startsWith("item_"))

    if (drop_type.startsWith("item_"))
    {
        let name = drop_type.replace(/^item_/, "");

        icon.style.backgroundImage = 'url( "file://{images}/custom_game/shop/effects/section/' + name + '.png" );'
        text.text = $.Localize("#category_effect")
    }

    if (drop_type.startsWith("npc_"))
    {
        let name = Game.GetHeroImage(Game.GetLocalPlayerID(), drop_type)
        icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + name + '.png" );'
    }
    icon.style.backgroundSize = 'contain';
    icon.style.backgroundRepeat = 'no-repeat'
}

function SetDropSlotIcon(slot_drop, drop_info)
{
    if (!slot_drop || !drop_info) { return }
    let item_icon = slot_drop.FindChildTraverse("item_icon")
    let old_tip_icon = slot_drop.FindChildTraverse("item_icon_tip")
    if (old_tip_icon) { old_tip_icon.DeleteAsync(0) }
    if (drop_info.drop_type == "category_tip")
    {
        if (item_icon) { item_icon.style.backgroundImage = 'url("")' }
        let tip_icon = $.CreatePanel("Panel", slot_drop, "item_icon_tip")
        tip_icon.AddClass("item_icon_tip")
        tip_icon.style.backgroundImage = 'url("' + drop_info.item_icon + '")'
        tip_icon.style.backgroundRepeat = 'no-repeat'
        tip_icon.style.backgroundSize = "100%"
    }
    else if (item_icon)
    {
        item_icon.style.backgroundImage = 'url("' + drop_info.item_icon + '")'
        item_icon.style.backgroundRepeat = 'no-repeat'
        item_icon.style.backgroundSize = "100%"
    }
}

function SetDropSlotSoundName(slot_drop, drop_info)
{
    if (!slot_drop) { return }
    let old_sound_name = slot_drop.FindChildTraverse("item_sound_name")
    if (old_sound_name) { old_sound_name.DeleteAsync(0) }
    if (drop_info && drop_info.is_sound == 1)
    {
        let item_sound_name = $.CreatePanel("Label", slot_drop, "item_sound_name")
        item_sound_name.AddClass("item_sound_name")
        item_sound_name.text = $.Localize("#" + drop_info.item_name)
    }
}

function GiveItemDrop(item_drop_info, items, retry_drop, shard_counter, is_reroll)
{
    $C("OpenChestButton").style.opacity = "1"
    $C("DropItemPanel").SetHasClass("DropItemPanelVisible", true)

    let item_icon_terrorblade_color = $C("ItemDropIcon").FindChildTraverse("item_icon_terrorblade_color")
    if (item_icon_terrorblade_color)
    {
        item_icon_terrorblade_color.DeleteAsync(0)
    }

    if (retry_drop == 1)
    {
        $C("ItemDropIcon").style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_5.png")';
        $C("ItemDropIcon").style.backgroundSize = "100%"
        $C("ItemDropName").text = shard_counter + $.Localize("#gift_name_shards")
        $C("ItemDropName").SetHasClass("ItemDropNamePhrase", false)
        SetDropCategory(null)
    }
    else
    {   
        let is_square = item_drop_info.drop_type == "category_tip"
        $C("ItemDropIcon").SetHasClass("ItemDropIconSquare", is_square)
        $C("ItemDropIcon").style.backgroundImage = 'url("' + item_drop_info.item_icon + '")';
        $C("ItemDropIcon").style.backgroundSize = is_square ? "85% 85%" : "100%"
        $C("ItemDropIcon").style.backgroundRepeat = "no-repeat"
        $C("ItemDropIcon").style["background-position"] = "50%"

        $C("ItemDropName").text = GetChestItemDisplayName(item_drop_info)
        $C("ItemDropName").SetHasClass("ItemDropNamePhrase", item_drop_info.is_sound == 1)
        if (ITEMS_TERRORBLADE_COLOR_GEM[item_drop_info.item_id])
        {
            let item_icon_terrorblade_color = $.CreatePanel("Panel", $C("ItemDropIcon"), "item_icon_terrorblade_color")
            item_icon_terrorblade_color.AddClass("item_icon_terrorblade_color")
            item_icon_terrorblade_color.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[item_drop_info.item_id]
        }
        SetDropCategory(item_drop_info.drop_type != null ? item_drop_info.drop_type : null)
    }

    $C("DropEffect").style.washColor = rarity_color[item_drop_info.rare]
    $C("DropEffect_top").style.washColor = rarity_color[item_drop_info.rare]
    $C("DropEffect_bottom").style.washColor = rarity_color[item_drop_info.rare]

    let item_drop_effect = $.CreatePanel("DOTAParticleScenePanel", $C("ChestHudMainPanel"), "", {particleName:"particles/ui/ui_generic_treasure_impact.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"0 0 300", lookAt:"0 0 0", fov:"60"})
    item_drop_effect.AddClass("item_drop_effect")
    item_drop_effect.hittest = false
    item_drop_effect.DeleteAsync(3)

    Game.EmitSound("ui.treasure_01")

    if (loop_sound != undefined)
    {
        Game.StopSound(loop_sound)
        GameUI.CustomUIConfig().chest_loop_sound = undefined  
        loop_sound = undefined   
    }
   
    $C("ItemDropClaimButtonLabel").text = $.Localize("#" + (retry_drop ? "claim_reward_shards" : "claim_reward"))
    $C("ItemDropClaimButton").SetPanelEvent('onactivate', function()
    {
        Game.EmitSound("UI.Weekly_Click")
        Game.EmitSound("UI.Click")
        if (last_chest_info != null)
        {
            InitChest(last_chest_info, true)
        }
        CloseDropPanel()
        $.Schedule( 0.35, function()
        {
            RefreshShopListsAfterChest()
        })
    })

    if (is_reroll == 1)
    {
        $C("ItemDropRerollButton").SetPanelEvent('onactivate', function()
        {
            InitChest(last_chest_info, true)
            $.Schedule( 0.25, function()
            {
                GameEvents.SendCustomGameEventToServer_custom( "shop_dota1x6_open_chest_get_reward", { chest_id : CHEST_ID_CURRENT, rerolled : true } );
            })
            CloseDropPanel(true)
        })
        $C("ItemDropRerollButton").visible = true
    }
    
    CURRENT_DROP_ID = null
}

function CloseDropPanel(is_reroll)
{
    if (!is_reroll)
    {
        GameEvents.SendCustomGameEventToServer_custom( "shop_dota1x6_close_chest_checked_reward", {} );
    }
    $C("RollItemsListMain").style.position = "0px 0px 0px"
    $C("DropItemPanel").SetHasClass("DropItemPanelVisible", false)
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

function GetChestItemDisplayName(info)
{
    if (!info) { return "" }
    if (info.is_sound == 1) { return $.Localize("#" + info.item_name) }
    return info.item_name
}

function GetChestData()
{
    return CustomNetTables.GetTableValue("chest_data", Players.GetLocalPlayer()) || {}
}

function GetPairChestInfo(kind, chest_id)
{
    if (chest_id == null) { return null }
    let is_rich = kind == "rich" || kind == 2
    let pool = CustomNetTables.GetTableValue("shop_items", is_rich ? "rich_chests" : "poor_chests")
    if (!pool) { return null }
    return pool[chest_id] != null ? pool[chest_id] : null
}
GameUI.CustomUIConfig().GetPairChestInfo = GetPairChestInfo

function IsChestOwned(kind, index)
{
    let chest_data = GetChestData()
    if (kind == "poor") { return chest_data.poor_id != null && Number(chest_data.poor_id) == Number(index) }
    if (kind == "rich") { return chest_data.rich_id != null && Number(chest_data.rich_id) == Number(index) }
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

    let BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButton, "")
    BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel")
    BlockItemBuyButtonLabel.text = $.Localize(is_openable ? "#open_chest" : "#chest_pool_locked")

    if (!is_openable)
    {
        let tooltip_text = $.Localize("#chest_pair_info_text")
        BlockItem.SetPanelEvent('onmouseover', function()
        {
            $.DispatchEvent('DOTAShowTextTooltip', BlockItem, tooltip_text)
        });
        BlockItem.SetPanelEvent('onmouseout', function()
        {
            $.DispatchEvent('DOTAHideTextTooltip', BlockItem);
        });
    }

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
    let which = IsChestOwned(kind, index) ? kind : null
    let can_open = IsChestAvailableToOpen(kind, index)
    InitPoolChestSingle(chest, which, can_open)
}

function InitPoolChestSingle(chest, which, can_open)
{
    if (typeof CloseBuyWindowIfOpen == "function") { CloseBuyWindowIfOpen() }
    PAIR_MODE = false
    CHEST_SINGLE_MODE = true
    CHEST_SINGLE_INFO = chest
    CHEST_SINGLE_WHICH = which
    PAIR_ANIM_RUNNING = false

    ClearOldChest()
    let roll2 = $.GetContextPanel().FindChildTraverse("RollItemsListMain2")
    if (roll2) { roll2.RemoveAndDeleteChildren() }

    $C("ChestHudMainPanel").RemoveClass("ChestHudPairMode")
    $C("ItemDropRerollButton").visible = false
    $C("InfoOpenReroll").visible = false
    $C("ChestHudMainPanel").SetHasClass("NoRareItems", true)
    $C("ChestName").text = $.Localize("#" + chest.chest_name)
    $C("ChestCostIcon").visible = false

    ChestPairInitLine($C("RollItemsListMain"), chest.chest_items)
    ChestInitItemsInChest(chest.chest_items, true)

    if (can_open)
    {
        $C("ChestCostLabel").text = $.Localize("#open_chest")
        $C("OpenChestButton").SetHasClass("ChestLocked", false)
        $C("OpenChestButton").SetHasClass("no_money", false)
        $C("OpenChestButton").SetPanelEvent("onactivate", function()
        {
            if (PAIR_ANIM_RUNNING) { return }
            PAIR_ANIM_RUNNING = true
            GameEvents.SendCustomGameEventToServer_custom("chest_pair_open", { which: which })
        })
    }
    else
    {
        let tooltip_text = $.Localize("#chest_pair_info_text")
        $C("ChestCostLabel").text = $.Localize("#how_to_get_chest")
        $C("OpenChestButton").SetHasClass("ChestLocked", false)
        $C("OpenChestButton").SetHasClass("no_money", false)
        $C("OpenChestButton").AddClass("is_chest_no_buy")
        $C("OpenChestButton").SetPanelEvent("onactivate", function() {})
        $C("OpenChestButton").SetPanelEvent("onmouseover", function()
        {
            $.DispatchEvent('DOTAShowTextTooltip', $C("OpenChestButton"), tooltip_text)
        })
        $C("OpenChestButton").SetPanelEvent("onmouseout", function()
        {
            $.DispatchEvent('DOTAHideTextTooltip', $C("OpenChestButton"));
        })
    }

    $C("ChestHudMainPanel").style.opacity = "1"
    $C("ChestHudMainPanel").hittest = true
    $C("ChestHudMainPanel").SetHasClass("ChestHudAnimClose", false)
    $C("ChestHudMainPanel").SetHasClass("ChestHudAnimOpen", true)
    $C("OpenChestButton").style.opacity = "1"

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
    let roll_panel = $C("RollItemsListMain")
    let drop_pos = GetItemPositionInDropList(drop_id, CHEST_SINGLE_INFO.chest_items)
    let drop_info = drop_pos != null ? CHEST_SINGLE_INFO.chest_items[drop_pos] : null
    if (!drop_info) { PAIR_ANIM_RUNNING = false; return }

    let slot_drop = roll_panel.FindChildTraverse("dropped_item")
    if (slot_drop)
    {
        SetDropSlotIcon(slot_drop, drop_info)
        let item_panel_border = slot_drop.FindChildTraverse("item_panel_border")
        if (item_panel_border) { item_panel_border.style.borderBrush = 'gradient( linear, 0% 100%, 0% 20%, from(' + rarity_color[drop_info.rare] + '), to( rgba(0,0,0,0.1) ) )' }
        let item_icon_terrorblade_color = slot_drop.FindChildTraverse("item_icon_terrorblade_color")
        if (item_icon_terrorblade_color && ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id])
        {
            item_icon_terrorblade_color.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id]
        }
        SetDropSlotSoundName(slot_drop, drop_info)
    }

    Game.EmitSound("UI.Chest_open")
    loop_sound = Game.EmitSound("UI.Chest_open2")
    GameUI.CustomUIConfig().chest_loop_sound = loop_sound

    ChestPairRecomputeDropPos(roll_panel)

    let dist = Math.floor(Math.random() * (PAIR_DROP_POS[1] - PAIR_DROP_POS[0] + 1) + PAIR_DROP_POS[0])
    ChestPairAnimate(roll_panel, 0, dist, STARTING_SPEED, PAIR_SOUND_TICK_WIDTH, "single", drop_info, is_dup, shards)
    $C("OpenChestButton").style.opacity = "0"
}

var PAIR_MODE = false
var PAIR_INFO = null
var PAIR_ANIM_RUNNING = false
var PAIR_DROP_POS = [0, 0]
var PAIR_SOUND_TICK_WIDTH = 128

var PAIR_REQUESTED = false

GameUI.CustomUIConfig().OpenChestPairWindow = OpenChestPairWindow
function OpenChestPairWindow()
{
    GameUI.CustomUIConfig().chest_popup_driving = false
    PAIR_REQUESTED = true
    GameEvents.SendCustomGameEventToServer_custom("chest_pair_get_info", {})
}

GameEvents.Subscribe_custom('chest_pair_info', chest_pair_info)
function chest_pair_info(data)
{
    if (GameUI.CustomUIConfig().chest_popup_driving) { return }
    if (!PAIR_REQUESTED) { return }
    if (!data || !data.chest_info) { return }
    InitChestPair(data.chest_info)
}

GameEvents.Subscribe_custom('chest_pair_roll_result', chest_pair_roll_result)
function chest_pair_roll_result(data)
{
    if (data != null && data.drop_id != null && Game.GetState() < DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME)
    {
        if (data.is_dup == 1)
        {
            let alert_cfg = GameUI.CustomUIConfig()
            if (!alert_cfg.pending_new_items_alert) { alert_cfg.pending_new_items_alert = [] }
            alert_cfg.pending_new_items_alert.push({ is_dup: 1, which: data.which, shards: data.shards != null ? data.shards : 0 })
            if (typeof ScheduleNewItemsAlert == "function") { ScheduleNewItemsAlert() }
        }
        StartChestLoopSoundGuard()
    }
    if (GameUI.CustomUIConfig().chest_popup_driving) { return }
    if (!PAIR_REQUESTED && !CHEST_SINGLE_MODE) { return }
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
    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        if (items[i] != null)
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
    if (typeof CloseBuyWindowIfOpen == "function") { CloseBuyWindowIfOpen() }
    PAIR_MODE = true
    PAIR_INFO = info
    PAIR_ANIM_RUNNING = false

    ClearOldChest()
    let roll2 = $.GetContextPanel().FindChildTraverse("RollItemsListMain2")
    if (roll2) { roll2.RemoveAndDeleteChildren() }

    $C("ItemDropRerollButton").visible = false
    $C("ChestHudMainPanel").AddClass("ChestHudPairMode")
    $C("ChestHudMainPanel").SetHasClass("NoRareItems", true)
    $C("ChestName").text = $.Localize("#chest_pair_title")
    $C("ChestCostIcon").visible = false
    $C("ChestCostLabel").text = $.Localize("#open_chest")

    let poor_unit = $C("ChestPairLineUnitPoor")
    if (poor_unit) { poor_unit.visible = info.poor != null }
    let rich_unit = $C("ChestPairLineUnitRich")
    if (rich_unit) { rich_unit.visible = info.rich != null }

    if (info.poor)
    {
        ChestPairInitLine($C("RollItemsListMain"), info.poor.chest_items)
    }
    if (info.rich && roll2)
    {
        ChestPairInitLine(roll2, info.rich.chest_items)
    }

    let poor_line = $.GetContextPanel().FindChildTraverse("RollLineBack")
    if (poor_line)
    {
        poor_line.SetHasClass("RollLineGray", info.poor != null && info.poor.opened == 1)
    }

    let rich_line = $.GetContextPanel().FindChildTraverse("RollLineBack2")
    let rich_text = $.GetContextPanel().FindChildTraverse("RollLineLockLabel")
    if (rich_line)
    {
        rich_line.SetHasClass("RollLineLocked", info.is_sub != 1)
        if (rich_text) { rich_text.SetHasClass("RollLineLocked", info.is_sub != 1) }
        rich_line.SetHasClass("RollLineGray", info.is_sub != 1 || (info.rich != null && info.rich.opened == 1))
    }

    let poor_title_icon = $.GetContextPanel().FindChildTraverse("RollLineChestIconPoor")
    if (poor_title_icon && info.poor && info.poor.chest_image)
    {
        poor_title_icon.style.backgroundImage = 'url("s2r://panorama/images/' + info.poor.chest_image + '.png")'
        poor_title_icon.style.backgroundSize = "100%"

        poor_title_icon.SetPanelEvent("onmouseover", () => 
        {
            Game.CustomTooltipOpened = true
            $.DispatchEvent(
                "UIShowCustomLayoutParametersTooltip",
                poor_title_icon,
                "chest_tooltip",
                "file://{resources}/layout/custom_game/info_reports/chest_tooltip/chest_tooltip.xml",
                "type=poor&id=" + info.poor.id,
            );
        });
        poor_title_icon.SetPanelEvent("onmouseout", () => 
        {
            Game.CustomTooltipOpened = false
            $.DispatchEvent("UIHideCustomLayoutTooltip", poor_title_icon, "chest_tooltip");
        });

    }
    let rich_title_icon = $.GetContextPanel().FindChildTraverse("RollLineChestIconRich")
    if (rich_title_icon && info.rich && info.rich.chest_image)
    {
        rich_title_icon.style.backgroundImage = 'url("s2r://panorama/images/' + info.rich.chest_image + '.png")'
        rich_title_icon.style.backgroundSize = "100%"

        rich_title_icon.SetPanelEvent("onmouseover", () => 
        {
            Game.CustomTooltipOpened = true
            $.DispatchEvent(
                "UIShowCustomLayoutParametersTooltip",
                rich_title_icon,
                "chest_tooltip",
                "file://{resources}/layout/custom_game/info_reports/chest_tooltip/chest_tooltip.xml",
                "type=rich&id=" + info.rich.id,
            );
        });
        rich_title_icon.SetPanelEvent("onmouseout", () => 
        {
            Game.CustomTooltipOpened = false
            $.DispatchEvent("UIHideCustomLayoutTooltip", rich_title_icon, "chest_tooltip");
        });
    }

    UpdateChestPairButton()

    $C("ChestHudMainPanel").style.opacity = "1"
    $C("ChestHudMainPanel").hittest = true
    $C("ChestHudMainPanel").SetHasClass("ChestHudAnimClose", false)
    $C("ChestHudMainPanel").SetHasClass("ChestHudAnimOpen", true)
    $C("OpenChestButton").style.opacity = "1"

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

    let poor_opened = PAIR_INFO.poor != null && PAIR_INFO.poor.opened == 1
    let rich_exists = PAIR_INFO.rich != null
    let rich_opened = rich_exists && PAIR_INFO.rich.opened == 1
    let rich_active = rich_exists && !rich_opened && PAIR_INFO.is_sub == 1

    if (poorBtn)
    {
        let poor_locked = poor_opened || PAIR_ANIM_RUNNING
        poorBtn.RemoveClass("chest_btn_hidden")
        poorBtn.SetHasClass("ChestLocked", poor_locked)
        if (poorLbl) { poorLbl.SetHasClass("ChestLockedTextCommon", poor_locked) }
        poorBtn.SetHasClass("OpenChestButtonCommon", !poor_locked)
        if (poorLbl) { poorLbl.text = $.Localize(poor_opened ? "#chest_is_opened" : "#open_chest") }
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
        let rich_need_sub = rich_exists && !rich_opened && PAIR_INFO.is_sub != 1
        let rich_locked = (!rich_active && !rich_need_sub) || PAIR_ANIM_RUNNING
        richBtn.RemoveClass("chest_btn_hidden")
        richBtn.RemoveClass("is_chest_no_buy")
        richBtn.SetHasClass("ChestLocked", (rich_locked) || (rich_need_sub && !PAIR_ANIM_RUNNING))

        if (richLbl) { richLbl.SetHasClass("ChestLockedTextRare", rich_locked) }
        richBtn.SetHasClass("OpenChestButtonRare", rich_active && !PAIR_ANIM_RUNNING)
        if (richLbl) { richLbl.text = $.Localize(rich_opened ? "#chest_is_opened" : (rich_need_sub ? "#chest_closed" : "#open_chest")) }

        if (rich_need_sub)
        {
            richBtn.SetPanelEvent("onmouseover", function()
            {
                //$.DispatchEvent('DOTAShowTextTooltip', richBtn, $.Localize("#chest_pair_rich_locked"))
            })
            richBtn.SetPanelEvent("onmouseout", function()
            {
               // $.DispatchEvent('DOTAHideTextTooltip', richBtn);
            })
        }
        else
        {
            richBtn.ClearPanelEvent("onmouseover")
            richBtn.ClearPanelEvent("onmouseout")
        }

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
    let roll_panel = which == "poor" ? $C("RollItemsListMain") : $.GetContextPanel().FindChildTraverse("RollItemsListMain2")
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
        SetDropSlotIcon(slot_drop, drop_info)
        let item_panel_border = slot_drop.FindChildTraverse("item_panel_border")
        if (item_panel_border) { item_panel_border.style.borderBrush = 'gradient( linear, 0% 100%, 0% 20%, from(' + rarity_color[drop_info.rare] + '), to( rgba(0,0,0,0.1) ) )' }
        let item_icon_terrorblade_color = slot_drop.FindChildTraverse("item_icon_terrorblade_color")
        if (item_icon_terrorblade_color && ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id])
        {
            item_icon_terrorblade_color.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id]
        }
        SetDropSlotSoundName(slot_drop, drop_info)
    }

    Game.EmitSound("UI.Chest_open")
    loop_sound = Game.EmitSound("UI.Chest_open2")
    GameUI.CustomUIConfig().chest_loop_sound = loop_sound

    ChestPairRecomputeDropPos(roll_panel)

    let randomly_max_distance = Math.floor(Math.random() * (PAIR_DROP_POS[1] - PAIR_DROP_POS[0] + 1) + PAIR_DROP_POS[0])
    ChestPairAnimate(roll_panel, 0, randomly_max_distance, STARTING_SPEED, PAIR_SOUND_TICK_WIDTH, which, drop_info, is_dup, shards)
    $C("OpenChestButton").style.opacity = "0"
}

function ChestPairAnimate(roll_panel, current, drop_distance, speed, sound_tick, which, drop_info, is_dup, shards)
{
    if ($C("ChestHudMainPanel").BHasClass("ChestHudAnimClose"))
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
    $C("OpenChestButton").style.opacity = "1"
    $C("DropItemPanel").SetHasClass("DropItemPanelVisible", true)
    $C("ItemDropRerollButton").visible = false

    let old_color = $C("ItemDropIcon").FindChildTraverse("item_icon_terrorblade_color")
    if (old_color) { old_color.DeleteAsync(0) }

    let drop_type = drop_info != null && drop_info.drop_type != null ? drop_info.drop_type : null

    if (is_dup == 1)
    {
        $C("ItemDropIcon").style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_5.png")'
        $C("ItemDropIcon").style.backgroundSize = "100%"
        $C("ItemDropName").text = $.Localize("#chest_already_have")
        $C("ItemDropName").SetHasClass("ItemDropNamePhrase", false)
        $C("DropEffect").style.washColor = rarity_color["rare"]
        $C("DropEffect_top").style.washColor = rarity_color["rare"]
        $C("DropEffect_bottom").style.washColor = rarity_color["rare"]
        drop_type = "category_dup_shards"
    }
    else
    {
        let is_square = drop_info.drop_type == "category_tip"
        $C("ItemDropIcon").SetHasClass("ItemDropIconSquare", is_square)
        $C("ItemDropIcon").style.backgroundImage = 'url("' + drop_info.item_icon + '")';
        $C("ItemDropIcon").style.backgroundSize = is_square ? "85% 85%" : "100%"
        $C("ItemDropIcon").style.backgroundRepeat = "no-repeat"
        $C("ItemDropIcon").style["background-position"] = "50%"

        $C("ItemDropName").text = GetChestItemDisplayName(drop_info)
        $C("ItemDropName").SetHasClass("ItemDropNamePhrase", drop_info.is_sound == 1)
        if (ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id])
        {
            let color_panel = $.CreatePanel("Panel", $C("ItemDropIcon"), "item_icon_terrorblade_color")
            color_panel.AddClass("item_icon_terrorblade_color")
            color_panel.style.washColor = ITEMS_TERRORBLADE_COLOR_GEM[drop_info.item_id]
        }
        $C("DropEffect").style.washColor = rarity_color[drop_info.rare]
        $C("DropEffect_top").style.washColor = rarity_color[drop_info.rare]
        $C("DropEffect_bottom").style.washColor = rarity_color[drop_info.rare]
    }

    let drop_effect = $.CreatePanel("DOTAParticleScenePanel", $C("ChestHudMainPanel"), "", {particleName:"particles/ui/ui_generic_treasure_impact.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"0 0 300", lookAt:"0 0 0", fov:"70"})
    drop_effect.AddClass("item_drop_effect")
    drop_effect.hittest = false
    drop_effect.DeleteAsync(3)

    SetDropCategory(drop_type, shards)

    Game.EmitSound("ui.treasure_01")
    if (loop_sound != undefined)
    {
        Game.StopSound(loop_sound)
        GameUI.CustomUIConfig().chest_loop_sound = undefined
        loop_sound = undefined
    }

    if (which == "poor" || which == "rich")
    {
        if (PAIR_INFO && PAIR_INFO[which])
        {
            PAIR_INFO[which].opened = 1
        }
        let opened_line = $.GetContextPanel().FindChildTraverse(which == "poor" ? "RollLineBack" : "RollLineBack2")
        if (opened_line)
        {
            opened_line.AddClass("RollLineGray")
        }
        let opened_icon = $.GetContextPanel().FindChildTraverse(which == "poor" ? "RollLineChestIconPoor" : "RollLineChestIconRich")
        if (opened_icon)
        {
            opened_icon.AddClass("RollLineGray")
        }
        UpdateChestPairButton()
    }


    $C("ItemDropClaimButtonLabel").text = $.Localize("#" + (is_dup ? "claim_reward_shards" : "claim_reward"))
    $C("ItemDropClaimButton").SetPanelEvent('onactivate', function()
    {
        Game.EmitSound("UI.Weekly_Click")
        Game.EmitSound("UI.Click")
        $C("DropItemPanel").SetHasClass("DropItemPanelVisible", false)
        PAIR_ANIM_RUNNING = false
        if (which == "single")
        {
            CloseChest()
        }
        else
        {
            UpdateChestPairButton()
        }
        RefreshShopListsAfterChest()
    })
}
InitChestWindowLayout()