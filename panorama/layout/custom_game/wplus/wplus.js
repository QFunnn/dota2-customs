--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var first_time = false;
var current_tab
var PLAYER_DATA = Game.GetCustomTable("woda_player_data", String(Players.GetLocalPlayer()));
var QUEST_DATA_TABLE = Game.GetCustomTable("quest_data", "quest_data");
var images_data =
{
    pass_reward_1 : "s2r://panorama/images/dota_plus/upsell_progression_psd.vtex",
    pass_reward_2 : "s2r://panorama/images/dota_plus/upsell_assistant_psd.vtex",
    pass_reward_3 : "s2r://panorama/images/dota_plus/upsell_battle_report_psd.vtex",
    pass_reward_4 : "s2r://panorama/images/dota_plus/upsell_perks_psd.vtex",
}
Game.SubscribeCustomTableListener("woda_player_data", UpdatePlayerData );
function UpdatePlayerData(table, key, data) 
{
	if (table == "woda_player_data") 
	{
        if (key == String(Players.GetLocalPlayer()) || key == Players.GetLocalPlayer())
        {
            PLAYER_DATA = data;
            InitData()
            UpdateStoreBackground()
            if (current_tab != undefined && current_tab != "MainPanel")
            {
                if ($("#DonateShopWindow").BHasClass("setvisible"))
                {
                    InitQuestsList(current_tab)
                }
            }
        }
	}
}

function ToggleDonateButton(tab, button) 
{
    if (!first_time)
    {
        first_time = true;
        InitData()
        InitPassMain()
        UpdateStoreBackground()
    }
    if (current_tab != tab)
    {
        SwitchTab(tab, button)
        $("#DonateShopWindow").SetHasClass("setvisible", true)
    }
    else
    {
        $("#DonateShopWindow").SetHasClass("setvisible", !$("#DonateShopWindow").BHasClass("setvisible"))
    }
    if (GameUI.CustomUIConfig().CloseShopGlobal)
    {
        GameUI.CustomUIConfig().CloseShopGlobal()
    }
    if (GameUI.CustomUIConfig().CloseBattlePassGlobal)
    {
        GameUI.CustomUIConfig().CloseBattlePassGlobal()
    }
}

function ToggleDonateButtonCloseW() 
{
    $("#DonateShopWindow").SetHasClass("setvisible", false)
}

GameUI.CustomUIConfig().CloseWPlusGlobal = ToggleDonateButtonCloseW

function SwitchTab(tab, button) 
{
    if (current_tab != tab)
    {
        Game.EmitSound("ui_topmenu_select")
    }
    for (menu_panel of $("#NavigationMenu").Children())
    {
        menu_panel.SetHasClass( "DonateNewMenuButtonSelected2", false );
        if (menu_panel.id == button)
        {
            menu_panel.SetHasClass( "DonateNewMenuButtonSelected2", true );
        }
    }
    for (menu_panel of $("#SubsPanels").Children())
    {
        menu_panel.visible = false
        if (menu_panel.id == tab)
        {
            menu_panel.visible = true
        }
    } 
    if (tab != "MainPanel")
    {
        InitQuestsList(tab)
    }
    current_tab = tab
}

function InitData()
{
    var localplayer_data = PLAYER_DATA;
    if (localplayer_data)
    {
        $("#CoinLabelCount").text = String(localplayer_data.coins)
        $("#WodaplusLabelCount").text = String(localplayer_data.plus_days)
        $("#BattlePassLabelCount").text = String(localplayer_data.battlepass_level_2026)
        $("#DoubleTokensLabelCount").text = String(localplayer_data.double_tokens)
    }
    SetTextInfo($("#CoinBlock"), "coin_information")
    SetTextInfo($("#WodaplusBlock"), "subscribe_information")
    SetTextInfo($("#BattlePassBlock"), "battlepass_information")
    SetTextInfo($("#DoubleTokensBlock"), "double_tokens_information")
}

function SetTextInfo(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, $.Localize("#" + text)); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function InitPassMain()
{
    $("#WodaPlusSubscribeButton").SetPanelEvent("onactivate", function() 
    { 
        GameUI.CustomUIConfig().GoToSiteStore()
    });
    CreateRewardPass($("#ContentSlider"), "pass_reward_1", "s2r://panorama/images/dota_plus/thumb_progression_psd.vtex")
    CreateRewardPass($("#ContentSlider"), "pass_reward_2", "s2r://panorama/images/dota_plus/thumb_assistant_psd.vtex")
    CreateRewardPass($("#ContentSlider"), "pass_reward_3", "s2r://panorama/images/dota_plus/thumb_battle_report_psd.vtex")
    CreateRewardPass($("#ContentSlider"), "pass_reward_4", "s2r://panorama/images/dota_plus/thumb_perks_psd.vtex")
    //CreateRewardPass($("#ContentSlider"), "pass_reward_3", "file://{images}/custom_game/shop/pass_bg_3.png")
    ChangeRewardInfo("pass_reward_1")
}

