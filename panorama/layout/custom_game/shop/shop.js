--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// shop variables
var first_time = false;
var PROMO_COOLDOWN = false
var timer_loading = -1
var current_tab
var current_tab_shop = "ShopMenuButtonPlus"
var PLAYER_DATA = Game.GetCustomTable("woda_player_data", String(Players.GetLocalPlayer()));
var OTHER_PLAYER_DATA = {}
var video_preview = null
var inventory_render_schedule = -1
var inventory_render_token = 0
var inventory_items_initialized = false
var INVENTORY_RENDER_CHUNK_SIZE = 25
var inventory_items_map_cache = null
var items_counter_cache = {}
var profile_items_percent_cache = null
var rune_spin_in_progress = false
var rune_pending_result = null
var rune_spin_timeout = -1
var rune_equip_update_pending = false
var RUNE_SPIN_COST = 1000
var RUNE_MAX_LEVEL = 3
var RUNE_MAX_EQUIPPED = 3
var RUNE_ROULETTE_VIEWPORT_WIDTH = 1100
var RUNE_ROULETTE_ITEM_WIDTH = 104
var RUNE_ROULETTE_ITEM_MARGIN_LEFT = -4
var RUNE_ROULETTE_ITEM_STEP = 112
// votes variables
var HERO_VOTES_TABLE_MAX_COUNT = 450000 // max count votes

if (Game.GetMapInfo().map_display_name != "arena")
{
    $("#DonateButtonRunes").visible = false
}

Game.SubscribeCustomTableListener("woda_player_data", UpdatePlayerData );
function UpdatePlayerData(table, key, data) 
{
	if (table == "woda_player_data")
	{
        if (key == String(Players.GetLocalPlayer()) || key == Players.GetLocalPlayer())
        {
            PLAYER_DATA = data;
            ResetItemsProgressCache()
            if ($("#DonateShopWindow").BHasClass("setvisible"))
            {
                if (current_tab == "ProfileWindow")
                {
                    InitData()
                }
                else if (current_tab == "HeroesWindow")
                {
                    InitHeroes()
                }
                else if (current_tab == "ShopWindow")
                {
                    InitItems()
                }
                else if (current_tab == "InventoryWindow")
                {
                    InitInventory()
                }
                else if (current_tab == "HeroVotesWindow")
                {
                    InitHeroVotes()
                }
                else if (current_tab == "RunesWindow")
                {
                    if (rune_equip_update_pending)
                    {
                        rune_equip_update_pending = false
                        RefreshRunesVisualOnly()
                    }
                    else if (!rune_spin_in_progress)
                    {
                        RefreshRunesListOnly()
                        UpdateRuneSpinButton()
                    }
                }
                else
                {
                    InitData()
                    InitHeroes()
                    InitItems()
                    InitInventory()
                    InitHeroVotes()
                    InitRunes()
                }
            }
            if ($("#HeroVotesWindowMain").BHasClass("setvisible"))
            {
                InitHeroVotes()
            }
            UpdateTopData()
            UpdateStoreBackground()
        }
	}
}

function ToggleDonateButton(tab, button) 
{
    if (!first_time)
    {
        first_time = true;
        InitShopMenu()
        InitData()
        UpdateStoreBackground()
        SwitchTab(tab, button)
    }
    if (current_tab != tab)
    {
        SwitchTab(tab, button)
        $("#DonateShopWindow").SetHasClass("setvisible", true)
    }
    else
    {
        $("#DonateShopWindow").SetHasClass("setvisible", !$("#DonateShopWindow").BHasClass("setvisible"))
        if (!$("#DonateShopWindow").BHasClass("setvisible"))
        {
            GameEvents.SendCustomGameEventToServer_custom( "update_player_items_list_server", {} );
        }
    }
    if (GameUI.CustomUIConfig().CloseWPlusGlobal)
    {
        GameUI.CustomUIConfig().CloseWPlusGlobal()
    }
    if (GameUI.CustomUIConfig().CloseBattlePassGlobal)
    {
        GameUI.CustomUIConfig().CloseBattlePassGlobal()
    }
    $("#HeroVotesWindowMain").SetHasClass("setvisible", false)
    UpdatePlayerCoinBase()
}

function OpenHeroVotesPanel() 
{
    $("#HeroVotesWindowMain").SetHasClass("setvisible", !$("#HeroVotesWindowMain").BHasClass("setvisible"))
    UpdateTopData()
    InitData()
    InitHeroVotes()
    $("#DonateShopWindow").SetHasClass("setvisible", false)
    if (GameUI.CustomUIConfig().CloseWPlusGlobal)
    {
        GameUI.CustomUIConfig().CloseWPlusGlobal()
    }
    if (GameUI.CustomUIConfig().CloseBattlePassGlobal)
    {
        GameUI.CustomUIConfig().CloseBattlePassGlobal()
    }
}

function ToggleDonateButtonClose() 
{
    $("#DonateShopWindow").SetHasClass("setvisible", false)
    GameEvents.SendCustomGameEventToServer_custom( "update_player_items_list_server", {} );
    $("#HeroVotesWindowMain").SetHasClass("setvisible", false)
}

GameUI.CustomUIConfig().CloseShopGlobal = ToggleDonateButtonClose

function InitData()
{
    var localplayer_data = PLAYER_DATA;
    if (localplayer_data)
    {
        $("#LocalRatingBig").text = "Rating: " + String(localplayer_data.rating)
        $("#LocalPveRatingBig").text = "Arena: " + String(localplayer_data.pve_rating)
        $("#CoinsBuyCount").text = String(localplayer_data.coins)
        $("#WodaPlusTime").text = String(localplayer_data.plus_days)
        $("#CoinLabelCount").text = String(localplayer_data.coins)
        $("#WodaplusLabelCount").text = String(localplayer_data.plus_days)
        $("#YourDotaID").text = $.Localize("#your_gameid") + " " + localplayer_data.steamid
        $("#BattlePassLabelCount").text = String(localplayer_data.battlepass_level_2026)
        $("#DoubleTokensLabelCount").text = String(localplayer_data.double_tokens)
        InitPlayerStats(localplayer_data)
        if (localplayer_data.games >= 1 || Game.IsInToolsMode())
        {
            if ($("#ShopMenuButtonCurrency"))
            {
                $("#ShopMenuButtonCurrency").style.visibility = "visible"
            }
            $("#CoinsBuyPlusBB").style.visibility = "visible"
            $("#WodaBuyPlusBB").style.visibility = "visible"
            
        }
        let items_collection_percent = GetPercentItemsInProfile()
        $("#ItemsCollectionLiner").style.width = items_collection_percent + "%"
        $("#ItemsCollectionPercent").text = items_collection_percent + "%"
    }

    UpdateFreeReward()
    SetTextInfo($("#CoinBlock"), "coin_information")
    SetTextInfo($("#WodaplusBlock"), "subscribe_information")
    SetTextInfo($("#BattlePassBlock"), "battlepass_information")
    SetTextInfo($("#DoubleTokensBlock"), "double_tokens_information")
    SetTextInfo($("#CoinBlockHeroVotes"), "coin_information")
    SetTextInfo($("#WodaplusBlockHeroVotes"), "subscribe_information")
    SetTextInfo($("#BattlePassBlockHeroVotes"), "battlepass_information")
    SetTextInfo($("#DoubleTokensBlockHeroVotes"), "double_tokens_information")
}

function UpdateTopData()
{
    var localplayer_data = PLAYER_DATA;
    if (localplayer_data)
    {
        $("#CoinsBuyCount").text = String(localplayer_data.coins)
        $("#WodaPlusTime").text = String(localplayer_data.plus_days)
        $("#BattlePassLabelCount").text = String(localplayer_data.battlepass_level_2026)
        $("#DoubleTokensLabelCount").text = String(localplayer_data.double_tokens)

        $("#CoinLabelCountHeroVotes").text = String(localplayer_data.coins)
        $("#WodaplusLabelCountHeroVotes").text = String(localplayer_data.plus_days)
        $("#BattlePassLabelCountHeroVotes").text = String(localplayer_data.battlepass_level_2026)
        $("#DoubleTokensLabelCountHeroVotes").text = String(localplayer_data.double_tokens)
    }
}

GameUI.CustomUIConfig().GoToSiteStore = function()
{
    var localplayer_data = PLAYER_DATA;
    if (localplayer_data.games >= 1 || Game.IsInToolsMode())
    {
        $("#ChoosePayMethode").SetHasClass("IsOpacity", false)
        //$.DispatchEvent('ExternalBrowserGoToURL', 'https://shop.world-of-dota.com/ru-RU');
    }
}

function PaymentClose()
{
    $("#ChoosePayMethode").SetHasClass("IsOpacity", true)
}

function RequestUrl(xsolla)
{
    if (xsolla)
    {
        $.DispatchEvent('ExternalBrowserGoToURL', 'https://shop.world-of-dota.com/ru-RU');
    }
    else
    {
        $.DispatchEvent('ExternalBrowserGoToURL', 'https://funpay.com/users/19824830/');
    }
}

// Обновление бесплатной награды
function UpdateFreeReward(fast)
{
    let panel = $("#FreeReward")
    if (fast)
    {
        panel.SetHasClass("free_reward_accepted", true)
        panel.SetHasClass("GetReward", false)
        panel.SetPanelEvent("onactivate", function() {} );
    } 
    else 
    {
        var localplayer_data = PLAYER_DATA;
        if (localplayer_data)
        {
            if (localplayer_data.free_reward == 1)
            {
                panel.SetHasClass("free_reward_accepted", true)
                panel.SetHasClass("GetReward", false)
                panel.SetPanelEvent("onactivate", function() {} );
            } 
            else 
            {
                panel.SetHasClass("free_reward_accepted", false)
                panel.SetHasClass("GetReward", true)
                panel.SetPanelEvent("onactivate", function() 
                { 
                    GetFreeReward()
                });
            }
        }
    }
    CheckoutEveryReward(true)
    $.Schedule( 0.5, function()
    {
        CheckoutEveryReward()
    })
}

function GetFreeReward()
{
    LoadingCreated()
    GameEvents.SendCustomGameEventToServer_custom( "donate_shop_get_free_reward", {} );
    UpdateFreeReward(true)
    $.Schedule( 0.5, function()
    {
        UpdateFreeReward()
    })
}

function InitShopMenu()
{
    let ShopMenu = $("#ShopMenu")
    for (menu_id in SHOP_BUTTONS_CATEGORY)
    {
        let menu_info = SHOP_BUTTONS_CATEGORY[menu_id]
        CreateMenuButton(ShopMenu, menu_info)
    }
}

