--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_bloodstone_2", "item_ability/item_bloodstone_2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_modifier_item_bloodstone_2_active",
	"item_ability/item_bloodstone_2",
	LUA_MODIFIER_MOTION_NONE
)

require("utils/bit")

local INTRINSIC_MODIFIER = "modifier_item_bloodstone_2"
local ACTIVE_MODIFIER = "modifier_modifier_item_bloodstone_2_active"
local VANILLA_BLOODSTONE_MODIFIER = "modifier_item_bloodstone"

item_bloodstone_2 = class({}) ---@class CDOTA_Item_Lua
modifier_item_bloodstone_2 = class({}) ---@class CDOTA_Modifier_Lua
modifier_modifier_item_bloodstone_2_active = class({}) ---@class CDOTA_Modifier_Lua

local function HasDamageFlag(flags, flag)
	return bit:_and(flags or 0, flag) == flag
end

local function GetReductionFromArmor(armor)
	return (0.06 * armor) / (1 + 0.06 * math.abs(armor))
end

local function GetEffectiveDamageAgainstIllusion(params)
	local target = params.unit

	if not target:IsIllusion() then
		return params.damage
	end

	if params.damage_type == DAMAGE_TYPE_PHYSICAL and target.GetPhysicalArmorValue then
		return params.original_damage * (1 - GetReductionFromArmor(target:GetPhysicalArmorValue(false)))
	end

	if params.damage_type == DAMAGE_TYPE_MAGICAL and target.GetMagicalArmorValue then
		return params.original_damage * (1 - GetReductionFromArmor(target:GetMagicalArmorValue()))
	end

	if params.damage_type == DAMAGE_TYPE_PURE then
		return params.original_damage
	end

	return params.damage
end

local function UpdateSecondaryCharges(parent, modifierName, ignoredModifier)
	if not IsServer() or not IsValid(parent) then
		return
	end

	local chargeIndex = 1

	for _, modifier in ipairs(parent:FindAllModifiersByName(modifierName)) do
		if modifier ~= ignoredModifier then
			local ability = modifier:GetAbility()

			if IsValid(ability) then
				ability:SetSecondaryCharges(chargeIndex)
				chargeIndex = chargeIndex + 1
			end
		end
	end
end

local function IsMainBloodstoneModifier(modifier)
	local parent = modifier:GetParent()
	local modifiers = parent:FindAllModifiersByName(modifier:GetName())

	return modifiers[1] == modifier
end

local function FindBloodstoneItem(parent, itemName)
	for itemSlot = 0, 5 do
		local item = parent:GetItemInSlot(itemSlot)

		if IsValid(item) and item:GetName() == itemName then
			return item
		end
	end
end

function item_bloodstone_2:GetIntrinsicModifierName()
	return INTRINSIC_MODIFIER
end

function item_bloodstone_2:GetManaCost()
	if self == nil or self.IsNull == nil or self:IsNull() or self.GetCaster == nil then
		return 0
	end

	local caster = self:GetCaster()

	if not IsValid(caster) then
		return 0
	end

	return caster:GetMaxMana() * self:GetSpecialValueFor("mana_cost_percentage") * 0.01
end

function item_bloodstone_2:OnSpellStart()
	local caster = self:GetCaster()

	if not IsServer() or not caster then
		return
	end

	local restoreDuration = self:GetSpecialValueFor("restore_duration")

	caster:EmitSound("DOTA_Item.Bloodstone.Cast")
	caster:AddNewModifier(caster, self, ACTIVE_MODIFIER, { duration = restoreDuration })
end

