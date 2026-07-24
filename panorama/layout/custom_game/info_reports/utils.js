--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function HasItemInventory(item_id)
{
    if (player_table_shop?.items_ids)
    {
        return Object.values(player_table_shop.items_ids).includes(Number(item_id));
    }
	return false
}

function IsChestOpened(chest_id)
{
    if (player_table_shop?.chest_opened)
    {
        return Object.values(player_table_shop.chest_opened).includes(Number(chest_id));
    }
	return false
}

function IsLockedTime()
{
    let state_table = CustomNetTables.GetTableValue("custom_pick", "pick_state");

    if (!state_table)
    	return false

    if (state_table.in_progress == 1)
    	return true

    if (state_table.player_count && state_table.player_count <= 2) //&&) !Game.IsInToolsMode())
    	return true

    GameEvents.SendEventClientSide("dota_hud_error_message", 
    {
        "splitscreenplayer": 0,
        "reason": 80,
        "message": $.Localize("#shop_error_time")
    })
    return false
}

function HeroIsAlive()
{
    let player_table = CustomNetTables.GetTableValue("networth_players", String(Players.GetLocalPlayer()));

    if (player_table)
    {
        if (player_table.place !== -1)
        {
            return true
        }
    }

    if (Entities.IsAlive( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) ))
    {
        return true
    }

    GameEvents.SendEventClientSide("dota_hud_error_message", 
    {
        "splitscreenplayer": 0,
        "reason": 80,
        "message": $.Localize("#shop_error_death")
    })
    return false
}

function ChangeScenePreviewItem(buy_panel, ButtonItemStyleBuyPanel, style, item_scene_panel_preview, item_id)
{
    ButtonItemStyleBuyPanel.SetPanelEvent("onactivate", function() 
    {
        Game.EmitSound("UI.Click")
        let model = style["model"]
        let find_info = style["styles"]
        let style_type = 0
        if (find_info)
        {
            style_type = find_info
        }
        if (model)
        {
            item_id = model
        }
        let full_scene_panel_preview_model = buy_panel.FindChildTraverse("full_scene_panel_preview_model")
        if (full_scene_panel_preview_model)
        {
            full_scene_panel_preview_model.DeleteAsync(0)
        }
        $.CreatePanel("DOTAUIEconSetPreview", item_scene_panel_preview, "full_scene_panel_preview_model", { itemdef:item_id, itemstyle:style_type, class:"full_scene_panel_preview_model", style: "width:100%;height:100%;", particleonly:"false", renderdeferred:"false", antialias:"false", renderwaterreflections:"false", allowrotation:"true" });
        let ButtonStylesBuyPanel = buy_panel.FindChildTraverse("ButtonStylesBuyPanel")
        if (ButtonStylesBuyPanel)
        {
            for (var i = 0; i < ButtonStylesBuyPanel.GetChildCount(); i++) 
            {  
                ButtonStylesBuyPanel.GetChild(i).SetHasClass("ButtonItemStyle_active", false)
                ButtonStylesBuyPanel.GetChild(i).SetHasClass("ButtonItemStyleBuyPanel_active", false)
            }
        }
        ButtonItemStyleBuyPanel.SetHasClass("ButtonItemStyle_active", true)
        ButtonItemStyleBuyPanel.SetHasClass("ButtonItemStyleBuyPanel_active", true)
    })
}

function HasItemForThisHero(info) 
{
	if (info)
	{
        if (info["hide"] == 1)
        {
            return false
        }
		if (HasItemInventory(info["item_id"]))
		{
            return true
		}
	}
    return false
}
function GetAllItemsInSet(set_name, hero_name)
{
    let set_info = [[], 0, 0, 0, 0, 0, 0];
    if (!SAVE_DATA_SETS_ITEMS[String(hero_name)])
    {
        SAVE_DATA_SETS_ITEMS[String(hero_name)] = CustomNetTables.GetTableValue("heroes_items_info", String(hero_name));
    }
    let items = SAVE_DATA_SETS_ITEMS[String(hero_name)]
    if (items) 
    {
        Object.values(items).forEach(item => {
            if (item && item.sets === set_name && item.hide === 0) 
            {
                set_info[0].push(item.item_id);
                if (item.sale_price > 0) 
                {
                    set_info[4] += item.sale_price;
                    if (item.sale > 0) {
                        set_info[3] = item.sale;
                    }
                }
                let price = item.item_id === 59571 ? 0 : item.price;
                set_info[2] += price;
                if (!razor_arcana_items_blocked[item.item_id])
                {
                    set_info[5] += 1
                }
                if (HasItemInventory(item.item_id) && !razor_arcana_items_blocked[item.item_id])
                {
                    set_info[6] += 1
                }
            }
        });
    }
    return set_info;
}

