--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


$("#ChestHudMainPanel").visible = false


const chests_data = {
    'item_treasure_1': {
        'chest_items': {
            1: {rare: 'legendary', item_name: 'item_armor_pet3'},
            2: {rare: 'legendary', item_name: 'item_attackspeed_pet3'},
            3: {rare: 'legendary', item_name: 'item_spell_pet3'},
            4: {rare: 'legendary', item_name: 'item_hpmp_pet3'},
            5: {rare: 'legendary', item_name: 'item_stats_pet3'},
            6: {rare: 'legendary', item_name: 'item_dmg_pet3'},
            7: {rare: 'mythical', item_name: 'item_armor_pet2'},
            8: {rare: 'mythical', item_name: 'item_spell_pet2'},
            9: {rare: 'mythical', item_name: 'item_hpmp_pet2'},
            10: {rare: 'mythical', item_name: 'item_dmg_pet2'},
            11: {rare: 'rare', item_name: 'item_spell_pet'},
            12: {rare: 'rare', item_name: 'item_hpmp_pet'},
            13: {rare: 'uncommon', item_name: 'item_bless'},
            14: {rare: 'common', item_name: 'item_attack_speed_aura'},
            15: {rare: 'common', item_name: 'item_base_damage_aura'},
            16: {rare: 'common', item_name: 'item_expiriance_aura'},
            17: {rare: 'common', item_name: 'item_move_aura'},
            18: {rare: 'common', item_name: 'item_cd_aura'}
        }
    },
    'item_treasure_2': {
        'chest_items': {
            1: {rare: 'immortal', item_name: 'item_attackspeed_pet5'},
            2: {rare: 'immortal', item_name: 'item_dmg_pet5'},
            3: {rare: 'immortal', item_name: 'item_hpmp_pet5'},
            4: {rare: 'legendary', item_name: 'item_stats_pet4'},
            5: {rare: 'legendary', item_name: 'item_hpmp_pet4'},
            6: {rare: 'mythical', item_name: 'item_spell_pet3'},
            7: {rare: 'mythical', item_name: 'item_dmg_pet3'},
            8: {rare: 'rare', item_name: 'item_hpmp_pet2'},
            9: {rare: 'rare', item_name: 'item_armor_pet2'},
            10: {rare: 'uncommon', item_name: 'item_hpmp_pet'},
            11: {rare: 'uncommon', item_name: 'item_spell_pet'},
            12: {rare: 'uncommon', item_name: 'item_stats_pet'},
            13: {rare: 'common', item_name: 'item_move_aura'},
            14: {rare: 'common', item_name: 'item_attack_speed_aura'},
            15: {rare: 'common', item_name: 'item_hp_aura'},
            16: {rare: 'common', item_name: 'item_cd_aura'},
            17: {rare: 'common', item_name: 'item_base_damage_aura'},
            18: {rare: 'common', item_name: 'item_gold_aura'}
        }
    },
    'item_treasure_3': {
        'chest_items': {
            1: {rare: 'immortal', item_name: 'item_armor_pet6'},
            2: {rare: 'immortal', item_name: 'item_spell_pet6'},
            3: {rare: 'immortal', item_name: 'item_stats_pet6'},
            4: {rare: 'legendary', item_name: 'item_spell_pet4'},
            5: {rare: 'legendary', item_name: 'item_dmg_pet4'},
            6: {rare: 'mythical', item_name: 'item_stats_pet3'},
            7: {rare: 'mythical', item_name: 'item_hpmp_pet3'},
            8: {rare: 'rare', item_name: 'item_stats_pet2'},
            9: {rare: 'rare', item_name: 'item_spell_pet2'},
            10: {rare: 'uncommon', item_name: 'item_krest'},
            11: {rare: 'uncommon', item_name: 'item_chest_d'},
            12: {rare: 'uncommon', item_name: 'item_bless'},
            13: {rare: 'uncommon', item_name: 'item_treasure_2'},
            14: {rare: 'common', item_name: 'item_armor_aura'},
            15: {rare: 'common', item_name: 'item_base_damage_aura'},
            16: {rare: 'common', item_name: 'item_expiriance_aura'},
            17: {rare: 'common', item_name: 'item_spell_aura'},
            18: {rare: 'common', item_name: 'item_gold_aura'}
        }
    },
    'item_treasure_4': {
        'chest_items': {
            1: {rare: 'ancient', item_name: 'item_d_pet'},
            2: {rare: 'ancient', item_name: 'item_d3_pet'},
            3: {rare: 'ancient', item_name: 'item_d5_pet'},
            4: {rare: 'immortal', item_name: 'item_attackspeed_pet4'},
            5: {rare: 'immortal', item_name: 'item_hpmp_pet4'},
            6: {rare: 'legendary', item_name: 'item_armor_pet3'},
            7: {rare: 'legendary', item_name: 'item_spell_pet3'},
            8: {rare: 'mythical', item_name: 'item_hpmp_pet2'},
            9: {rare: 'mythical', item_name: 'item_armor_pet2'},
            10: {rare: 'rare', item_name: 'item_stats_pet'},
            11: {rare: 'rare', item_name: 'item_dmg_pet'},
            12: {rare: 'uncommon', item_name: 'item_treasure_3'},
            13: {rare: 'uncommon', item_name: 'item_bless'},
            14: {rare: 'uncommon', item_name: 'item_treasure_2'},
            15: {rare: 'common', item_name: 'item_expiriance_aura'},
            16: {rare: 'common', item_name: 'item_hp_aura'},
            17: {rare: 'common', item_name: 'item_spell_aura'},
            18: {rare: 'common', item_name: 'item_base_damage_aura'}
        }
    },
    'item_treasure_5': {
        'chest_items': {
            1: {rare: 'ancient', item_name: 'item_d2_pet'},
            2: {rare: 'ancient', item_name: 'item_d4_pet'},
            3: {rare: 'ancient', item_name: 'item_d6_pet'},
            4: {rare: 'immortal', item_name: 'item_armor_pet4'},
            5: {rare: 'immortal', item_name: 'item_stats_pet4'},
            6: {rare: 'legendary', item_name: 'item_attackspeed_pet3'},
            7: {rare: 'legendary', item_name: 'item_dmg_pet3'},
            8: {rare: 'mythical', item_name: 'item_dmg_pet2'},
            9: {rare: 'mythical', item_name: 'item_attackspeed_pet2'},
            10: {rare: 'rare', item_name: 'item_hpmp_pet'},
            11: {rare: 'rare', item_name: 'item_spell_pet'},
            12: {rare: 'uncommon', item_name: 'item_krest'},
            13: {rare: 'uncommon', item_name: 'item_chest_d'},
            14: {rare: 'uncommon', item_name: 'item_bless'},
            15: {rare: 'uncommon', item_name: 'item_treasure_3'},
            16: {rare: 'common', item_name: 'item_attack_speed_aura'},
            17: {rare: 'common', item_name: 'item_gold_aura'},
            18: {rare: 'common', item_name: 'item_lifesteal_aura'}
        }
    }
}