function modifier_modifier_item_bloodstone_2_active:OnCreated()
	local ability = self:GetAbility()

	if not ability then
		if IsServer() then
			self:Destroy()
		end

		return
	end

	self.parent = self:GetParent()
	self.restore_duration = ability:GetSpecialValueFor("restore_duration")
	self.mana_cost = ability:GetManaCost(1)

	if not IsServer() then
		return
	end

	local particle =
		ParticleManager:CreateParticle("particles/items_fx/bloodstone_heal.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(
		particle,
		2,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(particle, false, false, -1, false, false)

	self.parent:Purge(false, true, false, false, false)
end

function modifier_modifier_item_bloodstone_2_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_modifier_item_bloodstone_2_active:GetModifierConstantHealthRegen()
	if self.restore_duration == nil or self.restore_duration <= 0 then
		return 0
	end

	return self.mana_cost / self.restore_duration
end

function modifier_modifier_item_bloodstone_2_active:OnTooltip()
	return self.mana_cost
end

function modifier_item_bloodstone_2:IsHidden()
	return true
end
function modifier_item_bloodstone_2:IsPurgable()
	return false
end
function modifier_item_bloodstone_2:RemoveOnDeath()
	return false
end
function modifier_item_bloodstone_2:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_bloodstone_2:OnCreated()
	local ability = self:GetAbility()

	if not IsValid(ability) then
		if IsServer() then
			self:Destroy()
		end

		return
	end

	self.parent = self:GetParent()
	self:ReadSpecialValues(ability)

	if not IsServer() then
		return
	end

	if not ability.initialized then
		ability:SetCurrentCharges(self.initial_charges_tooltip)
		ability.initialized = true
	end

	self:SetStackCount(ability:GetCurrentCharges())
	self.parent:AddNewModifier(self.parent, ability, VANILLA_BLOODSTONE_MODIFIER, {})
	UpdateSecondaryCharges(self.parent, self:GetName())
end

function modifier_item_bloodstone_2:OnRefresh()
	local ability = self:GetAbility()

	if IsValid(ability) then
		self.parent = self:GetParent()
		self:ReadSpecialValues(ability)
	end
end

function modifier_item_bloodstone_2:ReadSpecialValues(ability)
	self.bonus_intellect = ability:GetSpecialValueFor("bonus_intellect")
	self.mana_regen_multiplier = ability:GetSpecialValueFor("mana_regen_multiplier")
	self.spell_amp = ability:GetSpecialValueFor("spell_amp")
	self.regen_per_charge = ability:GetSpecialValueFor("regen_per_charge")
	self.amp_per_charge = ability:GetSpecialValueFor("amp_per_charge")
	self.death_charges = ability:GetSpecialValueFor("death_charges")
	self.kill_charges = ability:GetSpecialValueFor("kill_charges")
	self.charge_range = ability:GetSpecialValueFor("charge_range")
	self.initial_charges_tooltip = ability:GetSpecialValueFor("initial_charges_tooltip")
	self.spell_lifesteal = ability:GetSpecialValueFor("spell_lifesteal")
	self.lifesteal_multiplier = ability:GetSpecialValueFor("lifesteal_multiplier")
end

function modifier_item_bloodstone_2:OnDestroy()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()

	if IsValid(parent) then
		parent:RemoveModifierByName(VANILLA_BLOODSTONE_MODIFIER)
		UpdateSecondaryCharges(parent, self:GetName(), self)
	end
end

function modifier_item_bloodstone_2:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_item_bloodstone_2:GetModifierTotalPercentageManaRegen()
	return self.mana_regen_multiplier / 100
end

function modifier_item_bloodstone_2:GetModifierSpellAmplify_PercentageUnique()
	return self.spell_amp
end

function modifier_item_bloodstone_2:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end

function modifier_item_bloodstone_2:GetModifierConstantManaRegen()
	return self.regen_per_charge * self:GetStackCount()
end

function modifier_item_bloodstone_2:GetModifierSpellAmplify_Percentage()
	return self.amp_per_charge * self:GetStackCount()
end

function modifier_item_bloodstone_2:OnDeath(params)
	local ability = self:GetAbility()
	local killedUnit = params.unit

	if not IsValid(ability) then
		return
	end
	if not IsValid(killedUnit) or not IsValid(self.parent) then
		return
	end
	if not killedUnit:IsRealHero() or not self.parent:IsRealHero() then
		return
	end
	if killedUnit:IsTempestDouble() or self.parent:IsTempestDouble() then
		return
	end

	if self.parent == killedUnit then
		self:LoseChargesOnDeath(killedUnit, ability)
	elseif self:ShouldGainCharges(killedUnit, params.attacker) then
		self:GainChargesFromKill(ability)
	end

	self:SetStackCount(ability:GetCurrentCharges())
end

function modifier_item_bloodstone_2:ShouldGainCharges(killedUnit, attacker)
	if not self.parent:IsAlive() then
		return false
	end
	if self.parent:GetTeamNumber() == killedUnit:GetTeamNumber() then
		return false
	end

	local inRange = (killedUnit:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.charge_range

	return inRange or self.parent == attacker
end

function modifier_item_bloodstone_2:GainChargesFromKill(ability)
	if not IsMainBloodstoneModifier(self) then
		return
	end

	local item = FindBloodstoneItem(self.parent, ability:GetName())

	if IsValid(item) then
		item:SetCurrentCharges(item:GetCurrentCharges() + self.kill_charges)
	end
end

function modifier_item_bloodstone_2:LoseChargesOnDeath(killedUnit, ability)
	local isReincarnating = killedUnit.IsReincarnating and killedUnit:IsReincarnating()

	if isReincarnating then
		return
	end

	ability:SetCurrentCharges(math.max(ability:GetCurrentCharges() - self.death_charges, 0))
end

function modifier_item_bloodstone_2:OnTakeDamage(params)
	if not self:ShouldLifesteal(params) then
		return
	end

	local damage = math.max(GetEffectiveDamageAgainstIllusion(params), 0)
	local lifesteal = self.spell_lifesteal

	if self.parent:HasModifier(ACTIVE_MODIFIER) then
		lifesteal = lifesteal * self.lifesteal_multiplier
	end

	self:PlayLifestealParticle()
	self.parent:Heal(damage * lifesteal * 0.01, self.parent)
end

function modifier_item_bloodstone_2:ShouldLifesteal(params)
	if params.attacker ~= self.parent then
		return false
	end
	if not IsValid(params.unit) or params.unit:IsBuilding() or params.unit:IsOther() then
		return false
	end
	if self.parent:IsIllusion() or not IsMainBloodstoneModifier(self) then
		return false
	end
	if params.damage_category ~= DOTA_DAMAGE_CATEGORY_SPELL or not IsValid(params.inflictor) then
		return false
	end

	return not HasDamageFlag(params.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL)
end

function modifier_item_bloodstone_2:PlayLifestealParticle()
	local particle = ParticleManager:CreateParticle(
		"particles/items3_fx/octarine_core_lifesteal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
end