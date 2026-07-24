--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_dark_shield", "item_ability/item_dark_shield.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dark_shield_stack", "item_ability/item_dark_shield.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_foulfell_power_shield", "item_ability/item_dark_shield.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_bloodstone_3_shield", "item_ability/item_dark_shield.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_dark_shield == nil then
	item_dark_shield = class({})
end
function item_dark_shield:GetIntrinsicModifierName()
	return "modifier_item_dark_shield"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_dark_shield == nil then
	modifier_item_dark_shield = class({})
end
function modifier_item_dark_shield:IsHidden()
	return true
end
function modifier_item_dark_shield:IsDebuff()
	return false
end
function modifier_item_dark_shield:IsPurgable()
	return false
end
function modifier_item_dark_shield:IsPurgeException()
	return false
end
function modifier_item_dark_shield:RemoveOnDeath()
	return false
end
function modifier_item_dark_shield:OnCreated(params)
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	self.bonus_evasion = self:GetAbilitySpecialValueFor("bonus_evasion")
	self.stack_threshold = self:GetAbilitySpecialValueFor("stack_threshold")
	self.stack_armor = self:GetAbilitySpecialValueFor("stack_armor")
	self.stack_duration = self:GetAbilitySpecialValueFor("stack_duration")
	self.max_stacks = self:GetAbilitySpecialValueFor("max_stacks")
	-- 升级后属性
	self.lifesteal_percent = self:GetAbilitySpecialValueFor("lifesteal_percent")
	self.creep_lifesteal_reduction_pct = self:GetAbilitySpecialValueFor("creep_lifesteal_reduction_pct")
	self.bonus_aoe = self:GetAbilitySpecialValueFor("bonus_aoe")
	self.bonus_health = self:GetAbilitySpecialValueFor("bonus_health")
	self.bonus_mana = self:GetAbilitySpecialValueFor("bonus_mana")
	self.spell_lifesteal = self:GetAbilitySpecialValueFor("spell_lifesteal")
	self.creep_spell_lifesteal_reduction_pct = self:GetAbilitySpecialValueFor("creep_spell_lifesteal_reduction_pct")
	self.heal_to_shield = self:GetAbilitySpecialValueFor("heal_to_shield")
	self.bonus_strength = self:GetAbilitySpecialValueFor("bonus_strength")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.shield_duration = self:GetAbilitySpecialValueFor("shield_duration")
	-- 开启后属性
	self.unholy_lifesteal_percent = self:GetAbilitySpecialValueFor("unholy_lifesteal_percent")
	self.lifesteal_multiplier = self:GetAbilitySpecialValueFor("lifesteal_multiplier")
	if IsServer() then
		self.fDamagePool = 0
		AddModifierEvents(MODIFIER_EVENT_ON_TAKEDAMAGE, self, self:GetParent())
		if self.spell_lifesteal > 0 then
			local hParent = self:GetParent()
			local hAbility = self:GetAbility()
			self.tBloodStoneBuff = hParent:AddNewModifier(hParent, hAbility, "modifier_item_bloodstone", {})
		end
	end
end
function modifier_item_dark_shield:OnRefresh(params)
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	self.bonus_evasion = self:GetAbilitySpecialValueFor("bonus_evasion")
	self.stack_threshold = self:GetAbilitySpecialValueFor("stack_threshold")
	self.stack_armor = self:GetAbilitySpecialValueFor("stack_armor")
	self.stack_duration = self:GetAbilitySpecialValueFor("stack_duration")
	self.max_stacks = self:GetAbilitySpecialValueFor("max_stacks")
	-- 升级后属性
	self.lifesteal_percent = self:GetAbilitySpecialValueFor("lifesteal_percent")
	self.creep_lifesteal_reduction_pct = self:GetAbilitySpecialValueFor("creep_lifesteal_reduction_pct")
	self.bonus_aoe = self:GetAbilitySpecialValueFor("bonus_aoe")
	self.bonus_health = self:GetAbilitySpecialValueFor("bonus_health")
	self.bonus_mana = self:GetAbilitySpecialValueFor("bonus_mana")
	self.spell_lifesteal = self:GetAbilitySpecialValueFor("spell_lifesteal")
	self.creep_spell_lifesteal_reduction_pct = self:GetAbilitySpecialValueFor("creep_spell_lifesteal_reduction_pct")
	self.heal_to_shield = self:GetAbilitySpecialValueFor("heal_to_shield")
	self.bonus_strength = self:GetAbilitySpecialValueFor("bonus_strength")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.shield_duration = self:GetAbilitySpecialValueFor("shield_duration")
	-- 开启后属性
	self.unholy_lifesteal_percent = self:GetAbilitySpecialValueFor("unholy_lifesteal_percent")
	self.lifesteal_multiplier = self:GetAbilitySpecialValueFor("lifesteal_multiplier")
	if IsServer() then
	end