var rarity_color =
{
    common : "#b0c3d9",
    uncommon : "#5e98d9", 
    rare: "#4b69ff",
    mythical : "#8847ff", 
    legendary : "#d32ce6", 
    immortal : "#e4ae39", 
	ancient : "#ed0c2e",
} 

var DELAY_SPAWN_ITEMS_ANIM = 0.07 // 0 - off
var STARTING_SPEED = 6000
var DROP_SLOT = 70
var DROP_POS = [0,0]
var SOUND_TICK_WIDTH = 128


function InitChest(data)
{
	const item = data.item;
	const userTreasures = data["1"].user_treasures;
	const treasuresRolls = data["1"].treasures_rolls;
	const userTreasuresValue = userTreasures[item] || 0
	const difference = treasuresRolls[item] - userTreasuresValue
		
	
    ClearOldChest()
	var name = data.item
	
	var items = chests_data[name].chest_items
	if (difference == 1){
		$("#counter_to_best_reward").text = $.Localize("#counter_to_best_reward_next")
	}else{
		$("#counter_to_best_reward").text = $.Localize("#counter_to_best_reward") + " " + (difference-1)
	}	

    $("#ChestName").text = $.Localize("#DOTA_Tooltip_ability_"+name)
    ChestInitItemsInRoll(items)
    ChestInitItemsInChest(items)
    $("#ChestHudMainPanel").visible = true
    $("#OpenChestButton").style.visibility = "visible"
	
	$("#OpenChestButton").SetPanelEvent('onactivate', function()
    {
		GameEvents.SendCustomGameEventToServer("try_treasure", {items:items, name:name})
    })
}

