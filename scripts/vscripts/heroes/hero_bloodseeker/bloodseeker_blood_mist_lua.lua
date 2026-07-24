--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bloodseeker_blood_mist_lua", "heroes/hero_bloodseeker/bloodseeker_blood_mist_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if bloodseeker_blood_mist_lua == nil then
	bloodseeker_blood_mist_lua = class({})
end
function bloodseeker_blood_mist_lua:GetCastRange(vLocation, hTarget)
	local hCaster = self:GetCaster()
	local movespeed_radius = self:GetSpecialValueFor("movespeed_radius")
	return hCaster:GetIdealSpeed() * movespeed_radius
end
function bloodseeker_blood_mist_lua:OnToggle()
	local hCaster = self:GetCaster()
	if self:GetToggleState() then
		hCaster:AddNewModifier(hCaster, self, "modifier_bloodseeker_blood_mist_lua", {})
	else
		hCaster:RemoveModifierByName("modifier_bloodseeker_blood_mist_lua")
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_bloodseeker_blood_mist_lua == nil then
	modifier_bloodseeker_blood_mist_lua = class({})
end
function modifier_bloodseeker_blood_mist_lua:IsHidden()
	return false
end
function modifier_bloodseeker_blood_mist_lua:IsDebuff()
	return false
end
function modifier_bloodseeker_blood_mist_lua:IsPurgable()
	return false
end
function modifier_bloodseeker_blood_mist_lua:IsPurgeException()
	return false
end
function modifier_bloodseeker_blood_mist_lua:OnCreated(params)
	self.tick = self:GetAbilitySpecialValueFor("tick")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.range_damage_pct = self:GetAbilitySpecialValueFor("range_damage_pct")
	self.range_damage_threshold = self:GetAbilitySpecialValueFor("range_damage_threshold")
	self.movespeed_radius = self:GetAbilitySpecialValueFor("movespeed_radius")
	if IsServer() then
		local hParent = self:GetParent()
		self.LastTickTime = 0
		self.iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_scepter_blood_mist_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:SetParticleControl(self.iParticleID, 1, Vector(self.radius, 0, 0))
		self:AddParticle(self.iParticleID, false, false, -1, false, false)
		self:StartIntervalThink(0.5)
		self:OnIntervalThink()
	end
end
function modifier_bloodseeker_blood_mist_lua:OnRefresh(params)
	self.tick = self:GetAbilitySpecialValueFor("tick")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.range_damage_pct = self:GetAbilitySpecialValueFor("range_damage_pct")
	self.range_damage_threshold = self:GetAbilitySpecialValueFor("range_damage_threshold")
	self.movespeed_radius = self:GetAbilitySpecialValueFor("movespeed_radius")
	if IsServer() then
	end
end
function modifier_bloodseeker_blood_mist_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_bloodseeker_blood_mist_lua:OnIntervalThink()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()

	if IsValid(hParent) and IsValid(hAbility) then
		local fRadius = hAbility:GetCastRange(hParent:GetAbsOrigin(), nil)
		ParticleManager:SetParticleControl(self.iParticleID, 1, Vector(fRadius, 0, 0))
		if self.LastTickTime + self.tick < GameRules:GetGameTime() then
			self.LastTickTime = GameRules:GetGameTime()
			ApplyDamage({
				attacker = hParent,
				victim = hParent,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage = self.damage,
				damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL,
				ability = hAbility
			})
			local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, fRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
			for _, unit in pairs(units) do
				if IsValid(unit) and unit:IsAlive() then
					local fDistance = (unit:GetAbsOrigin() - hParent:GetAbsOrigin()):Length2D()
					local fDamage = self.damage * (100 + math.floor((fRadius - fDistance) / self.range_damage_threshold) * self.range_damage_pct) * 0.01
					ApplyDamage({
						attacker = hParent,
						victim = unit,
						damage_type = DAMAGE_TYPE_MAGICAL,
						damage = fDamage,
						ability = hAbility
					})
				end
			end
		end
	else
		self:Destroy()
	end
end
function modifier_bloodseeker_blood_mist_lua:DeclareFunctions()
	return {
	}
end