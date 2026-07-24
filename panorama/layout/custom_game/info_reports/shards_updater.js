--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function OpenBuyCurrency()
{
    let data = PLAYER_SERVER_DATA
    let lang = $.Localize("#lang")
	let active_sale = 0
    if (lang != "rus")
    {
    	active_sale = 0
    }
    if (!data?.total_games || data.total_games < max_games && lang !== "rus") 
    {
        return;
    }

	let main = $.GetContextPanel().FindChildTraverse("window_shop")
	Game.EmitSound("UI.Shop_Buy_start")

	let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
	blur_panel.RemoveClass("shop_window_blur_hidden")
	blur_panel.AddClass("shop_window_blur")

	let currency_panel_buying = $.CreatePanel("Panel", main, "currency_panel_buying")
	currency_panel_buying.AddClass("currency_panel_buying")
	currency_panel_buying.hittest = true
	currency_panel_buying.SetPanelEvent("onactivate", function() {})

	let closebuy = $.CreatePanel("Panel", currency_panel_buying, "")
	closebuy.AddClass("closebuy")

	blur_panel.SetPanelEvent("onactivate", function() 
	{	
		if (currency_panel_buying)
		{
			currency_panel_buying.RemoveClass("currency_panel_buying")
			currency_panel_buying.AddClass("currency_panel_buying_hide")
			$.Schedule( 0.35, function()
			{
				currency_panel_buying.DeleteAsync(0)
			})
			Game.EmitSound("UI.Shop_Category_Open")
			blur_panel.AddClass("shop_window_blur_hidden")
			blur_panel.RemoveClass("shop_window_blur")
		}
	});

	closebuy.SetPanelEvent("onactivate", function() 
	{	
		if (currency_panel_buying)
		{
			currency_panel_buying.RemoveClass("currency_panel_buying")
			currency_panel_buying.AddClass("currency_panel_buying_hide")
			$.Schedule( 0.35, function()
			{
				currency_panel_buying.DeleteAsync(0)
			})
			Game.EmitSound("UI.Shop_Category_Open")
			blur_panel.AddClass("shop_window_blur_hidden")
			blur_panel.RemoveClass("shop_window_blur")
		}
	});

	let label_header = $.CreatePanel("Label", currency_panel_buying, "")
	label_header.AddClass("label_header")
	label_header.text = $.Localize("#shop_buy_shards")

	let label_mid = $.CreatePanel("Label", currency_panel_buying, "")
	label_mid.AddClass("label_mid")
	label_mid.html = true;
	label_mid.text = $.Localize("#shop_buy_shards_text")

	if (active_shard_sale == true)
	{
		let label_sale = $.CreatePanel("Label", currency_panel_buying, "")
		label_sale.AddClass("label_sale")
		label_sale.html = true;
		label_sale.text = $.Localize("#buy_shards_sale_big_50")
	}

	let block_with_choose = $.CreatePanel("Panel", currency_panel_buying, "")
	block_with_choose.AddClass("block_with_choose")

	let choose_1 = $.CreatePanel("Panel", block_with_choose, "")
	choose_1.AddClass("choose_block")

	let ShardIconCurrencyBuy = $.CreatePanel("Panel", choose_1, "")
	ShardIconCurrencyBuy.AddClass("ShardIconCurrencyBuy")
	ShardIconCurrencyBuy.style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_5.png")';
	ShardIconCurrencyBuy.style.backgroundSize = "contain";

	let ShardNameCurrencyBuy = $.CreatePanel("Label", choose_1, "")
	ShardNameCurrencyBuy.AddClass("ShardNameCurrencyBuy")
	ShardNameCurrencyBuy.text = $.Localize("#shop_buy_shards_1")

	let BuyButtonSiteURL = $.CreatePanel("Panel", choose_1, "");
	BuyButtonSiteURL.AddClass("BuyButtonSiteURL")

	choose_1.SetPanelEvent("onactivate", function() 
    {
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "shards_2"});	
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
		Game.EmitSound("UI.Shop_Buy")
		currency_panel_buying.RemoveClass("currency_panel_buying")
		currency_panel_buying.AddClass("currency_panel_buying_hide")
		$.Schedule( 0.35, function()
		{
			currency_panel_buying.DeleteAsync(0)
		})
	})

	let BuyButtonSiteURLLabel = $.CreatePanel("Label", BuyButtonSiteURL, "")
	BuyButtonSiteURLLabel.AddClass("BuyButtonSiteURLLabel")
	BuyButtonSiteURLLabel.text = $.Localize("#shop_buy_shards_1_button")

	let choose_2 = $.CreatePanel("Panel", block_with_choose, "")
	choose_2.AddClass("choose_block")

	let ShardIconCurrencyBuy_2 = $.CreatePanel("Panel", choose_2, "")
	ShardIconCurrencyBuy_2.AddClass("ShardIconCurrencyBuy")
	ShardIconCurrencyBuy_2.style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_11.png")';
	ShardIconCurrencyBuy_2.style.backgroundSize = "contain";

	let ShardIconCurrencyBuy_2_sale = $.CreatePanel("Panel", ShardIconCurrencyBuy_2, "")
	ShardIconCurrencyBuy_2_sale.AddClass("ShardIconCurrencyBuy_sale")

	let ShardIconCurrencyBuy_2_sale_text = $.CreatePanel("Label", ShardIconCurrencyBuy_2_sale, "")
	ShardIconCurrencyBuy_2_sale_text.AddClass("ShardIconCurrencyBuy_sale_text")
	ShardIconCurrencyBuy_2_sale_text.text = $.Localize("#shop_buy_shards_2_sale")

	let ShardNameCurrencyBuy_2 = $.CreatePanel("Label", choose_2, "")
	ShardNameCurrencyBuy_2.AddClass("ShardNameCurrencyBuy")
	ShardNameCurrencyBuy_2.text = $.Localize("#shop_buy_shards_2")

	let BuyButtonSiteURL_2 = $.CreatePanel("Panel", choose_2, "");
	BuyButtonSiteURL_2.AddClass("BuyButtonSiteURL")

	choose_2.SetPanelEvent("onactivate", function() 
    {
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "shards_10"});	
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
		Game.EmitSound("UI.Shop_Buy")
		currency_panel_buying.RemoveClass("currency_panel_buying")
		currency_panel_buying.AddClass("currency_panel_buying_hide")
		$.Schedule( 0.35, function()
		{
			currency_panel_buying.DeleteAsync(0)
		})
	})

	let BuyButtonSiteURLLabel_2 = $.CreatePanel("Label", BuyButtonSiteURL_2, "")
	BuyButtonSiteURLLabel_2.AddClass("BuyButtonSiteURLLabel")
	BuyButtonSiteURLLabel_2.text = $.Localize("#shop_buy_shards_2_button")

	let choose_3 = $.CreatePanel("Panel", block_with_choose, "")
	choose_3.AddClass("choose_block")

	let ShardIconCurrencyBuy_3 = $.CreatePanel("Panel", choose_3, "")
	ShardIconCurrencyBuy_3.AddClass("ShardIconCurrencyBuy")
	ShardIconCurrencyBuy_3.style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_24.png")';
	ShardIconCurrencyBuy_3.style.backgroundSize = "contain";

	let ShardIconCurrencyBuy_3_sale = $.CreatePanel("Panel", ShardIconCurrencyBuy_3, "")
	ShardIconCurrencyBuy_3_sale.AddClass("ShardIconCurrencyBuy_sale")

	let ShardIconCurrencyBuy_3_sale_text = $.CreatePanel("Label", ShardIconCurrencyBuy_3_sale, "")
	ShardIconCurrencyBuy_3_sale_text.AddClass("ShardIconCurrencyBuy_sale_text")
	ShardIconCurrencyBuy_3_sale_text.text = $.Localize("#shop_buy_shards_3_sale")

	let ShardNameCurrencyBuy_3 = $.CreatePanel("Label", choose_3, "")
	ShardNameCurrencyBuy_3.AddClass("ShardNameCurrencyBuy")
	ShardNameCurrencyBuy_3.text = $.Localize("#shop_buy_shards_3")

	let BuyButtonSiteURL_3 = $.CreatePanel("Panel", choose_3, "");
	BuyButtonSiteURL_3.AddClass("BuyButtonSiteURL")

	choose_3.SetPanelEvent("onactivate", function() 
    {
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "shards_35"});	
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
		Game.EmitSound("UI.Shop_Buy")
		currency_panel_buying.RemoveClass("currency_panel_buying")
		currency_panel_buying.AddClass("currency_panel_buying_hide")
		$.Schedule( 0.35, function()
		{
			currency_panel_buying.DeleteAsync(0)
		})
	})

	let BuyButtonSiteURLLabel_3 = $.CreatePanel("Label", BuyButtonSiteURL_3, "")
	BuyButtonSiteURLLabel_3.AddClass("BuyButtonSiteURLLabel")
	BuyButtonSiteURLLabel_3.text = $.Localize("#shop_buy_shards_3_button")

	let choose_4 = $.CreatePanel("Panel", block_with_choose, "")
	choose_4.AddClass("choose_block")

	let ShardIconCurrencyBuy_4 = $.CreatePanel("Panel", choose_4, "")
	ShardIconCurrencyBuy_4.AddClass("ShardIconCurrencyBuy")
	ShardIconCurrencyBuy_4.style.backgroundImage = 'url("file://{images}/econ/tools/bp_2022_treasure_crimson.png")';
	ShardIconCurrencyBuy_4.style.backgroundSize = "contain";

	let ShardIconCurrencyBuy_4_sale = $.CreatePanel("Panel", ShardIconCurrencyBuy_4, "")
	ShardIconCurrencyBuy_4_sale.AddClass("ShardIconCurrencyBuy_sale")

	let ShardIconCurrencyBuy_4_sale_text = $.CreatePanel("Label", ShardIconCurrencyBuy_4_sale, "")
	ShardIconCurrencyBuy_4_sale_text.AddClass("ShardIconCurrencyBuy_sale_text")
	ShardIconCurrencyBuy_4_sale_text.text = $.Localize("#shop_buy_shards_4_sale")

	let ShardNameCurrencyBuy_4 = $.CreatePanel("Label", choose_4, "")
	ShardNameCurrencyBuy_4.AddClass("ShardNameCurrencyBuy")
	ShardNameCurrencyBuy_4.text = $.Localize("#shop_buy_shards_4")

	let BuyButtonSiteURL_4 = $.CreatePanel("Panel", choose_4, "");
	BuyButtonSiteURL_4.AddClass("BuyButtonSiteURL")

	choose_4.SetPanelEvent("onactivate", function() 
    {
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "shards_100"});	
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
		Game.EmitSound("UI.Shop_Buy")
		currency_panel_buying.RemoveClass("currency_panel_buying")
		currency_panel_buying.AddClass("currency_panel_buying_hide")
		$.Schedule( 0.35, function()
		{
			currency_panel_buying.DeleteAsync(0)
		})
	})

	let BuyButtonSiteURLLabel_4 = $.CreatePanel("Label", BuyButtonSiteURL_4, "")
	BuyButtonSiteURLLabel_4.AddClass("BuyButtonSiteURLLabel")
	BuyButtonSiteURLLabel_4.text = $.Localize("#shop_buy_shards_4_button")

	if (active_shard_sale == true)
	{
		let ShardIconCurrencyBuy_1_sale = $.CreatePanel("Panel", ShardIconCurrencyBuy, "")
		ShardIconCurrencyBuy_1_sale.AddClass("ShardIconCurrencyBuy_sale")

		let ShardIconCurrencyBuy_1_sale_text = $.CreatePanel("Label", ShardIconCurrencyBuy_1_sale, "")
		ShardIconCurrencyBuy_1_sale_text.AddClass("ShardIconCurrencyBuy_sale_text")
		ShardIconCurrencyBuy_1_sale_text.text = $.Localize("#buy_shards_sale_small_50")
		ShardIconCurrencyBuy_2_sale_text.text = $.Localize("#buy_shards_sale_small_50")
		ShardIconCurrencyBuy_3_sale_text.text = $.Localize("#buy_shards_sale_small_50")
		ShardIconCurrencyBuy_4_sale_text.text = $.Localize("#buy_shards_sale_small_50")

		BuyButtonSiteURLLabel.text = $.Localize("#shop_buy_shards_1_button_sale")
		BuyButtonSiteURLLabel_2.text = $.Localize("#shop_buy_shards_2_button_sale")
		BuyButtonSiteURLLabel_3.text = $.Localize("#shop_buy_shards_3_button_sale")
		BuyButtonSiteURLLabel_4.text = $.Localize("#shop_buy_shards_4_button_sale")

		BuyButtonSiteURLLabel.RemoveClass("BuyButtonSiteURLLabel")
		BuyButtonSiteURLLabel_2.RemoveClass("BuyButtonSiteURLLabel")
		BuyButtonSiteURLLabel_3.RemoveClass("BuyButtonSiteURLLabel")
		BuyButtonSiteURLLabel_4.RemoveClass("BuyButtonSiteURLLabel")

		BuyButtonSiteURLLabel.AddClass("ShardIconCurrencyBuy_block_text_new")
		BuyButtonSiteURLLabel_2.AddClass("ShardIconCurrencyBuy_block_text_new")
		BuyButtonSiteURLLabel_3.AddClass("ShardIconCurrencyBuy_block_text_new")
		BuyButtonSiteURLLabel_4.AddClass("ShardIconCurrencyBuy_block_text_new")

		let sale_block_1 = $.CreatePanel("Panel", BuyButtonSiteURL, "")
		sale_block_1.AddClass("ShardIconCurrencyBuy_block")

		let BuyButtonSiteURLLabel_1_old = $.CreatePanel("Label", sale_block_1, "")
		BuyButtonSiteURLLabel_1_old.AddClass("ShardIconCurrencyBuy_block_text")
		BuyButtonSiteURLLabel_1_old.text = $.Localize("#shop_buy_shards_1_button_sale_old")

		let sale_block_1_line = $.CreatePanel("Panel", sale_block_1, "")
		sale_block_1_line.AddClass("ShardIconCurrencyBuy_sale_line")

		let sale_block_2 = $.CreatePanel("Panel", BuyButtonSiteURL_2, "")
		sale_block_2.AddClass("ShardIconCurrencyBuy_block")

		let BuyButtonSiteURLLabel_2_old = $.CreatePanel("Label", sale_block_2, "")
		BuyButtonSiteURLLabel_2_old.AddClass("ShardIconCurrencyBuy_block_text")
		BuyButtonSiteURLLabel_2_old.text = $.Localize("#shop_buy_shards_2_button_sale_old")

		let sale_block_2_line = $.CreatePanel("Panel", sale_block_2, "")
		sale_block_2_line.AddClass("ShardIconCurrencyBuy_sale_line")

		let sale_block_3 = $.CreatePanel("Panel", BuyButtonSiteURL_3, "")
		sale_block_3.AddClass("ShardIconCurrencyBuy_block")

		let BuyButtonSiteURLLabel_3_old = $.CreatePanel("Label", sale_block_3, "")
		BuyButtonSiteURLLabel_3_old.AddClass("ShardIconCurrencyBuy_block_text")
		BuyButtonSiteURLLabel_3_old.text = $.Localize("#shop_buy_shards_3_button_sale_old")

		let sale_block_3_line = $.CreatePanel("Panel", sale_block_3, "")
		sale_block_3_line.AddClass("ShardIconCurrencyBuy_sale_line")

		let sale_block_4 = $.CreatePanel("Panel", BuyButtonSiteURL_4, "")
		sale_block_4.AddClass("ShardIconCurrencyBuy_block")

		let BuyButtonSiteURLLabel_4_old = $.CreatePanel("Label", sale_block_4, "")
		BuyButtonSiteURLLabel_4_old.AddClass("ShardIconCurrencyBuy_block_text")
		BuyButtonSiteURLLabel_4_old.text = $.Localize("#shop_buy_shards_4_button_sale_old")

		let sale_block_4_line = $.CreatePanel("Panel", sale_block_4, "")
		sale_block_4_line.AddClass("ShardIconCurrencyBuy_sale_line")
	}
}

