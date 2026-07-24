--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var CURRENT_TARGET_PLAYER_ID = null
var CHEATS_BLOCKS =
{
    "container_cheats_1" :  // общие
    {
        "1" :
        {
            "icon" : "file://{images}/spellicons/dark_willow_terrorize.png",
            "name" : "Урон статов",
            "lua_event_name" : "DamageFromAttributes",
            "IsToggle" : "true",
        },
        "2" :
        {
            "icon" : "file://{images}/spellicons/fel_beast_haunt.png",
            "name" : "КД рюкзака",
            "lua_event_name" : "IncreaseBackpackSwapCooldown",
            "IsToggle" : "true",
        },
        "3" :
        {
            "icon" : "file://{images}/spellicons/forest_troll_high_priest_mana_aura.png",
            "name" : "Черная карта",
            "lua_event_name" : "EnableUnseenFog",
            "IsToggle" : "true",
        },
        "4" :
        {
            "icon" : "file://{images}/spellicons/leoric_lifesteal_aura.png",
            "name" : "Всегда свой инвентарь",
            "lua_event_name" : "EnableAlwaysShowPlayerInventory",
            "IsToggle" : "true",
        },
        "5" :
        {
            "icon" : "file://{images}/spellicons/life_stealer_control.png",
            "name" : "Отключить тайник",
            "lua_event_name" : "EnableStashPurchasing",
            "IsToggle" : "true",
        },
        "6" :
        {
            "icon" : "file://{images}/spellicons/luna_lucent_beam_alt2.png",
            "name" : "Приблизить камеру",
            "lua_event_name" : "ZoomInCamera",
        },
        "7" :
        {
            "icon" : "file://{images}/spellicons/luna_lucent_beam.png",
            "name" : "Обычная камера",
            "lua_event_name" : "NormalCamera",
        },
        "8" :
        {
            "icon" : "file://{images}/spellicons/luna_lucent_beam_alt.png",
            "name" : "Отдаленая камера",
            "lua_event_name" : "ZoomOutCamera",
        },
        "9" :
        {
            "icon" : "file://{images}/spellicons/lion_voodoo.png",
            "name" : "Глобальный Hex",
            "lua_event_name" : "GlobalHex",
        },
        "10" :
        {
            "icon" : "file://{images}/spellicons/night_stalker_darkness.png",
            "name" : "Временная ночь",
            "lua_event_name" : "TemporaryNight",
        },
        "11" :
        {
            "icon" : "file://{images}/spellicons/magnataur_reverse_polarity.png",
            "name" : "Реверсивная поляризация",
            "lua_event_name" : "RP",
        },
        "12" :
        {
            "icon" : "file://{images}/spellicons/lich_dark_sorcery.png",
            "name" : "Скрыть миникарту",
            "lua_event_name" : "HideHudElement",
            "ElementID" : 4,
            "IsToggle" : "true",
        },
        "13" :
        {
            "icon" : "file://{images}/spellicons/lich_dark_sorcery.png",
            "name" : "Скрыть таймер",
            "lua_event_name" : "HideHudElement",
            "ElementID" : 0,
            "IsToggle" : "true",
        },
        "14" :
        {
            "icon" : "file://{images}/spellicons/lich_dark_sorcery.png",
            "name" : "Скрыть инвентарь",
            "lua_event_name" : "HideHudElement",
            "ElementID" : 5,
            "IsToggle" : "true",
        },
        "15" :
        {
            "icon" : "file://{images}/spellicons/lich_dark_sorcery.png",
            "name" : "Скрыть квикбай",
            "lua_event_name" : "HideHudElement",
            "ElementID" : 8,
            "IsToggle" : "true",
        },
        "16" :
        {
            "icon" : "file://{images}/spellicons/lich_dark_sorcery.png",
            "name" : "Скрыть золото",
            "lua_event_name" : "HideHudElement",
            "ElementID" : 11,
            "IsToggle" : "true",
        },
        "17" :
        {
            "icon" : "file://{images}/spellicons/lich_dark_sorcery.png",
            "name" : "Скрыть ниж панель",
            "lua_event_name" : "HideHudElement",
            "ElementID" : 3,
            "IsToggle" : "true",
        },
        "18" :
        {
            "icon" : "file://{images}/spellicons/kunkka_divine_anchor_x_marks.png",
            "name" : "Поменять местами героев",
            "lua_event_name" : "RandomShuffle",
            //@todo:если передано 2 айди поменяет игроков местами если нет поменяет всех игроков
        },
    },
    "container_cheats_2" : // на себя
    {
        "1" :
        {
            "icon" : "file://{images}/spellicons/leshrac_pulse_nova.png",
            "name" : "Неуяз и скорость",
            "lua_event_name" : "CheatMove",
            "IsToggle" : "true",
        },
        "2" :
        {
            "icon" : "file://{images}/spellicons/riki_backstab.png",
            "name" : "Невидимость",
            "lua_event_name" : "CheatInvis",
            "IsToggle" : "true",
        },
        "3" :
        {
            "icon" : "file://{images}/spellicons/watcher_channel.png",
            "name" : "Вижен",
            "lua_event_name" : "CheatViowers",
            "IsToggle" : "true",
        },
        "4" :
        {
            "icon" : "file://{images}/spellicons/storm_spirit_overload_ti8_golden.png",
            "name" : "+1000 золота",
            "lua_event_name" : "AddGold",
        },
        "5" :
        {
            "icon" : "file://{images}/spellicons/storm_spirit_overload_ti8_golden.png",
            "name" : "Новый уровень",
            "lua_event_name" : "LVLUp",
        },
        "6" :
        {
            "icon" : "file://{images}/spellicons/muerta_pierce_the_veil.png",
            "name" : "Возродить",
            "lua_event_name" : "Respawn",
        },
        "7" :
        {
            "icon" : "s2r://panorama/images/custom_game/icons/items/gray_png.vtex",
            "name" : "Серый",
            "lua_event_name" : "AddGrayUpgrade",
        },
        "8" :
        {
            "icon" : "s2r://panorama/images/custom_game/icons/items/blue_png.vtex",
            "name" : "Синий",
            "lua_event_name" : "AddBlueUpgrade",
        },
        "9" :
        {
            "icon" : "s2r://panorama/images/custom_game/icons/items/purple_png.vtex",
            "name" : "Фиолетовый",
            "lua_event_name" : "AddPurpleUpgrade",
        },
        "10" :
        {
            "icon" : "s2r://panorama/images/custom_game/icons/items/orange_png.vtex",
            "name" : "Оранжевый",
            "lua_event_name" : "AddOrangeUpgrade",
        },
    },
    "container_cheats_3" : // на цель
    {
        "1" :
        {
            "icon" : "file://{images}/spellicons/invoker_ghost_walk_persona1.png",
            "name" : "Скрыть модельку",
            "lua_event_name" : "NoDraw",
            "IsToggle" : "true",
        },
        "2" :
        {
            "icon" : "file://{images}/spellicons/black_drake_magic_amplification_aura.png",
            "name" : "Уменьшеный вижен",
            "lua_event_name" : "ChangeVision",
            "IsToggle" : "true",
        },
        "3" :
        {
            "icon" : "file://{images}/spellicons/big_thunder_lizard_wardrums_aura.png",
            "name" : "Экспа в минус",
            "lua_event_name" : "ExpRemoveTimer",
            "IsTimer" : "true",
        },
        "4" :
        {
            "icon" : "file://{images}/spellicons/elder_titan_echo_stomp.png",
            "name" : "Усыпить героя",
            "lua_event_name" : "Sleep",
        },
        "5" :
        {
            "icon" : "file://{images}/spellicons/beastmaster_greater_boar_poison.png",
            "name" : "Скрыть абилку",
            "lua_event_name" : "HideAbility",
            "IsToggle" : "true",
            //@todo:может принимать второй параметр (индекс абилки)
        },
        "6" :
        {
            "icon" : "file://{images}/spellicons/greevil_fatal_bonds.png",
            "name" : "Проклятый слот",
            "lua_event_name" : "CursedSlot",
        },
        "7" :
        {
            "icon" : "file://{images}/spellicons/harpy_scout_take_off.png",
            "name" : "Беспрепятственный обзор",
            "lua_event_name" : "AddFlyVision",
            "IsToggle" : "true",
        },
        "8" :
        {
            "icon" : "file://{images}/spellicons/chen_hand_of_god.png",
            "name" : "Видим всем",
            "lua_event_name" : "VisibleToEveryone",
            "IsTimer" : "true",
        },
        "9" :
        {
            "icon" : "file://{images}/spellicons/chaos_knight_chaos_strike_ti9.png",
            "name" : "Рес на месте смерти",
            "lua_event_name" : "RespawnOnDeathPosition",
            "IsToggle" : "true",
        },
        "10" :
        {
            "icon" : "file://{images}/spellicons/brewmaster_storm_dispel_magic.png",
            "name" : "Разобрать все предметы",
            "lua_event_name" : "DisassembleAllItems",
        },
        "11" :
        {
            "icon" : "file://{images}/spellicons/vengefulspirit_nether_swap.png",
            "name" : "Поменять предметы местами",
            "lua_event_name" : "RandomItemSwap",
        },
        "12" :
        {
            "icon" : "file://{images}/spellicons/omniknight_purification.png",
            "name" : "Полное исцеление",
            "lua_event_name" : "HealOnFull",
        },
        "13" :
        {
            "icon" : "file://{images}/spellicons/warlock_hellborn_upheaval.png",
            "name" : "Поднять полоску здоровья",
            "lua_event_name" : "LiftHealthBar",
        },
        "14" :
        {
            "icon" : "file://{images}/spellicons/furion_hedgerow.png",
            "name" : "Обычная полоса здоровья",
            "lua_event_name" : "NormalHealthBar",
        },
        "15" :
        {
            "icon" : "file://{images}/spellicons/pudge_flesh_heap.png",
            "name" : "Увеличить BAT",
            "lua_event_name" : "IncraseBAT",
        },
        "16" :
        {
            "icon" : "file://{images}/spellicons/granite_golem_bash.png",
            "name" : "Обычный BAT",
            "lua_event_name" : "NormalBAT",
        },
        "17" :
        {
            "icon" : "file://{images}/spellicons/elder_titan_return_spirit.png",
            "name" : "Уменьшить BAT",
            "lua_event_name" : "DecreaseBAT",
        },
        "18" :
        {
            "icon" : "file://{images}/spellicons/juggernaut_fall20_healingward.png",
            "name" : "Убрать иконку с миникарты",
            "lua_event_name" : "RemoveMinimapIcon",
            "IsToggle" : "true",
        },
        "19" :
        {
            "icon" : "file://{images}/spellicons/brewmaster_primal_companion_storm.png",
            "name" : "Отключить пассивки",
            "lua_event_name" : "DisablePassive",
            "IsToggle" : "true",
        },
        "20" :
        {
            "icon" : "file://{images}/spellicons/enchantress_untouchable.png",
            "name" : "Нельзя выбрать целью (сам)",
            "lua_event_name" : "SelfUntargetable",
            "IsToggle" : "true",
        },
        "21" :
        {
            "icon" : "file://{images}/spellicons/earth_spirit_petrify.png",
            "name" : "Нельзя выбрать целью (всем)",
            "lua_event_name" : "Untargetable",
            "IsToggle" : "true",
        },
        "22" :
        {
            "icon" : "file://{images}/spellicons/frostivus2018_decorate_tree.png",
            "name" : "Проход сквозь деревья",
            "lua_event_name" : "AddPathThroughTree",
            "IsToggle" : "true",
        },
        "23" :
        {
            "icon" : "file://{images}/spellicons/modifier_cny2015_speed.png",
            "name" : "Проход сквозь клифы",
            "lua_event_name" : "AddPathThroughCliffs",
            "IsToggle" : "true",
        },
        "24" :
        {
            "icon" : "file://{images}/spellicons/storm_spirit_overload_ti8_golden.png",
            "name" : "+1000 золота",
            "lua_event_name" : "AddGold",
        },
        "25" :
        {
            "icon" : "file://{images}/spellicons/action_patrol.png",
            "name" : "Поменяться модельками",
            "lua_event_name" : "ModelsSwap",
        },
        "26" :
        {
            "icon" : "file://{images}/spellicons/muerta_pierce_the_veil.png",
            "name" : "Возродить",
            "lua_event_name" : "Respawn",
        },
        "27" :
        {
            "icon" : "file://{images}/spellicons/muerta_pierce_the_veil.png",
            "name" : "Новый уровень",
            "lua_event_name" : "LVLUp",
        },
        "28" :
        {
            "icon" : "s2r://panorama/images/custom_game/icons/items/gray_png.vtex",
            "name" : "Серый",
            "lua_event_name" : "AddGrayUpgrade",
        },
        "29" :
        {
            "icon" : "s2r://panorama/images/custom_game/icons/items/blue_png.vtex",
            "name" : "Синий",
            "lua_event_name" : "AddBlueUpgrade",
        },
        "30" :
        {
            "icon" : "s2r://panorama/images/custom_game/icons/items/purple_png.vtex",
            "name" : "Фиолетовый",
            "lua_event_name" : "AddPurpleUpgrade",
        },
        "31" :
        {
            "icon" : "s2r://panorama/images/custom_game/icons/items/orange_png.vtex",
            "name" : "Оранжевый",
            "lua_event_name" : "AddOrangeUpgrade",
        },
    },
}

