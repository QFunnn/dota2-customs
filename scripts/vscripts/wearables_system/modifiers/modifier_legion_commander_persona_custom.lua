--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_legion_commander_persona_custom = class({})
function modifier_legion_commander_persona_custom:IsHidden()
	return true
end
function modifier_legion_commander_persona_custom:IsPurgable()
	return false
end
function modifier_legion_commander_persona_custom:IsPurgeException()
	return false
end
function modifier_legion_commander_persona_custom:RemoveOnDeath()
	return false
end
function modifier_legion_commander_persona_custom:OnCreated()
	if not IsServer() then
		return
	end
	self:GetCaster():EmitSound("Hero_LegionCommander.IdleLoop.Automaton")
end
function modifier_legion_commander_persona_custom:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetCaster():StopSound("Hero_LegionCommander.IdleLoop.Automaton")
end