function CheckShards()
{
	let main = $.GetContextPanel().FindChildTraverse("window_shop")
	if ((main) && (main.BHasClass("shop_window_show")))
	{
		UpdateShards()
	}
}

function UpdateShards()
{
	var player_data_local = player_table_shop;
	let points_label = $.GetContextPanel().FindChildTraverse("CurrencyNumber")
    if ($("#CrystalLabelSelection"))
    {
        points_label = $("#CrystalLabelSelection")
    }
	if (points_label)
	{
		points_label.text = player_data_local["points"]
        if (player_data_local.subscribed == 0 && player_data_local.points >= 500)
        {
            points_label.AddClass("CurrencyNumber_limit")
            points_label.text =  player_data_local["points"] + '/500'
        }
        else
        {
            points_label.RemoveClass("CurrencyNumber_limit")
        }
	}
	UpdateBonusShards()	
}

function UpdateBonusShards()
{
	let main = $.GetContextPanel().FindChildTraverse("BonusCurrencyButton")
	var sub_data = player_table_shop;
	if (main)
	{
		let text = ''
		let active = 0
		if (sub_data.bonus_shards_cd > 0)
		{
			active = 0
			let cd = Math.max(1, Math.floor(sub_data.bonus_shards_cd/3600))
			let s = "#vote_free_cd_hour"
			if (cd == 1)
			{
				s = "#vote_free_cd_hour_2"
			}
			text = $.Localize("#bonus_shards_notactive") + String(cd) + $.Localize(s)
		}
        else
		{
			active = 1
			text = $.Localize("#bonus_shards_active")
		}
		main.SetPanelEvent('onmouseover', function() 
		{
		   	$.DispatchEvent('DOTAShowTextTooltip', main, text) 
		});
		main.SetPanelEvent('onmouseout', function() 
		{
		   $.DispatchEvent('DOTAHideTextTooltip', main);
		});
		if (active == 0)
		{
			main.AddClass("BonusCurrencyButton_notactive")
			main.RemoveClass("BonusCurrencyButton_active")
			main.SetPanelEvent("onactivate", function() {});
		}
        else
		{
			main.AddClass("BonusCurrencyButton_active")
			main.RemoveClass("BonusCurrencyButton_notactive")

			main.SetPanelEvent("onactivate", function() {OpenBonusShards()});
		}
	}
}

