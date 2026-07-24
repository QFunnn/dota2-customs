--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_earth_spirit_geomagnetic_grip_lua", "heroes/hero_earth_spirit/earth_spirit_geomagnetic_grip_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_earth_spirit_geomagnetic_grip_lua_drag", "heroes/hero_earth_spirit/earth_spirit_geomagnetic_grip_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if earth_spirit_geomagnetic_grip_lua == nil then
	earth_spirit_geomagnetic_grip_lua = class({})
end
function earth_spirit_geomagnetic_grip_lua:GetIntrinsicModifierName()
	return "modifier_earth_spirit_geomagnetic_grip_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_earth_spirit_geomagnetic_grip_lua == nil then
	modifier_earth_spirit_geomagnetic_grip_lua = class({})
end
function modifier_earth_spirit_geomagnetic_grip_lua:IsHidden()
	return self:GetStackCount() <= 0
end
function modifier_earth_spirit_geomagnetic_grip_lua:IsDebuff()
	return false
end
function modifier_earth_spirit_geomagnetic_grip_lua:IsPurgable()
	return false
end
function modifier_earth_spirit_geomagnetic_grip_lua:IsPurgeException()
	return false
end
function modifier_earth_spirit_geomagnetic_grip_lua:OnCreated(params)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.bonus_damage_pct = self:GetAbilitySpecialValueFor("bonus_damage_pct")
	if IsServer() then
	end
end
function modifier_earth_spirit_geomagnetic_grip_lua:OnRefresh(params)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.bonus_damage_pct = self:GetAbilitySpecialValueFor("bonus_damage_pct")
	if IsServer() then
	end
end
function modifier_earth_spirit_geomagnetic_grip_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_earth_spirit_geomagnetic_grip_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end
function modifier_earth_spirit_geomagnetic_grip_lua:OnStackCountChanged(iStackCount)
	if IsServer() then
		local iStack = self:GetStackCount()
		local hParent = self:GetParent()
		if self.iParticleID ~= nil then
			ParticleManager:DestroyParticle(self.iParticleID, true)
			ParticleManager:ReleaseParticleIndex(self.iParticleID)
			self.iParticleID = nil
		end
		if iStack > 0 then
			self.iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_earth_spirit/espirit_stoneremnant_base.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
			ParticleManager:SetParticleControlEnt(self.iParticleID, 0, hParent, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0, 0, 0), true)
		end
	end
end
function modifier_earth_spirit_geomagnetic_grip_lua:OnAbilityExecuted(params)
	local hParent = self:GetParent()
	local hUnit = params.unit
	local hInflictor = params.ability
	local hAbility = self:GetAbility()
	if IsServer() then
		if hParent == hUnit and IsValid(hParent) and IsValid(hUnit) and IsValid(hInflictor) and IsValid(hAbility) and hAbility:IsCooldownReady() and (not hInflictor:IsToggle()) and (not hInflictor:IsItem()) and hInflictor:GetEffectiveCooldown(-1) > 0 then
			self:SetStackCount(1)
			hAbility:UseResources(false, false, false, true)
		end
	end
end
function modifier_earth_spirit_geomagnetic_grip_lua:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()
	if IsValid(hParent) and IsValid(hTarget) and hTarget:IsAlive() and IsValid(hAbility) and self:GetStackCount() >= 1 then
		self:SetStackCount(0)
		local units = FindUnitsInRadius(hParent:GetTeamNumber(), hTarget:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			EmitSoundOn("Hero_EarthSpirit.GeomagneticGrip.Stun", hTarget)
			if IsValid(unit) and unit:IsAlive() then

				EmitSoundOn("Hero_EarthSpirit.GeomagneticGrip.Target", hTarget)

				local fDamage = self.base_damage + self.bonus_damage_pct * hParent:GetAverageTrueAttackDamage(hTarget) * 0.01
				ApplyDamage({
					victim = unit,
					attacker = hParent,
					ability = hAbility,
					damage = fDamage,
					damage_type = DAMAGE_TYPE_MAGICAL,
				})
				if IsValid(unit) and unit:IsAlive() then
					unit:AddNewModifier(hParent, hAbility, "modifier_earth_spirit_geomagnetic_grip_lua_drag", { duration = self.duration * unit:GetStatusResistanceFactor(hParent) })
				end
			end
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_earth_spirit_geomagnetic_grip_lua_drag == nil then
	modifier_earth_spirit_geomagnetic_grip_lua_drag = class({})
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:IsHidden()
	return false
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:IsDebuff()
	return true
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:IsPurgable()
	return true
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:IsPurgeException()
	return true
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:OnCreated(params)
	self.pull_speed = self:GetAbilitySpecialValueFor("pull_speed")
	if IsServer() then

		self:StartIntervalThink(FrameTime())
	end
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:OnRefresh(params)
	self.pull_speed = self:GetAbilitySpecialValueFor("pull_speed")
	if IsServer() then
	end
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:OnDestroy()
	if IsServer() then
	end
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:OnIntervalThink()
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if IsValid(hCaster) and IsValid(hParent) then
		local vCasterPos = hCaster:GetAbsOrigin()
		local vMePos = hParent:GetAbsOrigin()
		local fRange = (vCasterPos - vMePos):Length2D()
		if fRange >= 150 then
			local vDir = (vCasterPos - vMePos):Normalized()
			local fPullRange = FrameTime() * self.pull_speed
			fPullRange = math.min(fPullRange, math.max(fRange, 150) - 150)
			local vNewPos = vMePos + vDir * fPullRange
			FindClearSpaceForUnit(hParent, vNewPos, false)
		end
	else
		self:Destroy()
	end
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:CheckState()
	return {
		[MODIFIER_STATE_SILENCED] = true,
	}
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:GetEffectName()
	return "particles/units/heroes/hero_earth_spirit/espirit_geomagentic_grip_target.vpcf"
end
function modifier_earth_spirit_geomagnetic_grip_lua_drag:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end