function HasItemUneqieup(hero, id)
{
	if (player_table_shop?.player_items_onequip?.[String(hero)])
    {
        return Object.values(player_table_shop.player_items_onequip[String(hero)]).includes(Number(id));
    }
    return false;
}

function HasItemUneqieupEffects(hero, id, is_item_effect)
{
	if (player_table_shop?.player_items_onequip_effects?.[String(hero)])
    {
        for (let ability_name in player_table_shop.player_items_onequip_effects[String(hero)])
        {
            if (player_table_shop.player_items_onequip_effects[String(hero)][ability_name] == id && ability_name == is_item_effect)
            {
                return true
            }
        }
    }
    return false;
}

function SetShowAbDesc(panel, ability)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowAbilityTooltip', panel, ability); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
    });       
}

function GetPlayerTips(item_id)
{
    if (player_table_shop?.player_tips)
    {
        return Object.values(player_table_shop.player_tips).includes(Number(item_id));
    }
    return false;
}

function GetCurrentHighFive(id, sub_data)
{
    if (sub_data && sub_data.selected_high_five == id)
    {
        return true
    }
    return false
}

function GetCurrentEmblem(id, sub_data)
{
    if (sub_data && sub_data.selected_emblem == id)
    {
        return true
    }
    return false
}

function GetCurrentEffect(effect_type, id, sub_data)
{
    if (sub_data && sub_data.selected_effects && sub_data.selected_effects[effect_type] == id)
    {
        return true
    }
    return false
}

function GetGameKeybind(command) 
{
    return Game.GetKeybindForCommand(command);
}

function roundPlus(x, n) 
{ //x - число, n - количество знаков
    if(isNaN(x) || isNaN(n)) return false;
    var m = Math.pow(10,n);
    return Math.round(x*m)/m;
}

function get_payment_url(kv)
{
	$.DispatchEvent("ExternalBrowserGoToURL", kv.url);
}

function NotActive(panel)
{
	if (panel)
	{
		let text = $.Localize("#NotActive")

		panel.SetPanelEvent('onmouseover', function() 
		{
		   	 $.DispatchEvent('DOTAShowTextTooltip', panel, text) 
		});
		    
		panel.SetPanelEvent('onmouseout', function() 
		{
		   $.DispatchEvent('DOTAHideTextTooltip', panel);
		});
	}
}

function padNumber(num) {
    const str = num.toString()
    if (str.length === 1)
        return "0" + str
    return str
}

function Sort_Games(player_matches,cb)
{
	var gamelist_label = $("#gamelist_label")
	for (var i = 1; i <= Object.keys(player_matches).length; i++) 
	{
		const panel = $("#gamelist_player_label"+i)
		const value = player_matches[i]

		for (var j = 1; j <= Object.keys(player_matches).length; j++) 
		{
			if (i === j)
			{
				continue
			}


			const panel_2 = $("#gamelist_player_label"+j)
			
			const v = player_matches[j]


			if (cb(value,v))
			{
				gamelist_label.MoveChildAfter(panel,panel_2)
			}
		}
	}	
}

function Sort(leaderboard_data,cb)
{
	var leaderboard_label = $("#leaderboard_label")

	for (var i = 1; i <= Object.keys(leaderboard_data).length; i++) 
	{
		const panel = $("#leaderboard_player_label"+i)
		const value = leaderboard_data[i]

		for (var j = 1; j <= Object.keys(leaderboard_data).length; j++) 
		{
			if (i === j)
			{
				continue
			}


			const panel_2 = $("#leaderboard_player_label"+j)
			
			const v = leaderboard_data[j]


			if (cb(value,v))
			{
				leaderboard_label.MoveChildAfter(panel,panel_2)
			}
		}
	}	
}

