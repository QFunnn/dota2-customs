--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_life_stealer_feast_lua", "heroes/hero_life_stealer/life_stealer_feast_lua.lua",
	LUA_MODIFIER_MOTION_NONE)

if life_stealer_feast_lua == nil then
	life_stealer_feast_lua = class({}) ---@class life_stealer_feast_lua : CDOTA_Ability_Lua
end

function life_stealer_feast_lua:GetIntrinsicModifierName()
	return "modifier_life_stealer_feast_lua"
end

---------------------------------------------------------------------
--Modifiers
if modifier_life_stealer_feast_lua == nil then
	modifier_life_stealer_feast_lua = class({}) ---@class modifier_life_stealer_feast_lua : CDOTA_Modifier_Lua
end
function modifier_life_stealer_feast_lua:IsHidden(params)
	return true
end

function modifier_life_stealer_feast_lua:IsPurgable(params)
	return false
end

function modifier_life_stealer_feast_lua:IsPurgeException(params)
	return false
end

function modifier_life_stealer_feast_lua:IsDebuff(params)
	return false
end

function modifier_life_stealer_feast_lua:AllowIllusionDuplicate()
	return false
end

function modifier_life_stealer_feast_lua:OnCreated(params)
	self.hp_leech_percent = self:GetAbility():GetSpecialValueFor("hp_leech_percent")
	self.hp_damage_percent = self:GetAbility():GetSpecialValueFor("hp_damage_percent")
end

function modifier_life_stealer_feast_lua:OnRefresh(params)
	self.hp_leech_percent = self:GetAbility():GetSpecialValueFor("hp_leech_percent")
	self.hp_damage_percent = self:GetAbility():GetSpecialValueFor("hp_damage_percent")
end

function modifier_life_stealer_feast_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,

	}
end

function modifier_life_stealer_feast_lua:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	if params.attacker == hParent and not hParent:PassivesDisabled() then
		if IsValid(hTarget) and hTarget:IsAlive() and hTarget.IsRoshan and not hTarget:IsRoshan() then
			if UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, hParent:GetTeamNumber()) == UF_SUCCESS then
				local particleID = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf",
					PATTACH_ABSORIGIN_FOLLOW, hParent)
				ParticleManager:ReleaseParticleIndex(particleID)
				SendOverheadEventMessage(hParent:GetPlayerOwner(), OVERHEAD_ALERT_HEAL, hParent,
					hTarget:GetMaxHealth() * self.hp_leech_percent * 0.01, hParent:GetPlayerOwner())
				hParent:HealWithParams(hTarget:GetMaxHealth() * self.hp_leech_percent * 0.01, self:GetAbility(), true,
					true, hParent, false)
			end
		end
	end
end

function modifier_life_stealer_feast_lua:GetModifierPreAttack_BonusDamage(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	if not IsServer() then return end
	if params.attacker == hParent and not hParent:PassivesDisabled() then
		if IsValid(hTarget) and hTarget:IsAlive() and hTarget.IsRoshan and not hTarget:IsRoshan() then
			if UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, hParent:GetTeamNumber()) == UF_SUCCESS then
				return hTarget:GetMaxHealth() * self.hp_damage_percent * 0.01
			end
		end
	end
end