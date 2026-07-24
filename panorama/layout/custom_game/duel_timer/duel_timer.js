--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom( "wodaset_startduel", startduel );
GameEvents.Subscribe_custom( "wodaset_startduel_duo", wodaset_startduel_duo );
GameEvents.Subscribe_custom( "wodaset_dueltimer", dueltimer );
GameEvents.Subscribe_custom( "wodaset_removeduel", removeduel );
GameEvents.Subscribe_custom( "wodaset_startduel_boss", wodaset_startduel_boss );
var duelBetTimeEnd = 0;
var duelBetUpdateToken = 0;

function GetCurrentDuelGameTime()
{
    if (typeof Game.GetGameTime === "function")
    {
        return Game.GetGameTime();
    }
    if (typeof Game.GetDOTATime === "function")
    {
        return Game.GetDOTATime(false, false);
    }
    return 0;
}

function GetDuelBetButtons()
{
    let root = $.GetContextPanel();
    return [
        root.FindChildTraverse("buttonpredict1"),
        root.FindChildTraverse("buttonpredict2"),
        root.FindChildTraverse("buttonpredict_duo"),
        root.FindChildTraverse("buttonpredict_duo_2")
    ];
}

function SetDuelBetLocked(locked)
{
    let buttons = GetDuelBetButtons();
    for (let i = 0; i < buttons.length; i++)
    {
        if (buttons[i])
        {
            buttons[i].SetHasClass("NoBetTime", locked);
        }
    }
}

function IsDuelBetTimeEnded()
{
    return duelBetTimeEnd > 0 && GetCurrentDuelGameTime() >= duelBetTimeEnd;
}

function UpdateDuelBetTimeLock(token)
{
    if (token != duelBetUpdateToken || duelBetTimeEnd <= 0)
    {
        return;
    }

    if (IsDuelBetTimeEnded())
    {
        SetDuelBetLocked(true);
        return;
    }

    SetDuelBetLocked(false);
    $.Schedule(0.1, function()
    {
        UpdateDuelBetTimeLock(token);
    });
}

function StartDuelBetTime(data)
{
    duelBetTimeEnd = Number(data.time_end || 0);
    duelBetUpdateToken = duelBetUpdateToken + 1;
    SetDuelBetLocked(false);
    UpdateDuelBetTimeLock(duelBetUpdateToken);
}

function StopDuelBetTime()
{
    duelBetTimeEnd = 0;
    duelBetUpdateToken = duelBetUpdateToken + 1;
    // Не снимаем NoBetTime здесь: при скрытии окна это вызывало мигание серым
    // (кнопка теряла цвет во время фейда). Сброс делает StartDuelBetTime на новой дуэли.
}

function CanSendDuelBet()
{
    if (IsDuelBetTimeEnded())
    {
        SetDuelBetLocked(true);
        return false;
    }
    return true;
}