function CreateMenuButton(parent, info)
{
    let ShopMenuButton = $.CreatePanel("Panel", parent, info[0])
    ShopMenuButton.AddClass("ShopMenuButton")
    if (info[2] != null)
    {
        ShopMenuButton.AddClass(info[2])
    }
    let ShopMenuButtonLabel = $.CreatePanel("Label", ShopMenuButton, "")
    ShopMenuButtonLabel.AddClass("ShopMenuButtonLabel")
    ShopMenuButtonLabel.text = $.Localize("#"+info[1])
    if (info[0] == "ShopMenuButtonCurrency")
    {
        ShopMenuButton.SetPanelEvent("onactivate", function() 
        { 
            GameUI.CustomUIConfig().GoToSiteStore()
        });
    }
    else
    {
        ShopMenuButton.SetPanelEvent("onactivate", function() 
        { 
            SwitchTabShop(info[0])
        });
    }
}

function SwitchTabShop(button) 
{
    if (current_tab_shop != button)
    {
        Game.EmitSound("ui_topmenu_select")
    }
    for (menu_panel of $("#ShopMenu").Children())
    {
        menu_panel.SetHasClass( "DonateNewMenuButtonSelected", false );
    }
    current_tab_shop = button
    $("#" + button).SetHasClass( "DonateNewMenuButtonSelected", true );
    InitItems()
    $('#ShopItemsWindow').ScrollToTop()
}

function SwitchTab(tab, button) 
{
    if (current_tab != tab)
    {
        Game.EmitSound("ui_topmenu_select")
    }

    current_tab = tab

    // collapse panels
    $("#ProfileWindow").style.visibility = "collapse";
    $("#HeroesWindow").style.visibility = "collapse";
    $("#ShopWindow").style.visibility = "collapse";
    $("#InventoryWindow").style.visibility = "collapse";
    $("#RunesWindow").style.visibility = "collapse";

    // styles
    $("#MenuProfie").SetHasClass( "DonateNewMenuButtonSelected2", false );
    $("#MenuHeroes").SetHasClass( "DonateNewMenuButtonSelected2", false );
    $("#MenuShop").SetHasClass( "DonateNewMenuButtonSelected2", false );
    $("#MenuInventory").SetHasClass( "DonateNewMenuButtonSelected2", false );
    $("#MenuRunes").SetHasClass( "DonateNewMenuButtonSelected2", false );

    if (tab == "ProfileWindow")
    {
        InitData()
    }
    else if (tab == "HeroesWindow")
    {
        InitHeroes()
    }
    else if (tab == "ShopWindow")
    {
        InitItems()
    }
    else if (tab == "InventoryWindow")
    {
        InitInventory()
    }
    else if (tab == "RunesWindow")
    {
        InitRunes()
    }
    else if (tab == "HeroVotesWindow")
    {
        
    }

    $("#" + button).SetHasClass( "DonateNewMenuButtonSelected2", true );
    $("#" + tab).style.visibility = "visible";
}

function InitItems() 
{
    let table_items = Items_plus
    let updater = false
    $('#ShopItemsWindow').RemoveAndDeleteChildren()
    if (current_tab_shop == "ShopMenuButtonPets")
    {
        table_items = Items_pets
        updater = true
    }
    if (current_tab_shop == "ShopMenuButtonEmblems")
    {
        table_items = Items_emblems
        updater = true
    }
    if (current_tab_shop == "ShopMenuButtonTips")
    {
        table_items = Items_tips
        updater = true
    }
    if (current_tab_shop == "ShopMenuButtonFive")
    {
        table_items = Items_Five
        updater = true
    }
    if (current_tab_shop == "ShopMenuButtonBG")
    {
        table_items = Items_Backround
        updater = true
    }
    if (current_tab_shop == "ShopMenuButtonTeleport")
    {
        table_items = Items_tpscroll
        updater = true
    }
    let how_much_items = HowMuchItemsInTab(table_items)
    if (!updater)
    {
        $("#ShopInfoBuyItemsCounter").text = ""
    }
    else
    {
        $("#ShopInfoBuyItemsCounter").text = how_much_items[1] + " / " + how_much_items[0]
    }
    for (var i = 0; i < table_items.length; i++) 
    {
        CreateItemInShop($('#ShopItemsWindow'), table_items, i)
    } 
}

function CreateItemInShop(panel, table, i) 
{
    if (table[i][0] == "subscribe_plus_1" || table[i][0] == "battle_pass_1")
    {
        let close_item = true
        if (PLAYER_DATA && (PLAYER_DATA.games >= 1 || Game.IsInToolsMode()))
        {
            close_item = false
        }
        if (close_item) { return }
    }

    if (table[i][5] && !Game.IsInToolsMode()) { return }

    var Recom_item = $.CreatePanel("Panel", panel, "");
    Recom_item.AddClass("ItemShop");

    var ItemImage = $.CreatePanel("Panel", Recom_item, "");
    ItemImage.AddClass("ItemImage");

    if (table[i][4].indexOf("pet_") !== 0) 
    {
        ItemImage.style.backgroundImage = 'url("file://{images}/custom_game/shop/' + table[i][3] + '.png")';
        ItemImage.style.backgroundSize = "100%"
    }
    else
    {
        ItemImage.style.backgroundImage = 'url("file://{images}/custom_game/shop/' + table[i][0] + '.png")';
        ItemImage.style.backgroundSize = "100%"
    }

    var ItemName = $.CreatePanel("Label", Recom_item, "ItemName");
    ItemName.AddClass("ItemName");
    ItemName.text = $.Localize( "#" + table[i][4] )

    var BuyItemPanel = $.CreatePanel("Panel", Recom_item, "BuyItemPanel");
    BuyItemPanel.AddClass("BuyItemPanel");

    var ItemPrice = $.CreatePanel("Panel", BuyItemPanel, "ItemPrice");
    ItemPrice.AddClass("ItemPrice");

    if (table[i][1] != "")
    {
        var PriceIcon = $.CreatePanel("Panel", ItemPrice, "PriceIcon");
    }

    var PriceLabel = $.CreatePanel("Label", ItemPrice, "PriceLabel");
    PriceLabel.AddClass("PriceLabel");

    if (HasItemInventory(table[i][0]))
    {
        Recom_item.SetPanelEvent("onactivate", function() {} );
        BuyItemPanel.style.saturation = "0"
        PriceLabel.text = $.Localize( "#shop_bought" )
        if (PriceIcon)
        {
            PriceIcon.DeleteAsync( 0 );
        } 
    }
    else
    {
        if (table[i][0] == "subscribe_plus_1" || table[i][0] == "battle_pass_1")
        {
            PriceLabel.text = $.Localize("#donate_button_leaderboard")
            Recom_item.SetPanelEvent("onactivate", function() 
            { 
                GameUI.CustomUIConfig().GoToSiteStore()
            });
        }
        else if (table[i][0] == "rune_chest_item")
        {
            PriceLabel.text = $.Localize("#donate_button_leaderboard")
            Recom_item.SetPanelEvent("onactivate", function() 
            {
                SwitchTab('RunesWindow', 'MenuRunes') 
            });
        }
        else
        {
            PriceIcon.AddClass("PriceIcon" + table[i][1]);
            PriceLabel.text = $.Localize(table[i][2])
            SetItemBuyFunction(Recom_item, table[i])
        }
    }
}

function SetItemBuyFunction(panel, item_info, no_buy)
{
    panel.SetPanelEvent("onactivate", function() 
    {
        $("#BuyItemPanelInfo").RemoveAndDeleteChildren()
        $("#BuyItemPanelName").text = $.Localize( "#" + item_info[4] )

        var ItemImage = $.CreatePanel("Panel", $("#BuyItemPanelInfo"), "");
        ItemImage.AddClass("ItemImageBuy");

        if (item_info[4].indexOf("background") === 0)
        {
            ItemImage.style.backgroundImage = 'url("' + Background_Images[item_info[0]] + '")';
            ItemImage.style.backgroundSize = "100%"
        }
        else if (item_info[4].indexOf("emblem_") === 0 || item_info[4].indexOf("five_") === 0 || item_info[4].indexOf("tp_effect") === 0)
        {
            ItemImage.style.backgroundImage = 'url("file://{images}/custom_game/shop/' + item_info[3] + '_open.png")';
            ItemImage.style.backgroundSize = "100%"
            video_preview = $.CreatePanel("MoviePanel", ItemImage, "ItemPreview", { 
                src: "file://{resources}/videos/shop/" + item_info[3] + "_open.webm", 
                repeat:"true", 
                autoplay:"onload",
                style:"width: 100%;height: 100%;z-index:-1; opacity:1;transition-property:opacity;transition-duration:0.3s;saturation:1;brightness:1;" 
            });
        }
        else if (item_info[4].indexOf("pet_") !== 0) 
        {
            ItemImage.style.backgroundImage = 'url("file://{images}/custom_game/shop/' + item_info[3] + '_open.png")';
            ItemImage.style.backgroundSize = "100%"
        }
        else
        {
            ItemImage.style.backgroundImage = 'url("file://{images}/custom_game/shop/' + item_info[0] + '_open.png")';
            ItemImage.style.backgroundSize = "100%"
        }

        $("#BuyItemPanelMain").SetHasClass("ProfileBGPreview", item_info[4].indexOf("background") == 0 || item_info[4].indexOf("emblem_") == 0 || item_info[4].indexOf("five_") == 0 || item_info[4].indexOf("tp_effect") == 0);

        var ItemInfoAndBuyButton = $.CreatePanel("Panel", $("#BuyItemPanelInfo"), "");
        ItemInfoAndBuyButton.AddClass("ItemInfoAndBuyButton");

        var ItemDescription = $.CreatePanel("Label", ItemInfoAndBuyButton, "");
        ItemDescription.html = true
        ItemDescription.AddClass("ItemDescription");
        ItemDescription.text = $.Localize( "#" + item_info[4]+"_description" )
        ItemDescription.html = true

        if (!no_buy)
        {
            var button_buy_item = $.CreatePanel("Panel", ItemInfoAndBuyButton, "");
            button_buy_item.AddClass("button_buy_item");

            var button_buy_item_center = $.CreatePanel("Panel", button_buy_item, "");
            button_buy_item_center.AddClass("button_buy_item_center");

            var button_buy_item_label = $.CreatePanel("Label", button_buy_item_center, "");
            button_buy_item_label.AddClass("button_buy_item_label");
            button_buy_item_label.text = String(item_info[2])

            var valuteicon = $.CreatePanel("Panel", button_buy_item_center, "");
            valuteicon.AddClass("valuteicon");
            valuteicon.style.backgroundImage = 'url("file://{images}/custom_game/shop/woda' + item_info[1] + '.png")';
            valuteicon.style.backgroundSize = "100%"

            button_buy_item.SetPanelEvent("onactivate", function()
            {
                BuyItemToServer(item_info);
                CloseBuyItemPanel(); 
            });
        }

        $("#BuyItemPanelMain").style.visibility = "visible"
    }); 
}

