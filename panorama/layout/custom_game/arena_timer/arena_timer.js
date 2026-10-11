--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom( 'set_game_time', SetGameTime );
$("#duel_timer_arena_name").style.visibility = "collapse"

function SetGameTime( data )
{
	var time = data.time
	var min = Math.trunc((time)/60) 
    var sec_n =  (time) - 60*Math.trunc((time)/60) 
    var hour = String( Math.trunc((min)/60) )
    var sec = String(sec_n)
    if (sec_n < 10) 
    {
        sec = '0' + sec
    }

	if (Game.IsDayTime()) 
	{
		$( "#arena_game_timer" ).SetHasClass("night_time", false)
	} else {
		$( "#arena_game_timer" ).SetHasClass("night_time", true)
	}
   	$("#arena_game_timer_label").text=min + ':' + sec
}

GameEvents.Subscribe_custom( "set_arena_timer", SetArenaTimer )

function SetArenaTimer( data )	{
    
	if (data.duel == 0) {
		$("#arena_timer").style.visibility = "visible"
		$("#duel_timer").style.visibility = "collapse"
		$("#arena_timer_arena_name").style.visibility = "visible"
		$("#duel_timer_arena_name").style.visibility = "collapse"
		$("#duel_timer_line_up").style['width'] = "220px";
	}
	if (data.full_time - 1 == data.time)
	{
		$("#arena_timer_line_up").SetHasClass("animation", false)
	} else
	{
		$("#arena_timer_line_up").SetHasClass("animation", true)
	}
	if (data.full_time == data.time)
	{
		$("#arena_timer_line_up").SetHasClass("animation", false)
	} else
	{
		$("#arena_timer_line_up").SetHasClass("animation", true)
	}
	if (data.relax == 1)
	{
		$("#arena_timer_line_up").SetHasClass("relax", true)
	} else
	{
		$("#arena_timer_line_up").SetHasClass("relax", false)
	}
	$("#arena_timer_line_up").SetHasClass("boss", data.boss == 1)
	let percent = ((data.full_time-data.time))/data.full_time
    $("#arena_timer_line_up").style['width'] = (220 * ((1 - percent))) +'px';
    var time = data.time
	var min = Math.trunc((time)/60) 
    var sec_n =  (time) - 60*Math.trunc((time)/60) 
    var hour = String( Math.trunc((min)/60) )
    var sec = String(sec_n)
    if (sec_n < 10) 
    {
        sec = '0' + sec
    }
   	$("#arena_timer_line_label").text=min + ':' + sec
}

function FormatArenaWaveTitle(wave, creep)
{
	if (!IsArenaTimerPveMap())
	{
		return $.Localize("#wave") + wave + ": " + $.Localize("#" + creep)
	}
	var number = Math.max(1, Number(wave) || 1)
	var stage = Math.floor((number - 1) / 10) + 1
	var stage_wave = (number - 1) % 10 + 1
	var head = $.Localize("#arena_timer_pve_title").replace("{stage}", String(stage)).replace("{wave}", String(stage_wave))
	var name = $.Localize("#" + creep)
	return head + " | " + name
}

function IsArenaTimerPveMap()
{
	return /^(arena|1_player|4_player)$/.test(Game.GetMapInfo().map_display_name)
}

function GetArenaTimerDifficulty()
{
	var state = Game.GetCustomTable("custom_pick", "arena_difficulty")
	if (state && state.level) { return Number(state.level) || 1 }
	return 1
}

function AddRoundDifficultyBadge()
{
	if (!IsArenaTimerPveMap()) { return }
	var badge = $.CreatePanel("Panel", $("#AbilitiesRound"), "RoundDifficultyBadge")
	badge.AddClass("RoundDifficultyBadge")
	badge.style.backgroundImage = 'url("file://{images}/custom_game/shop/difficulty_level_badge.png")'
	badge.style.backgroundSize = "100%"
	var number = $.CreatePanel("Label", badge, "")
	number.AddClass("RoundDifficultyBadgeNumber")
	number.text = String(GetArenaTimerDifficulty())
	badge.SetPanelEvent("onmouseover", function()
	{
		ShowRoundDifficultyTooltip(badge)
	})
	badge.SetPanelEvent("onmouseout", function()
	{
		$.DispatchEvent("DOTAHideTitleTextTooltip", badge)
	})
	$("#AbilitiesRound").style.opacity = "1"
	UpdateRoundRoomFeature()
}