function wodaset_startduel_duo(data)
{
    //vars
    let players_team_1 = data.players_id_1.players
    let players_team_2 = data.players_id_2.players
    let team_number_1 = data.players_id_1.teamnumber
    let team_number_2 = data.players_id_2.teamnumber

    var localPlayerTeamId = -1;
    var localPlayer = Game.GetLocalPlayerInfo();
    if (localPlayer) 
    {
        localPlayerTeamId = localPlayer.player_team_id;
    }

    // init
    $("#panelheroes").RemoveAndDeleteChildren()
    //$("#buttonpredict1").SetHasClass("selected", false)
	//$("#buttonpredict2").SetHasClass("selected", false)
	$("#paneldueltimer2").SetHasClass("animation", false)
	$("#lose_arena").style.opacity = 0
    $("#unlose_arena").style.opacity = 0
	$("#paneldueltimer2").style['width'] = "100" +'%';
    $("#panelduel").style.opacity = 1

    let predictactive = true
	if (data.players_id_1.teamnumber == localPlayerTeamId || data.players_id_2.teamnumber == localPlayerTeamId) 
    {
		predictactive = false
	}

    let heroes_in_panel = $.CreatePanel("Panel", $("#panelheroes"), "")
    heroes_in_panel.AddClass("heroes_in_panel")
 
    for (let i = 0; i < Object.keys(players_team_1).length; i++) 
    {   
        CreatePlayerPanelDuel(players_team_1[Object.keys(players_team_1)[i]], 1, i+1, heroes_in_panel)
    } 

    let buttonpredict_duo = $.CreatePanel("Panel", heroes_in_panel, "buttonpredict_duo")
    buttonpredict_duo.AddClass("buttonpredict_duo")
    buttonpredict_duo.SetPanelEvent("onactivate", function() 
	{
		if (!CanSendDuelBet()) return;
		GameEvents.SendCustomGameEventToServer_custom("woda_select_duel_player", {team : data.players_id_1.teamnumber});
        buttonpredict_duo_2.SetHasClass("selected", false)
        buttonpredict_duo.SetHasClass("selected", false)
        buttonpredict_duo.SetHasClass("selected", true)
	});

    let buttonpredict_duo_label = $.CreatePanel("Label", buttonpredict_duo, "buttonpredict_duo")
    buttonpredict_duo_label.AddClass("buttonpredict_duo_label")
    buttonpredict_duo_label.text = $.Localize("#predict")
 
    let vslogo = $.CreatePanel("Panel", $("#panelheroes"), "")
    vslogo.AddClass("vslogo")

    let heroes_in_panel_2 = $.CreatePanel("Panel", $("#panelheroes"), "")
    heroes_in_panel_2.AddClass("heroes_in_panel")

    for (let i = 0; i < Object.keys(players_team_2).length; i++) 
    {
        CreatePlayerPanelDuel(players_team_2[Object.keys(players_team_2)[i]], 2, i+1, heroes_in_panel_2)
    }

    let buttonpredict_duo_2 = $.CreatePanel("Panel", heroes_in_panel_2, "buttonpredict_duo_2")
    buttonpredict_duo_2.AddClass("buttonpredict_duo")
    buttonpredict_duo_2.SetPanelEvent("onactivate", function() 
	{
		if (!CanSendDuelBet()) return;
		GameEvents.SendCustomGameEventToServer_custom("woda_select_duel_player", {team : data.players_id_2.teamnumber});
        buttonpredict_duo_2.SetHasClass("selected", false)
        buttonpredict_duo.SetHasClass("selected", false)
        buttonpredict_duo_2.SetHasClass("selected", true)
	});
    let buttonpredict_duo_2_label = $.CreatePanel("Label", buttonpredict_duo_2, "buttonpredict_duo_2")
    buttonpredict_duo_2_label.AddClass("buttonpredict_duo_label")
    buttonpredict_duo_2_label.text = $.Localize("#predict")

    SetDuelBetLocked(IsDuelBetTimeEnded())

    if (predictactive) 
    {
		buttonpredict_duo.style.visibility = "visible"
		buttonpredict_duo_2.style.visibility = "visible"
	} 
    else 
    {
		buttonpredict_duo.style.visibility = "collapse"
		buttonpredict_duo_2.style.visibility = "collapse"
	}
 
	if (data.lose == true || data.lose == 1)
    {
        $("#lose_arena").style.opacity = 1
    } else {
        $("#unlose_arena").style.opacity = 1
    }

    $("#panelduel").SetHasClass("IsDuoMode", true)
    $("#PanelBoss").style.visibility = "collapse"
    $("#panelheroes").style.visibility = "visible"

    StartDuelBetTime(data)
}