var TARGET_VISUAL_INFO = {}

function Init()
{
	$( '#ButtonCheatPanel' ).style.visibility = "visible"
    InitCheats();
}

Init();

function OpenMainButton()
{
    $("#PanelChooseTypeCheat").SetHasClass("hidden", !$("#PanelChooseTypeCheat").BHasClass("hidden"))
    $("#CheatsType_1").SetHasClass("hidden", true)
    $("#CheatsType_2").SetHasClass("hidden", true)
    $("#CheatsType_3").SetHasClass("hidden", true) 
    $("#PanelChooseHero").SetHasClass("hidden", true) 
    Game.EmitSound("UI.Click")
}

function OpenCheatType(type)
{
    $("#PanelChooseTypeCheat").SetHasClass("hidden", true)
    
    if (type == 1)
    {
        $("#CheatsType_1").SetHasClass("hidden", false)
    }
    if (type == 2)
    {
        CURRENT_TARGET_PLAYER_ID = Players.GetLocalPlayer()
        $("#CheatsType_2").SetHasClass("hidden", false)
    }
    if (type == 3)
    {
        UpdateAbilityToggle(CURRENT_TARGET_PLAYER_ID);
        $("#CheatsType_3").SetHasClass("hidden", false) 
        $("#PanelChooseHero").SetHasClass("hidden", true) 
    }
    Game.EmitSound("UI.Talent_chose")
}

