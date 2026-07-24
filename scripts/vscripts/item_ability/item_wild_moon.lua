--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_wild_moon", "item_ability/item_wild_moon.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_wild_moon_knockback", "item_ability/item_wild_moon.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_wild_moon == nil then
	item_wild_moon = class({})
end
function item_wild_moon:GetIntrinsicModifierName()
	return "modifier_item_wild_moon"
end
function item_wild_moon:FireArrow(hTarget)
	local hCaster = self:GetCaster()
	local arrow_speed = self:GetSpecialValueFor("arrow_speed")

	local info = {
		EffectName = "particles/items/wild_moon.vpcf",
		Target = hTarget,
		Source = hCaster,
		Ability = self,
		iMoveSpeed = arrow_speed
	}
	ProjectileManager:CreateTrackingProjectile(info)
	EmitSoundOn("Hero_Mirana.Attack", hCaster)
end
function item_wild_moon:OnProjectileHit(hTarget, vLocation)
	local hCaster = self:GetCaster()
	local arrow_dmg_pct = self:GetSpecialValueFor("arrow_dmg_pct")
	local knockback_duration = self:GetSpecialValueFor("knockback_duration")
	local arrow_bonus_dmg_per_range = self:GetSpecialValueFor("arrow_bonus_dmg_per_range")
	local fDamage = hCaster:GetAverageTrueAttackDamage(hTarget) * arrow_dmg_pct * 0.01

	if IsValid(hTarget) and hTarget:IsAlive() then
		local fDistance = (hTarget:GetAbsOrigin() - hCaster:GetAbsOrigin()):Length2D()
		fDamage = fDamage * (100 + fDistance * arrow_bonus_dmg_per_range) * 0.01
		EmitSoundOn("Hero_Mirana.ProjectileImpact", hTarget)
		hTarget:AddNewModifier(hCaster, self, "modifier_item_wild_moon_knockback", { duration = knockback_duration * hTarget:GetStatusResistanceFactor(hCaster) })
		ApplyDamage({
			victim = hTarget,
			ability = self,
			attacker = hCaster,
			damage = fDamage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		})
	end


end
---------------------------------------------------------------------
--Modifiers
if modifier_item_wild_moon == nil then
	modifier_item_wild_moon = class({})
end
function modifier_item_wild_moon:IsHidden()
	return true
end
function modifier_item_wild_moon:IsDebuff()
	return false
end
function modifier_item_wild_moon:IsPurgable()
	return false
end
function modifier_item_wild_moon:IsPurgeException()
	return false
end
function modifier_item_wild_moon:OnCreated(params)
	self.bonus_range_per_stat = self:GetAbilitySpecialValueFor("bonus_range_per_stat")
	self.bonus_attack_range = self:GetAbilitySpecialValueFor("bonus_attack_range")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.projectile_speed = self:GetAbilitySpecialValueFor("projectile_speed")
	if IsServer() then
		self.units = {}
		self:StartIntervalThink(FrameTime())
	end
end
function modifier_item_wild_moon:OnRefresh(params)
	self.bonus_range_per_stat = self:GetAbilitySpecialValueFor("bonus_range_per_stat")
	self.bonus_attack_range = self:GetAbilitySpecialValueFor("bonus_attack_range")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.projectile_speed = self:GetAbilitySpecialValueFor("projectile_speed")
	if IsServer() then
	end
end
function modifier_item_wild_moon:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_wild_moon:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
	}
end
function modifier_item_wild_moon:OnIntervalThink()
	local hAbility = self:GetAbility()
	local hParent = self:GetParent()
	self:SetStackCount(hParent:GetPrimaryStatValue() * self.bonus_range_per_stat + self.bonus_attack_range)
	if IsValid(hAbility) then
		for i = #self.units, 1, -1 do
			local unit = self.units[i]
			if not (IsValid(unit) and unit:IsAlive()) then
				table.remove(self.units, i)
			end
		end
		for i = 1, #self.units do
			local unit = self.units[i]
			if IsValid(unit) and unit:IsAlive() then
				hAbility:FireArrow(unit)
				table.remove(self.units, i)
				break
			end
		end
	else
		self.units = nil
		self:Destroy()
	end
end
function modifier_item_wild_moon:OnAttack(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAttacker = params.attacker
	local hAbility = self:GetAbility()

	if IsValid(hParent) and IsValid(hTarget) and IsValid(hAbility) and hAttacker == hParent then
		table.insert(self.units, hTarget)
		local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, hParent:Script_GetAttackRange() + hParent:GetHullRadius(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)
		table.sort(units, function(unitA, unitB)
			return (unitA:GetAbsOrigin() - hParent:GetAbsOrigin()):Length2D() < (unitB:GetAbsOrigin() - hParent:GetAbsOrigin()):Length2D()
		end)
		if IsValid(units[1]) then
			table.insert(self.units, units[1])
		end
		if IsValid(units[2]) then
			table.insert(self.units, units[2])
		else
			table.insert(self.units, units[1])
		end

	end
end
function modifier_item_wild_moon:GetModifierAttackRangeBonus()
	local hParent = self:GetParent()
	if hParent:IsRangedAttacker() then
		return self:GetStackCount()
	end
end
function modifier_item_wild_moon:GetModifierBonusStats_Agility()
	return self.bonus_agi
end
function modifier_item_wild_moon:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end
function modifier_item_wild_moon:GetModifierProjectileSpeedBonus()
	return self.projectile_speed
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_wild_moon_knockback == nil then
	modifier_item_wild_moon_knockback = class({})
end
function modifier_item_wild_moon_knockback:IsHidden()
	return true
end
function modifier_item_wild_moon_knockback:IsDebuff()
	return true
end
function modifier_item_wild_moon_knockback:IsPurgable()
	return true
end
function modifier_item_wild_moon_knockback:IsPurgeException()
	return true
end
function modifier_item_wild_moon_knockback:OnCreated(params)
	self.max_knockback_distance = self:GetAbilitySpecialValueFor("max_knockback_distance")
	if IsServer() then
		self:StartIntervalThink(FrameTime())
	end
end
function modifier_item_wild_moon_knockback:OnRefresh(params)
	self.max_knockback_distance = self:GetAbilitySpecialValueFor("max_knockback_distance")
	if IsServer() then
	end
end
function modifier_item_wild_moon_knockback:OnDestroy()
	if IsServer() then
		local hParent = self:GetParent()
		FindClearSpaceForUnit(hParent, hParent:GetAbsOrigin(), true)
	end
end

function modifier_item_wild_moon_knockback:OnIntervalThink()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	local vCasterPos = hCaster:GetAbsOrigin()
	local vParentPos = hParent:GetAbsOrigin()
	vCasterPos.z = 0
	vParentPos.z = 0
	if (vCasterPos - vParentPos):Length2D() < math.min(self.max_knockback_distance, hCaster:Script_GetAttackRange()) then
		local vDir = (vParentPos - vCasterPos):Normalized()
		if vDir.x == 0 and vDir.y == 0 and vDir.z == 0 then
			vDir = RandomVector(1)
		end
		local fKnockDistance = 8
		if hParent:IsNeutralUnitType() then
			fKnockDistance = 20
		end
		hParent:SetAbsOrigin(hParent:GetAbsOrigin() + vDir * fKnockDistance)
	else
		self:Destroy()
	end
end