function CreatePlayerPanelDuel(id, player_team, player_count, heroes_in_panel)
{
    let playerInfo = Game.GetPlayerInfo( Number(id) );

    let panelhero = $.CreatePanel("Panel", heroes_in_panel, "")
    panelhero.AddClass("panelhero")
 
    let heroinfo = $.CreatePanel("Panel", panelhero, "")
    heroinfo.AddClass("heroinfo"+player_team)

    // talents
    let herotalents = $.CreatePanel("Panel", heroinfo, "")
    herotalents.AddClass("herotalents")
    let herotalentslot_1 = $.CreatePanel("Panel", herotalents, "")
    herotalentslot_1.AddClass("herotalentslot"+player_team)
    let herotalenticonstr = $.CreatePanel("Panel", herotalentslot_1, "")
    herotalenticonstr.AddClass("herotalenticonstr")
    let herotalentstr1 = $.CreatePanel("Label", herotalentslot_1, "")
    herotalentstr1.AddClass("herotalentlabel")

    let herotalentslot_2 = $.CreatePanel("Panel", herotalents, "")
    herotalentslot_2.AddClass("herotalentslot"+player_team)
    let herotalenticonagi = $.CreatePanel("Panel", herotalentslot_2, "")
    herotalenticonagi.AddClass("herotalenticonagi")
    let herotalentagi1 = $.CreatePanel("Label", herotalentslot_2, "")
    herotalentagi1.AddClass("herotalentlabel")

    let herotalentslot_3 = $.CreatePanel("Panel", herotalents, "")
    herotalentslot_3.AddClass("herotalentslot"+player_team)
    let herotalenticonint = $.CreatePanel("Panel", herotalentslot_3, "")
    herotalenticonint.AddClass("herotalenticonint")
    let herotalentint1 = $.CreatePanel("Label", herotalentslot_3, "")
    herotalentint1.AddClass("herotalentlabel")

    let playerstalents_table = Game.GetCustomTable("playerstalents", String(id))
	if (playerstalents_table) 
	{
		herotalentstr1.text = playerstalents_table["str"] || 0
		herotalentagi1.text = playerstalents_table["agi"] || 0
		herotalentint1.text = playerstalents_table["int"] || 0
	}

    // icon and level
    let heroicon = $.CreatePanel("Panel", heroinfo, "heroicon"+player_team)
    heroicon.AddClass("heroicon"+player_team)
    heroicon.style.backgroundImage='url("file://{images}/heroes/' + GetPortraitHero(playerInfo.player_selected_hero) + '.png")'
	heroicon.style.backgroundSize="100%"

    heroicon.SetPanelEvent("onactivate", function() 
	{
		GameUI.SelectUnit( playerInfo.player_selected_hero_entity_index, false )
	});

    let HeroLevelPanel = $.CreatePanel("Panel", heroicon, "HeroLevelPanel_"+player_team)
    HeroLevelPanel.AddClass("HeroLevelPanel_"+player_team)
    let HeroLevelLabel = $.CreatePanel("Label", HeroLevelPanel, "")
    HeroLevelLabel.AddClass("HeroLevelLabel")

    // items
    let ItemPanel = $.CreatePanel("Panel", panelhero, "ItemPanel_"+player_team)
    ItemPanel.AddClass("ItemPanel_"+player_team)

    let ItemPanel_inventory = $.CreatePanel("Panel", ItemPanel, "ItemPanel_"+player_team+"_inventory")
    ItemPanel_inventory.AddClass("ItemPanel_"+player_team+"_inventory")

    let NeutralSlots = $.CreatePanel("Panel", ItemPanel, "")
    NeutralSlots.AddClass("NeutralSlots")

    let ItemPanel_neutral = $.CreatePanel("Panel", NeutralSlots, "ItemPanel_"+player_team+"_neutral")
    ItemPanel_neutral.AddClass("ItemPanel_"+player_team+"_neutral")
    ItemPanel_neutral.neutral_id = -1

    let ItemPanel_neutral_passive = $.CreatePanel("Panel", NeutralSlots, "ItemPanel_"+player_team+"_neutral_passive")
    ItemPanel_neutral_passive.AddClass("ItemPanel_"+player_team+"_neutral_passive")
    ItemPanel_neutral_passive.neutral_id = -1

    CheckItemsPlayer(playerInfo.player_selected_hero_entity_index, ItemPanel_inventory, ItemPanel_neutral, HeroLevelLabel, ItemPanel_neutral_passive)
}

