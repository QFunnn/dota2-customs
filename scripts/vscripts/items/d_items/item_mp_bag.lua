--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_mp_bag = class({})

function item_mp_bag:GetIntrinsicModifierName()
	return "modifier_item_mp_bag"
end

function item_mp_bag:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_mp_bag:GetTexture()
	return "mp_bag"
end

function item_mp_bag:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_mp_bag:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	if not self:GetCaster():IsHero() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

-------------------------------------------------------------------------------------------------------------------

function item_mp_bag:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local self_damage = self:GetSpecialValueFor("less_heal")
	local duration = self:GetSpecialValueFor("duration")
	EmitSoundOn("DOTA_Item.UrnOfShadows.Activate", self:GetCaster())
	target:AddNewModifier(caster, self, "modifier_item_mp_bag_buff", { duration = duration })
	local maxhp = caster:GetMaxHealth()

	damagehp = maxhp / 100 * self_damage

	local damageType = DAMAGE_TYPE_PURE
	ApplyDamage({
		victim = caster,
		attacker = caster,
		damage = damagehp,
		damage_type = damageType,
		damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
	})
end

-------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_item_mp_bag", "items/d_items/item_mp_bag.lua", LUA_MODIFIER_MOTION_NONE)

modifier_item_mp_bag = class({})

function modifier_item_mp_bag:IsHidden()
	return true
end

function modifier_item_mp_bag:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_mp_bag:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
end

function modifier_item_mp_bag:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_item_mp_bag:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("hp_regen")
end

function modifier_item_mp_bag:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_mp_bag:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_mp_bag:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_item_mp_bag_buff", "items/d_items/item_mp_bag.lua", LUA_MODIFIER_MOTION_NONE)

modifier_item_mp_bag_buff = class({})

function modifier_item_mp_bag_buff:GetEffectName()
	return "particles/items2_fx/urn_of_shadows_damage_ground_anchors.vpcf"
end

function modifier_item_mp_bag_buff:GetTexture()
	return "mp_bag"
end

if IsServer() then
	function modifier_item_mp_bag_buff:OnCreated()
		local ability = self:GetAbility()

		if not ability then
			self:Destroy()
			return
		end

		self.base_heal = ability:GetSpecialValueFor("base_heal")
		self.heal_pct = ability:GetSpecialValueFor("heal_pct") * 0.01

		local think_interval = ability:GetSpecialValueFor("heal_interval")
		self:StartIntervalThink(think_interval)
	end

	function modifier_item_mp_bag_buff:OnIntervalThink()
		local ability = self:GetAbility()
		local parent = self:GetParent()

		if ability and parent then
			local heal_amount = self.base_heal + (parent:GetMaxMana() * self.heal_pct)
			parent:GiveMana(heal_amount)
		end
	end
end