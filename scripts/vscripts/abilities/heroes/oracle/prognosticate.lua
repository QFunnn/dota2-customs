--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


oracle_prognosticate_lua = class({})
LinkLuaModifier("modifier_oracle_prognosticate_lua", "abilities/heroes/oracle/prognosticate", LUA_MODIFIER_MOTION_NONE)

function oracle_prognosticate_lua:GetIntrinsicModifierName()
	return "modifier_oracle_prognosticate_lua"
end


---------------------------------------------------------------------------------------------------------------------------------------------------


modifier_oracle_prognosticate_lua = class({})

function modifier_oracle_prognosticate_lua:IsHidden() return false end
function modifier_oracle_prognosticate_lua:IsDebuff() return false end
function modifier_oracle_prognosticate_lua:IsPurgable() return false end
function modifier_oracle_prognosticate_lua:RemoveOnDeath() return false end
function modifier_oracle_prognosticate_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_oracle_prognosticate_lua:OnCreated(kv)
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end
	self.ability = self:GetAbility()
	if not IsValidEntity(self.ability) then return end

	self.backtrack_chance_pct = self.ability:GetSpecialValueFor("backtrack_chance_pct") or 0
end

function modifier_oracle_prognosticate_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_oracle_prognosticate_lua:OnDestroy(kv)
end

function modifier_oracle_prognosticate_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_AVOID_DAMAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_oracle_prognosticate_lua:GetModifierAvoidDamage(event)
	if not self or self:IsNull() then return 0 end
	if not IsServer() then return 0 end
	if not IsValidEntity(self.caster) then return 0 end
	if self.caster:PassivesDisabled() then return 0 end
	if not RollPercentage(self.backtrack_chance_pct) then return 0 end

	local backtrack_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", PATTACH_ABSORIGIN, self.caster)
	ParticleManager:SetParticleControl(backtrack_pfx, 0, self.caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(backtrack_pfx)

	return 1
end

function modifier_oracle_prognosticate_lua:OnTooltip()
	if not IsValidEntity(self.caster) then return 0 end
	if self.caster:PassivesDisabled() then return 0 end
	return self.backtrack_chance_pct
end