--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skywrath_mage_shield_of_the_scion_lua", "heroes/hero_skywrath_mage/skywrath_mage_shield_of_the_scion_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_shield_of_the_scion_lua_buff", "heroes/hero_skywrath_mage/skywrath_mage_shield_of_the_scion_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if skywrath_mage_shield_of_the_scion_lua == nil then
	skywrath_mage_shield_of_the_scion_lua = class({})
end
function skywrath_mage_shield_of_the_scion_lua:GetIntrinsicModifierName()
	return "modifier_skywrath_mage_shield_of_the_scion_lua"
end
function skywrath_mage_shield_of_the_scion_lua:GetCooldown(iLevel)
	local cooldown = self:GetSpecialValueFor("cooldown")
	local hCaster = self:GetCaster()
	return cooldown / hCaster:GetCooldownReduction()
end
---------------------------------------------------------------------
--Modifiers
if modifier_skywrath_mage_shield_of_the_scion_lua == nil then
	modifier_skywrath_mage_shield_of_the_scion_lua = class({})
end
function modifier_skywrath_mage_shield_of_the_scion_lua:IsDebuff()
	return false
end
function modifier_skywrath_mage_shield_of_the_scion_lua:IsHidden()
	return true
end
function modifier_skywrath_mage_shield_of_the_scion_lua:IsPurgable()
	return false
end
function modifier_skywrath_mage_shield_of_the_scion_lua:OnCreated(params)
	self.stack_duration = self:GetAbilitySpecialValueFor("stack_duration")
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
	self.stack_to_cooldown = self:GetAbilitySpecialValueFor("stack_to_cooldown")
	if IsServer() then
	end
end
function modifier_skywrath_mage_shield_of_the_scion_lua:OnRefresh(params)
	self.stack_duration = self:GetAbilitySpecialValueFor("stack_duration")
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
	self.stack_to_cooldown = self:GetAbilitySpecialValueFor("stack_to_cooldown")
	if IsServer() then
	end
end
function modifier_skywrath_mage_shield_of_the_scion_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_skywrath_mage_shield_of_the_scion_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end
function modifier_skywrath_mage_shield_of_the_scion_lua:GetModifierTotalDamageOutgoing_Percentage(params)
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	local hInflictor = params.inflictor
	local damage_type = params.damage_type

	if IsValid(hAbility) and IsValid(hInflictor) and IsValid(hParent) and hAbility:IsCooldownReady() and hInflictor.IsPassive and type(hInflictor.IsPassive) == "function" and not (hInflictor:IsPassive()) then
		if damage_type == DAMAGE_TYPE_MAGICAL and not hInflictor:IsItem() then
			hParent:AddNewModifier(hParent, hAbility, "modifier_skywrath_mage_shield_of_the_scion_lua_buff", { duration = self.stack_duration })
			self:IncrementStackCount()
			if self:GetStackCount() >= self.stack_to_cooldown then
				self:SetStackCount(0)
				hAbility:UseResources(true, false, true, true)
			end
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_skywrath_mage_shield_of_the_scion_lua_buff == nil then
	modifier_skywrath_mage_shield_of_the_scion_lua_buff = class({})
end
function modifier_skywrath_mage_shield_of_the_scion_lua_buff:IsDebuff()
	return false
end
function modifier_skywrath_mage_shield_of_the_scion_lua_buff:IsHidden()
	return false
end
function modifier_skywrath_mage_shield_of_the_scion_lua_buff:IsPurgable()
	return false
end
function modifier_skywrath_mage_shield_of_the_scion_lua_buff:OnCreated(params)
	self.bonus_intelligence = self:GetAbilitySpecialValueFor("bonus_intelligence")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	if IsServer() then
		self.tStack = {}
		self:StartIntervalThink(FrameTime())
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStack, { fDieTime = GameRules:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
	end
end
function modifier_skywrath_mage_shield_of_the_scion_lua_buff:OnRefresh(params)
	self.bonus_intelligence = self:GetAbilitySpecialValueFor("bonus_intelligence")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	if IsServer() then
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStack, { fDieTime = GameRules:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
	end
end
function modifier_skywrath_mage_shield_of_the_scion_lua_buff:OnDestroy()
	if IsServer() then
	end
end
function modifier_skywrath_mage_shield_of_the_scion_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end
function modifier_skywrath_mage_shield_of_the_scion_lua_buff:GetModifierBonusStats_Intellect()
	return self.bonus_intelligence * self:GetStackCount()
end
function modifier_skywrath_mage_shield_of_the_scion_lua_buff:GetModifierPhysicalArmorBonus()
	return self.bonus_armor * self:GetStackCount()
end
function modifier_skywrath_mage_shield_of_the_scion_lua_buff:OnIntervalThink()
	local hCaster = self:GetCaster()
	if not IsValid(hCaster) then
		self:Destroy()
		return
	end
	local fGameTime = GameRules:GetGameTime()
	for i = #self.tStack, 1, -1 do
		if fGameTime >= self.tStack[i].fDieTime then
			self:SetStackCount(math.max(0, self:GetStackCount() - self.tStack[i].iCount))
			table.remove(self.tStack, i)
		end
	end
end