GameUI.CustomUIConfig().OpenCheckoutItemPreview = SetItemBuyFunction

function CloseBuyItemPanel()
{
    $("#BuyItemPanelMain").style.visibility = "collapse"
    if (video_preview)
    {
        video_preview.DeleteAsync(0)
        video_preview = null
    }
}

function BuyItemToServer(item_info)
{
    var player_table = PLAYER_DATA
    if (player_table)
    {
        if ((typeof player_table.coins !== 'undefined'))
        {
            if (item_info[1] == "crystal") 
            {
                GameEvents.SendCustomGameEventToServer_custom( "donate_shop_buy_item", {item_id : item_info[0], price : item_info[2], currency : item_info[1], } );
                LoadingCreated()
            }
            else if (item_info[1] == "coin") 
            {
                GameEvents.SendCustomGameEventToServer_custom( "donate_shop_buy_item", {item_id : item_info[0], price : item_info[2], currency : item_info[1], } );
                LoadingCreated()
            }
        }
    }
}

/////////////////////////////////
///// Герои
////////////////////////////////

function InitHeroes()
{
    let table_heroes = Game.GetCustomTable("custom_pick", "hero_list")
    let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroesWindow")

    const hero_names_sorted = [...Object.keys(table_heroes)].sort()

    let heroes_strength = []
    let heroes_agility = []
    let heroes_intellect = []
    let heroes_all = []

    for (const hero_name of hero_names_sorted)
    {
        if (table_heroes[hero_name] == 0)
        {
            heroes_strength.push(hero_name)
        } else if (table_heroes[hero_name] == 1) {
            heroes_agility.push(hero_name)
        } else if (table_heroes[hero_name] == 2) {
            heroes_intellect.push(hero_name)
        } else if (table_heroes[hero_name] == 3) {
            heroes_all.push(hero_name)
        }
    }

    if (heroes_panel)
    {
        heroes_panel.RemoveAndDeleteChildren()

        let attribute_info = $.CreatePanel("Panel", heroes_panel, "");
        attribute_info.AddClass("attribute_info")
    
        let hero_icon_str = $.CreatePanel("Panel", attribute_info, "");
        hero_icon_str.AddClass("hero_icon_str")
    
        let hero_label_str = $.CreatePanel("Label", attribute_info, "");
        hero_label_str.AddClass("hero_label_str")
        hero_label_str.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_str")

        const str_row = $.CreatePanel("Panel", heroes_panel, "StrengthHeroes");

        let attribute_info_2 = $.CreatePanel("Panel", heroes_panel, "");
        attribute_info_2.AddClass("attribute_info")
    
        let hero_icon_agi = $.CreatePanel("Panel", attribute_info_2, "");
        hero_icon_agi.AddClass("hero_icon_agi")
    
        let hero_label_agi = $.CreatePanel("Label", attribute_info_2, "");
        hero_label_agi.AddClass("hero_label_agi")
        hero_label_agi.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_agi")

        const agi_row = $.CreatePanel("Panel", heroes_panel, "AgilityHeroes");

        let attribute_info_3 = $.CreatePanel("Panel", heroes_panel, "");
        attribute_info_3.AddClass("attribute_info")
    
        let hero_icon_int = $.CreatePanel("Panel", attribute_info_3, "");
        hero_icon_int.AddClass("hero_icon_int")
    
        let hero_label_int = $.CreatePanel("Label", attribute_info_3, "");
        hero_label_int.AddClass("hero_label_int")
        hero_label_int.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_int")

        const int_row = $.CreatePanel("Panel", heroes_panel, "IntellectHeroes");

        let attribute_info_4 = $.CreatePanel("Panel", heroes_panel, "");
        attribute_info_4.AddClass("attribute_info")
    
        let hero_icon_all = $.CreatePanel("Panel", attribute_info_4, "");
        hero_icon_all.AddClass("hero_icon_all")

        let hero_label_all = $.CreatePanel("Label", attribute_info_4, "");
        hero_label_all.AddClass("hero_label_all")
        hero_label_all.text = $.Localize("#woda_universal")

        const all_row = $.CreatePanel("Panel", heroes_panel, "AllHeroes");

        for (var i = 0; i < Object.keys(heroes_strength).length; i++) 
        {
            CreateHeroPanel(str_row, heroes_strength[i])
        }

        for (var i = 0; i < Object.keys(heroes_agility).length; i++) 
        {
            CreateHeroPanel(agi_row, heroes_agility[i])
        }

        for (var i = 0; i < Object.keys(heroes_intellect).length; i++) 
        {
            CreateHeroPanel(int_row, heroes_intellect[i])
        }

        for (var i = 0; i < Object.keys(heroes_all).length; i++) 
        {
            CreateHeroPanel(all_row, heroes_all[i])
        }
    }
}

function CreateHeroPanel(panel, hero_name) {
    var HeroBuy = $.CreatePanel("Panel", panel, "");
    HeroBuy.AddClass("HeroBuy");
    var HeroImage = $.CreatePanel(`DOTAHeroImage`, HeroBuy, "", {scaling: "stretch-to-cover-preserve-aspect", heroname : String(hero_name), tabindex : "auto", class: "HeroPortrait", heroimagestyle : "portrait"});
    ShowHero(HeroBuy, hero_name) 
    if (GetHeroInformation(hero_name) != null) 
    {
        let info = GetHeroInformation(hero_name)
        let hero_lvl = GetLevelByCoins(info.coins)
        let hero_progress = info.coins - GetProgressByCoins22(hero_lvl)
        let hero_progress_max = GetProgressByCoins(hero_lvl + 1)
        let image_rank = $.CreatePanel("Panel", HeroBuy, "");
        image_rank.AddClass("image_rank");
        image_rank.style.backgroundImage = 'url("file://{images}/custom_game/hero_rank/' + GetHeroRankIcon(hero_lvl) + '.png")'
        image_rank.style.backgroundSize = "100%"
        HeroBuy.AddClass(GetHeroRankIcon(hero_lvl));

        SetTextInfo3(image_rank, $.Localize("#localize_rank_info") + "<br><br>" + $.Localize("#level_bonus_"+GetHeroRankIcon(hero_lvl)))

        let image_rank_number = $.CreatePanel("Label", image_rank, "");
        image_rank_number.AddClass("image_rank_number");
        if (hero_lvl > 0)
        {
            image_rank_number.text = hero_lvl
        }
        let rank_info = $.CreatePanel("Panel", HeroBuy, "rank_info");
        rank_info.AddClass("rank_info");

        let rank_info_content = $.CreatePanel("Panel", rank_info, "");
        rank_info_content.AddClass("rank_info_content");

        let rank_info_label = $.CreatePanel("Label", rank_info_content, "");
        rank_info_label.AddClass("rank_info_label");

        let rank_info_label2 = $.CreatePanel("Label", rank_info_content, "");
        rank_info_label2.AddClass("rank_info_label2");

        if (hero_lvl >= 30)
        {
            rank_info_label.text = ""
            rank_info_label2.visible = false
        } 
        else 
        {
            rank_info_label.text = hero_progress
            rank_info_label2.text = " / " + hero_progress_max
        }

        let hero_level_progress_bar = $.CreatePanel("Panel", HeroBuy, "");
        hero_level_progress_bar.AddClass("hero_level_progress_bar");

        let hero_level_progress_bar_fill = $.CreatePanel("Panel", hero_level_progress_bar, "");
        hero_level_progress_bar_fill.AddClass("hero_level_progress_bar_fill");
        if (hero_progress_max > 0 && hero_progress > 0)
        {
            hero_level_progress_bar_fill.style.width = (hero_progress / hero_progress_max) * 100 + "%";
        }
        else
        {
            hero_level_progress_bar_fill.style.width = "0%"
        }
        if (hero_lvl >= 30)
        {
            hero_level_progress_bar_fill.style.width = "100%"
        }
    }
    else
    {
        let hero_lvl = GetLevelByCoins(0)
        let hero_progress = 0 - GetProgressByCoins22(hero_lvl)
        let hero_progress_max = GetProgressByCoins(hero_lvl + 1)
        let image_rank = $.CreatePanel("Panel", HeroBuy, "");
        image_rank.AddClass("image_rank");
        image_rank.style.backgroundImage = 'url("file://{images}/custom_game/hero_rank/' + GetHeroRankIcon(hero_lvl) + '.png")'
        image_rank.style.backgroundSize = "100%"

        SetTextInfo3(image_rank, $.Localize("#localize_rank_info") + "<br><br>" + $.Localize("#level_bonus_"+GetHeroRankIcon(hero_lvl)))

        let image_rank_number = $.CreatePanel("Label", image_rank, "");
        image_rank_number.AddClass("image_rank_number");
        if (hero_lvl > 0)
        {
            image_rank_number.text = hero_lvl
        }
        let rank_info = $.CreatePanel("Panel", HeroBuy, "rank_info");
        rank_info.AddClass("rank_info");
        let rank_info_label = $.CreatePanel("Label", rank_info, "");
        rank_info_label.AddClass("rank_info_label");
        if (hero_lvl >= 30)
        {
            rank_info_label.text = ""
        } 
        else 
        {
            rank_info_label.text = hero_progress + " / " + hero_progress_max
        }

        let hero_level_progress_bar = $.CreatePanel("Panel", HeroBuy, "");
        hero_level_progress_bar.AddClass("hero_level_progress_bar");
        hero_level_progress_bar.AddClass(GetHeroRankIcon(hero_lvl));

        let hero_level_progress_bar_fill = $.CreatePanel("Panel", hero_level_progress_bar, "");
        hero_level_progress_bar_fill.AddClass("hero_level_progress_bar_fill");
        if (hero_progress_max > 0 && hero_progress > 0)
        {
            hero_level_progress_bar_fill.style.width = (hero_progress / hero_progress_max) * 100 + "%";
        }
        else
        {
            hero_level_progress_bar_fill.style.width = "0%"
        }
        if (hero_lvl >= 30)
        {
            hero_level_progress_bar_fill.style.width = "100%"
        }
    }
} 

