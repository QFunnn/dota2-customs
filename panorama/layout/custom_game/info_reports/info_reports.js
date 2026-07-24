--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
if ($.GetContextPanel() && parentHUDElements)
{
    if ($.GetContextPanel().GetParent().id != "CustomUIContainer_PregameStrategy")
    {
        $.GetContextPanel().SetParent(parentHUDElements);
    }
}

var PLAYER_VIEW_ITEMS_FOR_BUY = true
var QUEST_BLUR = true
var courier_selected = null;
var active_sale = 0;
var active_sale_global = 0;
var active_sale_heroes = {}
var selected_category = "tips"
var items_cooldown = {}
var current_shop_hero_choose
var Hero_1 = null
var Hero_2 = null
var chat_select_active = false
var first_time = false
var chosen_label = 0
var cd = false 
var sound = null
var FIRST_INIT_STORE = false

function select_shop_button(panel, button)
{
	if (panel == "shop_window_1")
	{
        let shop_window_1 = $.GetContextPanel().FindChildTraverse("shop_window_1")
        if (shop_window_1)
        {
            shop_window_1.ScrollToTop()
        }
	}
    
	if (panel == "shop_window_2")
	{
		let GeneralHeroInformation = $.GetContextPanel().FindChildTraverse("GeneralHeroInformation")
		if (GeneralHeroInformation)
		{
			GeneralHeroInformation.style.visibility = "collapse"
		}
		let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroList")
		if (heroes_panel)
		{
			heroes_panel.style.visibility = "visible"
		}
	}

	if (panel == "shop_window_3")
	{
		$("#ChooseCategory").style.visibility = "visible"
		$("#CategoryPets").style.visibility = "collapse"
		$("#CategoryItems").style.visibility = "collapse"
        $("#CategoryCosmetics").style.visibility = "collapse"
        $("#CategoryChest").style.visibility = "collapse"
        $("#CategoryEffects").style.visibility = "collapse"
	}

    let shop_window_buttons_content = $.GetContextPanel().FindChildTraverse("shop_window_buttons_content")
    for (let child of shop_window_buttons_content.Children())
    {
        child.SetHasClass("activate", false)
    }

    for (var i = 1; i <= WINDOWS_MAX_COUNTER; i++)
    {
        let child = $.GetContextPanel().FindChildTraverse("shop_window_"+i)
        if (child)
        {
            child.style.visibility = "collapse"
        }
    }

	$.GetContextPanel().FindChildTraverse(button).SetHasClass("activate", true)
	$.GetContextPanel().FindChildTraverse(panel).style.visibility = "visible"
}

function init_shop()
{
    if (FIRST_INIT_STORE) { return }
    FIRST_INIT_STORE = true
    let inshop_button_sub = $.GetContextPanel().FindChildTraverse("inshop_button_sub")
    if (inshop_button_sub)
    {
        inshop_button_sub.SetPanelEvent("onactivate", function() 
        {	
            Game.EmitSound("UI.Shop_Main_Button")
		    select_shop_button("shop_window_1", "inshop_button_sub")
		    CloseActiveChatBlock()
        });
    }
    let inshop_button_heroes = $.GetContextPanel().FindChildTraverse("inshop_button_heroes")
    if (inshop_button_heroes)
    {
        inshop_button_heroes.SetPanelEvent("onactivate", function() 
        {
            Game.EmitSound("UI.Shop_Main_Button")
            InitHeroes()
            select_shop_button("shop_window_2", "inshop_button_heroes")
            CloseActiveChatBlock()
        });
    }
    let inshop_button_items = $.GetContextPanel().FindChildTraverse("inshop_button_items")
    if (inshop_button_items)
    {
        inshop_button_items.SetPanelEvent("onactivate", function() 
        {
            Game.EmitSound("UI.Shop_Main_Button")
            if (typeof selected_effect_category !== "undefined")
            {
                selected_effect_category = null
            }
            InitItems()
            InitSale()
            select_shop_button("shop_window_3", "inshop_button_items")
            CloseActiveChatBlock()
        });
    }
    let inshop_button_chat = $.GetContextPanel().FindChildTraverse("inshop_button_chat")
    if (inshop_button_chat)
    {
        inshop_button_chat.SetPanelEvent("onactivate", function() 
        {
            Game.EmitSound("UI.Shop_Main_Button")
            InitSounds()
            select_shop_button("shop_window_4", "inshop_button_chat")
            CloseActiveChatBlock()
        });
    }
    let inshop_button_vote = $.GetContextPanel().FindChildTraverse("inshop_button_vote")
    if (inshop_button_vote)
    {
        inshop_button_vote.SetPanelEvent("onactivate", function() 
        {
            Game.EmitSound("UI.Click")
            select_shop_button("shop_window_6", "inshop_button_vote")
            CloseActiveChatBlock()
            InitVote()
        });
    }

    let shop_window_blur_selected_set = $.GetContextPanel().FindChildTraverse("shop_window_blur_selected_set")
    if (shop_window_blur_selected_set)
    {
        shop_window_blur_selected_set.AddClass("shop_window_blur_hidden")
        shop_window_blur_selected_set.RemoveClass("shop_window_blur_sets")
    }

    let shop_window_blur = $.GetContextPanel().FindChildTraverse("shop_window_blur")
    if (shop_window_blur)
    {
        shop_window_blur.AddClass("shop_window_blur_hidden")
        shop_window_blur.RemoveClass("shop_window_blur")
    }

    InitHeroes()
	InitItems()
	InitSounds()
	UpdateShards()
}

