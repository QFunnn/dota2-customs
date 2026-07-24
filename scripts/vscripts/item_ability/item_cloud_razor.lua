--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_cloud_razor", "item_ability/item_cloud_razor.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_cloud_razor_corruption", "item_ability/item_cloud_razor.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_cloud_razor == nil then
	item_cloud_razor = class({})
end
function item_cloud_razor:GetIntrinsicModifierName()
	return "modifier_item_cloud_razor"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_cloud_razor == nil then
	modifier_item_cloud_razor = class({})
end
function modifier_item_cloud_razor:IsHidden()
	return true
end
function modifier_item_cloud_razor:IsDebuff()
	return false
end
function modifier_item_cloud_razor:IsPurgable()
	return false
end
function modifier_item_cloud_razor:IsPurgeException()
	return false
end
function modifier_item_cloud_razor:OnCreated(params)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.bonus_chance = self:GetAbilitySpecialValueFor("bonus_chance")
	self.bonus_chance_damage = self:GetAbilitySpecialValueFor("bonus_chance_damage")
	self.corruption_duration = self:GetAbilitySpecialValueFor("corruption_duration")
	self.kill_charge = self:GetAbilitySpecialValueFor("kill_charge")
	self.max_charge = self:GetAbilitySpecialValueFor("max_charge")
	self.death_lose_charge = self:GetAbilitySpecialValueFor("death_lose_charge")
	self.initial_charge = self:GetAbilitySpecialValueFor("initial_charge")
	if IsServer() then
		local hAbility = self:GetAbility()
		if IsValid(hAbility) then
			hAbility:SetCurrentCharges(self.initial_charge or 0)
		end
	end
end
function modifier_item_cloud_razor:OnRefresh(params)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.bonus_chance = self:GetAbilitySpecialValueFor("bonus_chance")
	self.bonus_chance_damage = self:GetAbilitySpecialValueFor("bonus_chance_damage")
	self.corruption_duration = self:GetAbilitySpecialValueFor("corruption_duration")
	self.kill_charge = self:GetAbilitySpecialValueFor("kill_charge")
	self.max_charge = self:GetAbilitySpecialValueFor("max_charge")
	self.death_lose_charge = self:GetAbilitySpecialValueFor("death_lose_charge")
	self.initial_charge = self:GetAbilitySpecialValueFor("initial_charge")
	if IsServer() then
	end
end
function modifier_item_cloud_razor:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_cloud_razor:RemoveOnDeath()
	return false
end
function modifier_item_cloud_razor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end
function modifier_item_cloud_razor:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end
function modifier_item_cloud_razor:GetModifierPreAttack_BonusDamage(params)
	return self.bonus_damage
end
function modifier_item_cloud_razor:GetModifierAttackSpeedBonus_Constant(params)
	return self.bonus_attack_speed
end
function modifier_item_cloud_razor:GetModifierProcAttack_BonusDamage_Magical(params)
	local hTarget = params.target
	if IsValid(hTarget) then
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, hTarget, self.bonus_chance_damage, nil)
		return self.bonus_chance_damage
	end
end
function modifier_item_cloud_razor:GetModifierTotalDamageOutgoing_Percentage(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()
	local iDamageType = params.damage_type

	if IsValid(hParent) and IsValid(hTarget) and IsValid(hAbility) and not hParent:IsIllusion() and hTarget:IsAlive() and iDamageType == DAMAGE_TYPE_PHYSICAL and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() then
		hTarget:AddNewModifier(hParent, hAbility, "modifier_item_cloud_razor_corruption", { duration = self.corruption_duration * hTarget:GetStatusResistanceFactor(hParent) })
	end
end
function modifier_item_cloud_razor:OnDeath(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	local hUnit = params.unit
	local hAbility = self:GetAbility()

	if IsValid(hAbility) and IsValid(hParent) and IsValid(hUnit) and hParent:IsRealHero() and hUnit:IsRealHero() and hAttacker:GetTeamNumber() ~= hUnit:GetTeamNumber() then
		if hParent == hAttacker and hParent ~= hUnit and hAbility:GetCurrentCharges() < self.max_charge then
			hAbility:SetCurrentCharges(math.min(self.max_charge, hAbility:GetCurrentCharges() + self.kill_charge))
		elseif hParent ~= hAttacker and hParent == hUnit then
			hAbility:SetCurrentCharges(math.max(0, hAbility:GetCurrentCharges() - self.death_lose_charge))
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_cloud_razor_corruption == nil then
	modifier_item_cloud_razor_corruption = class({})
end
function modifier_item_cloud_razor_corruption:IsHidden()
	return false
end
function modifier_item_cloud_razor_corruption:IsDebuff()
	return true
end
function modifier_item_cloud_razor_corruption:IsPurgable()
	return true
end
function modifier_item_cloud_razor_corruption:IsPurgeException()
	return true
end
function modifier_item_cloud_razor_corruption:OnCreated(params)
	self.corruption_armor = self:GetAbilitySpecialValueFor("corruption_armor")
	self.corruption_armor_pct_charge = self:GetAbilitySpecialValueFor("corruption_armor_pct_charge")
	if IsServer() then
		local hParent = self:GetParent()
		local hAbility = self:GetAbility()
		if IsValid(hParent) and IsValid(hAbility) then
			local fArmor_reduction = self.corruption_armor
			if IsValid(hAbility) then
				fArmor_reduction = fArmor_reduction + hParent:GetPhysicalArmorValue(false) * self.corruption_armor_pct_charge * hAbility:GetCurrentCharges() * 0.01
			end
			self.armor_reduction = fArmor_reduction
			self:SetHasCustomTransmitterData(true)
			self:SendBuffRefreshToClients()
		end
	end
end
function modifier_item_cloud_razor_corruption:OnRefresh(params)
	self.corruption_armor = self:GetAbilitySpecialValueFor("corruption_armor")
	self.corruption_armor_pct_charge = self:GetAbilitySpecialValueFor("corruption_armor_pct_charge")
	if IsServer() then
		local hParent = self:GetParent()
		local hAbility = self:GetAbility()
		if IsValid(hParent) and IsValid(hAbility) then
			local fArmor_reduction = self.corruption_armor
			if IsValid(hAbility) then
				fArmor_reduction = fArmor_reduction + (hParent:GetPhysicalArmorValue(false) + self.armor_reduction) * self.corruption_armor_pct_charge * hAbility:GetCurrentCharges() * 0.01
			end
			self.armor_reduction = fArmor_reduction
			self:SendBuffRefreshToClients()
		end
	end
end
function modifier_item_cloud_razor_corruption:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_cloud_razor_corruption:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end
function modifier_item_cloud_razor_corruption:AddCustomTransmitterData()
	local t = {}
	t.armor_reduction = self.armor_reduction
	return t
end
function modifier_item_cloud_razor_corruption:HandleCustomTransmitterData(t)
	self.armor_reduction = t.armor_reduction
end
function modifier_item_cloud_razor_corruption:GetModifierPhysicalArmorBonus(params)
	return -(self.armor_reduction or 0)
end