function UpdateQuipHeroItem(id, activate, slot_type, sets, is_effect)
{
	var ItemsList = $.GetContextPanel().FindChildTraverse("ItemsList")
    if ($("#HeroListItemsSelection"))
    {
        ItemsList = $("#HeroListItemsSelection")
    }
	if (ItemsList)
	{
        if (CURRENT_TAB_ITEMS_HERO)
        {
            if (CURRENT_TAB_ITEMS_HERO == "button_id_1")
            {
                ItemsList = ItemsList.FindChildTraverse("panel_items_list_id_1")
            }
            else if (CURRENT_TAB_ITEMS_HERO == "button_id_2")
            {
                ItemsList = ItemsList.FindChildTraverse("panel_items_list_id_2")
            }
            else if (CURRENT_TAB_ITEMS_HERO == "button_id_3")
            {
                ItemsList = ItemsList.FindChildTraverse("panel_items_list_id_3")
            }
        }
        let BlockItemChilds = ItemsList.FindChildrenWithClassTraverse("BlockItem")
        for (let child of BlockItemChilds)
        {
            let BlockItemActivateButton = child.FindChildTraverse("button_activate")
            let BlockItemActivateButtonLabel = child.FindChildTraverse("BlockItemActivateButtonLabel")
            if (is_effect)
            {
                if (child.id == "item_id_"+id && child.ability_name == is_effect)
                {
                    if (activate)
                    {
                        BlockItemActivateButtonLabel.text = $.Localize("#shop_unequip")
                        BlockItemActivateButton.AddClass("BlockItemBuyButton_unequip")
                        BlockItemActivateButton.RemoveClass("BlockItemBuyButton_equip")
        
                    }
                    else
                    {
                        BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
                        BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
                        BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
                    }
                }
                else
                {
                    if (BlockItemActivateButton && BlockItemActivateButtonLabel && child.ability_name == is_effect)
                    {
                        BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
                        BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
                        BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
                    }
                }
            }
            else
            {
                if (child.id == "item_id_"+id)
                {
                    if (activate)
                    {
                        BlockItemActivateButtonLabel.text = $.Localize("#shop_unequip")
                        BlockItemActivateButton.AddClass("BlockItemBuyButton_unequip")
                        BlockItemActivateButton.RemoveClass("BlockItemBuyButton_equip")
        
                    }
                    else
                    {
                        BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
                        BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
                        BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
                    }
                } 
                else 
                {
                    if (BlockItemActivateButton && BlockItemActivateButtonLabel && child.slot_type == slot_type)
                    {
                        BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
                        BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
                        BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
                    }
                }
            }
        }
	}
}

function UpdateOnlyCouriers()
{
    let CategoryPets = $.GetContextPanel().FindChildTraverse("CategoryPets")
    if (CategoryPets)
    {
        CategoryPets.RemoveAndDeleteChildren()
        let pets_info_table = ALL_PETS_TABLE
        let new_table = []
        if (pets_info_table)
        {
            for (var item = 1; item <= Object.keys(pets_info_table).length; item++)
            {
                new_table[item-1] = []
                new_table[item-1].push(pets_info_table[item][1], pets_info_table[item][2], pets_info_table[item][3], pets_info_table[item][4], pets_info_table[item][5])
            }
            new_table.sort(function (a, b) {
                return Number(a[3])-Number(b[3])
            });
            for (var i = 0; i < new_table.length; i++)
            {
                if (HasItemInventory(new_table[i][0]))
                {
                    let info = new_table[i]
                    CreatePanelInStore({
                        parent : CategoryPets,
                        item_id : info[0],
                        item_image : info[4],
                        item_name : info[2],
                        shard_cost : info[3],
                        item_type : "pet",
                        all_info : info,
                    })
                }
            }
            for (var i = 0; i < new_table.length; i++)
            {
                if (!HasItemInventory(new_table[i][0]))
                {
                    let info = new_table[i]
                    CreatePanelInStore({
                        parent : CategoryPets,
                        item_id : info[0],
                        item_image : info[4],
                        item_name : info[2],
                        shard_cost : info[3],
                        item_type : "pet",
                        all_info : info,
                    })
                }
            }
        }    
    }  
}

