--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


gyrocopter_flak_cannon_lua = class({})
LinkLuaModifier("modifier_gyrocopter_flak_cannon_lua", "heroes/hero_gyrocopter/gyrocopter_flak_cannon_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_gyrocopter_flak_cannon_lua_scepter", "heroes/hero_gyrocopter/gyrocopter_flak_cannon_lua", LUA_MODIFIER_MOTION_NONE)

function gyrocopter_flak_cannon_lua:GetIntrinsicModifierName()
	return "modifier_gyrocopter_flak_cannon_lua_scepter"
end
function gyrocopter_flak_cannon_lua:GetCastRange(vLocation, hTarget)
	local hCaster = self:GetCaster()
	local radius_melee = self:GetSpecialValueFor("radius_melee")
	if not hCaster:IsRangedAttacker() then
		return hCaster:Script_GetAttackRange() + radius_melee
	else
		return self:GetSpecialValueFor("radius")
	end
end
function gyrocopter_flak_cannon_lua:OnSpellStart()
	local hCaster = self:GetCaster()

	if IsValid(hCaster) and hCaster:IsAlive() then
		local flDuration = self:GetDuration()
		local max_attacks = self:GetSpecialValueFor("max_attacks")
		hCaster:AddNewModifier(hCaster, self, "modifier_gyrocopter_flak_cannon_lua", { duration = flDuration, stack = max_attacks })

		hCaster:EmitSound("Hero_Gyrocopter.FlackCannon.Activate")
	end
end
modifier_gyrocopter_flak_cannon_lua = class({})
function modifier_gyrocopter_flak_cannon_lua:IsHidden()
	return false
end
function modifier_gyrocopter_flak_cannon_lua:IsDebuff()
	return false
end
function modifier_gyrocopter_flak_cannon_lua:IsPurgable()
	return false
end
function modifier_gyrocopter_flak_cannon_lua:OnCreated(params)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_night_vision = self:GetAbilitySpecialValueFor("bonus_night_vision")
	self.projectile_speed = self:GetAbilitySpecialValueFor("projectile_speed")
	if IsServer() then
		self.units = {}
		self:SetStackCount(params.stack or 1)
	end
end
function modifier_gyrocopter_flak_cannon_lua:OnRefresh(params)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_night_vision = self:GetAbilitySpecialValueFor("bonus_night_vision")
	self.projectile_speed = self:GetAbilitySpecialValueFor("projectile_speed")
	if IsServer() then
		self:SetStackCount(params.stack or 1)
	end
end
function modifier_gyrocopter_flak_cannon_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_gyrocopter_flak_cannon_lua:GetEffectName()
	return "particles/units/heroes/hero_gyrocopter/gyro_flak_cannon_overhead.vpcf"
end
function modifier_gyrocopter_flak_cannon_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
	}
end
function modifier_gyrocopter_flak_cannon_lua:OnAttack(params)
	local hAttacker = params.attacker
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	local hTarget = params.target
	if params.no_attack_cooldown then return end

	if IsValid(hAttacker) and IsValid(hParent) and IsValid(hTarget) and IsValid(hAbility) and hAttacker == hParent then
		local flRadius = hAbility:GetSpecialValueFor("radius")
		local radius_melee = hAbility:GetSpecialValueFor("radius_melee")
		if not hParent:IsRangedAttacker() then
			flRadius = hParent:Script_GetAttackRange() + radius_melee
		end
		local enemies = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, flRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER, false)
		for i, hEnemy in pairs(enemies) do
			if IsValid(hEnemy) and hEnemy:IsAlive() and not hEnemy:IsAttackImmune() and hEnemy ~= hTarget then
				local buff = hParent:FindModifierByName("modifier_gyrocopter_flak_cannon_lua_scepter")
				if buff then
					if buff.units == nil then
						buff.units = {}
					end
					table.insert(buff.units, hEnemy)
				end
			end
		end
		self:DecrementStackCount()
	end
end
function modifier_gyrocopter_flak_cannon_lua:OnStackCountChanged(iStackCount)
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
function modifier_gyrocopter_flak_cannon_lua:GetModifierPreAttack_BonusDamage()
	if IsClient() then
		return self.bonus_damage
	end