function CheckItemsPlayer(player, item_panel, item_neutral, HeroLevelLabel, item_neutral_passive)
{
    if ($("#panelduel").style.opacity == 0 || $("#panelduel").style.opacity == "0") 
    {
        return
    }

    var EntityItems = [];
    var EntityItemsNames = [];
    var neutral_item_id = -1;
    var neutral_item_name = ""
    var neutral_item_id_passive = -1;
    var neutral_item_name_passive = ""

    for (var i = 0; i <= 5; i++) 
    {
        var item = Entities.GetItemInSlot(player, i);
        if (item !== -1)
        {
            EntityItems.push(item);
            EntityItemsNames.push(Abilities.GetAbilityName(item));
        }
    }

    HeroLevelLabel.text = Entities.GetLevel( player )

    var neutral_item = Entities.GetItemInSlot(player, 16);
    if (neutral_item !== -1)
    {
        neutral_item_id = neutral_item;
        neutral_item_name = Abilities.GetAbilityName(neutral_item)
    }

    var neutral_item_passive = Entities.GetItemInSlot(player, 17);
    if (neutral_item_passive !== -1)
    {
        neutral_item_id_passive = neutral_item_passive;
        neutral_item_name_passive = Abilities.GetAbilityName(neutral_item_passive)
    }

    if (!isEqual(EntityItemsNames, item_panel.EntityItemsNames) || item_panel.GetChildCount() <= 0) 
    {
        item_panel.RemoveAndDeleteChildren()
        for (k in EntityItems)
        {
            var item = EntityItems[k];
            var itemName = Abilities.GetAbilityName(item);
            let itemImage = $.CreatePanel("DOTAItemImage", item_panel, "");
            //itemImage.abilityId = item;
            itemImage.itemname = itemName;
            itemImage.SetPanelEvent("onmouseover", ShowItemTooltip(itemImage));
            itemImage.SetPanelEvent("onmouseout", HideItemTooltip(itemImage));
        }
        item_panel.EntityItems = EntityItems;
        item_panel.EntityItemsNames = EntityItemsNames;
    }
    if ( (item_neutral.neutral_id != neutral_item_id || item_neutral.GetChildCount() <= 0 ) && neutral_item_id != -1)
    {
        item_neutral.RemoveAndDeleteChildren()
        item_neutral.neutral_id = neutral_item_id
        var item_n = neutral_item_id;
        var itemName = Abilities.GetAbilityName(item_n);
        let itemImage = $.CreatePanel("DOTAItemImage", item_neutral, "neutral_item");
        itemImage.style.verticalAlign = "center"
        //itemImage.abilityId = item_n;
        itemImage.itemname = itemName;
        itemImage.SetPanelEvent("onmouseover", ShowItemTooltip(itemImage));
        itemImage.SetPanelEvent("onmouseout", HideItemTooltip(itemImage));
    }
    else if (neutral_item_id == -1)
    {
        item_neutral.RemoveAndDeleteChildren()
    }

    if ( (item_neutral_passive.neutral_id != neutral_item_id_passive || item_neutral_passive.GetChildCount() <= 0 ) && neutral_item_id_passive != -1)
    {
        item_neutral_passive.RemoveAndDeleteChildren()
        item_neutral_passive.neutral_id = neutral_item_id_passive
        var item_n = neutral_item_id_passive;
        var itemName = Abilities.GetAbilityName(item_n);
        let itemImage = $.CreatePanel("DOTAItemImage", item_neutral_passive, "item_neutral_passive");
        itemImage.style.verticalAlign = "center"
        //itemImage.abilityId = item_n;
        itemImage.itemname = itemName;
        itemImage.SetPanelEvent("onmouseover", ShowItemTooltip(itemImage));
        itemImage.SetPanelEvent("onmouseout", HideItemTooltip(itemImage));
    }
    else if (neutral_item_id_passive == -1)
    {
        item_neutral_passive.RemoveAndDeleteChildren()
    }

    $.Schedule(0.5, function() 
    {
        CheckItemsPlayer(player, item_panel, item_neutral, HeroLevelLabel, item_neutral_passive)
    });
}