function ShowHero(panel, hero, buy) 
{
    panel.SetPanelEvent('onmouseover', function() 
    {
        let vid = $.CreatePanel("MoviePanel", panel, 'portrait_' + hero, {
            class: "hero_portrait_hover",
            src: "file://{resources}/videos/heroes/" + hero + ".webm",
            repeat: "true",
            hittest: "false",
            autoplay: "onload"
        });
    });
    panel.SetPanelEvent('onmouseout', function() {
        var movie = panel.FindChild('portrait_' + hero + '')
        if (movie) 
        {
            movie.DeleteAsync(0)
        }
    })
}

/////////////////////////////////
///// Профиль
////////////////////////////////

function PromocodeUse()
{
    if (PROMO_COOLDOWN)
    {
        return
    }
    var promo = $("#PromoEntryID").text
    $("#PromoEntryID").text = ""
    PROMO_COOLDOWN = true
    $.Schedule( 2, function()
    {
        PROMO_COOLDOWN = false
    })
    if (promo == "") 
    {
        return
    }
    LoadingCreated()
    GameEvents.SendCustomGameEventToServer_custom( "donate_promocode", { promo : promo } );
}

function InitPlayerStats(data)
{
    $("#StatsGamesCount").text = $.Localize("#games_count") + data.games
    $("#StatsHoursCount").text = $.Localize("#hours_count") + Math.floor(data.game_time / 60)
    $("#TopTalentLabelSTR").text = data.talents_stats[1]
    $("#TopTalentLabelAGI").text = data.talents_stats[2]
    $("#TopTalentLabelINT").text = data.talents_stats[3]
    if (data.top_heroes)
    {
        for (var i = 1; i <= Object.keys(data.top_heroes).length; i++) 
        {
            $("#TopHeroStatsImage"+i).style.backgroundImage = "url('file://{images}/heroes/" + data.top_heroes[i].hero + ".png')"
            $("#TopHeroStatsImage"+i).style.backgroundSize = "100%"
            $("#TopHeroStatsGames"+i).text = data.top_heroes[i].games
        }
    }
    let full_place = 0
    if (data.place)
    {
        for (var i = 1; i <= Object.keys(data.place).length; i++) 
        {
            if (data.place[i] >= full_place)
            {
                full_place = data.place[i]
            }
        }
        if (full_place != 0)
        {
            $("#ColumnWinrate1").style.height = Math.max(Math.round((data.place[2] / full_place) * 100), 7) + "%"
            $("#ColumnWinrate2").style.height = Math.max(Math.round((data.place[3] / full_place) * 100), 7) + "%"
            $("#ColumnWinrate3").style.height = Math.max(Math.round((data.place[4] / full_place) * 100), 7) + "%"
            $("#ColumnWinrate4").style.height = Math.max(Math.round((data.place[5] / full_place) * 100), 7) + "%"
            $("#ColumnWinrate5").style.height = Math.max(Math.round((data.place[6] / full_place) * 100), 7) + "%"
            $("#ColumnWinrate6").style.height = Math.max(Math.round((data.place[7] / full_place) * 100), 7) + "%"
            $("#ColumnWinrate7").style.height = Math.max(Math.round((data.place[8] / full_place) * 100), 7) + "%"
            $("#ColumnWinrateleave").style.height = Math.max(Math.round((data.place[1] / full_place) * 100), 7) + "%"
    
            SetTextInfo2($("#ColumnWinrate1"), data.place[2] )
            SetTextInfo2($("#ColumnWinrate2"), data.place[3] )
            SetTextInfo2($("#ColumnWinrate3"), data.place[4] )
            SetTextInfo2($("#ColumnWinrate4"), data.place[5] )
            SetTextInfo2($("#ColumnWinrate5"), data.place[6] )
            SetTextInfo2($("#ColumnWinrate6"), data.place[7] )
            SetTextInfo2($("#ColumnWinrate7"), data.place[8] )
            SetTextInfo2($("#ColumnWinrateleave"), data.place[1] )
        }
    }

    let full_place_duo = 0
    if (data.place_duo)
    {
        for (var i = 1; i <= Object.keys(data.place_duo).length; i++) 
        {
            if (data.place_duo[i] >= full_place_duo)
            {
                full_place_duo = data.place_duo[i]
            }
        }
        if (full_place_duo != 0)
        {
            $("#ColumnWinrateDuo1").style.height = Math.max(Math.round((data.place_duo[2] / full_place_duo) * 100), 7) + "%"
            $("#ColumnWinrateDuo2").style.height = Math.max(Math.round((data.place_duo[3] / full_place_duo) * 100), 7) + "%"
            $("#ColumnWinrateDuo3").style.height = Math.max(Math.round((data.place_duo[4] / full_place_duo) * 100), 7) + "%"
            $("#ColumnWinrateDuo4").style.height = Math.max(Math.round((data.place_duo[5] / full_place_duo) * 100), 7) + "%"
            $("#ColumnWinrateDuoleave").style.height = Math.max(Math.round((data.place_duo[1] / full_place_duo) * 100), 7) + "%"
    
            SetTextInfo2($("#ColumnWinrateDuo1"), data.place_duo[2] )
            SetTextInfo2($("#ColumnWinrateDuo2"), data.place_duo[3] )
            SetTextInfo2($("#ColumnWinrateDuo3"), data.place_duo[4] )
            SetTextInfo2($("#ColumnWinrateDuo4"), data.place_duo[5] )
            SetTextInfo2($("#ColumnWinrateDuoleave"), data.place_duo[1] )
        }
    }
}

/////////////////////////////////
///// Голосование
////////////////////////////////

function InitHeroVotes()
{
    $("#HeroListVotes").RemoveAndDeleteChildren()
    GameEvents.SendCustomGameEventToServer_custom( "donate_shop_get_hero_votes", {} );
}

GameEvents.Subscribe_custom( 'donate_shop_set_hero_votes', donate_shop_set_hero_votes );
function donate_shop_set_hero_votes(data)
{
    let heroes_votes = data
    let heroes_table = GenerateTableVotes(heroes_votes)
    let heroesArray = [];
    for (let hero_id in HERO_VOTES_TABLE) 
    {
        let heroName = HERO_VOTES_TABLE[hero_id];
        heroesArray.push({name: heroName, votes: heroes_table[heroName] || 0});
    }
    heroesArray.sort((a, b) => b.votes - a.votes);
    for (let i = 0; i < heroesArray.length; i++) 
    {
        CreateHeroPanelVotes($("#HeroListVotes"), heroesArray[i].name, heroesArray[i].votes);
    }
}

function GenerateTableVotes(heroes_votes)
{
    let vot_table = {}
    for (var i = 0; i <= Object.keys(heroes_votes).length; i++) 
    {
        if (heroes_votes[i])
        {
            vot_table[heroes_votes[i].hero_name] = heroes_votes[i].votes
        }
    }
    return vot_table
}

function CreateHeroPanelVotes(panel, hero_name, votes) 
{
    var HeroVoteMainPanel = $.CreatePanel("Panel", panel, "");
    HeroVoteMainPanel.AddClass("HeroVotePanel");

    var HeroImage = $.CreatePanel(`DOTAHeroImage`, HeroVoteMainPanel, 'portrait_' + hero_name, {scaling: "stretch-to-cover-preserve-aspect", heroname : String(hero_name), tabindex : "auto", class: "hero_portrait_hover_votes", heroimagestyle : "portrait"});
    ShowHero(HeroImage, hero_name) 

    let panel_votes_count = $.CreatePanel("Panel", HeroVoteMainPanel, "");
    panel_votes_count.AddClass("panel_votes_count")

    let panel_votes_count_background = $.CreatePanel("Panel", panel_votes_count, "");
    panel_votes_count_background.AddClass("panel_votes_count_background")

    let panel_votes_count_frontground = $.CreatePanel("Panel", panel_votes_count, "");
    panel_votes_count_frontground.AddClass("panel_votes_count_frontground")

    let panel_votes_count_label = $.CreatePanel("Label", panel_votes_count, "");
    panel_votes_count_label.AddClass("panel_votes_count_label")
    panel_votes_count_label.text = votes + " / " + HERO_VOTES_TABLE_MAX_COUNT

    var percent = ((HERO_VOTES_TABLE_MAX_COUNT-votes )*100)/HERO_VOTES_TABLE_MAX_COUNT
    if (percent >= 0)
    {
        panel_votes_count_frontground.style['width'] = (100 - percent) +'%';
    } 
    else 
    {
        panel_votes_count_frontground.style['width'] = '0%';
    }

    let panel_votes_count_buy_votes = $.CreatePanel("Panel", HeroVoteMainPanel, "");
    let panel_votes_count_buy_votes_label = $.CreatePanel("Label", panel_votes_count_buy_votes, "");
    panel_votes_count_buy_votes_label.AddClass("panel_votes_count_buy_votes_label")

    if (votes < HERO_VOTES_TABLE_MAX_COUNT)
    {
        panel_votes_count_buy_votes_label.text = $.Localize("#hero_buy_vote")
        panel_votes_count_buy_votes.AddClass("panel_votes_count_buy_votes")
        CreateEventBuyHeroes(panel_votes_count_buy_votes, hero_name)
    } 
    else
    {
        panel_votes_count_buy_votes_label.text = $.Localize("#hero_in_work")
        panel_votes_count_buy_votes.AddClass("panel_votes_count_buy_votes_created")
    }
} 


function CreateEventBuyHeroes(panel, heroname)
{
    panel.SetPanelEvent("onactivate", function() 
    {
        OpenHeroBuy(heroname)
    }); 
}

function CloseBuyHeroPanel()
{
    $("#BuyHeroPanel").style.visibility = "collapse"
}

