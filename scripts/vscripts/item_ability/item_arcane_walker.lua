--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_arcane_walker", "item_ability/item_arcane_walker.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_arcane_walker_magical_armor_pen", "item_ability/item_arcane_walker.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_arcane_walker == nil then
	item_arcane_walker = class({})
end
function item_arcane_walker:GetIntrinsicModifierName()
	return "modifier_item_arcane_walker"
end
function item_arcane_walker:OnSpellStart()
	local hCaster = self:GetCaster()

	if IsValid(hCaster) then
		local replenish_amount = self:GetSpecialValueFor("replenish_amount")
		local bonus_replenish_amount_pct = self:GetSpecialValueFor("bonus_replenish_amount_pct")
		local fManaLostPct = 0
		if hCaster:GetMaxMana() > 0 then
			fManaLostPct = math.floor((hCaster:GetMaxMana() - hCaster:GetMana()) / hCaster:GetMaxMana() * 100)
		end
		local fAmount = replenish_amount * (100 + (fManaLostPct * bonus_replenish_amount_pct)) * 0.01
		hCaster:GiveMana(fAmount)
		SendOverheadEventMessage(hCaster, OVERHEAD_ALERT_MANA_ADD, hCaster, math.floor(fAmount), nil)

		local iParticleID = ParticleManager:CreateParticle("particles/items_fx/arcane_boots_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
		ParticleManager:ReleaseParticleIndex(iParticleID)
		local iParticleID2 = ParticleManager:CreateParticle("particles/items_fx/arcane_boots.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
		ParticleManager:ReleaseParticleIndex(iParticleID2)

		EmitSoundOn("DOTA_Item.ArcaneBoots.Activate", hCaster)
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_arcane_walker == nil then
	modifier_item_arcane_walker = class({})
end
function modifier_item_arcane_walker:IsHidden()
	return true
end
function modifier_item_arcane_walker:IsDebuff()
	return false
end
function modifier_item_arcane_walker:IsPurgable()
	return false
end
function modifier_item_arcane_walker:IsPurgeException()
	return false
end
function modifier_item_arcane_walker:OnCreated(params)
	self.bonus_movement = self:GetAbilitySpecialValueFor("bonus_movement")
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
	self.bonus_mana = self:GetAbilitySpecialValueFor("bonus_mana")
	self.bonus_mana_pct = self:GetAbilitySpecialValueFor("bonus_mana_pct")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.cast_range_bonus = self:GetAbilitySpecialValueFor("cast_range_bonus")
	self.magical_armor_pen = self:GetAbilitySpecialValueFor("magical_armor_pen")
	self.magical_armor_pen_pct_charge = self:GetAbilitySpecialValueFor("magical_armor_pen_pct_charge")
	self.kill_charge = self:GetAbilitySpecialValueFor("kill_charge")
	self.max_charge = self:GetAbilitySpecialValueFor("max_charge")
	self.death_lose_charge = self:GetAbilitySpecialValueFor("death_lose_charge")
	self.initial_charge = self:GetAbilitySpecialValueFor("initial_charge")
	self.bonus_hp = self:GetAbilitySpecialValueFor("bonus_hp")
	self.bonus_spell_lifesteal = self:GetAbilitySpecialValueFor("bonus_spell_lifesteal")
	self.spell_lifesteal_charge = self:GetAbilitySpecialValueFor("spell_lifesteal_charge")
	self.spell_amp_charge = self:GetAbilitySpecialValueFor("spell_amp_charge")
	self.lifesteal_multiplier = self:GetAbilitySpecialValueFor("lifesteal_multiplier")
	if IsServer() then
		local hParent = self:GetParent()
		local hAbility = self:GetAbility()
		if IsValid(hAbility) then
			if hParent.arcane_walker_charge then

				hAbility:SetCurrentCharges(hParent.arcane_walker_charge or 0)
			else
				hAbility:SetCurrentCharges(self.initial_charge or 0)
			end
		end
	end
end
function modifier_item_arcane_walker:OnRefresh(params)
	self.bonus_movement = self:GetAbilitySpecialValueFor("bonus_movement")
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
	self.bonus_mana = self:GetAbilitySpecialValueFor("bonus_mana")
	self.bonus_mana_pct = self:GetAbilitySpecialValueFor("bonus_mana_pct")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.cast_range_bonus = self:GetAbilitySpecialValueFor("cast_range_bonus")
	self.magical_armor_pen = self:GetAbilitySpecialValueFor("magical_armor_pen")
	self.magical_armor_pen_pct_charge = self:GetAbilitySpecialValueFor("magical_armor_pen_pct_charge")
	self.kill_charge = self:GetAbilitySpecialValueFor("kill_charge")
	self.max_charge = self:GetAbilitySpecialValueFor("max_charge")
	self.death_lose_charge = self:GetAbilitySpecialValueFor("death_lose_charge")
	self.initial_charge = self:GetAbilitySpecialValueFor("initial_charge")
	self.bonus_hp = self:GetAbilitySpecialValueFor("bonus_hp")
	self.bonus_spell_lifesteal = self:GetAbilitySpecialValueFor("bonus_spell_lifesteal")
	self.spell_lifesteal_charge = self:GetAbilitySpecialValueFor("spell_lifesteal_charge")
	self.spell_amp_charge = self:GetAbilitySpecialValueFor("spell_amp_charge")
	self.lifesteal_multiplier = self:GetAbilitySpecialValueFor("lifesteal_multiplier")
	if IsServer() then
	end
end
function modifier_item_arcane_walker:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_arcane_walker:RemoveOnDeath()
	return false
end
function modifier_item_arcane_walker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end
function modifier_item_arcane_walker:GetModifierMoveSpeedBonus_Special_Boots(params)
	return self.bonus_movement
end
function modifier_item_arcane_walker:GetModifierManaBonus(params)
	return self.bonus_mana
end
function modifier_item_arcane_walker:GetModifierHealthBonus(params)
	return self.bonus_hp
end
function modifier_item_arcane_walker:GetModifierConstantManaRegen(params)
	return self.bonus_mana_regen
end
function modifier_item_arcane_walker:GetModifierBonusStats_Intellect(params)
	return self.bonus_int
end
function modifier_item_arcane_walker:GetModifierBonusStats_Strength(params)
	return self.bonus_str
end
function modifier_item_arcane_walker:GetModifierBonusStats_Agility(params)
	return self.bonus_agi
end
function modifier_item_arcane_walker:GetModifierExtraManaPercentage(params)
	return self.bonus_mana_pct
end
function modifier_item_arcane_walker:GetModifierCastRangeBonusStacking(params)
	local hParent = self:GetParent()
	if not hParent:HasModifier("modifier_item_aether_lens") then
		return self.cast_range_bonus
	end
end
function modifier_item_arcane_walker:GetModifierTotalDamageOutgoing_Percentage(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()
	local hInflictor = params.inflictor
	local iDamageType = params.damage_type

	if IsValid(hParent) and IsValid(hTarget) and IsValid(hInflictor) and IsValid(hAbility) and not hParent:IsIllusion() and hInflictor ~= hAbility and hTarget:IsAlive() and iDamageType == DAMAGE_TYPE_MAGICAL and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() then
		hTarget:AddNewModifier(hParent, hAbility, "modifier_item_arcane_walker_magical_armor_pen", { duration = 1 })
	end
end
function modifier_item_arcane_walker:OnDeath(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	local hUnit = params.unit
	local hAbility = self:GetAbility()

	if IsValid(hAbility) and IsValid(hParent) and IsValid(hUnit) and hParent:IsRealHero() and hUnit:IsRealHero() and hAttacker:GetTeamNumber() ~= hUnit:GetTeamNumber() then
		if hParent == hAttacker and hParent ~= hUnit and hAbility:GetCurrentCharges() < self.max_charge then
			hAbility:SetCurrentCharges(math.min(self.max_charge, hAbility:GetCurrentCharges() + self.kill_charge))
			if hParent.arcane_walker_charge == nil then
				hParent.arcane_walker_charge = 0
			end
			hParent.arcane_walker_charge = hAbility:GetCurrentCharges()
		elseif hParent ~= hAttacker and hParent == hUnit then
			hAbility:SetCurrentCharges(math.max(0, hAbility:GetCurrentCharges() - self.death_lose_charge))
			if hParent.arcane_walker_charge == nil then
				hParent.arcane_walker_charge = 0
			end
			hParent.arcane_walker_charge = hAbility:GetCurrentCharges()
		end
	end
end
function modifier_item_arcane_walker:OnTakeDamage(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	local hTarget = params.unit
	local hAbility = self:GetAbility()
	local fDamage = params.damage or 0
	local hInflictor = params.inflictor

	if IsServer() then
		if IsValid(hAbility) and IsValid(hInflictor) and self.bonus_spell_lifesteal > 0 and fDamage > 0 and IsValid(hParent) and IsValid(hTarget) and hParent == hAttacker and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() then
			local sAbilityName = hInflictor:GetAbilityName()
			local fSpellLifestealPct = self.bonus_spell_lifesteal
			if PERCENTAGE_ABILITIES and PERCENTAGE_ABILITIES[sAbilityName] or (sAbilityName == "enigma_black_hole" and hParent:HasScepter()) or (sAbilityName == "witch_doctor_voodoo_restoration" and hParent:HasTalent("special_bonus_unique_witch_doctor_2")) then
			else
				fSpellLifestealPct = fSpellLifestealPct + self.spell_lifesteal_charge * hAbility:GetCurrentCharges()
			end
			if hParent:HasModifier("modifier_item_blood_boots") then
				fSpellLifestealPct = fSpellLifestealPct * self.lifesteal_multiplier
			end
			local flAmount = math.max(1, fDamage * fSpellLifestealPct * 0.01)
			hParent:HealWithParams(flAmount, hAbility, false, true, hParent, true)
			if hParent:HasModifier("modifier_item_blood_boots") then
				hParent:GiveMana(flAmount)
			end
			local iParticleID = ParticleManager:CreateParticle("particles/items3_fx/octarine_core_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
			ParticleManager:ReleaseParticleIndex(iParticleID)
		end
	end
end
function modifier_item_arcane_walker:GetModifierSpellAmplify_Percentage(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	local hTarget = params.unit
	local hAbility = self:GetAbility()
	local hInflictor = params.inflictor

	if IsServer() then
		if IsValid(hAbility) and IsValid(hInflictor) and self.spell_amp_charge > 0 and IsValid(hParent) and IsValid(hTarget) and hTarget:IsRealHero() and hParent == hAttacker and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() then
			local sAbilityName = hInflictor:GetAbilityName()
			if PERCENTAGE_ABILITIES and PERCENTAGE_ABILITIES[sAbilityName] or (sAbilityName == "enigma_black_hole" and hParent:HasScepter()) or (sAbilityName == "witch_doctor_voodoo_restoration" and hParent:HasTalent("special_bonus_unique_witch_doctor_2")) then
				return 0
			else
				return self.spell_amp_charge * hAbility:GetCurrentCharges()
			end
		end
	end
	return self.spell_amp_charge * hAbility:GetCurrentCharges()
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_arcane_walker_magical_armor_pen == nil then
	modifier_item_arcane_walker_magical_armor_pen = class({})
end
function modifier_item_arcane_walker_magical_armor_pen:IsHidden()
	return false
end
function modifier_item_arcane_walker_magical_armor_pen:IsDebuff()
	return true
end
function modifier_item_arcane_walker_magical_armor_pen:IsPurgable()
	return false
end
function modifier_item_arcane_walker_magical_armor_pen:IsPurgeException()
	return false
end
function modifier_item_arcane_walker_magical_armor_pen:OnCreated(params)
	self.magical_armor_pen = self:GetAbilitySpecialValueFor("magical_armor_pen")
	self.magical_armor_pen_pct_charge = self:GetAbilitySpecialValueFor("magical_armor_pen_pct_charge")
	if IsServer() then
		self.magical_armor_reduce = 0
		local hParent = self:GetParent()
		local hCaster = self:GetCaster()
		local hAbility = self:GetAbility()

		self:SetHasCustomTransmitterData(true)

		if IsValid(hCaster) and IsValid(hAbility) then
			local fMagicalArmorReduction = hParent:Script_GetMagicalArmorValue(false, hAbility)
			local fMagicalArmor = fMagicalArmorReduction * 100
			local fPenPct = hAbility:GetCurrentCharges() * self.magical_armor_pen_pct_charge
			local magical_armor_final = 0
			if fMagicalArmor > 0 then
				magical_armor_final = math.max(0, fMagicalArmor - self.magical_armor_pen)
				if magical_armor_final > 0 then
					magical_armor_final = math.max(0, magical_armor_final - magical_armor_final * fPenPct * 0.01)
				end
			end
			-- self.magical_armor_reduce = math.ceil(self.magical_armor_pen * hParent:Script_GetMagicalArmorValue(false, hAbility) * 100 / (100 - hParent:Script_GetMagicalArmorValue(false, hAbility) * 100))
			-- 所有其他魔法抗性计算结果=1-fMagicalArmorReduction
			-- 所有其他魔法抗性计算结果*(1-x)=(1-fMagicalArmorReduction)*(1-x)
			-- 新的魔法抗性 = 1-(1-fMagicalArmorReduction)*(1-x)
			-- 100-72*(1-x) = 10
			-- 90 = 72(1-x)
			-- 1.25 = 1-x
			-- x = 0.25
			self.magical_armor_final = magical_armor_final
			self:SendBuffRefreshToClients()
		end

		self:StartIntervalThink(FrameTime())
		self:OnIntervalThink()
	end
end
function modifier_item_arcane_walker_magical_armor_pen:OnRefresh(params)
	self.magical_armor_pen = self:GetAbilitySpecialValueFor("magical_armor_pen")
	self.magical_armor_pen_pct_charge = self:GetAbilitySpecialValueFor("magical_armor_pen_pct_charge")
	if IsServer() then
	end
end
function modifier_item_arcane_walker_magical_armor_pen:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_arcane_walker_magical_armor_pen:OnIntervalThink()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	self.magical_armor_reduce_base = -hParent:GetBaseMagicalResistanceValue()
	local fMagicalArmorReduction = hParent:Script_GetMagicalArmorValue(false, hAbility)
	local fMagicalArmor = fMagicalArmorReduction * 100

	self.magical_armor_reduce = -(fMagicalArmor - self.magical_armor_final) / (1 - fMagicalArmorReduction)

	if IsInToolsMode() then
		self:SendBuffRefreshToClients()
		self:StartIntervalThink(-1)
	end
end
function modifier_item_arcane_walker_magical_armor_pen:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function modifier_item_arcane_walker_magical_armor_pen:AddCustomTransmitterData()
	local t = {}
	if IsInToolsMode() then
		-- t.magical_armor_reduce = self.magical_armor_reduce
		-- t.magical_armor_reduce_base = self.magical_armor_reduce_base	
	end
	t.magical_armor_final = self.magical_armor_final
	return t
end
function modifier_item_arcane_walker_magical_armor_pen:HandleCustomTransmitterData(t)
	if IsInToolsMode() then
		-- self.magical_armor_reduce = t.magical_armor_reduce
		-- self.magical_armor_reduce_base = t.magical_armor_reduce_base
	end
	self.magical_armor_final = t.magical_armor_final
end
function modifier_item_arcane_walker_magical_armor_pen:GetModifierMagicalResistanceBonus(params)
	local hInflictor = params.inflictor
	local hCaster = self:GetCaster()
	local hAbility = self:GetAbility()
	if IsServer() then
		if IsValid(hInflictor) and IsValid(hAbility) and hAbility ~= hInflictor and hInflictor:GetCaster() == hCaster then
			local sAbilityName = hInflictor:GetAbilityName()
			if PERCENTAGE_ABILITIES and PERCENTAGE_ABILITIES[sAbilityName] or (sAbilityName == "enigma_black_hole" and hCaster:HasScepter()) or (sAbilityName == "witch_doctor_voodoo_restoration" and hCaster:HasTalent("special_bonus_unique_witch_doctor_2")) then
				return 0
			else
				return self.magical_armor_reduce
			end
		end
	end
	return self.magical_armor_reduce or 0
end
function modifier_item_arcane_walker_magical_armor_pen:GetModifierMagicalResistanceDirectModification(params)
	return self.magical_armor_reduce_base or 0
end
function modifier_item_arcane_walker_magical_armor_pen:OnTooltip()
	return self.magical_armor_final or 0
end
function modifier_item_arcane_walker_magical_armor_pen:GetTexture()
	local hCaster = self:GetCaster()
	return hCaster:GetUnitName()
end