--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ursa_enrage_lua_buff", "heroes/hero_ursa/ursa_enrage_lua.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ursa_enrage_lua", "heroes/hero_ursa/ursa_enrage_lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if ursa_enrage_lua == nil then
	ursa_enrage_lua = class({})
end
function ursa_enrage_lua:GetIntrinsicModifierName()
	return "modifier_ursa_enrage_lua"
end
function ursa_enrage_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local aoe_radius = self:GetSpecialValueFor("aoe_radius")
	local duration = self:GetSpecialValueFor("duration")

	hCaster:AddNewModifier(hCaster, self, "modifier_ursa_enrage_lua_buff", {duration = duration})
	hCaster:Purge(false, true, false, true, false)
	if aoe_radius > 0 then
		local units = FindUnitsInRadius(hCaster:GetTeamNumber(), hCaster:GetAbsOrigin(), nil, aoe_radius, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				unit:AddNewModifier(hCaster, self, "modifier_ursa_enrage_lua_buff", {duration = duration})
			end
		end
	end

end
function ursa_enrage_lua:GetBehavior()
	local hCaster = self:GetCaster()
	if hCaster:HasScepter() then
		return tonumber(tostring(self.BaseClass.GetBehavior(self))) + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
	end

	return tonumber(tostring(self.BaseClass.GetBehavior(self)))
end
function ursa_enrage_lua:GetCooldown(iLevel)
	local hCaster = self:GetCaster()
	if hCaster:HasScepter() then
		return self:GetSpecialValueFor("cooldown_scepter")
	end
	return self.BaseClass.GetCooldown(self, iLevel)
end
---------------------------------------------------------------------
--Modifiers
if modifier_ursa_enrage_lua_buff == nil then
	modifier_ursa_enrage_lua_buff = class({})
end
function modifier_ursa_enrage_lua_buff:IsDebuff()
	return false
end
function modifier_ursa_enrage_lua_buff:IsPurgeException()
	return false
end
function modifier_ursa_enrage_lua_buff:IsPurgable()
	return false
end
function modifier_ursa_enrage_lua_buff:OnCreated(params)
	self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")
	self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if hCaster ~= hParent then
		self.status_resistance = self.status_resistance * 0.5
		self.damage_reduction = self.damage_reduction * 0.5
	end
	if IsServer() then
		EmitSoundOn("Hero_Ursa.Enrage", hParent)
	end
	local particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_enrage_hero_effect.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
	self:AddParticle(particleID, false, false, MODIFIER_PRIORITY_ULTRA, true, false)

end
function modifier_ursa_enrage_lua_buff:OnRefresh(params)
	self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")
	self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if hCaster ~= hParent then
		self.status_resistance = self.status_resistance * 0.5
		self.damage_reduction = self.damage_reduction * 0.5
	end
	if IsServer() then
	end
end
function modifier_ursa_enrage_lua_buff:OnDestroy()
	if IsServer() then
	end
end
function modifier_ursa_enrage_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function modifier_ursa_enrage_lua_buff:GetModifierStatusResistanceStacking()
	return self.status_resistance
end
function modifier_ursa_enrage_lua_buff:GetModifierIncomingDamage_Percentage()
	return -self.damage_reduction
end
function modifier_ursa_enrage_lua_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_ursa_enrage_lua_buff:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf"
end
---------------------------------------------------------------------
--Modifiers
if modifier_ursa_enrage_lua == nil then
	modifier_ursa_enrage_lua = class({})
end
function modifier_ursa_enrage_lua:IsHidden()
	return true
end
function modifier_ursa_enrage_lua:OnCreated(params)
	if IsServer() then
	end
end
function modifier_ursa_enrage_lua:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_ursa_enrage_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_ursa_enrage_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
end
function modifier_ursa_enrage_lua:OnAbilityExecuted( params )
	local hParent = self:GetParent()
	local earth_shock_duration = self:GetAbility():GetSpecialValueFor("earth_shock_duration")
	if hParent ==  params.unit then
		if earth_shock_duration > 0 and params.ability:GetAbilityName() == "ursa_earthshock" then
			local bAdd = false
			if not hParent:HasModifier("modifier_ursa_enrage_lua_buff") then
				bAdd = true
			elseif hParent:HasModifier("modifier_ursa_enrage_lua_buff") and hParent:FindModifierByName("modifier_ursa_enrage_lua_buff"):GetRemainingTime() < earth_shock_duration then
				bAdd = true
			end
			if bAdd then
				hParent:AddNewModifier(hParent, self:GetAbility(), "modifier_ursa_enrage_lua_buff", {duration = earth_shock_duration})
			end
		end
	end
end