function OpenHeroBuy(heroname)
{   
    $("#HeroBuyInfo").RemoveAndDeleteChildren()

    $("#HeroNameBuy").text = $.Localize("#"+heroname)

    $.CreatePanel("MoviePanel", $("#HeroBuyInfo"), 'portrait_' + heroname, {class: "hero_portrait_buying",src: "file://{resources}/videos/heroes/" + heroname + ".webm",repeat: "true",hittest: "false",autoplay: "onload"});

    var hero_buy_info_all = $.CreatePanel("Panel", $("#HeroBuyInfo"), "");
    hero_buy_info_all.AddClass("hero_buy_info_all");

    var hero_buy_info_all_description = $.CreatePanel("Label", hero_buy_info_all, "");
    hero_buy_info_all_description.html = true
    hero_buy_info_all_description.AddClass("hero_buy_info_all_description");
    hero_buy_info_all_description.text = $.Localize("#hero_buy_info_all_description")
    
    var panel_votes_number = $.CreatePanel("Panel", hero_buy_info_all, "");
    panel_votes_number.AddClass("panel_votes_number");

    var button_buy_votes_panel = $.CreatePanel("Panel", panel_votes_number, "");
    button_buy_votes_panel.AddClass("button_buy_votes_panel");

    var button_buy_hero_label = $.CreatePanel("Label", button_buy_votes_panel, "");
    button_buy_hero_label.AddClass("button_buy_hero_label");
    button_buy_hero_label.text = $.Localize("#hero_buy_vote")

    let number_entry = $.CreatePanel(`NumberEntry`, panel_votes_number, "NumberEntryBuyVotes", {value : 1, min : 1, max : 50000});

    $("#BuyHeroPanel").style.visibility = "visible"

    button_buy_votes_panel.SetPanelEvent("onactivate", function() 
    {
        BuyVotesToHero(heroname, number_entry)
    }); 
}

function BuyVotesToHero(heroname, number_entry)
{
    var player_table = PLAYER_DATA
    let votes = 0
    if (number_entry)
	{
		let text_entry = number_entry.FindChildTraverse("TextEntry")
		if (text_entry)
		{
			votes = text_entry.text
		}
	}
    if (player_table)
    {
        GameEvents.SendCustomGameEventToServer_custom( "donate_shop_buy_hero_votes", {hero_name : heroname, votes : votes} );
        LoadingCreated()
    }
    CloseBuyHeroPanel()
    $.Schedule( 0.25, function()
    {
        InitHeroVotes()
    })
}

/////////////////////////////////
///// ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ
////////////////////////////////
function UpdatePlayerCoinBase()
{
    GameEvents.SendCustomGameEventToServer_custom( "web_update_player_coin_base", {});
}

function SetItemDescription(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, $.Localize("#" + text + "_description")); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function SetTextInfo(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, $.Localize("#" + text)); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function SetTextInfo2(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, $.Localize(text)); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function SetTextInfo3(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, text); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function SetTextInfoSeason(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, text); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function ErrorCreated(data) {
    Game.EmitSound("Relic.Received")

    if( timer_loading != -1 )
    {
        $.CancelScheduled(timer_loading)
    }

    LoadingClose()

    if (data && data.error_name)
    {
        $("#donate_error_label").text = $.Localize("#" + data.error_name)
    } else {
        $("#donate_error_label").text = $.Localize("#donate_shop_error")
    }

    $("#donate_error_window").style.visibility = "visible"

    $.Schedule(0.5, ErrorClose);
}

function ErrorClose() 
{
    $("#donate_error_window").style.visibility = "collapse"
}

function AcceptCreated(data)
{
    Game.EmitSound("ui.trophy_levelup")
    if ( timer_loading != -1 )
    {
        $.CancelScheduled(timer_loading)
    }
    LoadingClose()
    $("#donate_accept_window").style.visibility = "visible"
    $.Schedule(0.5, AcceptClose);
}

function AcceptClose()
{
    $("#donate_accept_window").style.visibility = "collapse"
}

function LoadingCreated()
{
    $("#donate_loading_window").style.visibility = "visible"
    timer_loading = $.Schedule(10 , LoadingClose);
}

function LoadingClose()
{
    $("#donate_loading_window").style.visibility = "collapse"
    timer_loading = -1;
}

function SetCurrency(data) 
{
    if (data) 
    {
        if (typeof data.coin !== 'undefined') 
        {
            $("#CoinLabelCount").text =  String(data.coin)   
        }
    }
}

function GetLevelByCoins(coins)
{
    let full_sum = 0
    let level_end = 30
    for (var cc = 0; cc <= Object.keys(levels).length; cc++) 
    {
        full_sum = full_sum + levels[cc]
        if (coins < full_sum)
        {
            level_end = cc - 1
            break
        }
    } 
    return level_end
}

function GetProgressByCoins(lvl) 
{
    if (levels[lvl])
    {
        return levels[lvl]
    }
    return levels[levels.length]
}

function GetProgressByCoins22(lvl) 
{
    let full_sum = 0
    for (var cc = 0; cc <= Object.keys(levels).length; cc++) {
        full_sum = full_sum + levels[cc]
        if (cc == lvl) 
        {
            return full_sum
        }
    }
}

function GetHeroInformation(hero) 
{
    let woda_player_data = PLAYER_DATA
    if (woda_player_data) 
    {
        for (var i = 1; i <= Object.keys(woda_player_data.heroes_level).length; i++) 
        {
            if (woda_player_data.heroes_level[i]["hero"] == hero) 
            {
                return woda_player_data.heroes_level[i]
            }
        }
    }
    return null
}

function GetHeroRankIcon(level) 
{
    if (level >= 30) 
    {
        return "rank_6"
    } else if (level >= 25) 
    {
        return "rank_5"
    } else if (level >= 18) 
    {
        return "rank_4"
    } else if (level >= 12) 
    {
        return "rank_3"
    } else if (level >= 6) 
    {
        return "rank_2"
    } else if (level >= 1) 
    {
        return "rank_1"
    } else 
    {
        return "rank_0"
    }
}

function HasItemInventory(item_id)
{
    var inventory_items_map = GetInventoryItemsMap()
    if (inventory_items_map[String(item_id)])
    {
        return true
    }
    // if (Game.IsInToolsMode())
    // {
    //     return true
    // }
	return false
}

function GetInventoryItemsMap()
{
    if (inventory_items_map_cache != null)
    {
        return inventory_items_map_cache
    }

    inventory_items_map_cache = {}
	if (PLAYER_DATA && PLAYER_DATA.donate_items)
	{
        for (var item_slot in PLAYER_DATA.donate_items)
        {
            if (PLAYER_DATA.donate_items[item_slot])
            {
                inventory_items_map_cache[String(PLAYER_DATA.donate_items[item_slot])] = true
            }
        }
	}
    return inventory_items_map_cache
}

function ResetItemsProgressCache()
{
    inventory_items_map_cache = null
    items_counter_cache = {}
    profile_items_percent_cache = null
}

GameEvents.Subscribe_custom( 'shop_error_notification', ErrorCreated );
GameEvents.Subscribe_custom( 'shop_accept_notification', AcceptCreated );
GameEvents.Subscribe_custom( 'shop_set_currency', SetCurrency );

function InitInventory()
{
    if (inventory_items_initialized)
    {
        RefreshInventoryItems()
        return
    }

    if (inventory_render_schedule != -1)
    {
        $.CancelScheduled(inventory_render_schedule)
        inventory_render_schedule = -1
    }

    inventory_render_token = inventory_render_token + 1
    var render_token = inventory_render_token
    var items_panel = $('#ItemsWindow')
    var inventory_items = []

    items_panel.RemoveAndDeleteChildren()

    AddItemsToInventoryRenderList(inventory_items, Items_pets, "Items_pets")
    AddItemsToInventoryRenderList(inventory_items, Items_Five, "Items_Five")
    AddItemsToInventoryRenderList(inventory_items, Items_emblems, "Items_emblems")
    AddItemsToInventoryRenderList(inventory_items, Items_tips, "Items_tips")
    AddItemsToInventoryRenderList(inventory_items, Items_Backround, "Items_Backround")
    AddItemsToInventoryRenderList(inventory_items, Items_tpscroll, "Items_tpscroll")

    CreateInventoryItemsChunk(items_panel, inventory_items, 0, render_token)
}

function AddItemsToInventoryRenderList(list, table, item_type)
{
    for (var i = 0; i < table.length; i++) 
    {
        list.push([table, i, item_type])
    }
}

function CreateInventoryItemsChunk(panel, items, index, render_token)
{
    if (render_token != inventory_render_token)
    {
        return
    }

    var limit = Math.min(index + INVENTORY_RENDER_CHUNK_SIZE, items.length)
    for (var i = index; i < limit; i++)
    {
        CreateItemInInventory(panel, items[i][0], items[i][1], items[i][2])
    }

    if (limit < items.length)
    {
        inventory_render_schedule = $.Schedule(0.01, function()
        {
            CreateInventoryItemsChunk(panel, items, limit, render_token)
        })
    }
    else
    {
        inventory_render_schedule = -1
        inventory_items_initialized = true
        RefreshInventoryItems()
    }
}

function RefreshInventoryItems()
{
    RefreshInventoryItemsFromTable($('#ItemsWindow'), Items_pets, "Items_pets")
    RefreshInventoryItemsFromTable($('#ItemsWindow'), Items_Five, "Items_Five")
    RefreshInventoryItemsFromTable($('#ItemsWindow'), Items_emblems, "Items_emblems")
    RefreshInventoryItemsFromTable($('#ItemsWindow'), Items_tips, "Items_tips")
    RefreshInventoryItemsFromTable($('#ItemsWindow'), Items_Backround, "Items_Backround")
    RefreshInventoryItemsFromTable($('#ItemsWindow'), Items_tpscroll, "Items_tpscroll")
}

function RefreshInventoryItemsFromTable(panel, table, item_type)
{
    for (var i = 0; i < table.length; i++)
    {
        var item_panel = panel.FindChild(GetInventoryItemPanelId(table[i][0]))
        if (ShouldShowInventoryItem(table[i][0]))
        {
            if (item_panel)
            {
                UpdateInventoryItemVisual(item_panel, table[i], item_type)
            }
            else
            {
                CreateItemInInventory(panel, table, i, item_type)
            }
        }
        else if (item_panel)
        {
            item_panel.DeleteAsync(0)
        }
    }
}

function GetInventoryItemPanelId(item_id)
{
    return "item_inventory_" + item_id
}

function ShouldShowInventoryItem(item_id)
{
    return HasItemInventory(item_id)
}

