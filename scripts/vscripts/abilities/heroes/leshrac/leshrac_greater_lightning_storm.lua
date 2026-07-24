--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


leshrac_greater_lightning_storm_lua = class({})
LinkLuaModifier("modifier_leshrac_decrepify_aura_lua", "abilities/heroes/leshrac/leshrac_greater_lightning_storm", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_leshrac_decrepify_caster_lua", "abilities/heroes/leshrac/leshrac_greater_lightning_storm", LUA_MODIFIER_MOTION_NONE )

function leshrac_greater_lightning_storm_lua:Precache( context )
	PrecacheResource("particle", "particles/units/heroes/hero_pugna/pugna_decrepify.vpcf", context)
end

function leshrac_greater_lightning_storm_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius") or 0
end

function leshrac_greater_lightning_storm_lua:OnSpellStart()
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end

	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier(caster, self, "modifier_leshrac_decrepify_aura_lua", {duration = duration})
	caster:AddNewModifier(caster, self, "modifier_leshrac_decrepify_caster_lua", {duration = duration})
end


------------------------------------------------------------------------------------------------------------------------------------------------


modifier_leshrac_decrepify_aura_lua = class({})

function modifier_leshrac_decrepify_aura_lua:IsHidden() return true end
function modifier_leshrac_decrepify_aura_lua:IsBuff() return true end
function modifier_leshrac_decrepify_aura_lua:IsDebuff() return false end
function modifier_leshrac_decrepify_aura_lua:IsPurgable() return true end
function modifier_leshrac_decrepify_aura_lua:IsPurgeException() return false end
function modifier_leshrac_decrepify_aura_lua:IsAura() return true end
function modifier_leshrac_decrepify_aura_lua:GetModifierAura() return "modifier_leshrac_decrepify" end
function modifier_leshrac_decrepify_aura_lua:GetAuraRadius() return self.radius end
function modifier_leshrac_decrepify_aura_lua:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_leshrac_decrepify_aura_lua:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_leshrac_decrepify_aura_lua:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_leshrac_decrepify_aura_lua:GetAuraDuration() return 0.5 end

function modifier_leshrac_decrepify_aura_lua:OnCreated(kv)
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	if not self.ability or self.ability:IsNull() then return end
	if not self.caster or self.caster:IsNull() then return end

	self.radius = self.ability:GetSpecialValueFor("radius")

	self.nihilism_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_leshrac/leshrac_scepter_nihilism_caster_custom.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.caster)
	ParticleManager:SetParticleControl(self.nihilism_particle, 0, self.caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.nihilism_particle, 10, Vector(self.radius, 0, 0))
	EmitSoundOn("Hero_Leshrac.Nihilism.Cast", self.caster)
end

function modifier_leshrac_decrepify_aura_lua:OnRefresh(kv)
	self:OnDestroy(kv)
	self:OnCreated(kv)
end

function modifier_leshrac_decrepify_aura_lua:OnDestroy(kv)
	if not self or self:IsNull() then return end
	if not self.caster or self.caster:IsNull() then return end

	if self.nihilism_particle then
		ParticleManager:DestroyParticle(self.nihilism_particle, false)
		ParticleManager:ReleaseParticleIndex(self.nihilism_particle)
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------------------


modifier_leshrac_decrepify_caster_lua = class({})

function modifier_leshrac_decrepify_caster_lua:IsHidden() return false end
function modifier_leshrac_decrepify_caster_lua:IsDebuff() return true end
function modifier_leshrac_decrepify_caster_lua:IsPurgable() return true end
function modifier_leshrac_decrepify_caster_lua:IsPurgeException() return false end
function modifier_leshrac_decrepify_caster_lua:GetEffectName() return "particles/units/heroes/hero_leshrac/leshrac_scepter_target.vpcf" end
function modifier_leshrac_decrepify_caster_lua:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end
function modifier_leshrac_decrepify_caster_lua:GetStatusEffectName() return "particles/status_fx/status_effect_ghost.vpcf" end
function modifier_leshrac_decrepify_caster_lua:StatusEffectPriority() return 15 end

function modifier_leshrac_decrepify_caster_lua:OnCreated(kv)
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	if not self.ability or self.ability:IsNull() then return end
	if not self.caster or self.caster:IsNull() then return end

	self.movespeed = self.ability:GetSpecialValueFor("slow")
end

function modifier_leshrac_decrepify_caster_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_leshrac_decrepify_caster_lua:OnDestroy(kv)
	if not IsServer() then return end
	if not self or self:IsNull() then return end
	if not self.caster or self.caster:IsNull() then return end

	self.caster:RemoveModifierByName("modifier_leshrac_decrepify_aura_lua")
end

function modifier_leshrac_decrepify_caster_lua:CheckState()
	return {
		[MODIFIER_STATE_ATTACK_IMMUNE]	= true,
		[MODIFIER_STATE_DISARMED]		= true,
	}
end

function modifier_leshrac_decrepify_caster_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	}
end

function modifier_leshrac_decrepify_caster_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end

function modifier_leshrac_decrepify_caster_lua:GetAbsoluteNoDamagePhysical()
	return 1
end