--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CreateBuyWindow(id, cost, name, sound, hero, no_money, styles, fast_active_tip, pet_video)
{
    let main = $.GetContextPanel().FindChildTraverse("window_shop")
    Game.EmitSound("UI.Shop_Buy_start")

    let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
    blur_panel.RemoveClass("shop_window_blur_hidden")
    blur_panel.AddClass("shop_window_blur")
    
    let buy_panel = $.CreatePanel("Panel", main, "buy_panel_item")
    buy_panel.AddClass("buy_panel")

    buy_panel.hittest = true;
    buy_panel.SetPanelEvent("onactivate", function() {})

    let buy_panel_name_space = $.CreatePanel("Panel", buy_panel, "")
    buy_panel_name_space.AddClass("buy_panel_name_space")

    let buy_panel_content_space_left = $.CreatePanel("Panel", buy_panel, "")
    buy_panel_content_space_left.AddClass("buy_panel_content_space_left")

    let buy_panel_changes_effects = $.CreatePanel("Panel", buy_panel, "")
    buy_panel_changes_effects.AddClass("buy_panel_changes_effects")

    let buy_panel_changes_icons = $.CreatePanel("Panel", buy_panel, "")
    buy_panel_changes_icons.AddClass("buy_panel_changes_icons")

    let buy_panel_cost_and_button = $.CreatePanel("Panel", buy_panel, "")
    buy_panel_cost_and_button.AddClass("buy_panel_cost_and_button")

    let buy_panel_name = $.CreatePanel("Label", buy_panel_name_space, "")

    let buy_panel_costpanel = $.CreatePanel("Panel", buy_panel_cost_and_button, "")
    buy_panel_costpanel.AddClass("buy_panel_costpanel")

    let shard_icon_cost = $.CreatePanel("Panel", buy_panel_costpanel, "")
    shard_icon_cost.AddClass("shard_icon_cost")

    let shard_label_cost = $.CreatePanel("Label", buy_panel_costpanel, "")
    shard_label_cost.AddClass("shard_label_cost")
    shard_label_cost.text = cost

    let buy_buttons = $.CreatePanel("Panel", buy_panel_cost_and_button, "")
    buy_buttons.AddClass("shop_buy_buttons")

    let button_buy_buy = $.CreatePanel("Panel", buy_buttons, "")
    button_buy_buy.AddClass("shop_button_buy")

    let label_button_1 = $.CreatePanel("Label", button_buy_buy, "")
    label_button_1.AddClass("label_button_buy")
    label_button_1.text = $.Localize("#buy")

    if (pet_video != null)
    {
        buy_panel.AddClass("buy_panel_pet_video")
        let video = $.CreatePanel("MoviePanel", buy_panel, 'video', 
        {
            style: "",
            src: "file://{resources}/videos/custom_game/shop/pets/" + name + ".webm",
            repeat: "true",
            hittest: "false",
            autoplay: "onload"
        });
        video.AddClass("PanelVideoPet")
    }

    if (id != -1 && ITEM_CHANGED_INFORMATION[id] != null)
    {
        buy_panel.AddClass("buy_panel_with_info")
        let abilities_changes_panel = null
        let scene_panel_visual = null

        if (ITEM_CHANGED_INFORMATION[id]["model"] != null)
        {
            let model_info = ITEM_CHANGED_INFORMATION[id]["model"]
            let style = 0
            if (ITEM_CHANGED_INFORMATION[id]["styles"])
            {
                style = ITEM_CHANGED_INFORMATION[id]["styles"]
            }
            let item_scene_panel_preview = $.CreatePanel("Panel", buy_panel_content_space_left, "")
            item_scene_panel_preview.AddClass("item_scene_panel_preview")
            scene_panel_visual = item_scene_panel_preview
            $.CreatePanel("DOTAUIEconSetPreview", item_scene_panel_preview, "full_scene_panel_preview_model", { itemdef: model_info, itemstyle:style, class:"full_scene_panel_preview_model", style: "width:100%;height:100%;", particleonly:"false", renderdeferred:"false", antialias:"false", renderwaterreflections:"false", allowrotation:"true" });
        }

        if ((styles != null) && (no_styles[id] !== true))
        {
            let ButtonStylesBuyPanel = $.CreatePanel("Panel", buy_panel_content_space_left, "ButtonStylesBuyPanel");
            ButtonStylesBuyPanel.AddClass("ButtonStylesBuyPanel");

            for (let i = 1; i <= Object.keys(styles).length; i++) 
            {
                let ButtonItemStyleBuyPanel = $.CreatePanel("Panel", ButtonStylesBuyPanel, "item_style_" + styles[i][1]);
                ButtonItemStyleBuyPanel.AddClass("ButtonItemStyleBuyPanel");
                ButtonItemStyleBuyPanel.style.backgroundColor = styles[i][2]
                let ButtonItemStyleBuyPanelActiveIcon = $.CreatePanel("Panel", ButtonItemStyleBuyPanel, "");

                if (i == 1)
                {
                    ButtonItemStyleBuyPanel.SetHasClass("ButtonItemStyle_active", true)
                    ButtonItemStyleBuyPanel.SetHasClass("ButtonItemStyleBuyPanel_active", true)
                }
                ChangeScenePreviewItem(buy_panel, ButtonItemStyleBuyPanel, ITEM_CHANGED_INFORMATION[styles[i][1]], scene_panel_visual, ITEM_CHANGED_INFORMATION[id]["model"])
            }
        }

        if (ITEM_CHANGED_INFORMATION[id]["changed_icons"] != null)
        {
            abilities_changes_panel = $.CreatePanel("Panel", buy_panel_changes_icons, "abilities_changes_panel")
            abilities_changes_panel.AddClass("abilities_changes_panel")

            let changes_icons_panel = $.CreatePanel("Panel", abilities_changes_panel, "changes_icons_panel")
            changes_icons_panel.AddClass("changes_icons_panel")
            let changes_icons_panel_label = $.CreatePanel("Label", changes_icons_panel, "changes_icons_panel_label")
            changes_icons_panel_label.AddClass("changes_icons_panel_label")
            changes_icons_panel_label.text = $.Localize("#changes_icons_abilities")
            let changes_ability_list = $.CreatePanel("Panel", changes_icons_panel, "")
            changes_ability_list.AddClass("changes_ability_list")

            for (let i = 0; i < ITEM_CHANGED_INFORMATION[id]["changed_icons"].length; i++) 
            {
                let ability_info = ITEM_CHANGED_INFORMATION[id]["changed_icons"][i]
                if (ability_info)
                {
                    let ability_info_panel = $.CreatePanel("Panel", changes_ability_list, "changes_icons_panel")
                    let image_texture = 'url("file://{images}/spellicons/' + ability_info[1] + '.png")';
                    if (ability_info[1].includes("item_"))
                    {
                        image_texture = 'url("file://{images}/items/' + ability_info[1].replace("item_", "") + '.png")';
                        ability_info_panel.AddClass("item_info_panel")
                    }
                    else
                    {
                        ability_info_panel.AddClass("ability_info_panel")
                    }
                    if (ability_info[1] == "nevermore_necromastery")
                    {
                        image_texture = 'url("file://{images}/custom_game/icons/skills/Necromastery.png")';
                    }
                    ability_info_panel.style.backgroundImage = image_texture
                    ability_info_panel.style.backgroundSize = "100%";
                    SetShowAbDesc(ability_info_panel, ability_info[0])
                }
            }
        }

        if (ITEM_CHANGED_INFORMATION[id]["changed_effects"] != null)
        {
            let changes_effects_panel = $.CreatePanel("Panel", buy_panel_changes_effects, "changes_effects_panel")
            changes_effects_panel.AddClass("changes_effects_panel")
            let changes_effects_panel_label = $.CreatePanel("Label", changes_effects_panel, "changes_effects_panel_label")
            changes_effects_panel_label.AddClass("changes_effects_panel_label")
            changes_effects_panel_label.text = $.Localize("#changes_effects_abilities")
            let changes_ability_list = $.CreatePanel("Panel", changes_effects_panel, "")
            changes_ability_list.AddClass("changes_ability_list")
            for (let i = 0; i < ITEM_CHANGED_INFORMATION[id]["changed_effects"].length; i++) 
            {
                let ability_info = ITEM_CHANGED_INFORMATION[id]["changed_effects"][i]
                if (ability_info)
                {
                    let ability_info_panel = $.CreatePanel("Panel", changes_ability_list, "changes_icons_panel")
                    let image_texture = 'url("file://{images}/spellicons/' + ability_info[1] + '.png")';
                    if (ability_info[1].includes("item_"))
                    {
                        image_texture = 'url("file://{images}/items/' + ability_info[1].replace("item_", "") + '.png")';
                        ability_info_panel.AddClass("item_info_panel")
                    }
                    else
                    {
                        ability_info_panel.AddClass("ability_info_panel")
                    }
                    if (ability_info[1] == "nevermore_necromastery")
                    {
                        image_texture = 'url("file://{images}/custom_game/icons/skills/Necromastery.png")';
                    }
                    ability_info_panel.style.backgroundImage = image_texture
                    ability_info_panel.style.backgroundSize = "100%";
                    SetShowAbDesc(ability_info_panel, ability_info[0])
                }
            }
        }
    } 

    if (sound == 1)
    {
        buy_panel_name.AddClass("buy_panel_name_sound")
    }
    else 
    {
        buy_panel_name.AddClass("buy_panel_name")
    }

    if (id == -1)
    {

        buy_panel_name.text = $.Localize("#vote_buy_window") + name
    }
    else
    {
        if (("#"+name) == $.Localize("#"+name))
        {
            buy_panel_name.text = name
        }else 
        {
            buy_panel_name.text = $.Localize("#"+name)
        }
    }

    if (no_money == null || no_money == false)
    {
        button_buy_buy.SetPanelEvent("onactivate", function() 
        { 
            button_buy_buy.SetPanelEvent("onactivate", function() {})
            blur_panel.AddClass("shop_window_blur_hidden")
            blur_panel.RemoveClass("shop_window_blur")
            Game.EmitSound("UI.Shop_Buy")
            let votes = 0
            if (id == -1)
            {
                votes = Number(name)
            }
            if (hero)
            {
                GameEvents.SendCustomGameEventToServer_custom( "shop_buy_item_player", { item_id : id, votes : votes, hero : hero} );
            }
            else
            {
                GameEvents.SendCustomGameEventToServer_custom( "shop_buy_item_player", { item_id : id, votes : votes} );
            }
            if (fast_active_tip != null)
            {
                GameEvents.SendCustomGameEventToServer_custom( "update_tip_list", {tip_id: fast_active_tip, delete : false} );
            }
            buy_panel.RemoveClass("buy_panel")
            buy_panel.AddClass("buy_panel_hide")
            $.Schedule( 0.35, function()
            {
                let is_start_selection = false
                if (buy_panel.GetParent().BHasClass("shop_window_show_selection"))
                {
                    is_start_selection = true
                }
                buy_panel.DeleteAsync(0)
                if (is_start_selection || $("#HeroListItemsSelection"))
                {
                    InitShopItemsForHero($("#HeroListItemsSelection"))
                    UpdateShards()
                    UpdateSelectionSets()
                }
                else
                {
                    UpdateShards()
                    InitItems()
                    InitSounds()
                    InitVote()
                    UpdateSelectionSets()
                    CloseActiveChatBlock()
                    let ItemsList = $.GetContextPanel().FindChildTraverse("ItemsList")
                    if (ItemsList)
                    {
                        InitShopItemsForHero(ItemsList)
                    }
                }
            })
        })
    }
    else
    {
        
        button_buy_buy.AddClass("button_no_money")
        shard_label_cost.AddClass("cost_no_money")
    }
    blur_panel.SetPanelEvent("onactivate", function() 
    {   
        buy_panel.RemoveClass("buy_panel")
        buy_panel.AddClass("buy_panel_hide")
        $.Schedule( 0.35, function()
        {
            buy_panel.DeleteAsync(0)
        })
        Game.EmitSound("UI.Shop_Category_Open")
        blur_panel.SetPanelEvent("onactivate", function() {})
        blur_panel.AddClass("shop_window_blur_hidden")
        blur_panel.RemoveClass("shop_window_blur")
    })
}