function CloseChest()
{
	GameUI.CustomUIConfig.OpenShop();
	$("#ChestHudMainPanel").visible = false
    $("#DropItemPanel").SetHasClass("DropItemPanelVisible", false)
}

function ClearOldChest()
{
    $("#RollItemsListMain").RemoveAndDeleteChildren()
    $("#ItemsInChestBlock").RemoveAndDeleteChildren()
    $("#RollItemsListMain").style.position = "0px 0px 0px"
}

function ChestInitItemsInRoll(items)
{
    $("#RollItemsListMain").RemoveAndDeleteChildren()
    for (let i = 0; i <= 100; i++)
    {
        let randomIndex = Math.floor(1 + Math.random() * (Object.keys(items).length - 1));
        let randomElement = items[randomIndex];
        CreateItemInfo($("#RollItemsListMain"), randomElement, 0, true, DROP_SLOT == i, i)
    }  
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

        if (rare == "ancient")
        {
            let very_rare_item_effect = $.CreatePanel("DOTAParticleScenePanel", item_panel, "", {particleName:"particles/ui/dota_hud_armory_selection_icon.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"160 0 0", lookAt:"0 0 0", fov:"60"})
            very_rare_item_effect.AddClass("very_rare_item_effect")
			very_rare_item_effect.hittest = false
        }

		let item_panel_name = $.CreatePanel("Panel", item_panel, "item_panel_name")
		item_panel_name.AddClass("item_panel_name")
		item_panel_name.style.backgroundColor = rarity_color[rare]
		
		let item_name = $.CreatePanel("Label", item_panel_name, "item_name")
		item_name.AddClass("item_name")
		item_name.html = true
		

		let item_icon = $.CreatePanel("DOTAItemImage", item_panel, "item_icon")
		item_icon.AddClass("item_icon")
		item_icon.itemname = name
		item_name.text = $.Localize("#DOTA_Tooltip_ability_"+name)

		
		let item_panel_border = $.CreatePanel("Panel", item_panel, "item_panel_border")
		item_panel_border.AddClass("item_panel_border")
		item_panel_border.hittest = false
		item_panel_border.style.borderBrush = 'gradient( linear, 0% 100%, 0% 20%, from(' + rarity_color[rare] + '), to( rgba(0,0,0,0.1) ) )'
		
			
        $.Schedule( 0.02, function()
        {
            item_panel.style.opacity = "1" 
            if (roll && drop_slot)
            {
                let check_pos = item_panel.style.position
                let SpaceFind = check_pos.indexOf('px');
                SOUND_TICK_WIDTH = (item_panel.actuallayoutwidth / item_panel.actualuiscale_x) + (7 * 2)
                DROP_POS[0] = -((Number(check_pos.substring(0, SpaceFind)) - ( (item_panel.actuallayoutwidth / item_panel.actualuiscale_x) * 2) - (7 * 4)) - (item_panel.actuallayoutwidth / item_panel.actualuiscale_x))
                DROP_POS[1] = -(Number(check_pos.substring(0, SpaceFind)) - ( (item_panel.actuallayoutwidth / item_panel.actualuiscale_x) * 2) - (7 * 4))
            }
        })
    }) 
}

function getItemKeyByName(chestData, itemName) {
    const chestItems = chestData['chest_items'];
    for (const key in chestItems) {
        if (chestItems[key].item_name === itemName) {
            return key
        }
    }
}