function CreateItemInInventory(panel, table, i, item_type) 
{
    if (!ShouldShowInventoryItem(table[i][0])) { return }

    var Recom_item = $.CreatePanel("Panel", panel, GetInventoryItemPanelId(table[i][0]));
    Recom_item.AddClass("ItemInventory");

    var ItemImage = $.CreatePanel("Panel", Recom_item, "");
    ItemImage.AddClass("ItemImage");

    if (item_type == "Items_pets")
    {
        ItemImage.style.backgroundImage = 'url("file://{images}/custom_game/shop/' + table[i][0] + '.png")';
    }
    else
    {
        ItemImage.style.backgroundImage = 'url("file://{images}/custom_game/shop/' + table[i][3] + '.png")';
    }

    ItemImage.style.backgroundSize = "100%"

    var ItemName = $.CreatePanel("Label", Recom_item, "ItemName");
    ItemName.AddClass("ItemName");
    ItemName.text = $.Localize( "#" + table[i][4] )

    var BuyItemPanel = $.CreatePanel("Panel", Recom_item, "BuyItemPanel");
    BuyItemPanel.AddClass("BuyItemPanel");

    var ItemPrice = $.CreatePanel("Panel", BuyItemPanel, "ItemPrice");
    ItemPrice.AddClass("ItemPrice");

    var PriceLabel = $.CreatePanel("Label", ItemPrice, "PriceLabel");
    PriceLabel.AddClass("PriceLabel");
    PriceLabel.text = $.Localize( "#shop_activate" )

    if (item_type == "Items_pets")
    {
        SetPetInventory(Recom_item, table[i])
    }
    else if (item_type == "Items_Five")
    {
        SetFiveInventory(Recom_item, table[i])
    }
    else if (item_type == "Items_emblems")
    {
        SetEmblemInventory(Recom_item, table[i])
    }
    else if (item_type == "Items_tips")
    {
        SetTipInventory(Recom_item, table[i])
    }
    else if (item_type == "Items_Backround")
    {
        SetBGInventory(Recom_item, table[i])
    }
    else if (item_type == "Items_tpscroll")
    {
        SetTpInventory(Recom_item, table[i])
    }

    UpdateInventoryItemVisual(Recom_item, table[i], item_type)
}

function UpdateInventoryItemVisual(panel, table, item_type)
{
    var BuyItemPanel = panel.FindChildTraverse("BuyItemPanel")
    var PriceLabel = panel.FindChildTraverse("PriceLabel")
    if (!BuyItemPanel || !PriceLabel)
    {
        return
    }

    BuyItemPanel.style.backgroundColor = "gradient(linear, 0% 0%, 0% 100%, from(#60862d), to(#3d5f1c))"
    PriceLabel.text = $.Localize( "#shop_activate" )

    if (IsInventoryItemActive(table[0], item_type))
    {
        BuyItemPanel.style.backgroundColor = "gradient( linear, 0% 0%, 0% 100%, from( #84302C ), to( #60321D ))"
        PriceLabel.text = $.Localize( "#shop_deactivate" )
    }
}

function IsInventoryItemActive(item_id, item_type)
{
    if (!PLAYER_DATA)
    {
        return false
    }
    if (item_type == "Items_pets")
    {
        return Number(PLAYER_DATA.pet_id) == Number(item_id)
    }
    if (item_type == "Items_Five")
    {
        return Number(PLAYER_DATA.five_id) == Number(item_id)
    }
    if (item_type == "Items_emblems")
    {
        return Number(PLAYER_DATA.effect_id) == Number(item_id)
    }
    if (item_type == "Items_Backround")
    {
        return Number(PLAYER_DATA.background_id) == Number(item_id)
    }
    if (item_type == "Items_tpscroll")
    {
        return Number(PLAYER_DATA.teleport_id) == Number(item_id)
    }
    if (item_type == "Items_tips" && PLAYER_DATA.tips)
    {
        for (var f = 1; f <= Object.keys(PLAYER_DATA.tips).length; f++) 
        {
            if (Number(PLAYER_DATA.tips[f]) == Number(item_id))
            {
                return true
            }
        }
    }
    return false
}

function SetPetInventory(panel, table) 
{
    panel.SetPanelEvent("onactivate", function() 
    { 
        SelectCourier(table[0])
    });
}

function SetEmblemInventory(panel, table) 
{
    panel.SetPanelEvent("onactivate", function() 
    { 
        SelectEmblem(table[0])
    });
}

function SetFiveInventory(panel, table) 
{
    panel.SetPanelEvent("onactivate", function() 
    { 
        SelectFive(table[0])
    });
}

function SetTipInventory(panel, table) 
{
    panel.SetPanelEvent("onactivate", function() 
    { 
        SelectTip(table[0])
    });
}

function SetBGInventory(panel, table) 
{
    panel.SetPanelEvent("onactivate", function() 
    { 
        SelectBG(table[0])
    });
}

function SetTpInventory(panel, table) 
{
    panel.SetPanelEvent("onactivate", function() 
    { 
        SelectTeleport(table[0])
    });
}

function SelectTip(num)
{
    GameEvents.SendCustomGameEventToServer_custom( "change_premium_tip", {tip: num} );
}

function SelectCourier(num)
{
    GameEvents.SendCustomGameEventToServer_custom( "change_premium_pet", {pet_id: num} );
}

function SelectEmblem(num)
{
    GameEvents.SendCustomGameEventToServer_custom( "change_premium_emblem", {effect: num} );
}

function SelectFive(num)
{
    GameEvents.SendCustomGameEventToServer_custom( "change_premium_five", {five_id: num} );
}

function SelectBG(num)
{
    GameEvents.SendCustomGameEventToServer_custom( "change_premium_bg", {background_id: num} );
}

function SelectTeleport(num)
{
    GameEvents.SendCustomGameEventToServer_custom( "change_premium_tp", {teleport_id: num} );
}

function InitRunes()
{
    var root = $("#RunesWindow")
    if (!root) { return }

    root.RemoveAndDeleteChildren()
    root.AddClass("RunesWindowContent")

    var main = $.CreatePanel("Panel", root, "RunesMain")
    main.AddClass("RunesMain")

    var description = $.CreatePanel("Label", main, "")
    description.AddClass("RunesDescription")
    description.text = $.Localize("#shop_runes_description")

    CreateRunesRoulette(main)

    var list_header = $.CreatePanel("Panel", main, "")
    list_header.AddClass("RunesListHeader")

    var list_title = $.CreatePanel("Label", list_header, "")
    list_title.AddClass("RunesListTitle")
    list_title.text = $.Localize("#shop_all_runes")

    var equipped_counter = $.CreatePanel("Label", list_header, "RunesEquippedCounter")
    equipped_counter.AddClass("RunesEquippedCounter")
    equipped_counter.text = GetOwnedRunesCount() + " / " + Items_Runes.length

    var equipped_counter_2 = $.CreatePanel("Label", list_header, "RunesEquippedCounter2")
    equipped_counter_2.AddClass("RunesEquippedCounter_2")
    equipped_counter_2.text = $.Localize("#shop_runes_activated") + GetEquippedRunesCount() + " / " + RUNE_MAX_EQUIPPED

    var list = $.CreatePanel("Panel", main, "RunesList")
    list.AddClass("RunesList")

    var sorted_runes = GetRunesSortedForDisplay()
    for (var i = 0; i < sorted_runes.length; i++)
    {
        CreateRuneCard(list, sorted_runes[i], false)
    }
}

function CreateRunesRoulette(parent)
{
    var roulette = $.CreatePanel("Panel", parent, "RunesRoulette")
    roulette.AddClass("RunesRoulette")

    var viewport = $.CreatePanel("Panel", roulette, "RunesRouletteViewport")
    viewport.AddClass("RunesRouletteViewport")

    var track = $.CreatePanel("Panel", viewport, "RunesRouletteTrack")
    track.AddClass("RunesRouletteTrack")

    var marker = $.CreatePanel("Panel", viewport, "")
    marker.AddClass("RunesRouletteMarker")

    BuildIdleRuneTrack(track)

    var footer = $.CreatePanel("Panel", roulette, "")
    footer.AddClass("RunesRouletteFooter")

    var status = $.CreatePanel("Label", footer, "RunesRouletteStatus")
    status.AddClass("RunesRouletteStatus")

    var button = $.CreatePanel("Panel", footer, "RunesOpenButton")
    button.AddClass("RunesOpenButton")

    var button_content = $.CreatePanel("Panel", button, "")
    button_content.AddClass("RunesOpenButtonContent")

    var button_price = $.CreatePanel("Label", button_content, "RunesOpenButtonPriceLabel")
    button_price.AddClass("RunesOpenButtonPriceLabel")
    button_price.text = "1000"

    var coin = $.CreatePanel("Panel", button_content, "")
    coin.AddClass("RunesOpenButtonCoin")

    var all_maxed = AreAllRunesMaxed()
    button.SetHasClass("Locked", rune_spin_in_progress || all_maxed)

    if (all_maxed)
    {
        status.text = $.Localize("#shop_player_has_all_runes")
    }
    else
    {
        status.text = ""
    }

    button.SetPanelEvent("onactivate", function()
    {
        if (button.BHasClass("Locked"))
        {
            return
        }
        RequestRuneSpin()
    })
}

function BuildIdleRuneTrack(track)
{
    track.style.transitionDuration = "0.0s"
    track.RemoveAndDeleteChildren()
    track.style.transform = "translateX(0px)"
    var available_runes = GetAvailableRunes()
    if (available_runes.length <= 0)
    {
        available_runes = Items_Runes
    }
    var last_rune_id = null
    for (var i = 0; i < 14; i++)
    {
        var rune = GetRandomRuneFromList(available_runes, last_rune_id)
        last_rune_id = rune ? rune.id : null
        CreateRuneWheelItem(track, rune)
    }
}

function RequestRuneSpin()
{
    if (rune_spin_in_progress || AreAllRunesMaxed())
    {
        if (AreAllRunesMaxed())
        {
            //RuneNotice("Коллекция завершена", "Все руны уже имеют 3 уровень.", null)
        }
        return
    }
    if (PLAYER_DATA && Number(PLAYER_DATA.coins) < RUNE_SPIN_COST && !Game.IsInToolsMode())
    {
        ErrorCreated({error_name: "shop_error_no_coins"})
        return
    }
    var track = $("#RunesRouletteTrack")
    if (track)
    {
        BuildIdleRuneTrack(track)
    }
    rune_spin_in_progress = true
    $("#RunesOpenButton").SetHasClass("Locked", true)
    $("#RunesRouletteStatus").text = ""//$.Localize("#shop_rullet_spinning")
    GameEvents.SendCustomGameEventToServer_custom("woda_rune_spin_request", {})
    if (rune_spin_timeout != -1)
    {
        $.CancelScheduled(rune_spin_timeout)
    }
    rune_spin_timeout = $.Schedule(3.0, function()
    {
        if (!rune_spin_in_progress || rune_pending_result != null)
        {
            return
        }
        rune_spin_in_progress = false
        rune_spin_timeout = -1
        if (current_tab == "RunesWindow")
        {
            InitRunes()
        }
    })
}