function startduel(data)
{
	$("#buttonpredict1").SetHasClass("selected", false)
	$("#buttonpredict2").SetHasClass("selected", false)
	$("#paneldueltimer2").SetHasClass("animation", false)
	$("#lose_arena").style.opacity = 0
    $("#unlose_arena").style.opacity = 0
	$("#paneldueltimer2").style['width'] = "100" +'%';
	let predictactive = true
	if (data.player_id_1 == Players.GetLocalPlayer() || data.player_id_2 == Players.GetLocalPlayer()) {
		predictactive = false
	}
	var playerInfo_1 = Game.GetPlayerInfo( data.player_id_1 );
	var playerInfo_2 = Game.GetPlayerInfo( data.player_id_2 );

    let icon_1 = GetPortraitHero(playerInfo_1.player_selected_hero)
    let icon_2 = GetPortraitHero(playerInfo_2.player_selected_hero)

	$("#heroicon1").style.backgroundImage='url("file://{images}/heroes/' + icon_1 + '.png")'
	$("#heroicon2").style.backgroundImage='url("file://{images}/heroes/' + icon_2 + '.png")'
	$("#heroicon1").style.backgroundSize="100%"
	$("#heroicon2").style.backgroundSize="100%"
	let table1 = Game.GetCustomTable("playerstalents", String(data.player_id_1))
	let table2 = Game.GetCustomTable("playerstalents", String(data.player_id_2))
	if (table1) {
		$("#herotalentstr1").text = table1["str"] || 0
		$("#herotalentagi1").text = table1["agi"] || 0
		$("#herotalentint1").text = table1["int"] || 0
	}
	if (table2) {
		$("#herotalentstr2").text = table2["str"] || 0
		$("#herotalentagi2").text = table2["agi"] || 0
		$("#herotalentint2").text = table2["int"] || 0
	}
	if (predictactive) {
		$("#buttonpredict1").style.visibility = "visible"
		$("#buttonpredict2").style.visibility = "visible"
	} else {
		$("#buttonpredict1").style.visibility = "collapse"
		$("#buttonpredict2").style.visibility = "collapse"
	}
	$("#buttonpredict1").SetPanelEvent("onactivate", function() 
	{
		if (!CanSendDuelBet()) return;
		GameEvents.SendCustomGameEventToServer_custom("woda_select_duel_player", {player_id:data.player_id_1,});
		selectbutton($("#buttonpredict1"))
	});
	$("#buttonpredict2").SetPanelEvent("onactivate", function() 
	{
	    if (!CanSendDuelBet()) return;
	    GameEvents.SendCustomGameEventToServer_custom("woda_select_duel_player", {player_id:data.player_id_2,});
	    selectbutton($("#buttonpredict2"))
	});
	$("#heroicon1").SetPanelEvent("onactivate", function() 
	{
		GameUI.SelectUnit( playerInfo_1.player_selected_hero_entity_index, false )
	});
	$("#heroicon2").SetPanelEvent("onactivate", function() 
	{
		GameUI.SelectUnit( playerInfo_2.player_selected_hero_entity_index, false )
	});
	if (data.lose == true || data.lose == 1)
	{
		$("#lose_arena").style.opacity = 1
	} else {
        $("#unlose_arena").style.opacity = 1
    }
	$("#PanelBoss").style.visibility = "collapse"
	$("#panelheroes").style.visibility = "visible"
	$("#panelduel").style.opacity = 1
    CheckItemsPlayer_One(playerInfo_1.player_selected_hero_entity_index)
    CheckItemsPlayer_One2(playerInfo_2.player_selected_hero_entity_index)
    StartDuelBetTime(data)
}

function wodaset_startduel_boss(data)
{
    StopDuelBetTime()
	$("#PanelBoss").style.backgroundImage='url("file://{images}/custom_game/talents/bg_boss_' + data.boss + '.png")'
	$("#PanelBoss").style.backgroundSize="100%"
	$("#paneldueltimer2").SetHasClass("animation", false)
	$("#paneldueltimer2").style['width'] = "100" +'%';
	$("#PanelBoss").style.visibility = "visible"
	$("#panelheroes").style.visibility = "collapse"
	$("#panelduel").style.opacity = 1
}

function dueltimer(data)
{
	$("#paneldueltimer2").SetHasClass("animation", true)
	let percent = ((data.full_time-(data.time-1))*100)/data.full_time
    $("#paneldueltimer2").style['width'] = (100 - percent) +'%';

    if (data.time > 0 && data.lose != undefined)
    {
        if (data.lose == true || data.lose == 1)
        {
            $("#lose_arena").style.opacity = 1
            $("#unlose_arena").style.opacity = 0
        } 
        else 
        {
            $("#unlose_arena").style.opacity = 1
            $("#lose_arena").style.opacity = 0
        }
    }
    else
    {
        $("#unlose_arena").style.opacity = 0
	    $("#lose_arena").style.opacity = 0
    }
}

function removeduel(data)
{
    StopDuelBetTime()
    let buttons = GetDuelBetButtons();
    for (let i = 0; i < buttons.length; i++)
    {
        if (buttons[i])
        {
            buttons[i].SetHasClass("NoBetTime", false);
            buttons[i].style.visibility = "collapse";
        }
    }
    $("#unlose_arena").style.opacity = 0
	$("#lose_arena").style.opacity = 0
	$("#panelduel").style.opacity = 0
}

function selectbutton(panel)
{
	$("#buttonpredict1").SetHasClass("selected", false)
	$("#buttonpredict2").SetHasClass("selected", false)
	panel.SetHasClass("selected", true)
}

