--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_forged_spirit_melting_strike_lua", "heroes/hero_invoker/forged_spirit_melting_strike_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_forged_spirit_melting_strike_lua_debuff", "heroes/hero_invoker/forged_spirit_melting_strike_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if forged_spirit_melting_strike_lua == nil then
	forged_spirit_melting_strike_lua = class({})
end
function forged_spirit_melting_strike_lua:GetIntrinsicModifierName()
	return "modifier_forged_spirit_melting_strike_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_forged_spirit_melting_strike_lua == nil then
	modifier_forged_spirit_melting_strike_lua = class({})
end
function modifier_forged_spirit_melting_strike_lua:IsDebuff()
	return false
end
function modifier_forged_spirit_melting_strike_lua:IsHidden()
	return true
end
function modifier_forged_spirit_melting_strike_lua:IsPurgable()
	return false
end
function modifier_forged_spirit_melting_strike_lua:IsPurgeException()
	return false
end
function modifier_forged_spirit_melting_strike_lua:OnCreated(params)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.armor_removed = self:GetAbility():GetSpecialValueFor("armor_removed")
	if IsServer() then
	end
end
function modifier_forged_spirit_melting_strike_lua:OnRefresh(params)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.armor_removed = self:GetAbility():GetSpecialValueFor("armor_removed")
	if IsServer() then
	end
end
function modifier_forged_spirit_melting_strike_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_forged_spirit_melting_strike_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
	}
end
function modifier_forged_spirit_melting_strike_lua:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()
	if IsValid(hParent) and IsValid(hTarget) and IsValid(hAbility) and hTarget:IsHero() then
		hTarget:AddNewModifier(hParent, hAbility, "modifier_forged_spirit_melting_strike_lua_debuff", { duration = self.duration })
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_forged_spirit_melting_strike_lua_debuff == nil then
	modifier_forged_spirit_melting_strike_lua_debuff = class({})
end
function modifier_forged_spirit_melting_strike_lua_debuff:IsDebuff()
	return true
end
function modifier_forged_spirit_melting_strike_lua_debuff:IsHidden()
	return false
end
function modifier_forged_spirit_melting_strike_lua_debuff:IsPurgable()
	return true
end
function modifier_forged_spirit_melting_strike_lua_debuff:IsPurgeException()
	return true
end
function modifier_forged_spirit_melting_strike_lua_debuff:OnCreated(params)
	self.max_armor_removed = self:GetAbility():GetSpecialValueFor("max_armor_removed")
	self.armor_removed = self:GetAbility():GetSpecialValueFor("armor_removed")
	if IsServer() then
		self:SetStackCount(1)
	end
end
function modifier_forged_spirit_melting_strike_lua_debuff:OnRefresh(params)
	self.max_armor_removed = self:GetAbility():GetSpecialValueFor("max_armor_removed")
	self.armor_removed = self:GetAbility():GetSpecialValueFor("armor_removed")
	if IsServer() then
		if self:GetStackCount() < self.max_armor_removed then
			self:IncrementStackCount()
		end
	end
end
function modifier_forged_spirit_melting_strike_lua_debuff:OnDestroy()
	if IsServer() then
	end
end
function modifier_forged_spirit_melting_strike_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end
function modifier_forged_spirit_melting_strike_lua_debuff:GetModifierPhysicalArmorBonus(params)
	return -self.armor_removed * self:GetStackCount()
end