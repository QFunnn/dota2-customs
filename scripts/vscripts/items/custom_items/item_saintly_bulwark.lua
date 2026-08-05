--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_saintly_bulwark", "items/custom_items/item_saintly_bulwark", LUA_MODIFIER_MOTION_NONE)

item_saintly_bulwark_1 = item_saintly_bulwark_1 or class({})
item_saintly_bulwark_2 = item_saintly_bulwark_1 or class({})
item_saintly_bulwark_3 = item_saintly_bulwark_1 or class({})

function item_saintly_bulwark_1:Precache(context)
	PrecacheResource("particle", "particles/items2_fx/vanguard_active.vpcf", context)
	PrecacheResource("particle", "particles/items3_fx/warmage.vpcf", context)
	PrecacheResource("soundfile", "sounds/items/guardian_greaves.vsnd", context)
end

function item_saintly_bulwark_1:GetIntrinsicModifierName()
	return "modifier_item_saintly_bulwark"
end

function item_saintly_bulwark_1:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("heal_radius")
	local heal_per_charge = self:GetSpecialValueFor("heal_per_charge")
	local mana_per_charge = self:GetSpecialValueFor("mana_per_charge")
	local charges = self:GetCurrentCharges()

	if charges <= 0 then
		return
	end

	local heal_amount = charges * heal_per_charge
	local mana_amount = charges * mana_per_charge

	caster:EmitSound("Item.GuardianGreaves.Activate")
	local cast_pfx =
		ParticleManager:CreateParticle("particles/items3_fx/warmage.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(cast_pfx)

	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, ally in pairs(allies) do
		ally:Heal(heal_amount, caster)
		ally:GiveMana(mana_amount)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, ally, heal_amount, nil)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, ally, mana_amount, nil)
		ally:EmitSound("Item.GuardianGreaves.Target")
	end

	self:SetCurrentCharges(0)
end

---------------------------------------------------------------------------------------------------

modifier_item_saintly_bulwark = class({})

function modifier_item_saintly_bulwark:IsHidden()
	return true
end
function modifier_item_saintly_bulwark:IsPurgable()
	return false
end
function modifier_item_saintly_bulwark:RemoveOnDeath()
	return false
end
function modifier_item_saintly_bulwark:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_saintly_bulwark:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.block_chance = ability:GetSpecialValueFor("block_chance")
	self.max_charges = ability:GetSpecialValueFor("max_charges")
	self.bonus_all_stats = ability:GetSpecialValueFor("bonus_all_stats")
	self.bonus_health = ability:GetSpecialValueFor("bonus_health")
	self.bonus_health_regen = ability:GetSpecialValueFor("bonus_health_regen")

	if self:GetParent():IsRangedAttacker() then
		self.block_damage = ability:GetSpecialValueFor("block_damage_ranged")
	else
		self.block_damage = ability:GetSpecialValueFor("block_damage_melee")
	end
end

function modifier_item_saintly_bulwark:OnRefresh()
	self:OnCreated()
end

function modifier_item_saintly_bulwark:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_saintly_bulwark:GetModifierBonusStats_Strength()
	return self.bonus_all_stats or 0
end
function modifier_item_saintly_bulwark:GetModifierBonusStats_Agility()
	return self.bonus_all_stats or 0
end
function modifier_item_saintly_bulwark:GetModifierBonusStats_Intellect()
	return self.bonus_all_stats or 0
end
function modifier_item_saintly_bulwark:GetModifierHealthBonus()
	return self.bonus_health or 0
end
function modifier_item_saintly_bulwark:GetModifierConstantHealthRegen()
	return self.bonus_health_regen or 0
end

function modifier_item_saintly_bulwark:GetModifierPhysical_ConstantBlock(keys)
	if not IsServer() then
		return 0
	end
	if not keys or keys.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
		return 0
	end
	if self.block_damage <= 0 then
		return 0
	end

	if self.block_chance >= 100 or RandomInt(1, 100) <= self.block_chance then
		local ability = self:GetAbility()
		if ability then
			local current = ability:GetCurrentCharges()
			ability:SetCurrentCharges(math.min(current + 1, self.max_charges))
		end

		-- local pfx = ParticleManager:CreateParticle("particles/items2_fx/vanguard_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		-- ParticleManager:ReleaseParticleIndex(pfx)

		return self.block_damage
	end

	return 0
end