function PanelChooseHero()
{
    $("#PanelChooseTypeCheat").SetHasClass("hidden", true)
    $("#PanelChooseHero").SetHasClass("hidden", false) 
    UpdatePlayersPanel()
    Game.EmitSound("UI.Talent_chose")
}

function ButtonBack(type)
{
    if (type == 'main')
    {
        $("#PanelChooseTypeCheat").SetHasClass("hidden", !$("#PanelChooseTypeCheat").BHasClass("hidden"))
        $("#CheatsType_1").SetHasClass("hidden", true)
        $("#CheatsType_2").SetHasClass("hidden", true)
        $("#CheatsType_3").SetHasClass("hidden", true) 
        $("#PanelChooseHero").SetHasClass("hidden", true) 
    }
    if (type == 'close')
    {
        $("#PanelChooseTypeCheat").SetHasClass("hidden", true)
        $("#CheatsType_1").SetHasClass("hidden", true)
        $("#CheatsType_2").SetHasClass("hidden", true)
        $("#CheatsType_3").SetHasClass("hidden", true) 
        $("#PanelChooseHero").SetHasClass("hidden", true) 
    }
    if (type == 'heroes')
    {
        $("#CheatsType_1").SetHasClass("hidden", true)
        $("#CheatsType_2").SetHasClass("hidden", true)
        $("#CheatsType_3").SetHasClass("hidden", true) 
        PanelChooseHero()
    }
    Game.EmitSound("UI.Talent_chose")
}

