--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_stargazing_staff", "item_ability/item_stargazing_staff.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_stargazing_staff_cd", "item_ability/item_stargazing_staff.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_stargazing_staff_debuff", "item_ability/item_stargazing_staff.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_stargazing_staff_buff", "item_ability/item_stargazing_staff.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_stargazing_staff == nil then
	item_stargazing_staff = class({})
end
function item_stargazing_staff:GetIntrinsicModifierName()
	return "modifier_item_stargazing_staff"
end
function item_stargazing_staff:GetAOERadius()
	return self:GetSpecialValueFor("debuff_radius")
end
function item_stargazing_staff:OnSpellStart()
	local hCaster = self:GetCaster()
	local vPos = self:GetCursorPosition()
	local debuff_radius = self:GetSpecialValueFor("debuff_radius")
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")

	if IsValid(hCaster) then
		local particleID = ParticleManager:CreateParticle("particles/items2_fx/veil_of_discord.vpcf", PATTACH_WORLDORIGIN, hCaster)
		ParticleManager:SetParticleControl(particleID, 0, vPos)
		ParticleManager:SetParticleControl(particleID, 1, Vector(debuff_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particleID)

		local units = FindUnitsInRadius(hCaster:GetTeamNumber(), vPos, nil, debuff_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				unit:AddNewModifier(hCaster, self, "modifier_item_stargazing_staff_debuff", { duration = debuff_duration * unit:GetStatusResistanceFactor(hCaster) })
			end
		end
		EmitSoundOnLocationWithCaster(vPos, "DOTA_Item.VeilofDiscord.Activate", hCaster)
	end

end
---------------------------------------------------------------------
--Modifiers
if modifier_item_stargazing_staff == nil then
	modifier_item_stargazing_staff = class({})
end
function modifier_item_stargazing_staff:IsHidden()
	return true
end
function modifier_item_stargazing_staff:IsDebuff()
	return false
end
function modifier_item_stargazing_staff:IsPurgable()
	return false
end
function modifier_item_stargazing_staff:IsPurgeException()
	return false
end
function modifier_item_stargazing_staff:OnCreated(params)
	self.manacost_reduction = self:GetAbilitySpecialValueFor("manacost_reduction")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.magic_crit_pct = self:GetAbilitySpecialValueFor("magic_crit_pct")
	self.magic_crit_damage = self:GetAbilitySpecialValueFor("magic_crit_damage")
	self.buff_duration = self:GetAbilitySpecialValueFor("buff_duration")
	self.all_stats = self:GetAbilitySpecialValueFor("all_stats")
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.crit_cd = self:GetAbilitySpecialValueFor("crit_cd")
	self.bonus_magic_cirt_pct = self:GetAbilitySpecialValueFor("bonus_magic_cirt_pct")
	if IsServer() then
		local name = self:GetName()
		local hParent = self:GetParent()
		local buffs = hParent:FindAllModifiersByName(name)
		if self == buffs[1] then
			AddCustomModifierEvent(self, "MODIFIER_EVENT_ON_MAGICAL_CRIT")
			AddCustomModifierProps(self, "MODIFIER_PROPERTY_MAGICAL_CRIT_DAMAGE")
		end
	end
end
function modifier_item_stargazing_staff:OnRefresh(params)
	self.manacost_reduction = self:GetAbilitySpecialValueFor("manacost_reduction")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.magic_crit_pct = self:GetAbilitySpecialValueFor("magic_crit_pct")
	self.magic_crit_damage = self:GetAbilitySpecialValueFor("magic_crit_damage")
	self.buff_duration = self:GetAbilitySpecialValueFor("buff_duration")
	self.all_stats = self:GetAbilitySpecialValueFor("all_stats")
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.crit_cd = self:GetAbilitySpecialValueFor("crit_cd")
	self.bonus_magic_cirt_pct = self:GetAbilitySpecialValueFor("bonus_magic_cirt_pct")
	if IsServer() then
	end
end
function modifier_item_stargazing_staff:OnDestroy()
	if IsServer() then
		RemoveCustomModifierEvent(self, "MODIFIER_EVENT_ON_MAGICAL_CRIT")
		RemoveCustomModifierProps(self, "MODIFIER_PROPERTY_MAGICAL_CRIT_DAMAGE")

		local name = self:GetName()
		local hParent = self:GetParent()
		local buffs = hParent:FindAllModifiersByName(name)
		if buffs[1] then
			AddCustomModifierEvent(buffs[1], "MODIFIER_EVENT_ON_MAGICAL_CRIT")
			AddCustomModifierProps(buffs[1], "MODIFIER_PROPERTY_MAGICAL_CRIT_DAMAGE")
		end
	end
end
function modifier_item_stargazing_staff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end
function modifier_item_stargazing_staff:GetModifierBonusStats_Strength()
	return self.all_stats + self.bonus_str
end
function modifier_item_stargazing_staff:GetModifierBonusStats_Agility()
	return self.all_stats + self.bonus_agi
end
function modifier_item_stargazing_staff:GetModifierBonusStats_Intellect()
	return self.all_stats + self.bonus_int
end
function modifier_item_stargazing_staff:GetModifierConstantManaRegen()
	return self.mana_regen
end
function modifier_item_stargazing_staff:GetModifierPercentageManacostStacking()
	return self.manacost_reduction
end
function modifier_item_stargazing_staff:GetModifierMagicalCritDamage(params)
	if IsValid(self) then
		local name = self:GetName()
		local hParent = self:GetParent()
		local hAttacker = params.attacker
		local hTarget = params.target
		local buffs = hParent:FindAllModifiersByName(name)
		local hAbility = self:GetAbility()

		if self == buffs[1] then
			if IsValid(hParent) and IsValid(hAttacker) and IsValid(hTarget) and hAttacker == hParent and (not hParent:HasModifier("modifier_item_stargazing_staff_cd")) then
				local chance = self.magic_crit_pct
				if hTarget:HasModifier("modifier_item_stargazing_staff_debuff") then
					chance = chance + self.bonus_magic_cirt_pct
				end
				if RandomFloat(0, 100) <= chance then
					return self.magic_crit_damage
				end
			end
		end
	end

	return 0
end
function modifier_item_stargazing_staff:OnMagicalCrit(params)
	local name = self:GetName()
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	local hTarget = params.target
	local buffs = hParent:FindAllModifiersByName(name)
	local hAbility = self:GetAbility()

	if self == buffs[1] then
		if IsValid(hParent) and IsValid(hAttacker) and IsValid(hTarget) and hAttacker == hParent then
			--进入内置冷却
			if hAbility and params.crit_buff == self then
				if not (hTarget:HasModifier("modifier_item_stargazing_staff_debuff") and hTarget:IsNeutralUnitType()) then
					hParent:AddNewModifier(hParent, hAbility, "modifier_item_stargazing_staff_cd", { duration = self.crit_cd * hParent:GetCooldownReduction() })
				end
			end
			hParent:AddNewModifier(hParent, hAbility, "modifier_item_stargazing_staff_buff", { duration = self.buff_duration })
		end
	end
	return 0
end
function modifier_item_stargazing_staff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_stargazing_staff_cd == nil then
	modifier_item_stargazing_staff_cd = class({})
end
function modifier_item_stargazing_staff_cd:IsHidden()
	return false
end
function modifier_item_stargazing_staff_cd:IsDebuff()
	return true
end
function modifier_item_stargazing_staff_cd:IsPurgable()
	return false
end
function modifier_item_stargazing_staff_cd:IsPurgeException()
	return false
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_stargazing_staff_debuff == nil then
	modifier_item_stargazing_staff_debuff = class({})
end
function modifier_item_stargazing_staff_debuff:IsHidden()
	return false
end
function modifier_item_stargazing_staff_debuff:IsDebuff()
	return true
end
function modifier_item_stargazing_staff_debuff:IsPurgable()
	return true
end
function modifier_item_stargazing_staff_debuff:IsPurgeException()
	return true
end
function modifier_item_stargazing_staff_debuff:OnCreated(params)
	self.bonus_magical_dmg = self:GetAbilitySpecialValueFor("bonus_magical_dmg")
	if IsServer() then
	end
end
function modifier_item_stargazing_staff_debuff:OnRefresh(params)
	self.bonus_magical_dmg = self:GetAbilitySpecialValueFor("bonus_magical_dmg")
	if IsServer() then
	end
end
function modifier_item_stargazing_staff_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function modifier_item_stargazing_staff_debuff:GetModifierIncomingDamage_Percentage(params)
	local hParent = self:GetParent()
	if params.damage_type == DAMAGE_TYPE_MAGICAL and not hParent:HasModifier("modifier_item_veil_of_discord_debuff") then
		return self.bonus_magical_dmg
	end
end
function modifier_item_stargazing_staff_debuff:OnTooltip()
	return self.bonus_magical_dmg
end
function modifier_item_stargazing_staff_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_stargazing_staff_debuff:GetEffectName()
	return "particles/items2_fx/veil_of_discord_debuff.vpcf"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_stargazing_staff_buff == nil then
	modifier_item_stargazing_staff_buff = class({})
end
function modifier_item_stargazing_staff_buff:IsHidden()
	return false
end
function modifier_item_stargazing_staff_buff:IsDebuff()
	return false
end
function modifier_item_stargazing_staff_buff:IsPurgable()
	return false
end
function modifier_item_stargazing_staff_buff:IsPurgeException()
	return false
end
function modifier_item_stargazing_staff_buff:OnCreated(params)
	self.creep_damage_reduce = self:GetAbilitySpecialValueFor("creep_damage_reduce")
	if IsServer() then
	end
end
function modifier_item_stargazing_staff_buff:OnRefresh(params)
	self.creep_damage_reduce = self:GetAbilitySpecialValueFor("creep_damage_reduce")
	if IsServer() then
	end
end
function modifier_item_stargazing_staff_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function modifier_item_stargazing_staff_buff:GetModifierIncomingDamage_Percentage(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	if IsServer() then
		if IsValid(hParent) and IsValid(hAttacker) and hAttacker:IsNeutralUnitType() then
			return -self.creep_damage_reduce
		end
	else
		return -self.creep_damage_reduce
	end
end