function OnRuneSpinStart(data)
{
    if (rune_spin_timeout != -1)
    {
        $.CancelScheduled(rune_spin_timeout)
        rune_spin_timeout = -1
    }
    rune_pending_result = data.rune_id
    var track = $("#RunesRouletteTrack")
    if (!track) { return }

    track.RemoveAndDeleteChildren()
    track.style.transitionDuration = "0.0s"
    track.style.transform = "translateX(0px)"

    var stop_index = 34
    var available_runes = GetAvailableRunes()
    var result_rune = GetRuneInfo(data.rune_id)
    var result_in_available = false
    for (var check = 0; check < available_runes.length; check++)
    {
        if (available_runes[check].id == data.rune_id)
        {
            result_in_available = true
            break
        }
    }
    if (!result_in_available && result_rune)
    {
        available_runes.push(result_rune)
    }
    var last_rune_id = null
    for (var i = 0; i < 44; i++)
    {
        var rune = GetRandomRuneFromList(available_runes, last_rune_id)
        if (i == stop_index)
        {
            rune = result_rune || rune
        }
        last_rune_id = rune ? rune.id : null
        CreateRuneWheelItem(track, rune)
    }

    Game.EmitSound("ui.treasure_01")
    $.Schedule(0.05, function()
    {
        track.style.transitionDuration = "4.5s"
        track.style.transform = "translateX(" + String(GetRuneRouletteStopOffset(stop_index)) + "px)"
        $("#RunesRouletteStatus").text = ""
    })
}

function OnRuneSpinComplete(data)
{
    rune_spin_in_progress = false
    rune_pending_result = null
    UpdateRuneSpinButton()
    var rune = GetRuneInfo(data.rune_id)
    if (rune)
    {
        RuneNotice($.Localize("#shop_rune_is_drop"), $.Localize("#"+rune.id), rune)
        Game.EmitSound("ui.treasure_02")
    }
    RefreshRunesListOnly()
}

function OnRuneSpinDenied(data)
{
    rune_spin_in_progress = false
    rune_pending_result = null
    if (rune_spin_timeout != -1)
    {
        $.CancelScheduled(rune_spin_timeout)
        rune_spin_timeout = -1
    }
    if (data.reason == "all_max")
    {
        // RuneNotice("Коллекция завершена", "Все руны уже имеют 3 уровень.", null)
    }
    else if (data.reason == "no_data")
    {
        // RuneNotice("Нет данных", "Данные игрока еще не загрузились. Попробуйте через пару секунд.", null)
    }
    if (current_tab == "RunesWindow")
    {
        InitRunes()
    }
}

function UpdateRuneSpinButton()
{
    var button = $("#RunesOpenButton")
    var status = $("#RunesRouletteStatus")
    var all_maxed = AreAllRunesMaxed()

    if (button)
    {
        button.SetHasClass("Locked", rune_spin_in_progress || all_maxed)
    }

    if (status)
    {
        if (all_maxed)
        {
            status.text = $.Localize("#shop_player_has_all_runes")
        }
        else if (!rune_spin_in_progress)
        {
            status.text = ""
        }
    }
}

function OnRuneEquipDenied(data)
{
    rune_equip_update_pending = false
    if (data.reason == "max_equipped")
    {
        //RuneNotice("Лимит рун", "Одновременно можно надеть только 3 руны.", null)
    }
}

function CreateRuneWheelItem(parent, rune)
{
    if (!rune) { return }

    var item = $.CreatePanel("Panel", parent, "")
    item.AddClass("RuneWheelItem")
    item.style.border = "1px solid " + rune.color

    var icon = $.CreatePanel("Panel", item, "")
    icon.AddClass("RuneIcon")
    icon.style.backgroundImage = "url('file://{images}/custom_game/runes/" + rune.id + ".png')"
    icon.style.backgroundSize = "100%"

    var text = $.CreatePanel("Label", icon, "")
    text.AddClass("RuneIconText")
}

function GetRandomRuneFromList(runes, previous_rune_id)
{
    if (!runes || runes.length <= 0)
    {
        return null
    }
    if (runes.length == 1)
    {
        return runes[0]
    }

    var rune = runes[Math.floor(Math.random() * runes.length)]
    for (var i = 0; i < 4; i++)
    {
        if (rune.id != previous_rune_id)
        {
            break
        }
        rune = runes[Math.floor(Math.random() * runes.length)]
    }
    return rune
}

function GetRuneRouletteStopOffset(stop_index)
{
    var viewport_center = RUNE_ROULETTE_VIEWPORT_WIDTH / 2
    var item_center = RUNE_ROULETTE_ITEM_MARGIN_LEFT + RUNE_ROULETTE_ITEM_WIDTH / 2
    return viewport_center - (stop_index * RUNE_ROULETTE_ITEM_STEP + item_center)
}

function CreateRuneCard(parent, rune)
{
    var level = GetRuneLevel(rune.id)
    var equipped = IsRuneEquipped(rune.id)

    var card = $.CreatePanel("Panel", parent, "RuneCard_" + rune.id)
    card.AddClass("RuneCard")
    card.SetHasClass("Owned", level > 0)
    card.SetHasClass("Equipped", equipped)
    card.SetHasClass("MaxLevel", level >= RUNE_MAX_LEVEL)
    card.SetPanelEvent("onmouseover", function()
    {
        $.DispatchEvent("DOTAShowTextTooltip", card, $.Localize("#"+rune.id) + "<br><br>" + $.Localize("#"+rune.id+"_description_"+level))
    })
    card.SetPanelEvent("onmouseout", function()
    {
        $.DispatchEvent("DOTAHideTextTooltip", card)
    })
    card.SetPanelEvent("onactivate", function()
    {
        if (GetRuneLevel(rune.id) <= 0)
        {
            return
        }
        rune_equip_update_pending = true
        GameEvents.SendCustomGameEventToServer_custom("woda_rune_toggle_equip", {rune_id: rune.id})
    })

    var top = $.CreatePanel("Panel", card, "")
    top.AddClass("RuneCardTop")

    var icon = $.CreatePanel("Panel", top, "")
    icon.AddClass("RuneCardIcon")
    icon.style.backgroundImage = "url('file://{images}/custom_game/runes/" + rune.id + ".png')"
    icon.style.backgroundSize = "100%"
    
    var short = $.CreatePanel("Label", icon, "")
    short.AddClass("RuneCardIconText")

    var info = $.CreatePanel("Panel", top, "")
    info.AddClass("RuneCardInfo")

    var name = $.CreatePanel("Label", info, "")
    name.AddClass("RuneCardName")
    name.text = $.Localize("#"+rune.id)

    var level_label = $.CreatePanel("Label", info, "RuneCardLevel_" + rune.id)
    level_label.AddClass("RuneCardLevel")
    level_label.text = level > 0 ? $.Localize("#shop_rune_level") + " " + level + " / 3" : $.Localize("#shop_rune_not_active")

}

function GetRuneInfo(rune_id)
{
    for (var i = 0; i < Items_Runes.length; i++)
    {
        if (Items_Runes[i].id == rune_id)
        {
            return Items_Runes[i]
        }
    }
    return null
}

function GetRuneLevel(rune_id)
{
    if (!PLAYER_DATA || !PLAYER_DATA.runes)
    {
        return 0
    }
    var direct_level = PLAYER_DATA.runes[String(rune_id)]
    if (direct_level != null && typeof direct_level != "object")
    {
        return Number(direct_level) || 0
    }
    for (var key in PLAYER_DATA.runes)
    {
        var rune_data = PLAYER_DATA.runes[key]
        if (rune_data == null)
        {
            continue
        }
        if (typeof rune_data == "object")
        {
            var data_id = rune_data.id || rune_data.rune_id || rune_data.name
            if (String(data_id) == String(rune_id))
            {
                return Number(rune_data.level || rune_data.count || rune_data.value || 1) || 1
            }
        }
        else if (String(rune_data) == String(rune_id))
        {
            return 1
        }
    }
    return 0
}

function IsRuneEquipped(rune_id)
{
    if (!PLAYER_DATA || !PLAYER_DATA.equipped_runes)
    {
        return false
    }
    for (var key in PLAYER_DATA.equipped_runes)
    {
        if (String(PLAYER_DATA.equipped_runes[key]) == String(rune_id))
        {
            return true
        }
    }
    return false
}

function GetEquippedRunesCount()
{
    if (!PLAYER_DATA || !PLAYER_DATA.equipped_runes)
    {
        return 0
    }
    var count = 0
    for (var key in PLAYER_DATA.equipped_runes)
    {
        if (PLAYER_DATA.equipped_runes[key])
        {
            count++
        }
    }
    return count
}

function GetOwnedRunesCount()
{
    var count = 0
    for (var i = 0; i < Items_Runes.length; i++)
    {
        if (GetRuneLevel(Items_Runes[i].id) > 0)
        {
            count++
        }
    }
    return count
}

function GetAvailableRunes()
{
    var available_runes = []
    for (var i = 0; i < Items_Runes.length; i++)
    {
        if (GetRuneLevel(Items_Runes[i].id) < RUNE_MAX_LEVEL)
        {
            available_runes.push(Items_Runes[i])
        }
    }
    return available_runes
}

function GetRunesSortedForDisplay()
{
    var owned_runes = []
    var locked_runes = []
    for (var i = 0; i < Items_Runes.length; i++)
    {
        if (GetRuneLevel(Items_Runes[i].id) > 0)
        {
            owned_runes.push(Items_Runes[i])
        }
        else
        {
            locked_runes.push(Items_Runes[i])
        }
    }
    return owned_runes.concat(locked_runes)
}

function RefreshRunesVisualOnly()
{
    for (var i = 0; i < Items_Runes.length; i++)
    {
        UpdateRuneCardVisual(Items_Runes[i])
    }
    RefreshRunesCounter()
}

function UpdateRuneCardVisual(rune)
{
    var level = GetRuneLevel(rune.id)
    var equipped = IsRuneEquipped(rune.id)
    var card = $("#RuneCard_" + rune.id)
    if (!card)
    {
        return
    }

    card.SetHasClass("Owned", level > 0)
    card.SetHasClass("Equipped", equipped)
    card.SetHasClass("MaxLevel", level >= RUNE_MAX_LEVEL)

    var level_label = $("#RuneCardLevel_" + rune.id)
    if (level_label)
    {
        level_label.text = level > 0 ? $.Localize("#shop_rune_level") + " " + level + " / 3" : $.Localize("#shop_rune_not_active")
    }

}

function RefreshRunesCounter()
{
    var counter = $("#RunesEquippedCounter")
    if (counter)
    {
        counter.text = GetOwnedRunesCount() + " / " + Items_Runes.length
    }
    var counter2 = $("#RunesEquippedCounter2")
    if (counter2)
    {
        counter2.text = $.Localize("#shop_runes_activated") + GetEquippedRunesCount() + " / " + RUNE_MAX_EQUIPPED
    }
}