end
function modifier_item_dark_shield:OnRemoved(bDeath)
	if IsServer() then
		local hParent = self:GetParent()
		hParent:RemoveModifierByNameAndCaster("modifier_item_foulfell_power_shield", hParent)
		hParent:RemoveModifierByNameAndCaster("modifier_item_bloodstone_3_shield", hParent)
		if self.tBloodStoneBuff then
			self.tBloodStoneBuff:Destroy()
		end
	end
end
function modifier_item_dark_shield:OnDestroy()
	if IsServer() then
		RemoveModifierEvents(MODIFIER_EVENT_ON_TAKEDAMAGE, self, self:GetParent())
	end
end
function modifier_item_dark_shield:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		-- MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		-- MODIFIER_PROPERTY_HEALTH_BONUS,
		-- MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_AOE_BONUS_CONSTANT,
	}
end
function modifier_item_dark_shield:GetModifierPhysicalArmorBonus(params)
	local hParent = self:GetParent()

	return self.bonus_armor + hParent:GetModifierStackCount("modifier_item_dark_shield_stack", hParent) * self.stack_armor
end
function modifier_item_dark_shield:GetModifierEvasion_Constant(params)
	return self.bonus_evasion
end
function modifier_item_dark_shield:GetModifierBonusStats_Strength()
	return self.bonus_strength
end
function modifier_item_dark_shield:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_dark_shield:GetModifierHealthBonus(params)
	return self.bonus_health
end
function modifier_item_dark_shield:GetModifierManaBonus(params)
	return self.bonus_mana
end
function modifier_item_dark_shield:GetModifierAoEBonusConstant(params)
	return self.bonus_aoe
end
function modifier_item_dark_shield:GetModifierIncomingPhysicalDamage_Percentage(params)
	local fDamage = params.original_damage
	local hCaster = self:GetCaster()
	local hAttacker = params.attacker
	local hAbility = self:GetAbility()

	if fDamage > 0 and IsValid(hCaster) and IsValid(hAttacker) and IsValid(hAbility) and hCaster:GetTeamNumber() ~= hAttacker:GetTeamNumber() then
		self.fDamagePool = self.fDamagePool + fDamage
		local iStack = math.floor(self.fDamagePool / self.stack_threshold)

		if iStack > 0 then
			hCaster:AddNewModifier(hCaster, hAbility, "modifier_item_dark_shield_stack", { duration = self.stack_duration, stack = iStack })
			self.fDamagePool = self.fDamagePool - iStack * self.stack_threshold
		end
	end