function CreatePlusWindow()
{
    let main = $.GetContextPanel().FindChildTraverse("window_shop")
	let data = PLAYER_SERVER_DATA
    let lang = $.Localize("#lang")
    if (!data?.total_games || data.total_games < max_games && lang !== "rus") 
    {
        return;
    }
	Game.EmitSound("UI.Shop_Buy_start")

	let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
	blur_panel.RemoveClass("shop_window_blur_hidden")
	blur_panel.AddClass("shop_window_blur")
	
	let buy_panel = $.CreatePanel("Panel", main, "buy_panel_item")
	buy_panel.AddClass("buy_pass_panel")
	buy_panel.hittest = true;
	buy_panel.SetPanelEvent("onactivate", function() {})

	let buy_pass_top = $.CreatePanel("Panel", buy_panel, "buy_panel_item")
	buy_pass_top.AddClass("buy_pass_top")

	let buy_pass_bot = $.CreatePanel("Panel", buy_panel, "buy_panel_item")
	buy_pass_bot.AddClass("buy_pass_bot")

	let buy_pass_close_button= $.CreatePanel("Panel", buy_pass_top, "buy_panel_item")
	buy_pass_close_button.AddClass("buy_pass_close_button")

	let buy_pass_top_text = $.CreatePanel("Label", buy_pass_top, "buy_panel_item")
	buy_pass_top_text.AddClass("buy_pass_top_text")
	buy_pass_top_text.text = $.Localize("#pass_buy_top")

	let buy_pass_bot_left =  $.CreatePanel("Panel", buy_pass_bot, "buy_panel_item")
	buy_pass_bot_left.AddClass("buy_pass_bot_panel")

	let buy_pass_bot_mid =  $.CreatePanel("Panel", buy_pass_bot, "buy_panel_item")
	buy_pass_bot_mid.AddClass("buy_pass_bot_panel")

	let buy_pass_bot_right =  $.CreatePanel("Panel", buy_pass_bot, "buy_panel_item")
	buy_pass_bot_right.AddClass("buy_pass_bot_panel")

	let buy_pass_bot_button_left = $.CreatePanel("Panel", buy_pass_bot_left, "")
	buy_pass_bot_button_left.AddClass("buy_pass_button")

	let buy_pass_bot_button_left_text = $.CreatePanel("Label", buy_pass_bot_button_left, "")
	buy_pass_bot_button_left_text.AddClass("buy_pass_button_text")
	buy_pass_bot_button_left_text.text = $.Localize("#pass_buy_button1")

	let buy_pass_bot_button_mid = $.CreatePanel("Panel", buy_pass_bot_mid, "")
	buy_pass_bot_button_mid.AddClass("buy_pass_button")

	let buy_pass_bot_button_mid_text = $.CreatePanel("Label", buy_pass_bot_button_mid, "")
	buy_pass_bot_button_mid_text.AddClass("buy_pass_button_text")
	buy_pass_bot_button_mid_text.text = $.Localize("#pass_buy_button2")

	let buy_pass_bot_button_right = $.CreatePanel("Panel", buy_pass_bot_right, "")
	buy_pass_bot_button_right.AddClass("buy_pass_button")

	let buy_pass_bot_button_right_text = $.CreatePanel("Label", buy_pass_bot_button_right, "")
	buy_pass_bot_button_right_text.AddClass("buy_pass_button_text")
	buy_pass_bot_button_right_text.text = $.Localize("#pass_buy_button3")

	if (active_sub_sale == true)
	{
		let buy_pass_mid_text = $.CreatePanel("Label", buy_pass_top, "buy_panel_item")
		buy_pass_mid_text.html = true
		buy_pass_mid_text.AddClass("buy_pass_mid_text")
		buy_pass_mid_text.text = $.Localize("#pass_buy_mid")

		let buy_pass_bot_cost_left_sale_text = $.CreatePanel("Label", buy_pass_bot_left, "")
		buy_pass_bot_cost_left_sale_text.AddClass("buy_pass_cost_sale_text_left")
		buy_pass_bot_cost_left_sale_text.html = true
		buy_pass_bot_cost_left_sale_text.text = $.Localize("#pass_buy_cost1_sale_left")

		let buy_pass_bot_cost_left_sale_text_cost = $.CreatePanel("Label", buy_pass_bot_left, "")
		buy_pass_bot_cost_left_sale_text_cost.AddClass("buy_pass_cost_sale_text_right")
		buy_pass_bot_cost_left_sale_text_cost.html = true
		buy_pass_bot_cost_left_sale_text_cost.text = $.Localize("#pass_buy_cost1_sale_right")

		let buy_pass_bot_cost_mid_sale_text = $.CreatePanel("Label", buy_pass_bot_mid, "")
		buy_pass_bot_cost_mid_sale_text.AddClass("buy_pass_cost_sale_text_left")
		buy_pass_bot_cost_mid_sale_text.html = true
		buy_pass_bot_cost_mid_sale_text.text = $.Localize("#pass_buy_cost2_sale_left")

		let buy_pass_bot_cost_mid_sale_text_cost = $.CreatePanel("Label", buy_pass_bot_mid, "")
		buy_pass_bot_cost_mid_sale_text_cost.AddClass("buy_pass_cost_sale_text_right")
		buy_pass_bot_cost_mid_sale_text_cost.html = true
		buy_pass_bot_cost_mid_sale_text_cost.text = $.Localize("#pass_buy_cost2_sale_right")

		let buy_pass_bot_cost_right_sale_text = $.CreatePanel("Label", buy_pass_bot_right, "")
		buy_pass_bot_cost_right_sale_text.AddClass("buy_pass_cost_sale_text_left")
		buy_pass_bot_cost_right_sale_text.html = true
		buy_pass_bot_cost_right_sale_text.text = $.Localize("#pass_buy_cost3_sale_left")

		let buy_pass_bot_cost_right_sale_text_cost = $.CreatePanel("Label", buy_pass_bot_right, "")
		buy_pass_bot_cost_right_sale_text_cost.AddClass("buy_pass_cost_sale_text_right")
		buy_pass_bot_cost_right_sale_text_cost.html = true
		buy_pass_bot_cost_right_sale_text_cost.text = $.Localize("#pass_buy_cost3_sale_right")
	}
	else
	{
		let buy_pass_mid_icon = $.CreatePanel("Panel", buy_pass_top, "buy_panel_item")
		buy_pass_mid_icon.AddClass("buy_pass_mid_icon")

		let buy_pass_bot_cost_left_text = $.CreatePanel("Label", buy_pass_bot_left, "")
		buy_pass_bot_cost_left_text.AddClass("buy_pass_cost_text")
		buy_pass_bot_cost_left_text.html = true
		buy_pass_bot_cost_left_text.text = $.Localize("#pass_buy_cost1")

		let buy_pass_bot_cost_mid_text = $.CreatePanel("Label", buy_pass_bot_mid, "")
		buy_pass_bot_cost_mid_text.AddClass("buy_pass_cost_text")
		buy_pass_bot_cost_mid_text.html = true
		buy_pass_bot_cost_mid_text.text = $.Localize("#pass_buy_cost2")
		
		let buy_pass_bot_cost_right_text = $.CreatePanel("Label", buy_pass_bot_right, "")
		buy_pass_bot_cost_right_text.AddClass("buy_pass_cost_text")
		buy_pass_bot_cost_right_text.html = true
		buy_pass_bot_cost_right_text.text = $.Localize("#pass_buy_cost3")
	} 

	buy_pass_bot_button_left.SetPanelEvent("onactivate", function() 
	{ 
		buy_pass_bot_button_left.SetPanelEvent("onactivate", function() {})
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "dota_plus_1"});
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
		Game.EmitSound("UI.Shop_Buy")
		buy_panel.RemoveClass("buy_pass_panel")
		buy_panel.AddClass("buy_pass_panel_hide")
		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
		})
	})

	buy_pass_bot_button_mid.SetPanelEvent("onactivate", function() 
	{ 
		buy_pass_bot_button_mid.SetPanelEvent("onactivate", function() {})
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name : "dota_plus_3"});
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
		Game.EmitSound("UI.Shop_Buy")
		buy_panel.RemoveClass("buy_pass_panel")
		buy_panel.AddClass("buy_pass_panel_hide")
		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
		})
	})

	buy_pass_bot_button_right.SetPanelEvent("onactivate", function() 
	{ 
		buy_pass_bot_button_right.SetPanelEvent("onactivate", function() {})
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name:  "dota_plus_6"});
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
		Game.EmitSound("UI.Shop_Buy")
		buy_panel.RemoveClass("buy_pass_panel")
		buy_panel.AddClass("buy_pass_panel_hide")
		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
		})
	})

	buy_pass_close_button.SetPanelEvent("onactivate", function() 
	{ 
		buy_panel.RemoveClass("buy_pass_panel")
		buy_panel.AddClass("buy_pass_panel_hide")
		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
		})
		Game.EmitSound("UI.Shop_Category_Open")
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
	})

	blur_panel.SetPanelEvent("onactivate", function() 
	{ 	
		buy_panel.RemoveClass("buy_pass_panel")
		buy_panel.AddClass("buy_pass_panel_hide")
		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
		})
		Game.EmitSound("UI.Shop_Category_Open")
		blur_panel.SetPanelEvent("onactivate", function() {})
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
	})
}


