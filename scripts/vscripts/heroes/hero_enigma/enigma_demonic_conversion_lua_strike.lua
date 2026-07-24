--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_enigma_demonic_conversion_lua_strike", "heroes/hero_enigma/enigma_demonic_conversion_lua_strike.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if enigma_demonic_conversion_lua_strike == nil then
	enigma_demonic_conversion_lua_strike = class({})
end
function enigma_demonic_conversion_lua_strike:GetIntrinsicModifierName()
	return "modifier_enigma_demonic_conversion_lua_strike"
end
function enigma_demonic_conversion_lua_strike:Fire(hTarget)
	local hCaster = self:GetCaster()

	if IsValid(hCaster) and IsValid(hTarget) and hCaster:IsAlive() and hTarget:IsAlive() then
		local info = {
			EffectName = "particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance.vpcf",
			Ability = self,
			Source = hCaster,
			Target = hTarget,
			iMoveSpeed = hCaster:GetProjectileSpeed(),
			bDodgeable = true,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
			bProvidesVision = false,
			iVisionRadius = 0,
			iVisionTeamNumber = hCaster:GetTeamNumber(),
			ExtraData = {},
		}
		ProjectileManager:CreateTrackingProjectile(info)
		EmitSoundOn("Hero_Abaddon.DeathCoil.Cast", hCaster)
	end
end
function enigma_demonic_conversion_lua_strike:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
	local hCaster = self:GetCaster()
	local damage = self:GetSpecialValueFor("damage")
	local bonus_damage_per_level = self:GetSpecialValueFor("bonus_damage_per_level")

	EmitSoundOn("Hero_Abaddon.DeathCoil.Target", hTarget)
	if IsValid(hTarget) and hTarget:IsAlive() then
		if not hTarget:TriggerSpellAbsorb(self) then
			local fDamage = damage + bonus_damage_per_level * hCaster:GetLevel()
			local fHealAmount = fDamage * (1 + hCaster:GetSpellAmplification(false))
			ApplyDamage({
				victim = hTarget,
				attacker = hCaster,
				ability = self,
				damage = fDamage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			})
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, hCaster, fHealAmount, nil)
			hCaster:HealWithParams(fHealAmount, self, false, true, hCaster, false)
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_enigma_demonic_conversion_lua_strike == nil then
	modifier_enigma_demonic_conversion_lua_strike = class({})
end
function modifier_enigma_demonic_conversion_lua_strike:IsHidden()
	return true
end
function modifier_enigma_demonic_conversion_lua_strike:IsDebuff()
	return false
end
function modifier_enigma_demonic_conversion_lua_strike:IsPurgable()
	return false
end
function modifier_enigma_demonic_conversion_lua_strike:IsPurgeException()
	return false
end
function modifier_enigma_demonic_conversion_lua_strike:OnCreated(params)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.mana_restore = self:GetAbilitySpecialValueFor("mana_restore")
	if IsServer() then
		self:StartIntervalThink(0.5)
	end
end
function modifier_enigma_demonic_conversion_lua_strike:OnRefresh(params)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.mana_restore = self:GetAbilitySpecialValueFor("mana_restore")
	if IsServer() then
	end
end
function modifier_enigma_demonic_conversion_lua_strike:OnDestroy()
	if IsServer() then
	end
end
function modifier_enigma_demonic_conversion_lua_strike:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end
function modifier_enigma_demonic_conversion_lua_strike:OnIntervalThink()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()

	if IsValid(hParent) and IsValid(hAbility) and hAbility:IsCooldownReady() and hAbility:GetEffectiveManaCost(-1) <= hParent:GetMana() then
		local target_count = 1 + self:GetAbilitySpecialValueFor("target_count")
		local tTargets = {}
		local hAttackTarget = hParent:GetAttackTarget()
		if hParent:IsAttacking() and IsValid(hAttackTarget) and hAttackTarget:IsAlive() then
			table.insert(tTargets, hAttackTarget)
		end

		if #tTargets < target_count then
			local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, hAbility:GetCastRange(hParent:GetAbsOrigin(), nil), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			for _, unit in pairs(units) do
				if IsValid(unit) and unit ~= hAttackTarget and unit:IsAlive() then
					table.insert(tTargets, unit)
					if #tTargets >= target_count then
						break
					end
				end
			end
		end
		if #tTargets > 0 then
			hAbility:UseResources(true, false, false, true)
			for _, hTarget in pairs(tTargets) do
				if IsValid(hTarget) then
					hAbility:Fire(hTarget)
				end
			end
		end
	end
end