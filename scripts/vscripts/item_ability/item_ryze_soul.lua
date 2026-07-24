--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ryze_soul", "item_ability/item_ryze_soul.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_ryze_soul_buff", "item_ability/item_ryze_soul.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_ryze_soul == nil then
	item_ryze_soul = class({})
end
function item_ryze_soul:OnSpellStart()
	local hCaster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	hCaster:AddNewModifier(hCaster, self, "modifier_item_ryze_soul_buff", { duration = duration })
end
function item_ryze_soul:GetIntrinsicModifierName()
	return "modifier_item_ryze_soul"
end
function item_ryze_soul:IsRefreshable()
	return false
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_ryze_soul == nil then
	modifier_item_ryze_soul = class({})
end
function modifier_item_ryze_soul:IsHidden()
	return true
end
function modifier_item_ryze_soul:IsDebuff()
	return false
end
function modifier_item_ryze_soul:IsPurgable()
	return false
end
function modifier_item_ryze_soul:IsPurgeException()
	return false
end
function modifier_item_ryze_soul:OnCreated(params)
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_cast_range = self:GetAbilitySpecialValueFor("bonus_cast_range")
	if IsServer() then
	end
end
function modifier_item_ryze_soul:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_ryze_soul:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_ryze_soul:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,

	}
end
function modifier_item_ryze_soul:GetModifierMPRegenAmplify_Percentage(params)
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()

	if IsValid(hParent) and IsValid(hAbility) then
		local fManaDeficitPercent = (hParent:GetMaxMana() - hParent:GetMana()) / hParent:GetMaxMana() * 100
		return fManaDeficitPercent * fManaDeficitPercent
	end
end
function modifier_item_ryze_soul:GetModifierBonusStats_Intellect()
	return self.bonus_int
end
--------------------------------------------------------------------
--Modifiers
if modifier_item_ryze_soul_buff == nil then
	modifier_item_ryze_soul_buff = class({})
end
function modifier_item_ryze_soul_buff:IsHidden()
	return false
end
function modifier_item_ryze_soul_buff:IsDebuff()
	return false
end
function modifier_item_ryze_soul_buff:IsPurgable()
	return false
end
function modifier_item_ryze_soul_buff:IsPurgeException()
	return false
end
function modifier_item_ryze_soul_buff:OnCreated(params)
	self.cooldown_min = self:GetAbilitySpecialValueFor("cooldown_min")
	self.cooldown_reduction = self:GetAbilitySpecialValueFor("cooldown_reduction")
	self.bonus_manacost = self:GetAbilitySpecialValueFor("bonus_manacost")
	self.casttime_reduction = self:GetAbilitySpecialValueFor("casttime_reduction")
	self.bonus_cast_range = self:GetAbilitySpecialValueFor("bonus_cast_range")
	if IsServer() then
		self:StartIntervalThink(0)
		self.tCooldown = {}
		self:SetHasCustomTransmitterData(true)
	end
end
function modifier_item_ryze_soul_buff:OnRefresh(params)
	self.cooldown_min = self:GetAbilitySpecialValueFor("cooldown_min")
	self.cooldown_reduction = self:GetAbilitySpecialValueFor("cooldown_reduction")
	self.bonus_manacost = self:GetAbilitySpecialValueFor("bonus_manacost")
	self.casttime_reduction = self:GetAbilitySpecialValueFor("casttime_reduction")
	self.bonus_cast_range = self:GetAbilitySpecialValueFor("bonus_cast_range")
	if IsServer() then
	end
end
function modifier_item_ryze_soul_buff:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_ryze_soul_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
	}
end
function modifier_item_ryze_soul_buff:OnIntervalThink()
	local hParent = self:GetParent()
	if IsValid(hParent) then
		for i = 0, hParent:GetAbilityCount() - 1 do
			local hAbility = hParent:GetAbilityByIndex(i)
			if IsValid(hAbility) then
				local sAbilityName = hAbility:GetAbilityName()
				local fCooldown = hAbility:GetCooldown(-1)
				if fCooldown > self.cooldown_min then
					local fEffectiveCooldown = hAbility:GetCooldown(-1) * hParent:GetCooldownReduction()
					if fEffectiveCooldown > 0 then
						if fEffectiveCooldown * (100 - self.cooldown_reduction) * 0.01 < self.cooldown_min then
							self.tCooldown[sAbilityName] = 1 - self.cooldown_min / fEffectiveCooldown
						else
							self.tCooldown[sAbilityName] = self.cooldown_reduction * 0.01
						end
					end
				end
			end
		end
		for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_9 do
			local hItem = hParent:GetItemInSlot(i)
			if IsValid(hItem) then
				local sAbilityName = hItem:GetAbilityName()
				local fCooldown = hItem:GetCooldown(-1)
				if sAbilityName ~= "item_refresher_lua" and fCooldown > self.cooldown_min then
					local fEffectiveCooldown = hItem:GetCooldown(-1) * hParent:GetCooldownReduction()
					if fEffectiveCooldown > 0 then
						if fEffectiveCooldown * (100 - self.cooldown_reduction) * 0.01 < self.cooldown_min then
							self.tCooldown[sAbilityName] = 1 - self.cooldown_min / fEffectiveCooldown
						else
							self.tCooldown[sAbilityName] = self.cooldown_reduction * 0.01
						end
					end
				end
			end
		end
		self:SendBuffRefreshToClients()
	end
end
function modifier_item_ryze_soul_buff:AddCustomTransmitterData()
	return self.tCooldown
end
function modifier_item_ryze_soul_buff:HandleCustomTransmitterData(tCooldown)
	if self.tCooldown == nil then
		self.tCooldown = {}
	end
	for AbilityName, CooldownReduction in pairs(tCooldown) do
		self.tCooldown[AbilityName] = CooldownReduction
	end
end
function modifier_item_ryze_soul_buff:GetModifierPercentageCooldown(params)
	local hInflictor = params.ability

	if hInflictor then
		local sAbilityName = hInflictor:GetAbilityName()

		if self.tCooldown[sAbilityName] then
			return self.tCooldown[sAbilityName] * 100
		end
	end
end
function modifier_item_ryze_soul_buff:CheckState()
	return {
		[MODIFIER_STATE_SILENCED] = false,
	}
end
function modifier_item_ryze_soul_buff:GetModifierPercentageManacostStacking(params)
	return -(self.bonus_manacost - 100)
end
function modifier_item_ryze_soul_buff:GetModifierPercentageCasttime(params)
	return self.casttime_reduction
end
function modifier_item_ryze_soul_buff:GetModifierCastRangeBonusStacking(params)
	return self.bonus_cast_range
end