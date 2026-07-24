--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_night_stalker_midnight_feast_custom", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_midnight_feast_custom", LUA_MODIFIER_MOTION_NONE )

night_stalker_midnight_feast_custom = class({})
night_stalker_midnight_feast_custom.night_stalker_2 = {4,8}

function night_stalker_midnight_feast_custom:GetIntrinsicModifierName()
    return "modifier_night_stalker_midnight_feast_custom"
end

function night_stalker_midnight_feast_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_night_stalker_4") and self:GetCaster():GetModifierStackCount("modifier_night_stalker_midnight_feast_custom", self:GetCaster()) >= 1 then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT
	end
    if self:GetCaster():GetModifierStackCount("modifier_night_stalker_midnight_feast_custom", self:GetCaster()) >= 1 then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function night_stalker_midnight_feast_custom:CastFilterResultTarget( target )
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

function night_stalker_midnight_feast_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
    local health = self:GetCaster():GetMaxHealth()
    local mana = self:GetCaster():GetMaxMana()
    if target == nil then
		target = CreateUnitByName("npc_dota_creep_badguys_melee", self:GetCursorPosition(), true, nil, nil, self:GetCaster():GetTeamNumber())
		target:SetOriginalModel("models/heroes/nerubian_assassin/nerubian_assassin.vmdl")
		target:SetModel("models/heroes/nerubian_assassin/nerubian_assassin.vmdl")
		target:SetMaximumGoldBounty(0)
		target:SetMinimumGoldBounty(0)
		target:SetDeathXP(0)
		target:StartGesture(ACT_DOTA_DIE)
    end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_shard_hunter.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    local heal_restore = health / 100 * self:GetSpecialValueFor("hp_restore")
    local mana_restore = mana / 100 * self:GetSpecialValueFor("mp_restore")
    self:GetCaster():GiveMana(mana_restore)
    self:GetCaster():Heal(heal_restore, self)
    target:EmitSound("Hero_Nightstalker.Hunter.Target")
    target:Kill(self, self:GetCaster())
end

modifier_night_stalker_midnight_feast_custom = class({})
function modifier_night_stalker_midnight_feast_custom:IsHidden() return true end
function modifier_night_stalker_midnight_feast_custom:IsPurgable() return false end
function modifier_night_stalker_midnight_feast_custom:IsPurgeException() return false end
function modifier_night_stalker_midnight_feast_custom:RemoveOnDeath() return false end
function modifier_night_stalker_midnight_feast_custom:OnCreated()
    self.attack_heal = self:GetAbility():GetSpecialValueFor("attack_heal")
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_night_stalker_midnight_feast_custom:OnRefresh()
    self.attack_heal = self:GetAbility():GetSpecialValueFor("attack_heal")
    if not IsServer() then return end
end
function modifier_night_stalker_midnight_feast_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_night_stalker_10") then return end
    if self:GetCaster():HasModifier("modifier_night_stalker_darkness_custom") or not GameRules:IsDaytime() or self:GetCaster():HasModifier("modifier_night_stalker_7") or self:GetCaster():HasModifier("modifier_night_stalker_void_custom_thinker_night_buff") then
        if self:GetStackCount() == 0 then
            self:SetStackCount(1)
        end
    else
        if self:GetStackCount() == 1 then
            self:SetStackCount(0)
        end
    end
end
function modifier_night_stalker_midnight_feast_custom:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if not params.target:IsBaseNPC() then return end
    if params.target:IsOther() then return end
    if self:GetParent():HasModifier("modifier_night_stalker_10") then return end
    local bonus = 0
    if self:GetCaster():HasModifier("night_stalker_2") then
        bonus = self:GetAbility().night_stalker_2[self:GetCaster():GetTalentLevel("night_stalker_2")]
    end
    local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetParent():Heal(self.attack_heal + bonus, self:GetAbility())
end