function UpdateEquiupPet(id)
{
	var CategoryPets = $.GetContextPanel().FindChildTraverse("CategoryPets")
	if (CategoryPets)
	{
		for (var i = 0; i < CategoryPets.GetChildCount(); i++) {


			let lable = CategoryPets.GetChild(i).FindChildTraverse("BlockItemActivateButtonLabel")
			let button = CategoryPets.GetChild(i).FindChildTraverse('button_activate')
			if (lable)
			{
				lable.text = $.Localize("#shop_equip")
				CategoryPets.GetChild(i).RemoveClass("BlockItem_money")
				CategoryPets.GetChild(i).RemoveClass("BlockItem_nomoney")
				CategoryPets.GetChild(i).AddClass("BlockItem_purchased")
			}
			if (button)
			{
				button.RemoveClass("BlockItemBuyButton_unequip")
				button.AddClass("BlockItemBuyButton_equip")
			}

		}
		let current_courier = CategoryPets.FindChildTraverse("item_id_"+id)
		if (current_courier)
		{
			let lable = current_courier.FindChildTraverse("BlockItemActivateButtonLabel")
			if (lable)
			{
				lable.text = $.Localize("#shop_unequip")
				current_courier.RemoveClass("BlockItem_money")
				current_courier.RemoveClass("BlockItem_nomoney")
				current_courier.AddClass("BlockItem_purchased")
			}


			let button = current_courier.FindChildTraverse('button_activate')
			if (button)
			{
				button.AddClass("BlockItemBuyButton_unequip")
				button.RemoveClass("BlockItemBuyButton_equip")	
			} 
		}
	}

	var CategoryPetsInventory = $.GetContextPanel().FindChildTraverse("CategoryPetsInventory")
	if (CategoryPetsInventory)
	{
		for (var i = 0; i < CategoryPetsInventory.GetChildCount(); i++) {
		

			let button = CategoryPetsInventory.GetChild(i).FindChildTraverse('button')

			let lable = CategoryPetsInventory.GetChild(i).FindChildTraverse("BlockItemActivateButtonLabel")
			if (lable)
			{
				lable.text = $.Localize("#shop_equip")
				CategoryPetsInventory.GetChild(i).RemoveClass("BlockItem_money")
				CategoryPetsInventory.GetChild(i).RemoveClass("BlockItem_nomoney")
				CategoryPetsInventory.GetChild(i).AddClass("BlockItem_purchased")
			}

			if (button)
			{
				button.RemoveClass("BlockItemBuyButton_unequip")
				button.AddClass("BlockItemBuyButton_equip")
			}
		}
		let current_courier = CategoryPetsInventory.FindChildTraverse("item_id_"+id)
		if (current_courier)
		{
			let button = current_courier.FindChildTraverse('button')
			let lable = current_courier.FindChildTraverse("BlockItemActivateButtonLabel")
			if (lable)
			{
				lable.text = $.Localize("#shop_unequip")
				current_courier.RemoveClass("BlockItem_money")
				current_courier.RemoveClass("BlockItem_nomoney")
				current_courier.AddClass("BlockItem_purchased")
			}
			if (button)
			{
				button.AddClass("BlockItemBuyButton_unequip")
				button.RemoveClass("BlockItemBuyButton_equip")
			}
		}
	}
}

function HoverStoreItemInfo(panel, item_data, has_item)
{
    let is_locked = item_data.is_locked
    let video = "file://{resources}/" + item_data.video

    if (item_data.item_type == "emblem" || item_data.item_type == "custom_effect")
        video = item_data.video

    if (video == "")
        return

    panel.SetPanelEvent("onmouseover", () => 
    {
        $.DispatchEvent(
            "UIShowCustomLayoutParametersTooltip",
            panel,
            "store_video_tooltip",
            "file://{resources}/layout/custom_game/info_reports/video_tooltip/video_tooltip.xml",
            "video_name=" + video + "&is_locked=" + is_locked + "&is_locked_description=" + item_data.is_locked_description
        );
    });

    panel.SetPanelEvent("onmouseout", () => 
    {
        $.DispatchEvent("UIHideCustomLayoutTooltip", panel, "store_video_tooltip");
    });
}

function SetVideoItemCosmeticsPreview(panel, video_name)
{
    panel.SetPanelEvent('onmouseover', function() 
    {
        var BlockHoverPanel = $.CreatePanel("Panel", $.GetContextPanel().FindChildTraverse("CategoryCosmeticsVideo"), "BlockHoverPanel");
        BlockHoverPanel.AddClass("BlockHoverPanel");
        BlockHoverPanel.hittest = false;
    
        var width = 300
        var height = 185;
        BlockHoverPanel.style.width = String(width) + 'px';
        BlockHoverPanel.style.height = String(height) + 'px';
    
        var x = panel.actualxoffset + panel.actuallayoutwidth + 20
        var y = panel.actualyoffset + panel.actuallayoutheight/2 + 30
    
        if ((x + width) > panel.GetParent().actuallayoutwidth)
        {
            x = panel.actualxoffset - width*panel.actualuiscale_x - 20
            BlockHoverPanel.AddClass("BlockHoverPanelLeft")
        }else 
        {
            BlockHoverPanel.AddClass("BlockHoverPanelRight")
        }
    
        BlockHoverPanel.SetPositionInPixels(x/panel.actualuiscale_x , y/panel.actualuiscale_y, 0)
    
        var video = $.CreatePanel("MoviePanel", BlockHoverPanel, 'video', 
        {
            style: "",
            src: "file://{resources}/"+ video_name,
            repeat: "true",
            hittest: "false",
            autoplay: "onload"
        });
    
        video.AddClass("BlockHoverPanelVideo")
    });
    
    panel.SetPanelEvent('onmouseout', function() 
    {
        let BlockHoverPanel = $.GetContextPanel().FindChildTraverse("BlockHoverPanel")
        if (BlockHoverPanel)
        {
            BlockHoverPanel.DeleteAsync(0)
        }
    });
}