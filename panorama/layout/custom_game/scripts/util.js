--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function IsPlayerHasSubscribe(id)
{
    let player_data = Game.GetCustomTable("woda_player_data", String(id));
    if (player_data) 
    {
        if (player_data.plus_days > 0 || Game.IsInToolsMode())
        {
            return true
        }
    }
    return false
}

function GetDotaHud()
{
	let hPanel = $.GetContextPanel();

	while ( hPanel && hPanel.id !== 'Hud')
	{
        hPanel = hPanel.GetParent();
	}

	if (!hPanel)
	{
        throw new Error('Could not find Hud root from panel with id: ' + $.GetContextPanel().id);
	}

	return hPanel;
}

function FindDotaHudElement(sId)
{
	return GetDotaHud().FindChildTraverse(sId);
}

function HasModifier(unit, modifier) 
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
    {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
        {
            return true
        }
    }
    return false
}

function ShowAbilityDescription(panel, ability)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowAbilityTooltip', panel, ability); });
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
    });       
}

function FindModifier(unit, modifier) 
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
    {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
        {
            return Entities.GetBuff(unit, i);
        }
    }
    return "none"
}

function HowStacks(mod) 
{
	var hero = Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )
	for (var i = 0; i < Entities.GetNumBuffs(hero); i++) 
    {
		var buffID = Entities.GetBuff(hero, i)
		if (Buffs.GetName(hero, buffID ) == mod ){
			var stack = Buffs.GetStackCount(hero, buffID ) 
			if (stack == 0) {
				stack = 1
			}
			return stack
		}
	}
	return 0
}

function GetCurrentStacks(hero_id, mod) 
{
    var hero = hero_id
 
    for (var i = 0; i < Entities.GetNumBuffs(hero); i++) 
    {
       var buffID = Entities.GetBuff(hero, i)
        if (Buffs.GetName(hero, buffID ) == mod )
        {
            var stack = Buffs.GetStackCount(hero, buffID ) 
            return stack
        }
    }
    return 0
}

function IsSpectator() 
{
    const localPlayer = Players.GetLocalPlayer()
    if (Players.IsSpectator(localPlayer))
    {
        return true
    }
    const localTeam = Players.GetTeam(localPlayer)
    return localTeam !== 2 && localTeam !== 3 && localTeam !== 6 && localTeam !== 7 && localTeam !== 8 && localTeam !== 9 && localTeam !== 10 && localTeam !== 11 && localTeam !== 12 && localTeam !== 13
}

function ConvertTimeMinutes(time)
{
    var min = Math.trunc((time)/60) 
    var sec_n =  (time) - 60*Math.trunc((time)/60) 
    var min = String(min - 60*( Math.trunc(min/60) ))
    var sec = String(sec_n)
    if (sec_n < 10) 
    {
        sec = '0' + sec
    }
    if (min < 10)
    {
        min = '0' + min
    } 
    return min + ':' + sec
}