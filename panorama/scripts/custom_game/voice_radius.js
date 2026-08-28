--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


"use strict";

var g_MuteState = {}
var g_Applied = false

function IsEnabled()
{
	var config = CustomNetTables.GetTableValue("voice_radius", "config")
	return config !== undefined && config !== null && Number(config.enabled) === 1
}

function GetAudibleSet()
{
	var audible = {}
	var data = CustomNetTables.GetTableValue("voice_radius", String(Game.GetLocalPlayerID()))

	if (data && data.players)
	{
		for (var key in data.players)
		{
			audible[Number(data.players[key])] = true
		}
	}

	return audible
}

function SetMuteState(pid, muted)
{
	if (g_MuteState[pid] === muted) return

	g_MuteState[pid] = muted
	Game.SetPlayerMutedVoice(pid, muted)
}

function ClearMuteState()
{
	if (!g_Applied) return

	for (var pid in g_MuteState)
	{
		if (g_MuteState[pid] === true)
		{
			Game.SetPlayerMutedVoice(Number(pid), false)
		}
	}

	g_MuteState = {}
	g_Applied = false
}

function MuteThink()
{
	$.Schedule(0.25, MuteThink)

	if (!IsEnabled())
	{
		ClearMuteState()
		return
	}

	var localPid = Game.GetLocalPlayerID()
	if (localPid === undefined || localPid < 0) return

	g_Applied = true

	var local_spec = Players.IsSpectator(localPid)
	var audible = local_spec ? {} : GetAudibleSet()

	for (var pid = 0; pid < 64; pid++)
	{
		if (pid === localPid) continue
		if (!Players.IsValidPlayerID(pid)) continue

		if (local_spec || Players.IsSpectator(pid))
		{
			SetMuteState(pid, true)
			continue
		}

		SetMuteState(pid, audible[pid] === undefined)
	}
}

MuteThink()