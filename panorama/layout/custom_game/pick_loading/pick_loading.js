--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var PICK_LOADING_FADE_OUT = 1.0
var PICK_LOADING_SPAWN_DELAY = 1.0
var pick_loading_shown = false
var pick_loading_hidden = false

GameEvents.Subscribe_custom("pick_end", ShowPickLoading)
GameEvents.Subscribe_custom("pick_heroes_spawned", OnPickHeroesSpawned)
GameEvents.Subscribe("game_rules_state_change", OnPickLoadingStateChange)

function ShowPickLoading()
{
	if (pick_loading_shown) { return }
	pick_loading_shown = true

	var panel = $("#PickLoadingScreen")
	if (!panel) { return }

	var player_data = Game.GetCustomTable("woda_player_data", String(Players.GetLocalPlayer()))
	if (player_data && player_data.background_id && typeof Background_Images !== "undefined" && Background_Images[player_data.background_id])
	{
		panel.style.backgroundImage = 'url("' + Background_Images[player_data.background_id] + '")'
		panel.style.backgroundSize = "cover"
		panel.style.backgroundPosition = "50% 50%"
	}

	var label = $("#PickLoadingLabel")
	if (label)
	{
		label.text = $.Localize("#donate_shop_loading") + ".."
	}

	panel.style.visibility = "visible"
	panel.style.opacity = "1"
}

function OnPickHeroesSpawned()
{
	$.Schedule(PICK_LOADING_SPAWN_DELAY, function()
	{
		HidePickLoading()
	})
}

function OnPickLoadingStateChange()
{
	if (Game.GetState() >= DOTA_GameState.DOTA_GAMERULES_STATE_GAME_IN_PROGRESS)
	{
		HidePickLoading()
	}
}

function HidePickLoading()
{
	if (pick_loading_hidden) { return }
	if (!pick_loading_shown) { return }
	pick_loading_hidden = true

	var panel = $("#PickLoadingScreen")
	if (!panel) { return }

	panel.style.opacity = "0"
	$.Schedule(PICK_LOADING_FADE_OUT + 0.2, function()
	{
		var hidden = $("#PickLoadingScreen")
		if (hidden)
		{
			hidden.style.visibility = "collapse"
		}
	})
}