function ShowRoundDifficultyTooltip(badge)
{
	var info = CustomNetTables.GetTableValue("map_info", "pve_difficulty")
	var level = info && info.level ? Number(info.level) : GetArenaTimerDifficulty()
	var title = $.Localize("#arena_difficulty_tooltip_title").replace("{level}", String(level))
	if (!info)
	{
		$.DispatchEvent("DOTAShowTitleTextTooltip", badge, title, "")
		return
	}
	var global_damage = Number(info.global_damage) || 0
	var final_room = Number(info.final_room)
	var text = $.Localize("#arena_difficulty_tooltip_text")
		.replace("{final_room}", final_room >= 0 ? $.Localize("#arena_room_" + final_room) : "")
		.replace("{final_boss}", info.final_boss ? $.Localize("#" + info.final_boss) : "")
		.replace("{global_damage}", (global_damage > 0 ? "+" : "") + global_damage)
		.replace("{reduction_ignore}", String(Number(info.reduction_ignore) || 0))
		.replace("{status_resistance}", String(Number(info.status_resistance) || 0))
		.replace("{debuff_amplify}", String(Number(info.debuff_amplify) || 0))
		.replace("{accuracy}", String(Number(info.accuracy) || 0))
	$.DispatchEvent("DOTAShowTitleTextTooltip", badge, title, text)
}

function GetRoomFeatureIconPath(icon)
{
	if (icon.indexOf("woda_arena_feature_") == 0)
	{
		return "file://{images}/custom_game/arena_rooms/features/" + icon + ".png"
	}
	if (icon.indexOf("item_") == 0)
	{
		return "s2r://panorama/images/items/" + icon.substring(5) + "_png.vtex"
	}
	return "s2r://panorama/images/spellicons/" + icon + "_png.vtex"
}

function UpdateRoundRoomFeature()
{
	if (!IsArenaTimerPveMap()) { return }
	var round = $("#AbilitiesRound")
	var panel = round.FindChildTraverse("RoundRoomFeature")
	var state = CustomNetTables.GetTableValue("map_info", "room_feature")
	var room = state ? Number(state.room) : -1
	if (!state || !state.icon || room < 0)
	{
		if (panel) { panel.visible = false }
		return
	}
	if (!panel)
	{
		panel = $.CreatePanel("Panel", round, "RoundRoomFeature")
		panel.AddClass("RoundAbility")
		panel.AddClass("RoundRoomFeature")
		var icon = $.CreatePanel("Panel", panel, "RoundRoomFeatureIcon")
		icon.AddClass("RoundRoomFeatureIcon")
	}
	panel.visible = true
	var badge = round.FindChildTraverse("RoundDifficultyBadge")
	if (badge) { round.MoveChildAfter(panel, badge) }
	var icon_panel = panel.FindChildTraverse("RoundRoomFeatureIcon")
	icon_panel.style.backgroundImage = 'url("' + GetRoomFeatureIconPath(state.icon) + '")'
	icon_panel.style.backgroundSize = "100%"
	panel.SetPanelEvent("onmouseover", function()
	{
		var title = Number(state.title) == 1 ? $.Localize("#arena_room_feature_title_" + room) : $.Localize("#arena_room_" + room)
		$.DispatchEvent("DOTAShowTitleTextTooltip", panel, title, $.Localize("#arena_room_feature_" + room))
	})
	panel.SetPanelEvent("onmouseout", function()
	{
		$.DispatchEvent("DOTAHideTitleTextTooltip", panel)
	})
	round.style.opacity = "1"
}

CustomNetTables.SubscribeNetTableListener("map_info", function(table_name, key, value)
{
	if (key == "room_feature")
	{
		UpdateRoundRoomFeature()
	}
})

$.Schedule(1, function()
{
	if (IsArenaTimerPveMap() && $("#AbilitiesRound").GetChildCount() == 0)
	{
		AddRoundDifficultyBadge()
	}
})

function GetRoundSkillNames(skills)
{
	var keys = Object.keys(skills || {})
	if (keys.length > 0 && typeof skills[keys[0]] === "string")
	{
		keys.sort(function(a, b) { return Number(a) - Number(b) })
		return keys.map(function(key) { return skills[key] })
	}
	return keys
}

GameEvents.Subscribe_custom( "arena_timer_arena_name", SetArenaName )