function RefreshRunesListOnly()
{
    var list = $("#RunesList")
    if (list)
    {
        list.RemoveAndDeleteChildren()
        var sorted_runes = GetRunesSortedForDisplay()
        for (var i = 0; i < sorted_runes.length; i++)
        {
            CreateRuneCard(list, sorted_runes[i], false)
        }
    }
    RefreshRunesCounter()
}

function AreAllRunesMaxed()
{
    for (var i = 0; i < Items_Runes.length; i++)
    {
        if (GetRuneLevel(Items_Runes[i].id) < RUNE_MAX_LEVEL)
        {
            return false
        }
    }
    return true
}

function RuneNotice(title, text, rune)
{
    var panel = $("#donate_accept_window")
    var label = $("#donate_accept_label")
    if (!panel || !label) { return }

    label.text = title + "\n" + text
    label.style.color = rune ? rune.color : "#16eb02"
    panel.style.visibility = "visible"
    $.Schedule(2.2, function()
    {
        panel.style.visibility = "collapse"
        label.text = $.Localize("#donate_shop_aceept")
        label.style.color = "#16eb02"
    })
}

GameEvents.Subscribe_custom("woda_rune_spin_start", OnRuneSpinStart)
GameEvents.Subscribe_custom("woda_rune_spin_complete", OnRuneSpinComplete)
GameEvents.Subscribe_custom("woda_rune_spin_denied", OnRuneSpinDenied)
GameEvents.Subscribe_custom("woda_rune_equip_denied", OnRuneEquipDenied)

function UpdateStoreBackground()
{
    let PlayerBackground = $("#PlayerBackground")
    let PlayerBackgroundHeroVotes = $("#PlayerBackgroundHeroVotes")
    
    if (PLAYER_DATA && PLAYER_DATA.background_id)
    {
        PlayerBackground.style.backgroundImage = 'url("' + Background_Images[PLAYER_DATA.background_id] + '")'
        PlayerBackground.style.backgroundSize = "100%"
        PlayerBackground.style.opacity = "1";

        PlayerBackgroundHeroVotes.style.backgroundImage = 'url("' + Background_Images[PLAYER_DATA.background_id] + '")'
        PlayerBackgroundHeroVotes.style.backgroundSize = "100%"
        PlayerBackgroundHeroVotes.style.opacity = "1";
    }
    else
    {
        PlayerBackground.style.opacity = "0";
        PlayerBackgroundHeroVotes.style.opacity = "0";
    }

    if (GameUI.CustomUIConfig().GlobalUpdateBGHS)
    {
        GameUI.CustomUIConfig().GlobalUpdateBGHS()
    }
}

function HowMuchItemsInTab(table_items)
{
    let cache_key = GetItemsCounterCacheKey(table_items)
    if (cache_key != null && items_counter_cache[cache_key])
    {
        return items_counter_cache[cache_key]
    }

    let counter = table_items.length
    let items_has = 0
    for (var i = 0; i < table_items.length; i++) 
    {
        if (table_items[i])
        {
            if (HasItemInventory(table_items[i][0]) && !table_items[i][5])
            {
                items_has = items_has + 1
            }
            if (table_items[i][5])
            {
                counter = counter - 1
            }
        }
    } 
    let result = [counter, items_has]
    if (cache_key != null)
    {
        items_counter_cache[cache_key] = result
    }
    return result
}

function GetItemsCounterCacheKey(table_items)
{
    if (table_items == Items_pets) { return "Items_pets" }
    if (table_items == Items_emblems) { return "Items_emblems" }
    if (table_items == Items_tips) { return "Items_tips" }
    if (table_items == Items_Five) { return "Items_Five" }
    if (table_items == Items_Backround) { return "Items_Backround" }
    if (table_items == Items_tpscroll) { return "Items_tpscroll" }
    return null
}

function GetPercentItemsInProfile()
{
    if (profile_items_percent_cache != null)
    {
        return profile_items_percent_cache
    }

    let Items_pets_counter = HowMuchItemsInTab(Items_pets)
    let Items_emblems_counter = HowMuchItemsInTab(Items_emblems)
    let Items_tips_counter = HowMuchItemsInTab(Items_tips)
    let Items_Five_counter = HowMuchItemsInTab(Items_Five)
    let Items_Backround_counter = HowMuchItemsInTab(Items_Backround)
    let Items_Teleports_counter = HowMuchItemsInTab(Items_tpscroll)
    let all_items_counter = Items_pets_counter[0] + Items_emblems_counter[0] + Items_tips_counter[0] + Items_Five_counter[0] + Items_Backround_counter[0] + Items_Teleports_counter[0]
    let has_items_counter = Items_pets_counter[1] + Items_emblems_counter[1] + Items_tips_counter[1] + Items_Five_counter[1] + Items_Backround_counter[1] + Items_Teleports_counter[1]
    profile_items_percent_cache = Math.floor(has_items_counter / all_items_counter * 100)
    return profile_items_percent_cache
}

function CheckoutEveryReward(is_fast)
{
    let has_reward = true
    var localplayer_data = PLAYER_DATA;
    if (localplayer_data)
    {
        if (localplayer_data.free_reward == 1)
        {
            has_reward = false
        }
    }
    if (is_fast)
    {
        has_reward = false
    }
    $("#DonateButton").SetHasClass("HasReward", has_reward)
}

CheckoutEveryReward()


function GetHeroInformationOther(hero, player_id) {
    // Проверяем и загружаем данные игрока, если их нет в кэше
    if (!OTHER_PLAYER_DATA[player_id]) {
        OTHER_PLAYER_DATA[player_id] = Game.GetCustomTable("woda_player_data", String(player_id));
    }
    const playerData = OTHER_PLAYER_DATA[player_id];
    if (!playerData?.heroes_level) return null;
    // Используем Object.values для более чистого кода и find для поиска
    return Object.values(playerData.heroes_level).find(
        heroData => heroData.hero === hero
    ) || null;
}

const level_colors = ['#edb96e','#d5edf3','#feeb44',"#c4eaff",'#d1ce89','#d1ce89']

function check_level_timer()
{
    let hero_id = Players.GetLocalPlayerPortraitUnit()
    if (!hero_id) { 
        $.Schedule( 0.1, check_level_timer)
        return 
    }
    if (hero_id == -1) { 
        $.Schedule( 0.1, check_level_timer)
        return 
    }
    let hero = Entities.GetUnitName(hero_id)
    let player_id = Entities.GetPlayerOwnerID( hero_id )
    let level_icon_img = null
    if (GetHeroInformationOther(hero, player_id) != null) 
    {
        let info = GetHeroInformationOther(hero, player_id)
        let hero_lvl = GetLevelByCoins(info.coins)
        level_icon_img = GetHeroRankIcon(hero_lvl)
    }
    let level_icon = FindDotaHudElement("level_icon_custom")
    let hero_label = FindDotaHudElement("UnitNameLabel");
    let dota_level = FindDotaHudElement('unitbadge')
    if (dota_level)
    {
        dota_level.style.opacity = '0';
    }
    if (!level_icon)
    {
        level_icon =  $.CreatePanel("Panel", $.GetContextPanel(), "level_icon_custom")
        level_icon.AddClass("level_icon_custom")
        level_icon.SetParent(dota_level.GetParent())
    }  
    if (level_icon_img && level_icon_img != "rank_0")
    {
        hero_label.style.color = level_colors[Number(level_icon_img.replace("rank_", ""))-1];
        level_icon.style.backgroundImage = 'url("s2r://panorama/images/hud/portrait_hero_badge_frame_tier_' + level_icon_img.replace("rank_", "") + '_psd.vtex")';
        level_icon.style.opacity = "1";
    }
    else 
    {
        hero_label.style.color = 'white';
        level_icon.style.opacity = "0";
    }
    $.Schedule( 0.1, check_level_timer)
}

check_level_timer()

//function StopSoundBlock()
//{
//    var videos = 
//    [
//        "https://www.youtube.com/watch?v=E5Vi2kue_zE",
//        "https://www.youtube.com/watch?v=JXNgF5KjKh4",
//        "https://www.youtube.com/watch?v=G2HdCqL6kJI",
//        "https://www.youtube.com/watch?v=YV9HEyGNRFU",
//        "https://www.youtube.com/watch?v=lQZCtLCNip4",
//        "https://www.youtube.com/watch?v=mZMg3e2ZbA0",
//        "https://www.youtube.com/watch?v=FpD531bislA",
//        "https://www.youtube.com/watch?v=r6g_1yYl4_A",
//        "https://www.youtube.com/watch?v=1vAj4WXnjh8",
//        "https://www.youtube.com/watch?v=3rtoQDG0V64",
//        "https://www.youtube.com/watch?v=NJZjhB1MRXo",
//        "https://www.youtube.com/watch?v=AYQnLRh8D3w",
//        "https://www.youtube.com/watch?v=Wc9cz51DN30",
//        "https://www.youtube.com/watch?v=3lXG8jLinBo",
//        "https://www.youtube.com/watch?v=vWFJ-yn76pU",
//        "https://www.youtube.com/watch?v=YYxykzscQn4",
//        "https://www.youtube.com/watch?v=UECw6JYoZFI",
//
//        
//    ]
//    let YoutubeMusic = $.GetContextPanel().FindChildTraverse("YoutubeMusic")
//    if (YoutubeMusic == null)
//    {
//        YoutubeMusic = $.CreatePanel("DOTAHTMLPanel", $.GetContextPanel(), "YoutubeMusic", {style:"width:1%;height:1%;align:center center;transform:TranslateX(10000px);", url:videos[Math.floor(Math.random() * videos.length)], volume:0, muted:true})
//        //YoutubeMusic = $.CreatePanel("DOTAHTMLPanel", $.GetContextPanel(), "YoutubeMusic", {style:"width:25%;height:25%;align:center center;", url:videos[Math.floor(Math.random() * videos.length)], volume:0, muted:true})
//    }
//    YoutubeMusic.RunJavascript("var video = document.querySelector('video');if (!video.muted) { var muteButton = document.querySelector('.ytp-mute-button');muteButton.click(); };")
//    YoutubeMusic.RunJavascript("function muteMe(elem) {elem.muted = true;elem.volume=0;} function mutePage() { document.querySelectorAll('video, audio').forEach((elem) => muteMe(elem));} mutePage()")
//    $.Schedule( 0.1, StopSoundBlock)
//}
//
//StopSoundBlock()