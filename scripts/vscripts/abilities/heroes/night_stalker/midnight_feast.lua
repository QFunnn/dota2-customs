--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


night_stalker_midnight_feast_custom = class({})
LinkLuaModifier("modifier_night_stalker_midnight_feast_custom", "abilities/heroes/night_stalker/midnight_feast", LUA_MODIFIER_MOTION_NONE)

function night_stalker_midnight_feast_custom:GetIntrinsicModifierName()
	return "modifier_night_stalker_midnight_feast_custom"
end

function night_stalker_midnight_feast_custom:GetBehavior()
	if not self:Get_IsDaytime() then return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function night_stalker_midnight_feast_custom:CastFilterResultTarget(target)
	if self:Get_IsDaytime() then return end
	if self:GetCaster() == target then return UF_SUCCESS end
	if target:IsAncient() then return UF_FAIL_ANCIENT end

	return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO, self:GetCaster():GetTeamNumber())
end

-- does not exist on client, is set from the innate modifier
function night_stalker_midnight_feast_custom:Get_IsDaytime()
	return self.is_daytime
end

function night_stalker_midnight_feast_custom:Set_IsDaytime(is_day)
	self.is_daytime = is_day
end


function night_stalker_midnight_feast_custom:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not IsValidEntity(caster) then return end
	if not IsValidEntity(target) then return end

	local health_pct = self:GetSpecialValueFor("hp_restore")
	local mana_pct = self:GetSpecialValueFor("mp_restore")

	local heal_health = caster:GetMaxHealth() * health_pct * 0.01
	local heal_mana = caster:GetMaxMana() * mana_pct * 0.01

	if caster == target then
		local self_cast_pct = self:GetSpecialValueFor("self_cast_pct")
		heal_health = heal_health * self_cast_pct * 0.01
		heal_mana = heal_mana * self_cast_pct * 0.01
	else
		target:Kill(self, caster)
	end

	caster:HealWithParams(heal_health, self, false, true, caster, false)
	caster:GiveMana(heal_mana)

	target:EmitSound("Hero_Nightstalker.Hunter.Target")

	local hunter_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_shard_hunter.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(hunter_pfx, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(hunter_pfx, 1, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(hunter_pfx)

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, caster, heal_health, nil)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, caster, heal_mana, nil)
end


---------------------------------------------------------------------------------------------


modifier_night_stalker_midnight_feast_custom = class({})

function modifier_night_stalker_midnight_feast_custom:IsHidden() return false end
function modifier_night_stalker_midnight_feast_custom:IsDebuff() return false end
function modifier_night_stalker_midnight_feast_custom:IsPurgable() return false end
function modifier_night_stalker_midnight_feast_custom:RemoveOnDeath() return false end
function modifier_night_stalker_midnight_feast_custom:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_night_stalker_midnight_feast_custom:OnCreated()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	if not IsValidEntity(self.caster) then return end
	if not IsValidEntity(self.parent) then return end
	if not IsValidEntity(self.ability) then return end

	self.attack_heal = self.ability:GetSpecialValueFor("attack_heal")

	self:OnStackCountChanged()

	if not IsServer() then return end

	self:OnIntervalThink()
	self:StartIntervalThink(0.4)
end

function modifier_night_stalker_midnight_feast_custom:OnRefresh()
	self:OnCreated()
end

function modifier_night_stalker_midnight_feast_custom:OnIntervalThink()
	if not self or self:IsNull() then return end
	if not IsValidEntity(self.ability) then return end

	self.ability:Set_IsDaytime(GameRules:IsDaytime())
	self:SetStackCount(self.ability:Get_IsDaytime() and 0 or 1)
end

function modifier_night_stalker_midnight_feast_custom:OnStackCountChanged()
	if IsServer() then return end
	self.ability:Set_IsDaytime(self:GetStackCount() == 0)
end

function modifier_night_stalker_midnight_feast_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_night_stalker_midnight_feast_custom:GetModifierProcAttack_Feedback(event)
	if not IsServer() then return end
	if event.target:GetTeamNumber() == event.attacker:GetTeamNumber() then return end
	if event.target:IsOther() then return end
	if self.caster:PassivesDisabled() then return end

	self.caster:HealWithParams(self.attack_heal, self.ability, true, true, self.caster, false)
end