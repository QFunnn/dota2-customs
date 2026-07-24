--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bloodseeker_thirst_lua", "heroes/hero_bloodseeker/bloodseeker_thirst_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if bloodseeker_thirst_lua == nil then
	bloodseeker_thirst_lua = class({})
end
function bloodseeker_thirst_lua:GetIntrinsicModifierName()
	return "modifier_bloodseeker_thirst_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_bloodseeker_thirst_lua == nil then
	modifier_bloodseeker_thirst_lua = class({})
end
function modifier_bloodseeker_thirst_lua:IsHidden()
	return true
end
function modifier_bloodseeker_thirst_lua:IsDebuff()
	return false
end
function modifier_bloodseeker_thirst_lua:IsPurgable()
	return false
end
function modifier_bloodseeker_thirst_lua:IsPurgeException()
	return false
end
function modifier_bloodseeker_thirst_lua:OnCreated(params)
	self.max_threshold_pct = self:GetAbilitySpecialValueFor("max_threshold_pct")
	self.bonus_movement_speed = self:GetAbilitySpecialValueFor("bonus_movement_speed")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.kill_heal = self:GetAbilitySpecialValueFor("kill_heal")
	if IsServer() then
		self:StartIntervalThink(1)
	end
end
function modifier_bloodseeker_thirst_lua:OnRefresh(params)
	self.max_threshold_pct = self:GetAbilitySpecialValueFor("max_threshold_pct")
	self.bonus_movement_speed = self:GetAbilitySpecialValueFor("bonus_movement_speed")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.kill_heal = self:GetAbilitySpecialValueFor("kill_heal")
	if IsServer() then
	end
end
function modifier_bloodseeker_thirst_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_bloodseeker_thirst_lua:OnIntervalThink()
	local hParent = self:GetParent()
	local iStack = 0
	if IsValid(hParent) then
		if not hParent:PassivesDisabled() then
			local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
			for _, unit in pairs(units) do
				if IsValid(unit) and unit:IsAlive() then
					local pct = 100 - unit:GetHealthPercent()
					if pct > 0 then
						iStack = iStack + pct * self.bonus_movement_speed / (100 - self.max_threshold_pct)
					end
				end
			end
		end
		
	end
	self:SetStackCount(iStack)
end
function modifier_bloodseeker_thirst_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_EVENT_ON_DEATH,
	}
end
function modifier_bloodseeker_thirst_lua:GetModifierMoveSpeedBonus_Percentage()
	return self:GetStackCount()
end
function modifier_bloodseeker_thirst_lua:GetModifierIgnoreMovespeedLimit()
	return 1
end
function modifier_bloodseeker_thirst_lua:OnDeath(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	local hUnit = params.unit
	local hAbility = self:GetAbility()
	if IsValid(hParent) and hParent:IsAlive() and IsValid(hUnit) and hAttacker == hParent and not hParent:PassivesDisabled() then
		hParent:HealWithParams(hUnit:GetMaxHealth() * self.kill_heal * 0.01, hAbility, false, true, hParent, false)
		local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
end