function CheckItemsPlayer_One(player)
{
    if ($("#panelduel").style.opacity == 0 || $("#panelduel").style.opacity == "0") 
    {
        return
    }

    let item_panel = $("#ItemPanel_1_inventory")
    let item_neutral = $("#ItemPanel_1_neutral")
    let item_neutral_passive = $("#ItemPanel_1_neutral_passive")
    var EntityItems = [];
    var EntityItemsNames = [];
    var neutral_item_id = -1;
    var neutral_item_name = ""
    var neutral_item_id_passive = -1;
    var neutral_item_name_passive = ""

    for (var i = 0; i <= 5; i++) 
    {
        var item = Entities.GetItemInSlot(player, i);
        if (item !== -1)
        {
            EntityItems.push(item);
            EntityItemsNames.push(Abilities.GetAbilityName(item));
        }
    }

    $("#HeroLevelLabel_1").text = Entities.GetLevel( player )

    var neutral_item = Entities.GetItemInSlot(player, 16);
    if (neutral_item !== -1)
    {
        neutral_item_id = neutral_item;
        neutral_item_name = Abilities.GetAbilityName(neutral_item)
    }

    var neutral_item_passive = Entities.GetItemInSlot(player, 17);
    if (neutral_item_passive !== -1)
    {
        neutral_item_id_passive = neutral_item_passive;
        neutral_item_name_passive = Abilities.GetAbilityName(neutral_item_passive)
    }

    if (!isEqual(EntityItemsNames, item_panel.EntityItemsNames) || item_panel.GetChildCount() <= 0) 
    {
        item_panel.RemoveAndDeleteChildren()
        for (k in EntityItems)
        {
            var item = EntityItems[k];
            var itemName = Abilities.GetAbilityName(item);
            let itemImage = $.CreatePanel("DOTAItemImage", item_panel, "");
            //itemImage.abilityId = item;
            itemImage.itemname = itemName;
            itemImage.SetPanelEvent("onmouseover", ShowItemTooltip(itemImage));
            itemImage.SetPanelEvent("onmouseout", HideItemTooltip(itemImage));
        }
        item_panel.EntityItems = EntityItems;
        item_panel.EntityItemsNames = EntityItemsNames;
    }
    if ( (item_neutral.neutral_id != neutral_item_id || item_neutral.GetChildCount() <= 0 ) && neutral_item_id != -1)
    {
        item_neutral.RemoveAndDeleteChildren()
        item_neutral.neutral_id = neutral_item_id
        var item_n = neutral_item_id;
        var itemName = Abilities.GetAbilityName(item_n);
        let itemImage = $.CreatePanel("DOTAItemImage", item_neutral, "neutral_item");
        itemImage.style.verticalAlign = "center"
        //itemImage.abilityId = item_n;
        itemImage.itemname = itemName;
        itemImage.SetPanelEvent("onmouseover", ShowItemTooltip(itemImage));
        itemImage.SetPanelEvent("onmouseout", HideItemTooltip(itemImage));
    }
    else if (neutral_item_id == -1)
    {
        item_neutral.RemoveAndDeleteChildren()
    }

    if ( (item_neutral_passive.neutral_id != neutral_item_id_passive || item_neutral_passive.GetChildCount() <= 0 ) && neutral_item_id_passive != -1)
    {
        item_neutral_passive.RemoveAndDeleteChildren()
        item_neutral_passive.neutral_id = neutral_item_id_passive
        var item_n = neutral_item_id_passive;
        var itemName = Abilities.GetAbilityName(item_n);
        let itemImage = $.CreatePanel("DOTAItemImage", item_neutral_passive, "neutral_item_passive");
        itemImage.style.verticalAlign = "center"
        //itemImage.abilityId = item_n;
        itemImage.itemname = itemName;
        itemImage.SetPanelEvent("onmouseover", ShowItemTooltip(itemImage));
        itemImage.SetPanelEvent("onmouseout", HideItemTooltip(itemImage));
    }
    else if (neutral_item_id_passive == -1)
    {
        item_neutral_passive.RemoveAndDeleteChildren()
    }

    $.Schedule(0.5, function() 
    {
        CheckItemsPlayer_One(player)
    });
}