GameUI.CustomUIConfig().OpenShop = function Shop_window_show()
{
    if (cd) { return }
    Game.EmitSound("UI.Shop_Open")
    UpdateShards()	
	cd = true
	var button_shard = $.GetContextPanel().FindChildTraverse("BuyCurrencyButton")
	var button_shard_bot = $.GetContextPanel().FindChildTraverse("ButtonBuySubscribe_bot")
	var button_sub = $.GetContextPanel().FindChildTraverse("ButtonBuySubscribe")
    let data = PLAYER_SERVER_DATA
    let lang = $.Localize("#lang")
    var gift_button = $.GetContextPanel().FindChildTraverse("GiftButton")
    var info_button = $.GetContextPanel().FindChildTraverse("info_button")
	var leaderbord_button = $.GetContextPanel().FindChildTraverse("leaderbord_button")
	var shop_button = $.GetContextPanel().FindChildTraverse("shop_button")
	var info_window = $.GetContextPanel().FindChildTraverse("window_info")
	var leaderbord_window = $.GetContextPanel().FindChildTraverse("leaderbord_window")
	var window_shop = $.GetContextPanel().FindChildTraverse("window_shop")
    if (gift_button)
    {
        gift_button.SetHasClass("inshop_button_hidden", lang != "rus")
    }
    if ((data && data.total_games && data.total_games >= max_games) || lang == "rus")
    {
        button_shard.RemoveClass("BuyCurrencyButton_not")
        button_shard.AddClass("BuyCurrencyButton")
        button_sub.RemoveClass("ButtonBuySubscribe_not")
        button_sub.AddClass("ButtonBuySubscribe")
        button_shard_bot.RemoveClass("ButtonBuySubscribe_bot_not")
        button_shard_bot.AddClass("ButtonBuySubscribe_bot")
    }
    else
    {
        button_shard.AddClass("BuyCurrencyButton_not")
        button_shard.RemoveClass("BuyCurrencyButton")
        button_sub.AddClass("ButtonBuySubscribe_not")
        button_sub.RemoveClass("ButtonBuySubscribe")
        button_shard_bot.AddClass("ButtonBuySubscribe_bot_not")
        button_shard_bot.RemoveClass("ButtonBuySubscribe_bot")
    }
    if (info_window.BHasClass("info_window_show"))
    {
        info_window.RemoveClass("info_window_show")
        info_window.AddClass("info_window_hidden")
        info_button.SetPanelEvent("onactivate", function() 
        {	
            Info_window_show()
        });
    }
    if (leaderbord_window.BHasClass("leaderbord_window_show"))
    {
        leaderbord_window.RemoveClass("leaderbord_window_show")
        leaderbord_window.AddClass("leaderbord_window_hidden")
        leaderbord_button.SetPanelEvent("onactivate", function() 
        {	
            leaderbord_window_show()
        });
    }
	info_button.RemoveClass("button_active")
	leaderbord_button.RemoveClass("button_active")
	shop_button.AddClass("button_active")
	window_shop.RemoveClass("shop_window_hidden")
	window_shop.AddClass("shop_window_show")
    shop_button.SetPanelEvent("onactivate", function() 
    {	
        Shop_window_hide()
    });
	init_shop()
    CheckShards()
    $.Schedule(0.5, function () { cd = false })
}

