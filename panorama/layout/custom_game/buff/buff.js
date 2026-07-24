--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function OnBuffClicked()
{
	var queryUnit = $.GetContextPanel().Data().m_QueryUnit;
	var buffSerial = $.GetContextPanel().Data().m_BuffSerial;
	var alertBuff = GameUI.IsAltDown();
	Players.BuffClicked( queryUnit, buffSerial, alertBuff );
}

function BuffShowTooltip()
{
	var queryUnit = $.GetContextPanel().Data().m_QueryUnit;
	var buffSerial = $.GetContextPanel().Data().m_BuffSerial;
	var isEnemy = Entities.IsEnemy( queryUnit );
	$.DispatchEvent( "DOTAShowBuffTooltip", $.GetContextPanel(), queryUnit, buffSerial, isEnemy );
}

function BuffHideTooltip()
{
	$.DispatchEvent( "DOTAHideBuffTooltip", $.GetContextPanel() );
}


function SetCircularDurationClip(progress)
{
    let circular_duration = $("#CircularDuration")
    if (!circular_duration) return

    progress = Math.max(0, Math.min(1, progress || 0))
    circular_duration.style.clip = "radial(50.0% 50.0%, 0deg," + (360 * progress) + "deg)"
}

function BuffThink()
{
    let context_panel = $.GetContextPanel()
    let data = context_panel.Data()
    let query_unit = context_panel.QueryUnit !== undefined ? context_panel.QueryUnit : data.m_QueryUnit
    let buff_id = context_panel.BuffID !== undefined ? context_panel.BuffID : data.m_BuffSerial

    if (query_unit === undefined || query_unit === -1 || buff_id === undefined || buff_id === -1)
    {
        SetCircularDurationClip(0)
        $.Schedule(Game.GetGameFrameTime(), BuffThink)
        return
    }

    let duration = Number(Buffs.GetDuration(query_unit, buff_id)) || 0
    let remaining_time = Number(Buffs.GetRemainingTime(query_unit, buff_id)) || 0
    if (duration > 0)
    {
        remaining_time = Math.max(0, Math.min(duration, remaining_time))
        SetCircularDurationClip((remaining_time / duration))
    }
    else
    {
        SetCircularDurationClip(1)
    }

    $.Schedule(Game.GetGameFrameTime(), BuffThink)
}

BuffThink()