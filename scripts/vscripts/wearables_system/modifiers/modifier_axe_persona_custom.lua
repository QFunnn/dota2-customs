--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


modifier_axe_persona_custom = class({})
function modifier_axe_persona_custom:IsHidden()
	return true
end
function modifier_axe_persona_custom:IsPurgable()
	return false
end
function modifier_axe_persona_custom:IsPurgeException()
	return false
end
function modifier_axe_persona_custom:RemoveOnDeath()
	return false
end
function modifier_axe_persona_custom:OnCreated()
	if not IsServer() then
		return
	end
	self:GetCaster():EmitSound("Hero_Axe.IdleLoop.Automaton")
end
function modifier_axe_persona_custom:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetCaster():StopSound("Hero_Axe.IdleLoop.Automaton")
end
function modifier_axe_persona_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
	}
end
function modifier_axe_persona_custom:GetAttackSound()
	return "Hero_Axe.Attack.Automaton"
end