function CreateRewardPass(parent, name, image)
{
    let pass_reward_block = $.CreatePanel("Panel", parent, name)
    pass_reward_block.AddClass("pass_reward_block")
    pass_reward_block.style.backgroundImage = 'url("'+image+'")';
    pass_reward_block.style.backgroundSize = "100%";
    if (parent.GetChildCount() <= 1)
    {
        pass_reward_block.SetHasClass("active_reward_info", true)
    }

    let pass_reward_block_label = $.CreatePanel("Label", pass_reward_block, "")
    pass_reward_block_label.AddClass("pass_reward_block_label")
    pass_reward_block_label.text = $.Localize("#"+name)

    let pass_image_block = $.CreatePanel("Panel", pass_reward_block, "")
    pass_image_block.AddClass("pass_image_block")

    pass_reward_block.SetPanelEvent("onactivate", function()
    {
        ChangeRewardInfo(name)
    })
}

function ChangeRewardInfo(name)
{
    for (let child of $("#ContentSlider").Children())
    {
        child.SetHasClass("active_reward_info", child.id == name)
    }
    $("#ContentHeaderLabel").text = $.Localize("#"+name)
    $("#ContentDescriptionLabel").text = $.Localize("#"+name+"_description")
    $("#ContentImage").style.backgroundImage = 'url("'+images_data[name]+'")';
    $("#ContentImage").style.backgroundSize = "contain";
    $("#ContentImage").style.backgroundRepeat = "no-repeat";
    $("#ContentImage").style.backgroundPosition = "center";
}

function InitQuestsList(tab)
{
    let quest_panel = $("#"+tab)
    if (!quest_panel) { return }
    quest_panel.RemoveAndDeleteChildren()
    let quest_container = $.CreatePanel("Panel", quest_panel, "")
    quest_container.AddClass("quest_container")
    for (let tbl of QUEST_LIST_INFO[tab])
    {
        CreateQuestPanel(quest_container, tbl)
    }
}