function SetArenaName( data )
{
	if (data.wave)
	{
        if ((typeof data.skills !== 'undefined'))
        {
            $("#AbilitiesRound").RemoveAndDeleteChildren()
            AddRoundDifficultyBadge()
            var skill_names = GetRoundSkillNames(data.skills)
            for (var i = 0; i < skill_names.length; i++)
            {
                var ability_panel = $.CreatePanel('DOTAAbilityImage', $("#AbilitiesRound"), '');
                ability_panel.abilityname = skill_names[i];
                ability_panel.AddClass('RoundAbility');
                SetShowAbDesc(ability_panel, skill_names[i]);
            }
            if (Object.keys(data.skills).length <= 0 && !IsArenaTimerPveMap())
            {
                $("#AbilitiesRound").style.opacity = "0"
            } else {
                $("#AbilitiesRound").style.opacity = "1"
            }
        }
		$("#arena_timer_arena_name").text = FormatArenaWaveTitle(data.wave, data.creep)
		return
}
	$("#arena_timer_arena_name").text = $.Localize("#" + data.name)
}

GameEvents.Subscribe_custom( "arena_timer_arena_name_wave", arena_timer_arena_name_wave )

function arena_timer_arena_name_wave( data )
{
	if (data.kills)
	{
		$("#duel_timer_arena_name").text = $.Localize("#kills_to_win") + " " + data.kills
		return
	}
    if ((typeof data.skills !== 'undefined'))
    {
        $("#AbilitiesRound").RemoveAndDeleteChildren()
        AddRoundDifficultyBadge()
        var skill_names = GetRoundSkillNames(data.skills)
        for (var i = 0; i < skill_names.length; i++)
        {
            var ability_panel = $.CreatePanel('DOTAAbilityImage', $("#AbilitiesRound"), '');
            ability_panel.abilityname = skill_names[i];
            ability_panel.AddClass('RoundAbility');
            SetShowAbDesc(ability_panel, skill_names[i]);
        }
        if (Object.keys(data.skills).length <= 0 && !IsArenaTimerPveMap())
        {
            $("#AbilitiesRound").style.opacity = "0"
        } else {
            $("#AbilitiesRound").style.opacity = "1"
        }
    }
	$("#duel_timer_arena_name").text = FormatArenaWaveTitle(data.wave, data.creep)
}

GameEvents.Subscribe_custom( "set_arena_timer_duel", SetArenaTimerDuel )

function SetArenaTimerDuel( data )	
{
	$("#arena_timer").style.visibility = "collapse"
	$("#duel_timer").style.visibility = "visible"
	$("#arena_timer_arena_name").style.visibility = "collapse"
	$("#duel_timer_arena_name").style.visibility = "visible"
	$("#duel_timer_line_up").SetHasClass("pve_blue", data.color == "blue")
	if (data.full_time - 1 == data.time)
	{
		$("#duel_timer_line_up").SetHasClass("animation", false)
	} else
	{
		$("#duel_timer_line_up").SetHasClass("animation", true)
	}
	if (data.full_time == data.time)
	{
		$("#duel_timer_line_up").SetHasClass("animation", false)
	} else
	{
		$("#duel_timer_line_up").SetHasClass("animation", true)
	}
	let percent = ((data.full_time-data.time))/data.full_time
    $("#duel_timer_line_up").style['width'] = (220 * ((1 - percent))) +'px';
    var time = data.time
	var min = Math.trunc((time)/60) 
    var sec_n =  (time) - 60*Math.trunc((time)/60) 
    var hour = String( Math.trunc((min)/60) )
    var min = String(min - 60*( Math.trunc(min/60) ))
    var sec = String(sec_n)
    if (sec_n < 10) 
    {
        sec = '0' + sec
    }
   	$("#duel_timer_line_label").text=min + ':' + sec
}

GameEvents.Subscribe_custom( "skip_arena_button_visible", skip_arena_button_visible )

function skip_arena_button_visible()
{
	$("#SkipArena").style.visibility = "visible"
}

GameEvents.Subscribe_custom( "skip_arena_button_unvisible", skip_arena_button_unvisible )

function skip_arena_button_unvisible()
{
	$("#SkipArena").style.visibility = "collapse"
}

function skip_arena()
{
	GameEvents.SendCustomGameEventToServer_custom( "skip_current_arena", {} );
	skip_arena_button_unvisible()
}

function SetShowAbDesc(panel, ability)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowAbilityTooltip', panel, ability); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
    });       
}