end
function modifier_gyrocopter_flak_cannon_lua:GetAttackSound()
	return "Hero_Gyrocopter.FlackCannon"
end
function modifier_gyrocopter_flak_cannon_lua:GetBonusNightVision()
	return self.bonus_night_vision
end
----------------------------------------------------------------------
------------Modifier----------------------------------------------
modifier_gyrocopter_flak_cannon_lua_scepter = class({})
function modifier_gyrocopter_flak_cannon_lua_scepter:IsDebuff()
	return false
end
function modifier_gyrocopter_flak_cannon_lua_scepter:IsHidden()
	return true
end
function modifier_gyrocopter_flak_cannon_lua_scepter:IsPurgable()
	return false
end
function modifier_gyrocopter_flak_cannon_lua_scepter:IsPurgeException()
	return false
end
function modifier_gyrocopter_flak_cannon_lua_scepter:OnCreated()
	self.scepter_radius = self:GetAbilitySpecialValueFor("scepter_radius")
	self.scepter_bonus_target = self:GetAbilitySpecialValueFor("scepter_bonus_target")
	self.fire_rate = self:GetAbilitySpecialValueFor("fire_rate")
	if IsServer() then
		self.LastTime = GameRules:GetGameTime()
		self.units = {}
		self.bCannon = false
		self:StartIntervalThink(FrameTime() * 2)
	end
end
function modifier_gyrocopter_flak_cannon_lua_scepter:OnRefresh()
	self.scepter_radius = self:GetAbilitySpecialValueFor("scepter_radius")
	self.scepter_bonus_target = self:GetAbilitySpecialValueFor("scepter_bonus_target")
	self.fire_rate = self:GetAbilitySpecialValueFor("fire_rate")
	if IsServer() then
	end
end
function modifier_gyrocopter_flak_cannon_lua_scepter:OnIntervalThink()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()

	if IsValid(hParent) and hParent:IsAlive() and IsValid(hAbility) then
		local attack_done = false
		for i = #self.units, 1, -1 do
			local unit = self.units[i]
			if IsValid(unit) and unit:IsAlive() then
				if not attack_done then
					self.bCannon = true
					hParent:Attack(unit, ATTACK_STATE_NOT_USECASTATTACKORB + ATTACK_STATE_NOT_PROCESSPROCS + ATTACK_STATE_SKIPCOOLDOWN + ATTACK_STATE_IGNOREINVIS + ATTACK_STATE_NO_EXTENDATTACK + ATTACK_STATE_SKIPCOUNTING)
					self.bCannon = false
					attack_done = true
					table.remove(self.units, i)
				end
			else
				table.remove(self.units, i)
			end
		end

		if hParent:HasScepter() and GameRules:GetGameTime() >= self.LastTime + self.fire_rate and not hParent:PassivesDisabled() and not hParent:IsOutOfGame() and not hParent:IsInvisible() then
			self.LastTime = GameRules:GetGameTime()
			local radius = hAbility:GetSpecialValueFor("scepter_radius")
			local radius_melee = hAbility:GetSpecialValueFor("radius_melee")
			if not hParent:IsRangedAttacker() then
				radius = hParent:Script_GetAttackRange() + radius_melee
			end
			local iCount = 1
			if hParent:HasModifier("modifier_gyrocopter_flak_cannon_lua") then
				iCount = iCount + self.scepter_bonus_target
			end
			local enemies = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_FARTHEST, false)

			for _, enemy in pairs(enemies) do
				if IsValid(enemy) and not enemy:IsAttackImmune() and enemy:IsAlive() then
					hParent:Attack(enemy, ATTACK_STATE_SKIPCOOLDOWN + ATTACK_STATE_IGNOREINVIS + ATTACK_STATE_NO_EXTENDATTACK + ATTACK_STATE_SKIPCOUNTING)
					iCount = iCount - 1
					if iCount <= 0 then
						break
					end
				end
			end
		end
	end
end
function modifier_gyrocopter_flak_cannon_lua_scepter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end
function modifier_gyrocopter_flak_cannon_lua_scepter:GetModifierPreAttack_BonusDamage()
	if IsServer() and self.bCannon then
		return self:GetAbilitySpecialValueFor("bonus_damage")
	end
end