function OpenBonusShards()
{
	let main = $.GetContextPanel().FindChildTraverse("window_shop")
	Game.EmitSound("UI.Shop_Buy_start")

	let buy_panel = $.CreatePanel("Panel", main, "bonus_shards_panel")
	buy_panel.AddClass("bonus_shards_panel")

	let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
	blur_panel.RemoveClass("shop_window_blur_hidden")
	blur_panel.AddClass("shop_window_blur")
	
	let bonus_panel_top = $.CreatePanel("Panel", buy_panel, "")
	bonus_panel_top.AddClass("bonus_panel_top")

	let bonus_panel_top_text = $.CreatePanel("Label", bonus_panel_top, "")
	bonus_panel_top_text.AddClass("bonus_panel_top_text")
	bonus_panel_top_text.text = $.Localize("#bonus_panel_top")

	let closebuy = $.CreatePanel("Panel", bonus_panel_top, "")
	closebuy.AddClass("bonus_panel_close")

	let bonus_panel_mid = $.CreatePanel("Panel", buy_panel, "bonus_shards_panel_mid")
	bonus_panel_mid.AddClass("bonus_panel_mid")

	let bonus_panel_amount = $.CreatePanel("Label", bonus_panel_mid, "bonus_panel_amount")
	bonus_panel_amount.AddClass("bonus_panel_amount")
	bonus_panel_amount.text = '+0'

	let bonus_panel_max = $.CreatePanel("Label", bonus_panel_mid, "bonus_panel_max")
	bonus_panel_max.AddClass("bonus_panel_max")

	bonus_panel_max.html = true
	bonus_panel_max.text = $.Localize("#bonus_shards_random")

	let bonus_panel_icon = $.CreatePanel("Panel", bonus_panel_mid, "")
	bonus_panel_icon.AddClass("bonus_panel_icon")

	GameEvents.SendCustomGameEventToServer_custom( "get_bonus_shards", {});

	$.Schedule( 0.25, function()
	{
		UpdateBonusShards()
	});

	blur_panel.SetPanelEvent("onactivate", function() 
	{ 
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
		buy_panel.AddClass("bonus_shards_panel_hide")
		buy_panel.RemoveClass("bonus_shards_panel")
		UpdateShards()
		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
		})
		if (sound != null)
		{
			Game.StopSound(sound)
		}
		if (sound != -1)
		{
		
			Game.EmitSound("Sub.Points_end")
		}
		Game.EmitSound("UI.Shop_Category_Open")
		blur_panel.SetPanelEvent("onactivate", function() {})
	})
}

function give_bonus_shards(kv)
{
	AddBonusShards(0, kv.count, kv.limit)
	if (kv.count > 0)
	{	
		sound = Game.EmitSound("Sub.Points_inc")
	}
}

function AddBonusShards(current, max, limit)
{
	var panel = $.GetContextPanel().FindChildTraverse("bonus_panel_amount")
	if (panel)
	{
		var text = current + 1
		if (max == 0)
		{
			text = 0
		}
		panel.text = '+' + String(text)
		if (text < max)
		{
			$.Schedule(0.04, function ()
			{
				AddBonusShards(text, max, limit)
			})
		}
        else
		{
			if (limit == 1)
			{
				let bonus_panel_max = $.GetContextPanel().FindChildTraverse("bonus_panel_max")
				bonus_panel_max.text = $.Localize("#bonus_shards_max")
			}
			if (sound != null)
			{
				Game.StopSound(sound)
				Game.EmitSound("Sub.Points_end")
				sound = -1
			}
		}
	}
}

function OpenGiftWindow()
{
	Game.EmitSound("UI.Shop_Buy_start")
	GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "gift"});	
}