function CheckItemsPlayer_One2(player)
{
    if ($("#panelduel").style.opacity == 0 || $("#panelduel").style.opacity == "0") 
    {
        return
    }

    let item_panel = $("#ItemPanel_2_inventory")
    let item_neutral = $("#ItemPanel_2_neutral")
    let item_neutral_passive = $("#ItemPanel_2_neutral_passive")
    var EntityItems = [];
    var EntityItemsNames = [];
    var neutral_item_id = -1;
    var neutral_item_name = ""
    var neutral_item_id_passive = -1;
    var neutral_item_name_passive = ""

    for (var i = 0; i <= 5; i++) 
    {
        var item = Entities.GetItemInSlot(player, i);
        if (item !== -1)
        {
            EntityItems.push(item);
            EntityItemsNames.push(Abilities.GetAbilityName(item));
        }
    }

    $("#HeroLevelLabel_2").text = Entities.GetLevel( player )

    var neutral_item = Entities.GetItemInSlot(player, 16);
    if (neutral_item !== -1)
    {
        neutral_item_id = neutral_item;
        neutral_item_name = Abilities.GetAbilityName(neutral_item)
    }

    var neutral_item_passive = Entities.GetItemInSlot(player, 17);
    if (neutral_item_passive !== -1)
    {
        neutral_item_id_passive = neutral_item_passive;
        neutral_item_name_passive = Abilities.GetAbilityName(neutral_item_passive)
    }

    if (!isEqual(EntityItemsNames, item_panel.EntityItemsNames) || item_panel.GetChildCount() <= 0) 
    {
        
        item_panel.RemoveAndDeleteChildren()
        for (k in EntityItems)
        {
            
            var item = EntityItems[k];
            var itemName = Abilities.GetAbilityName(item);
            let itemImage = $.CreatePanel("DOTAItemImage", item_panel, "");
            //itemImage.abilityId = item;
            itemImage.itemname = itemName;
            itemImage.SetPanelEvent("onmouseover", ShowItemTooltip(itemImage));
            itemImage.SetPanelEvent("onmouseout", HideItemTooltip(itemImage));
        }
        item_panel.EntityItems = EntityItems;
        item_panel.EntityItemsNames = EntityItemsNames;
    }

    if ( (item_neutral.neutral_id != neutral_item_id || item_neutral.GetChildCount() <= 0 ) && neutral_item_id != -1)
    {
        item_neutral.RemoveAndDeleteChildren()
        item_neutral.neutral_id = neutral_item_id
        var item_n = neutral_item_id;
        var itemName = Abilities.GetAbilityName(item_n);
        let itemImage = $.CreatePanel("DOTAItemImage", item_neutral, "neutral_item");
        itemImage.style.verticalAlign = "center"
        //itemImage.abilityId = item_n;
        itemImage.itemname = itemName;
        itemImage.SetPanelEvent("onmouseover", ShowItemTooltip(itemImage));
        itemImage.SetPanelEvent("onmouseout", HideItemTooltip(itemImage));
    }
    else if (neutral_item_id == -1)
    {
        item_neutral.RemoveAndDeleteChildren()
    }

    if ( (item_neutral_passive.neutral_id != neutral_item_id_passive || item_neutral_passive.GetChildCount() <= 0 ) && neutral_item_id_passive != -1)
    {
        item_neutral_passive.RemoveAndDeleteChildren()
        item_neutral_passive.neutral_id = neutral_item_id_passive
        var item_n = neutral_item_id_passive;
        var itemName = Abilities.GetAbilityName(item_n);
        let itemImage = $.CreatePanel("DOTAItemImage", item_neutral_passive, "neutral_item_passive");
        itemImage.style.verticalAlign = "center"
        //itemImage.abilityId = item_n;
        itemImage.itemname = itemName;
        itemImage.SetPanelEvent("onmouseover", ShowItemTooltip(itemImage));
        itemImage.SetPanelEvent("onmouseout", HideItemTooltip(itemImage));
    }
    else if (neutral_item_id_passive == -1)
    {
        item_neutral_passive.RemoveAndDeleteChildren()
    }

    $.Schedule(0.5, function() 
    {
        CheckItemsPlayer_One2(player)
    });
}

function isEqual(a, b)
{
    if (a instanceof Array && b instanceof Array)
    {
        if (a.length !== b.length) {
            return false;
        }
 
        for (var i = 0; i < a.length; i++)
        {
            if (!isEqual(a[i], b[i])) {
                return false;
            }
        }
 
        return true;
    }
 
    return a === b;
}

var ShowItemTooltip = ( function( item )
{
    return function()
    {
        $.DispatchEvent( "DOTAShowAbilityTooltip", item, item.itemname );
    }
});

var HideItemTooltip = ( function( item )
{
    return function()
    {
        $.DispatchEvent( "DOTAHideAbilityTooltip", item );
    }
});