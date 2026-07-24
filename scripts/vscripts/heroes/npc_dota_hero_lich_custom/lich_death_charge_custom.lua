--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


lich_death_charge_custom = class({})

function lich_death_charge_custom:Spawn()
    if not IsServer() then return end
    --self:SetCurrentAbilityCharges(0)
end

function lich_death_charge_custom:CastFilterResultTarget( target )
	if target:HasModifier("modifier_wodacreepchampion") then
		return UF_FAIL_ANCIENT
	end
	if target:HasModifier("modifier_wodacreepchampionred") then
		return UF_FAIL_ANCIENT
	end
	local nResult = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end

function lich_death_charge_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local target_heal = target:GetHealth()
    local bonus_mana = target_heal / 100 * self:GetSpecialValueFor("active_mana_restore_pct_of_health")
    local xp_pct = self:GetSpecialValueFor("xp_pct")
    self:GetCaster():GiveMana(bonus_mana)
    target.is_lich_creep = xp_pct
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_death_charge_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:ReleaseParticleIndex(particle)
    target:EmitSound("Hero_Lich.Sacrifice")
    target:Kill(self, self:GetCaster())
end