function InitCheats()
{
    for ( var cheat_block in CHEATS_BLOCKS ) 
    {
        for ( var cheat_name in CHEATS_BLOCKS[cheat_block] ) 
        {
            var AblityPanel = $.CreatePanel("Panel", $("#"+String(cheat_block)), CHEATS_BLOCKS[cheat_block][cheat_name]["lua_event_name"]);
            AblityPanel.AddClass("AblityPanel");

            var AbilityImage = $.CreatePanel('Panel', AblityPanel, "");
    	    AbilityImage.AddClass('AbilityImage');
    	    AbilityImage.style.backgroundImage = 'url( "' + CHEATS_BLOCKS[cheat_block][cheat_name]["icon"] + '" )';
    	    AbilityImage.style.backgroundSize = "100% 100%"

            var CheatName = $.CreatePanel("Label", AblityPanel, "");
            CheatName.AddClass("CheatName");
            CheatName.text = $.Localize(CHEATS_BLOCKS[cheat_block][cheat_name]["name"])

            SetCheatEvent(AblityPanel, CHEATS_BLOCKS[cheat_block][cheat_name]["lua_event_name"], CHEATS_BLOCKS[cheat_block][cheat_name]["IsToggle"], CHEATS_BLOCKS[cheat_block][cheat_name]["ElementID"])
        }
    }
}