function CreateQuestPanel(parent, table)
{
    let quest_panel = $.CreatePanel("Panel", parent, "")
    quest_panel.AddClass("quest_panel")

    let quest_reward_icon = $.CreatePanel("Panel", quest_panel, "")
    quest_reward_icon.AddClass("quest_reward_icon")
    quest_reward_icon.style.backgroundImage = 'url("file://{images}/custom_game/shop/' + table[2] + '_open.png")';
    quest_reward_icon.style.backgroundSize = "100%"

    if (GameUI.CustomUIConfig().OpenCheckoutItemPreview && (table[2].indexOf("background") === 0 || table[2].indexOf("emblem") === 0 || table[2].indexOf("five_") === 0 || table[2].indexOf("tp_effect") === 0))
    {
        quest_reward_icon.AddClass("quest_reward_icon_hover", true)
        GameUI.CustomUIConfig().OpenCheckoutItemPreview(quest_reward_icon, [table[0], null, null, table[1], table[2], null], true)
    }

    let quest_reward_name = $.CreatePanel("Label", quest_panel, "")
    quest_reward_name.AddClass("quest_reward_name")
    quest_reward_name.text = $.Localize("#"+table[1])

    let quest_description = $.CreatePanel("Label", quest_panel, "")
    quest_description.AddClass("quest_description")
    quest_description.text = $.Localize("#quest_id_"+table[3])

    if (table[4])
    {
        quest_description.text = $.Localize("#quest_reach_top_1_for_hero") + " " + $.Localize("#"+table[4])
    }

    let quest_progress_with_button_claim = $.CreatePanel("Panel", quest_panel, "")
    quest_progress_with_button_claim.AddClass("quest_progress_with_button_claim")

    let quest_progress_line = $.CreatePanel("Panel", quest_progress_with_button_claim, "")
    quest_progress_line.AddClass("quest_progress_line")

    let quest_progress_bar = $.CreatePanel("Panel", quest_progress_line, "")
    quest_progress_bar.AddClass("quest_progress_bar")

    let quest_progress_label = $.CreatePanel("Label", quest_progress_line, "")
    quest_progress_label.AddClass("quest_progress_label")

    let quest_progress_value = 0
    if (PLAYER_DATA && PLAYER_DATA.quest_data && PLAYER_DATA.quest_data[table[3]])
    {
        quest_progress_value = PLAYER_DATA.quest_data[table[3]]
    }

    quest_progress_value = Math.min(quest_progress_value, QUEST_DATA_TABLE[table[3]][1])

    quest_progress_label.text = quest_progress_value+"/" + QUEST_DATA_TABLE[table[3]][1]
    quest_progress_bar.style.width = (quest_progress_value/QUEST_DATA_TABLE[table[3]][1])*100 + "%"

    let quest_button_claim = $.CreatePanel("Panel", quest_progress_with_button_claim, "")
    quest_button_claim.AddClass("quest_button_claim")

    let quest_button_claim_label = $.CreatePanel("Label", quest_button_claim, "")
    quest_button_claim_label.AddClass("quest_button_claim_label")
    if (!HasItemInventory(table[0]))
    {
        quest_button_claim_label.text = $.Localize("#woda_quest_claim_reward")
    }
    else
    {
        quest_button_claim_label.text = $.Localize("#woda_quest_claim_reward_sucess")
    }

    if (quest_progress_value >= QUEST_DATA_TABLE[table[3]][1])
    {
        if (!HasItemInventory(table[0]))
        {
            if (PLAYER_DATA && PLAYER_DATA.plus_days > 0)
            {
                quest_button_claim.AddClass("activate")
                quest_button_claim.SetPanelEvent("onactivate", function()
                {
                    quest_button_claim.ClearPanelEvent("onactivate")
                    GameEvents.SendCustomGameEventToServer_custom( "woda_plus_get_player_reward", {reward_id : table[0], quest_id : table[3]} );
                    CheckoutEveryReward(true)
                    $.Schedule( 0.5, function()
                    {
                        CheckoutEveryReward()
                    })
                })
            }
        }
    }
}

function UpdateIconButton()
{
    if ((PLAYER_DATA && PLAYER_DATA.games >= 1) || Game.IsInToolsMode())
    {
        $("#DonateButton").visible = true
    }
    else
    {
        $("#DonateButton").visible = false
    }
    $.Schedule(1, UpdateIconButton)
}

UpdateIconButton()

function UpdateStoreBackground()
{
    let PlayerBackground = $("#PlayerBackground")
    let WodaPlusBG = $("#WodaPlusBG")
    if (PLAYER_DATA && PLAYER_DATA.background_id)
    {
        PlayerBackground.style.backgroundImage = 'url("' + Background_Images[PLAYER_DATA.background_id] + '")'
        PlayerBackground.style.backgroundSize = "100%"
        PlayerBackground.style.opacity = "1";
        WodaPlusBG.style.opacity = "0"
    }
    else
    {
        PlayerBackground.style.opacity = "0";
        WodaPlusBG.style.opacity = "1"
    }
}

function HasItemInventory(item_id)
{
	if (PLAYER_DATA && PLAYER_DATA.donate_items)
	{
		for (var d = 1; d <= Object.keys(PLAYER_DATA.donate_items).length; d++) 
		{
			if (PLAYER_DATA.donate_items[d])
			{
				if (String(PLAYER_DATA.donate_items[d]) == String(item_id))
				{
					return true
				}
			}
		}
	}
    // if (Game.IsInToolsMode())
    // {
    //     return true
    // }
	return false
}

function CheckoutEveryReward(is_fast) {
    let has_reward = false;
    
    if (!has_reward && PLAYER_DATA?.plus_days > 0) {
        const questTypes = [
            "StrengthQuests",
            "AgilityQuests",
            "IntellectQuests",
            "UniversalQuests"
        ];
        
        for (const questType of questTypes) {
            for (const table of QUEST_LIST_INFO[questType]) {
                const questId = table[3];
                const questProgress = PLAYER_DATA?.quest_data?.[questId] || 0;
                const requiredProgress = QUEST_DATA_TABLE[questId]?.[1] || Infinity;
                
                if (questProgress >= requiredProgress && !HasItemInventory(table[0])) {
                    has_reward = true;
                    break;
                }
            }
            if (has_reward) break;
        }
    }
    
    $("#DonateButton").SetHasClass("HasReward", !is_fast && has_reward);
}

CheckoutEveryReward()




