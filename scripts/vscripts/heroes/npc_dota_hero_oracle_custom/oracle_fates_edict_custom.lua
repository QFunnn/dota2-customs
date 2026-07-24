--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_oracle_fates_edict_custom", "heroes/npc_dota_hero_oracle_custom/oracle_fates_edict_custom", LUA_MODIFIER_MOTION_NONE)

oracle_fates_edict_custom = class({})

function oracle_fates_edict_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_fatesedict.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_fatesedict_disarm.vpcf", context )
end

oracle_fates_edict_custom.modifier_oracle_12 = 1

function oracle_fates_edict_custom:CastFilterResultTarget( hTarget )
    if hTarget:IsMagicImmune() and (not self:GetCaster():HasModifier("modifier_oracle_12")) then
        return UF_FAIL_MAGIC_IMMUNE_ENEMY
    end

    if not IsServer() then return UF_SUCCESS end
    local nResult = UnitFilter(
        hTarget,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags(),
        self:GetCaster():GetTeamNumber()
    )

    if nResult ~= UF_SUCCESS then
        return nResult
    end

    return UF_SUCCESS
end

function oracle_fates_edict_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		if target:TriggerSpellAbsorb(self) then return end
	end
	self:ApplyFatesEdict(target)
end

function oracle_fates_edict_custom:ApplyFatesEdict(target)
	self:GetCaster():EmitSound("Hero_Oracle.FatesEdict.Cast")

	target:EmitSound("Hero_Oracle.FatesEdict")

	local duration = self:GetSpecialValueFor("duration")

	if self:GetCaster():HasModifier("modifier_oracle_12") then
		duration = duration + self.modifier_oracle_12
	end

	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		duration = duration * (1-target:GetStatusResistance())
	end

	target:AddNewModifier(self:GetCaster(), self, "modifier_oracle_fates_edict_custom", {duration = duration})
end

modifier_oracle_fates_edict_custom = class({})

function modifier_oracle_fates_edict_custom:GetEffectName()
	return "particles/units/heroes/hero_oracle/oracle_fatesedict.vpcf"
end

function modifier_oracle_fates_edict_custom:OnCreated()
	self.magic_damage_resistance_pct_tooltip = self:GetAbility():GetSpecialValueFor("magic_damage_resistance_pct_tooltip")
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Oracle.FatesEdict")
	self.disarm_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_fatesedict_disarm.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	self:AddParticle(self.disarm_particle, false, false, -1, true, true)
end

function modifier_oracle_fates_edict_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_Oracle.FatesEdict")
end

function modifier_oracle_fates_edict_custom:CheckState()
	return {[MODIFIER_STATE_DISARMED] = true}
end

function modifier_oracle_fates_edict_custom:DeclareFunctions()
	return {MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS}
end

function modifier_oracle_fates_edict_custom:GetModifierMagicalResistanceBonus()
	return self.magic_damage_resistance_pct_tooltip
end