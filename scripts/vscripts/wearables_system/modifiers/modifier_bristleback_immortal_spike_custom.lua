--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_bristleback_immortal_spike_custom = class({})
function modifier_bristleback_immortal_spike_custom:IsHidden()
	return true
end
function modifier_bristleback_immortal_spike_custom:IsPurgable()
	return false
end
function modifier_bristleback_immortal_spike_custom:IsPurgeException()
	return false
end
function modifier_bristleback_immortal_spike_custom:RemoveOnDeath()
	return false
end
function modifier_bristleback_immortal_spike_custom:OnCreated()
	if not IsServer() then
		return
	end
	self:GetCaster():EmitSound("Hero_Bristleback.PistonProngs.IdleLoop")
end
function modifier_bristleback_immortal_spike_custom:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetCaster():StopSound("Hero_Bristleback.PistonProngs.IdleLoop")
end