function SetCheatEvent(panel, event_name, toggle, ElementID )
{
    panel.SetPanelEvent('onactivate', function() 
    {
        $.Msg("current_target_id ", CURRENT_TARGET_PLAYER_ID)
        Game.EmitSound("UI.Click")
        
        if (event_name == "HideHudElement") {
            GameEvents.SendCustomGameEventToServer_custom( "call_cheat_event", {event_name : event_name, target_id : CURRENT_TARGET_PLAYER_ID, ElementID : ElementID});
        }
        else {
            GameEvents.SendCustomGameEventToServer_custom( "call_cheat_event", {event_name : event_name, target_id : CURRENT_TARGET_PLAYER_ID});
        }
        if (toggle)
        {
            panel.SetHasClass("toggle_cheat", !panel.BHasClass("toggle_cheat"))
            if (TARGET_VISUAL_INFO[CURRENT_TARGET_PLAYER_ID] == null)
            {
                TARGET_VISUAL_INFO[CURRENT_TARGET_PLAYER_ID] = {}
            }
            TARGET_VISUAL_INFO[CURRENT_TARGET_PLAYER_ID][event_name] = panel.BHasClass("toggle_cheat")
        }
    });
}

function UpdatePlayersPanel()
{
    var teamsList = [];
    var players = [];
    var end_players = [];
	for ( var teamId of Game.GetAllTeamIDs() )
	{
		teamsList.push( Game.GetTeamDetails( teamId ) );
	}
    for ( var i = 0; i < teamsList.length; ++i )
	{
		let teamId = teamsList[i].team_id;
        let teamPlayers = Game.GetPlayerIDsOnTeam( teamId )
        for ( var d = 0; d < teamPlayers.length; ++d )
	    {
            if (teamPlayers[d] != Players.GetLocalPlayer())
            {
                players.push( teamPlayers[d] );
            }
        }
	}

    let player_1 = getRandomArrayElement(players)
    end_players.push( player_1 );
    players = UpdateArray(players, player_1)
    let player_2 = getRandomArrayElement(players)
    end_players.push( player_2 );
    players = UpdateArray(players, player_2)
    let player_3 = getRandomArrayElement(players)
    end_players.push( player_3 );
    players = UpdateArray(players, player_3)

    UpdateHeroes(end_players);
}

function UpdateArray(array, id)
{
    for ( var d = 0; d < array.length; ++d )
    {
        if (array[d] == id)
        {
            array.splice(d, 1);
            break;
        }
    }
    return array
}

function getRandomArrayElement(arr)
{
    return arr[Math.floor(Math.random()*arr.length)]
}