function OpenChest(tab)
{
	$.Msg(tab)
// {"treasure_name":"item_treasure_3","user_treasures":{"item_treasure_3":8,"item_treasure_2":1},"itemname":"item_chest_d"}
	const userTreasures = tab.user_treasures;
	const treasuresRolls = tab.treasures_rolls;
	const userTreasuresValue = userTreasures[tab.treasure_name] || 0
	const difference = treasuresRolls[tab.treasure_name] - userTreasuresValue
	if (difference == 1){
		$("#counter_to_best_reward").text = $.Localize("#counter_to_best_reward_next")
	}else{
		$("#counter_to_best_reward").text = $.Localize("#counter_to_best_reward") + " " + (difference-1)
	}	
	
	CURRENT_DROP_ID = getItemKeyByName(chests_data[tab.treasure_name], tab.itemname)
	items = chests_data[tab.treasure_name]['chest_items']
    Game.EmitSound("ui.treasure_count")
    let current = 0

    if (CURRENT_DROP_ID != null)
    {
        let drop_info = items[CURRENT_DROP_ID]
        let slot_drop = $("#RollItemsListMain").FindChildTraverse("dropped_item")
        if (slot_drop)
        {   
			show_reward_scroll_desc(slot_drop, drop_info)
			
            let item_panel_name = slot_drop.FindChildTraverse("item_panel_name")
            if (item_panel_name)
            {
                item_panel_name.style.backgroundColor = rarity_color[drop_info.rare]
            }
   
            let item_panel_border = slot_drop.FindChildTraverse("item_panel_border")
            if (item_panel_border)
            {
                item_panel_border.style.borderBrush = 'gradient( linear, 0% 100%, 0% 20%, from(' + rarity_color[drop_info.rare] + '), to( rgba(0,0,0,0.1) ) )'
            }
            if (drop_info.rare == "ancient")
            {
                let very_rare_item_effect = $.CreatePanel("DOTAParticleScenePanel", slot_drop, "", {particleName:"particles/ui/dota_hud_armory_selection_icon.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"160 0 0", lookAt:"0 0 0", fov:"60"})
                very_rare_item_effect.AddClass("very_rare_item_effect")
            }
        }
    }

    let randomly_max_distance = Math.floor(Math.random() * (DROP_POS[1] - DROP_POS[0] + 1) + DROP_POS[0]);
    ChestAnimate(current, randomly_max_distance, STARTING_SPEED, SOUND_TICK_WIDTH, items[CURRENT_DROP_ID], items)
    $("#OpenChestButton").style.visibility = "collapse"
}

function show_reward_scroll_desc(slot_drop, drop_info){
	var reward = drop_info.item_name
	var item_name = slot_drop.FindChildTraverse("item_name")
	var item_icon = slot_drop.FindChildTraverse("item_icon")

	item_icon.itemname = reward
	item_name.text = $.Localize("#DOTA_Tooltip_ability_"+reward)
}

function ChestAnimate(current, drop_distance, speed, sound_tick, item_drop_info, items)
{
    if (current <= drop_distance)
    {
        $.Schedule(0.1, function() 
        {
            GiveItemDrop(item_drop_info, items)
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
    speed = Math.max(100, speed);
    $("#RollItemsListMain").style.position = current + "px 0px 0px"
    $.Schedule(Game.GetGameFrameTime(), function() 
    {
		ChestAnimate(current, drop_distance, speed, sound_tick, item_drop_info, items)
	})
}

function GiveItemDrop(item_drop_info, items)
{
    $("#OpenChestButton").style.visibility = "visible"
    $("#DropItemPanel").SetHasClass("DropItemPanelVisible", true)
	
	show_reward_desc(item_drop_info.item_name)
	
    $("#DropEffect").style.washColor = rarity_color[item_drop_info.rare]
    $("#DropEffect_top").style.washColor = rarity_color[item_drop_info.rare]
    $("#DropEffect_bottom").style.washColor = rarity_color[item_drop_info.rare]

    let item_drop_effect = $.CreatePanel("DOTAParticleScenePanel", $("#ChestHudMainPanel"), "", {particleName:"particles/ui/ui_generic_treasure_impact.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"0 0 300", lookAt:"0 0 0", fov:"60"})
    item_drop_effect.AddClass("item_drop_effect")
    item_drop_effect.hittest = false
    item_drop_effect.DeleteAsync(3)
    Game.EmitSound("ui.treasure_01")

	$.Schedule(2, function()
        {
			ChestInitItemsInRoll(items)
			CloseDropPanel()
		}
	)
}

function show_reward_desc(reward){
	$("#ItemDropIconItem").visible = true
	$("#ItemDropIconItem").itemname = reward
	$("#ItemDropName").text = $.Localize("#DOTA_Tooltip_ability_" + reward)
}


function CloseDropPanel()
{
    $("#RollItemsListMain").style.position = "0px 0px 0px"
    $("#DropItemPanel").SetHasClass("DropItemPanelVisible", false)
}

(function(){
	GameEvents.Subscribe( "show_treasure_rewards", InitChest)
	GameEvents.Subscribe( "srart_roll", OpenChest)
})();