function Shop_window_hide()
{
    if (cd) { return }
	cd = true
	Game.EmitSound("UI.Shop_Close")
	var info_button = $.GetContextPanel().FindChildTraverse("info_button")
	var leaderbord_button = $.GetContextPanel().FindChildTraverse("leaderbord_button")
	var shop_button = $.GetContextPanel().FindChildTraverse("shop_button")
	var info_window = $.GetContextPanel().FindChildTraverse("window_info")
	var leaderbord_window = $.GetContextPanel().FindChildTraverse("leaderbord_window")
	var shop_window = $.GetContextPanel().FindChildTraverse("window_shop")
	shop_window.RemoveClass("shop_window_show")
	shop_window.AddClass("shop_window_hidden")
	shop_button.RemoveClass("button_active")
	CloseActiveChatBlock()
    shop_button.SetPanelEvent("onactivate", function() 
    {	
        GameUI.CustomUIConfig().OpenShop()
    });
	$.Schedule(0.5, function() { cd = false })
}

function OpenItemsContent(panel)
{
    $("#ChooseCategory").style.visibility = "collapse"
    $("#CategoryPets").style.visibility = "collapse"
    $("#CategoryItems").style.visibility = "collapse"
    $("#CategoryCosmetics").style.visibility = "collapse"
    $("#ItemsList").style.visibility = "collapse"
    $("#CategoryChest").style.visibility = "collapse"
    $("#CategoryEffects").style.visibility = "collapse"
    $("#HeroListItems").style.visibility = "visible"
    $.GetContextPanel().FindChildTraverse(panel).style.visibility = "visible"
    Game.EmitSound("UI.Shop_Category_Open")
}

GameUI.CustomUIConfig().OpenChestWindow = OpenChestWindow
function OpenChestWindow()
{
	InitItems()
    InitSale()
	select_shop_button("shop_window_3", "inshop_button_items")
	CloseActiveChatBlock()
    OpenItemsContent('CategoryChest');
}

function show_new_shop_heroes(kv)
{
    let data = PLAYER_SERVER_DATA
    let lang = $.Localize("#lang")
    if (!data?.total_games || data.total_games < max_games && lang !== "rus") 
    {
        return;
    }

    let active_vote_show = $.GetContextPanel().FindChildTraverse("active_vote_show")
    active_vote_show.RemoveClass("active_vote_show_hidden")
    active_vote_show.AddClass("active_vote_show")

    let active_vote_top_text = $.GetContextPanel().FindChildTraverse("active_vote_top_text")
    active_vote_top_text.text = $.Localize("#active_new_shop_heroes")

    let sale = $.GetContextPanel().FindChildTraverse("active_vote_sale") 

    let icons = $.GetContextPanel().FindChildTraverse("active_vote_bot_icons")
    icons.style.width = String(50 * max) + "px"

    let bot_text = $.GetContextPanel().FindChildTraverse("active_vote_bot_text_label")
    bot_text.html = true
    bot_text.text = $.Localize("#active_giga_sale")

    let max = Object.keys(kv.heroes).length

    if (kv.sale == 1)
    {
        sale.AddClass("active_vote_sale_visible")
        active_sale = 1
        active_sale_heroes = kv.heroes
    }
    for (var i = 1; i <= max; i++) 
    {
        var icon = $.CreatePanel("Panel", icons, "icon" + i)
        if (icon)
        {
	        icon.AddClass("active_vote_bot_icon")
	        icon.style.backgroundImage = "url('file://{images}/heroes/icons/" + String(kv.heroes[i]) + ".png')"
	        icon.style.backgroundSize = "contain"
	        icon.style.backgroundRepeat = 'no-repeat'
	    }
    }
    $.Schedule(12, function ()
    {
        active_vote_show.AddClass("active_vote_show_hidden")
        active_vote_show.RemoveClass("active_vote_show")
    })
}



