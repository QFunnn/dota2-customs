--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
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

GameEvents.Subscribe_custom( "arena_timer_arena_name", SetArenaName )

function SetArenaName( data )
{
	if (data.wave)
	{
        if ((typeof data.skills !== 'undefined'))
        {
            $("#AbilitiesRound").RemoveAndDeleteChildren()
            for (var i = 1; i <= Object.keys(data.skills).length; i++) 
            {
                var ability_panel = $.CreatePanel('DOTAAbilityImage', $("#AbilitiesRound"), '');
                ability_panel.abilityname = Object.keys(data.skills)[i-1];
                ability_panel.AddClass('RoundAbility');
                SetShowAbDesc(ability_panel, Object.keys(data.skills)[i-1]);
            }
            if (Object.keys(data.skills).length <= 0)
            {
                $("#AbilitiesRound").style.opacity = "0"
            } else {
                $("#AbilitiesRound").style.opacity = "1"
            }
        }
		$("#arena_timer_arena_name").text = $.Localize("#wave") + data.wave + ": " + $.Localize("#"+data.creep)
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
        for (var i = 1; i <= Object.keys(data.skills).length; i++) 
        {
            var ability_panel = $.CreatePanel('DOTAAbilityImage', $("#AbilitiesRound"), '');
            ability_panel.abilityname = Object.keys(data.skills)[i-1];
            ability_panel.AddClass('RoundAbility');
            SetShowAbDesc(ability_panel, Object.keys(data.skills)[i-1]);
        }
        if (Object.keys(data.skills).length <= 0)
        {
            $("#AbilitiesRound").style.opacity = "0"
        } else {
            $("#AbilitiesRound").style.opacity = "1"
        }
    }
	$("#duel_timer_arena_name").text = $.Localize("#wave") + data.wave + ": " + $.Localize("#"+data.creep)
}

GameEvents.Subscribe_custom( "set_arena_timer_duel", SetArenaTimerDuel )

function SetArenaTimerDuel( data )	
{
	$("#arena_timer").style.visibility = "collapse"
	$("#duel_timer").style.visibility = "visible"
	$("#arena_timer_arena_name").style.visibility = "collapse"
	$("#duel_timer_arena_name").style.visibility = "visible"
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