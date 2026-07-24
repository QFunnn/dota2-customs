--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dawnbreaker_luminosity_lua", "heroes/hero_dawnbreaker/dawnbreaker_luminosity_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dawnbreaker_luminosity_lua_counter", "heroes/hero_dawnbreaker/dawnbreaker_luminosity_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if dawnbreaker_luminosity_lua == nil then
	dawnbreaker_luminosity_lua = class({})
end
function dawnbreaker_luminosity_lua:GetIntrinsicModifierName()
	return "modifier_dawnbreaker_luminosity_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_dawnbreaker_luminosity_lua == nil then
	modifier_dawnbreaker_luminosity_lua = class({})
end
function modifier_dawnbreaker_luminosity_lua:IsHidden()
	return self:GetStackCount() < 1
end
function modifier_dawnbreaker_luminosity_lua:IsDebuff()
	return false
end
function modifier_dawnbreaker_luminosity_lua:IsPurgable()
	return false
end
function modifier_dawnbreaker_luminosity_lua:IsPurgeException()
	return false
end
function modifier_dawnbreaker_luminosity_lua:OnCreated(params)
	self.bonus_damage_daytime = self:GetAbilitySpecialValueFor("bonus_damage_daytime")
	self.heal_radius = self:GetAbilitySpecialValueFor("heal_radius")
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
	self.heal_from_creeps = self:GetAbilitySpecialValueFor("heal_from_creeps")
	self.allied_healing_pct = self:GetAbilitySpecialValueFor("allied_healing_pct")
	if IsServer() then
	end
end
function modifier_dawnbreaker_luminosity_lua:OnRefresh(params)
	self.bonus_damage_daytime = self:GetAbilitySpecialValueFor("bonus_damage_daytime")
	self.heal_radius = self:GetAbilitySpecialValueFor("heal_radius")
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
	self.heal_from_creeps = self:GetAbilitySpecialValueFor("heal_from_creeps")
	self.allied_healing_pct = self:GetAbilitySpecialValueFor("allied_healing_pct")
	if IsServer() then
	end
end
function modifier_dawnbreaker_luminosity_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_dawnbreaker_luminosity_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end
function modifier_dawnbreaker_luminosity_lua:OnAttackLanded(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local attack_count = self:GetAbilitySpecialValueFor("attack_count")
	if IsServer() then
		if IsValid(hTarget) and IsValid(hParent) and (not hParent:PassivesDisabled()) and params.attacker == hParent and UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, hParent:GetTeamNumber()) == UF_SUCCESS then
			if self:GetStackCount() >= attack_count then
				local heal_amount = params.damage * self.heal_pct * 0.01
				if GameRules:IsDaytime() then
					heal_amount = heal_amount * (100 + self.bonus_damage_daytime) * 0.01
				end
				if hTarget:IsCreep() or hTarget:IsNeutralUnitType() then
					heal_amount = heal_amount * (100 - self.heal_from_creeps) * 0.01
				end
				local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, self.heal_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
				for _, unit in pairs(units) do
					if IsValid(unit) and unit:IsAlive() then
						local heal_num = heal_amount
						if hParent ~= unit then
							heal_num = heal_num * self.allied_healing_pct * 0.01
						end
						unit:HealWithParams(heal_num, self:GetAbility(), true, true, hParent, false)
						local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_dawnbreaker/dawnbreaker_luminosity.vpcf", PATTACH_CUSTOMORIGIN, unit)
						ParticleManager:SetParticleControlEnt(iParticleID, 0, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
						ParticleManager:SetParticleControlEnt(iParticleID, 1, hParent, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0, 0, 0), true)
						ParticleManager:ReleaseParticleIndex(iParticleID)
						SendOverheadEventMessage(hParent:GetPlayerOwner(), OVERHEAD_ALERT_HEAL, unit, heal_num, hParent:GetPlayerOwner())
						if hParent:GetPlayerOwnerID() ~= unit:GetPlayerOwnerID() then
							SendOverheadEventMessage(unit:GetPlayerOwner(), OVERHEAD_ALERT_HEAL, unit, heal_num, hParent:GetPlayerOwner())
						end
						EmitSoundOn("Hero_Dawnbreaker.Luminosity.Heal", unit)
					end
				end
				if self.particleID ~= nil then
					ParticleManager:DestroyParticle(self.particleID, true)
					ParticleManager:ReleaseParticleIndex(self.particleID)
				end
				EmitSoundOn("Hero_Dawnbreaker.Luminosity.Strike", hParent)
				self:SetStackCount(0)
			else
				self:IncrementStackCount()
				if self:GetStackCount() >= attack_count then
					if self.particleID ~= nil then
						ParticleManager:DestroyParticle(self.particleID, true)
						ParticleManager:ReleaseParticleIndex(self.particleID)
					end
					self.particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_dawnbreaker/dawnbreaker_luminosity_attack_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
					EmitSoundOn("Hero_Dawnbreaker.Luminosity.PowerUp", hParent)
				end
			end
		end
	end
end
function modifier_dawnbreaker_luminosity_lua:GetModifierPreAttack_CriticalStrike(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local attack_count = self:GetAbilitySpecialValueFor("attack_count")
	local bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	if IsServer() then
		if IsValid(hTarget) and IsValid(hTarget) and params.attacker == hParent and UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, hParent:GetTeamNumber()) == UF_SUCCESS then
			if self:GetStackCount() >= attack_count then
				if GameRules:IsDaytime() then
					bonus_damage = bonus_damage + self.bonus_damage_daytime
				end
				return bonus_damage
			end
		end
	end
end