function show_sale_alert(kv)
{
    let data = PLAYER_SERVER_DATA
    let lang = $.Localize("#lang")

    if (lang !== "rus")
        return

    if (!data?.total_games || data.total_games < max_games) 
    {
        return;
    }

    let main = $.GetContextPanel().FindChildTraverse("active_sale_shards_panel")
    main.RemoveClass("active_sale_shards_panel_hidden")
    main.AddClass("active_sale_shards_panel_show")

    let active_vote_top_text = $.GetContextPanel().FindChildTraverse("active_sale_shards_top_text")
    let bot_text = $.GetContextPanel().FindChildTraverse("active_sale_shards_bot_text")

    let sale_type = kv.sale_type
    if (sale_type == 0)
    {
        active_shard_sale = true
        bot_text.text = $.Localize("#active_sale_shards_bot_text")
        active_vote_top_text.text = $.Localize("#active_sale_shards_top_text")

        let shop_panel = $("#shard_sale_active")
        shop_panel.RemoveClass("shard_sale_active_hidden")
    }else
    {
        active_sub_sale = true
        bot_text.text = $.Localize("#active_sale_sub_bot_text")
        active_vote_top_text.text = $.Localize("#active_sale_sub_top_text")    

        let shop_panel = $("#sub_sale_active")
        shop_panel.RemoveClass("shard_sale_active_hidden")
    }

    $.Schedule(10, function ()
    {
        main.RemoveClass("active_sale_shards_panel_show")
        main.AddClass("active_sale_shards_panel_hide")

        $.Schedule(0.2, function()
        {
          main.AddClass("active_sale_shards_panel_hidden")
        })
    })
}



function show_active_vote()
{
    let data = PLAYER_SERVER_DATA
    let lang = $.Localize("#lang")
    if (!data?.total_games || data.total_games < max_games && lang !== "rus") 
    {
        return;
    }
	let main = $.GetContextPanel().FindChildTraverse("active_sale_panel")
	main.RemoveClass("active_sale_panel_hidden")
	main.AddClass("active_sale_panel_show")
	var heroes_to_vote = CustomNetTables.GetTableValue("sub_data", "heroes_vote").vote_table;
	for (var i = 1; i <= Object.keys(heroes_to_vote).length; i++) 
	{
		var icon = $.GetContextPanel().FindChildTraverse("active_vote_icon_" + String(i))
		icon.style.backgroundImage = "url('file://{images}/heroes/icons/" + String(heroes_to_vote[i][1]) + ".png')"
		icon.style.backgroundSize = "contain"
		icon.style.backgroundRepeat = 'no-repeat'
	}
	$.Schedule(12, function ()
	{
        main.RemoveClass("active_sale_panel_show")
        main.AddClass("active_sale_panel_hide")

        $.Schedule(0.3, function()
		{
          main.AddClass("active_sale_panel_hidden")
        })
	})
}

function InitSale()
{
    let last_panel = $.GetContextPanel().FindChildTraverse("active_sale_panel")
    if (last_panel)
    {
        last_panel.DeleteAsync(0)
    }
    if (active_sale == 0 && active_sale_global == 0)
    {
       return
    }
    let main = $.GetContextPanel().FindChildTraverse('shop_window_header_shop')
    if (active_sale_global == 1)
    {
        let panel = $.CreatePanel("Panel", main, "active_sale_panel");
        panel.AddClass("active_sale_global_panel")
        let top = $.CreatePanel("Panel", panel, "");
        top.AddClass("active_sale_top")
        let bot = $.CreatePanel("Panel", panel, "");
        bot.AddClass("active_sale_bot")
        let text = $.CreatePanel("Label", top, "");
        text.AddClass("active_sale_text")
        text.html = true
        text.text = $.Localize("#global_sale_shop")
        let text_bot = $.CreatePanel("Label", bot, "");
        text_bot.AddClass("active_sale_text_bot")
        text_bot.html = true
        text_bot.text = $.Localize("#global_sale_shop_bot")
        return
    }
    let panel = $.CreatePanel("Panel", main, "active_sale_panel");
    panel.AddClass("active_sale_panel")
    let top = $.CreatePanel("Panel", panel, "");
    top.AddClass("active_sale_top")
    let bot = $.CreatePanel("Panel", panel, "");
    bot.AddClass("active_sale_bot")
    let bot_icons = $.CreatePanel("Panel", bot, "");
    bot_icons.AddClass("active_sale_bot_icons")
    let text = $.CreatePanel("Label", top, "");
    text.AddClass("active_sale_text")
    text.html = true
    text.text = $.Localize("#active_sale_panel")
    for (var i = 1; i <= Object.keys(active_sale_heroes).length; i++) 
    {
        let icon = $.CreatePanel("Panel", bot_icons, "");
        icon.AddClass("active_sale_icon")
        icon.style.backgroundImage = "url('file://{images}/heroes/icons/" + String(active_sale_heroes[i]) + ".png')"
        icon.style.backgroundSize = "contain"
        icon.style.backgroundRepeat = 'no-repeat'
    }
}