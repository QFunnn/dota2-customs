--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_slow", "abilities/creeps_lane/npc_satyr_purge", LUA_MODIFIER_MOTION_NONE)

npc_satyr_purge = class({})

function npc_satyr_purge:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_purge.vpcf", context)
end

function npc_satyr_purge:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.slow = self:GetLevelSpecialValueFor("slow", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

function npc_satyr_purge:OnSpellStart()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	target:Purge(true, false, false, false, false)
	target:EmitSound("n_creep_SatyrTrickster.Cast")
	target:GenericParticle("particles/generic_gameplay/generic_purge.vpcf")
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_satyr_slow",
		{ duration = self.duration * (1 - target:GetStatusResistance()) }
	)
end

modifier_satyr_slow = class(mod_visible)
function modifier_satyr_slow:IsPurgable()
	return true
end
function modifier_satyr_slow:OnCreated()
	self.ability = self:GetAbility()

	self.slow = -self.ability.slow
end

function modifier_satyr_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_satyr_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_satyr_slow:OnTooltip()
	return self.slow
end