function UpdateHeroes(array)
{
    $("#HeroesSelected").RemoveAndDeleteChildren()
    for ( var i = 0; i < array.length; ++i )
	{
        let player_id = array[i]
        var playerInfo = Game.GetPlayerInfo( player_id );
        let players_panel = $("#HeroesSelected")
        var playerPanelName = "player_" + player_id;

        let playerPanel = $.CreatePanel( "Panel", players_panel, playerPanelName );
        playerPanel.AddClass("PlayerPanel")

        if ( playerInfo )
        {
            $.CreatePanelWithProperties(`DOTAHeroImage`, playerPanel, "playerHero", {scaling: "stretch-to-cover-preserve-aspect", heroname : String(playerInfo.player_selected_hero), tabindex : "auto", class: "playerHero", heroimagestyle : "portrait"});
        }

        let playerName = $.CreatePanel( "Label", playerPanel, "playerName" );
        playerName.AddClass("TextCard")
        playerName.text = Players.GetPlayerName(player_id) || 'unknown';

        playerPanel.SetPanelEvent("onactivate", function() 
        { 
            OpenCheatMenu(player_id)
        });
    }
}

function OpenCheatMenu(player_id)
{
    CURRENT_TARGET_PLAYER_ID = player_id
    OpenCheatType(3)
    Game.EmitSound("UI.Talent_chose")
}

GameEvents.Subscribe_custom("create_timer_notification_meepo_cheat", TimerCreateInfo);

function UpdateTimerCreateInfo(data)
{
    let notification = $.GetContextPanel().FindChildTraverse("timer_"+data.id)
    if (notification)
    {
        let timer_panel = notification.FindChildTraverse("timer_panel")
        if (timer_panel)
        {
            let time = Math.floor(data.time)
            var min = Math.trunc((time)/60) 
            var sec_n =  (time) - 60*Math.trunc((time)/60) 
            var hour = String( Math.trunc((min)/60) )
            var min = String(min - 60*( Math.trunc(min/60) ))
            var sec = String(sec_n)

            if (sec_n < 10) 
            {
                sec = '0' + sec
            }

            timer_panel.text = Math.floor(min) + ':' +sec

            if (data.time > 0 )
            {
                $.Schedule(1, function() 
                {
                    data.time = data.time - 1
                    UpdateTimerCreateInfo(data)
                })
            }
        }
    }
}

function TimerCreateInfo(data)
{
    let notification = $.CreatePanel("Panel", $("#EffectsTimer"), "timer_"+data.id)
    notification.AddClass("notification")

    $.Schedule(0.1, function() 
    {
        notification.AddClass("visible")
    })
    
    let hero_icon_notif = $.CreatePanel("Panel", notification, "")
    hero_icon_notif.AddClass("hero_icon_notif")
    hero_icon_notif.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + String(data.hero) + '.png" );'
    hero_icon_notif.style.backgroundSize = "100%"
    
    let skill_name_notiff = $.CreatePanel("Label", notification, "")
    skill_name_notiff.AddClass("skill_name_notiff")
    skill_name_notiff.text = data.effect

    let time_notiff = $.CreatePanel("Label", notification, "timer_panel")
    time_notiff.AddClass("time_notiff")

    let time = Math.floor(data.time)
    var min = Math.trunc((time)/60) 
    var sec_n =  (time) - 60*Math.trunc((time)/60) 
    var hour = String( Math.trunc((min)/60) )
    var min = String(min - 60*( Math.trunc(min/60) ))
    var sec = String(sec_n)

    if (sec_n < 10) 
    {
        sec = '0' + sec
    }

    time_notiff.text = Math.floor(min) + ':' +sec

    UpdateTimerCreateInfo({id : data.id, time : data.time})

    $.Schedule(data.time, function() 
    {
        notification.RemoveClass("visible")
    })
 
    notification.DeleteAsync(data.time+1.5)   
}

function UpdateAbilityToggle(id)
{
    for (var i = 0; i < $("#container_cheats_3").GetChildCount(); i++) 
	{
		$("#container_cheats_3").GetChild(i).SetHasClass("toggle_cheat", false)
	}
    if (TARGET_VISUAL_INFO && TARGET_VISUAL_INFO[id])
    {
        for ( var event_check in TARGET_VISUAL_INFO[id] ) 
        {
            let panel_event = $("#container_cheats_3").FindChildTraverse(event_check)
            if (panel_event)
            {
                panel_event.SetHasClass("toggle_cheat", true)
            }
        }
    }
}