end
function modifier_item_dark_shield:OnTakeDamage(params)
	local fDamage = params.damage
	local hTarget = params.unit
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	local hInflictor = params.inflictor
	local iDamageFlags = params.damage_flags
	local iDamageCategory = params.damage_category

	if IsServer() then
		if IsValid(hAbility) and IsValid(hParent) and IsValid(hTarget) and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() then
			if iDamageCategory == DOTA_DAMAGE_CATEGORY_ATTACK then
				if self.lifesteal_percent > 0 then
					-- 攻击吸血
					local fLifestealPercent = self.lifesteal_percent
					if hParent:HasModifier("modifier_item_foulfell_power") then
						fLifestealPercent = self.unholy_lifesteal_percent
					end
					if not hTarget:IsHero() then
						fLifestealPercent = fLifestealPercent * (100 - self.creep_lifesteal_reduction_pct) * 0.01
					end
					local flAmount = fDamage * fLifestealPercent * 0.01
					if flAmount >= 1 then
						hParent:HealWithParams(flAmount, hAbility, true, true, hParent, false)
						SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, hParent, flAmount, nil)

						local iParticleID = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
						ParticleManager:ReleaseParticleIndex(iParticleID)

						local fOverHeal = math.floor(self.heal_to_shield * 0.01 * (flAmount - hParent:GetHealthDeficit()))
						if fOverHeal >= 1 then
							hParent:AddNewModifier(hParent, hAbility, "modifier_item_foulfell_power_shield", { duration = self.shield_duration, stack = fOverHeal })
						end
					end
				end
			elseif iDamageCategory == DOTA_DAMAGE_CATEGORY_SPELL then
				if self.spell_lifesteal > 0 then
					-- 技能吸血
					if bit.band(iDamageFlags, DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION) ~= DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION and bit.band(iDamageFlags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL) ~= DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL then
						local fLifestealPercent = self.spell_lifesteal
						if hParent:HasModifier("modifier_item_bloodstone_3") then
							fLifestealPercent = fLifestealPercent * self.lifesteal_multiplier
						end
						if not hTarget:IsHero() then
							fLifestealPercent = fLifestealPercent * (100 - self.creep_spell_lifesteal_reduction_pct) * 0.01
						end
						local flAmount = fDamage * fLifestealPercent * 0.01

						if flAmount >= 1 then
							hParent:HealWithParams(flAmount, hAbility, false, true, hParent, true)
							SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, hParent, flAmount, nil)
							if hParent:HasModifier("modifier_item_bloodstone_3") then
								hParent:GiveMana(flAmount)
								SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, hParent, flAmount, nil)
							end

							local iParticleID = ParticleManager:CreateParticle("particles/items3_fx/octarine_core_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
							ParticleManager:ReleaseParticleIndex(iParticleID)

							local fOverHeal = math.floor(self.heal_to_shield * 0.01 * (flAmount - hParent:GetHealthDeficit()))
							if fOverHeal >= 1 then
								hParent:AddNewModifier(hParent, hAbility, "modifier_item_bloodstone_3_shield", { duration = self.shield_duration, stack = fOverHeal })
							end
						end
					end
				end
			end
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_dark_shield_stack == nil then
	modifier_item_dark_shield_stack = class({})
end
function modifier_item_dark_shield_stack:IsHidden()
	return false
end
function modifier_item_dark_shield_stack:IsDebuff()
	return false
end
function modifier_item_dark_shield_stack:IsPurgable()
	return false
end
function modifier_item_dark_shield_stack:IsPurgeException()
	return false
end
function modifier_item_dark_shield_stack:OnCreated(params)
	self.max_stacks = self:GetAbilitySpecialValueFor("max_stacks")
	self.stack_armor = self:GetAbilitySpecialValueFor("stack_armor")
	if IsServer() then
		self.tStacks = {}
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStacks, { fDieTime = GameRules:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
		if iStackCount > self.max_stacks then
			self:RemoveStackCount(iStackCount - self.max_stacks)
		end
		self:StartIntervalThink(0)
	end
end
function modifier_item_dark_shield_stack:OnRefresh(params)
	self.max_stacks = self:GetAbilitySpecialValueFor("max_stacks")
	self.stack_armor = self:GetAbilitySpecialValueFor("stack_armor")
	if IsServer() then
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStacks, { fDieTime = GameRules:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
		if iStackCount > self.max_stacks then
			self:RemoveStackCount(iStackCount - self.max_stacks)
		end
	end
end
function modifier_item_dark_shield_stack:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_dark_shield_stack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function modifier_item_dark_shield_stack:OnIntervalThink()
	local fGameTime = GameRules:GetGameTime()
	for i = #self.tStacks, 1, -1 do
		if fGameTime >= self.tStacks[i].fDieTime then
			self:SetStackCount(math.max(0, self:GetStackCount() - self.tStacks[i].iCount))
			table.remove(self.tStacks, i)
		end
	end
end
function modifier_item_dark_shield_stack:RemoveStackCount(iRemovedCount)
	if IsServer() then
		local iStackCount = self:GetStackCount()
		local iLast = 0
		for i = 1, #self.tStacks, 1 do
			if self.tStacks[i].iCount <= iRemovedCount then
				iLast = i
				iRemovedCount = iRemovedCount - self.tStacks[i].iCount
				if iRemovedCount == 0 then
					break
				end
			else
				iStackCount = iStackCount - iRemovedCount
				self.tStacks[i].iCount = self.tStacks[i].iCount - iRemovedCount
				break
			end
		end
		for i = iLast, 1, -1 do
			iStackCount = iStackCount - self.tStacks[i].iCount
			table.remove(self.tStacks, i)
		end
		self:SetStackCount(iStackCount)
		if iStackCount <= 0 then
			self:Destroy()
		end
	end
end
function modifier_item_dark_shield_stack:OnTooltip()
	return self:GetStackCount() * self.stack_armor
end
function modifier_item_dark_shield_stack:GetTexture()
	return "item_glimmerdark_shield"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_foulfell_power_shield == nil then
	modifier_item_foulfell_power_shield = class({})
end
function modifier_item_foulfell_power_shield:IsHidden()
	return false
end
function modifier_item_foulfell_power_shield:IsDebuff()
	return false
end
function modifier_item_foulfell_power_shield:IsPurgable()
	return false
end
function modifier_item_foulfell_power_shield:IsPurgeException()
	return false
end
function modifier_item_foulfell_power_shield:OnCreated(params)
	self.max_shield = self:GetAbilitySpecialValueFor("max_shield")
	if IsServer() then
		local iStack = (params.stack or 0)
		self.fShieldHP = math.min(self.max_shield, (self.fShieldHP or 0) + iStack)
		self:SetHasCustomTransmitterData(true)
	end
end
function modifier_item_foulfell_power_shield:OnRefresh(params)
	self.max_shield = self:GetAbilitySpecialValueFor("max_shield")
	if IsServer() then
		local iStack = (params.stack or 0)
		self.fShieldHP = math.min(self.max_shield, (self.fShieldHP or 0) + iStack)
		self:SendBuffRefreshToClients()
	end
end
function modifier_item_foulfell_power_shield:OnDestroy()
	if IsServer() then
		self:SetHasCustomTransmitterData(false)
	end
end
function modifier_item_foulfell_power_shield:AddCustomTransmitterData()
	return {
		fShieldHP = self.fShieldHP,
	}
end
function modifier_item_foulfell_power_shield:HandleCustomTransmitterData(t)
	self.fShieldHP = t.fShieldHP
end
function modifier_item_foulfell_power_shield:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
end
function modifier_item_foulfell_power_shield:GetModifierIncomingDamageConstant(params)
	local fDamage = params.damage
	local hAttacker = params.attacker
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	if IsServer() then
		if fDamage > 0 then
			if IsValid(hAttacker) and IsValid(hParent) and IsValid(hAbility) and hAttacker:GetTeamNumber() ~= hParent:GetTeamNumber() then
				if fDamage >= self.fShieldHP then
					self.fShieldHP = 0
					self:Destroy()
					return -self.fShieldHP
				else
					self.fShieldHP = self.fShieldHP - fDamage
					self:SendBuffRefreshToClients()
					return -fDamage
				end
			end
		end
	else
		if params.report_max then
			return self.max_shield
		else
			return self.fShieldHP or 0
		end
	end
end
function modifier_item_foulfell_power_shield:GetTexture()
	return "foulfell_power_shield"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_bloodstone_3_shield == nil then
	modifier_item_bloodstone_3_shield = class({})
end
function modifier_item_bloodstone_3_shield:IsHidden()
	return false
end
function modifier_item_bloodstone_3_shield:IsDebuff()
	return false
end
function modifier_item_bloodstone_3_shield:IsPurgable()
	return false
end
function modifier_item_bloodstone_3_shield:IsPurgeException()
	return false
end
function modifier_item_bloodstone_3_shield:OnCreated(params)
	self.max_shield = self:GetAbilitySpecialValueFor("max_shield")
	if IsServer() then
		local iStack = (params.stack or 0)
		self.fShieldHP = math.min(self.max_shield, (self.fShieldHP or 0) + iStack)
		self:SetHasCustomTransmitterData(true)
	end
end
function modifier_item_bloodstone_3_shield:OnRefresh(params)
	self.max_shield = self:GetAbilitySpecialValueFor("max_shield")
	if IsServer() then
		local iStack = (params.stack or 0)
		self.fShieldHP = math.min(self.max_shield, (self.fShieldHP or 0) + iStack)
		self:SendBuffRefreshToClients()
	end
end
function modifier_item_bloodstone_3_shield:OnDestroy()
	if IsServer() then
		self:SetHasCustomTransmitterData(false)
	end
end
function modifier_item_bloodstone_3_shield:AddCustomTransmitterData()
	return {
		fShieldHP = self.fShieldHP,
	}
end
function modifier_item_bloodstone_3_shield:HandleCustomTransmitterData(t)
	self.fShieldHP = t.fShieldHP
end
function modifier_item_bloodstone_3_shield:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
end
function modifier_item_bloodstone_3_shield:GetModifierIncomingDamageConstant(params)
	local fDamage = params.damage
	local hAttacker = params.attacker
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	if IsServer() then
		if fDamage > 0 then
			if IsValid(hAttacker) and IsValid(hParent) and hAttacker:GetTeamNumber() ~= hParent:GetTeamNumber() then
				if fDamage >= self.fShieldHP then
					self.fShieldHP = 0
					self:Destroy()
					return -self.fShieldHP
				else
					self.fShieldHP = self.fShieldHP - fDamage
					self:SendBuffRefreshToClients()
					return -fDamage
				end
			end
		end
	else
		if params.report_max then
			return self.max_shield
		else
			return self.fShieldHP or 0
		end
	end
end
function modifier_item_bloodstone_3_shield:GetTexture()
	return "bloodstone_3_shield"
end