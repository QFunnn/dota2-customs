--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_stunned = class({})

function modifier_woda_stunned:IsPurgable() return false end
function modifier_woda_stunned:IsPurgeException() return false end
function modifier_woda_stunned:IsHidden() return true end

function modifier_woda_stunned:CheckState()
	return 
	{
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end