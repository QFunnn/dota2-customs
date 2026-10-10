--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_armlet_custom", "abilities/items/item_armlet_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_item_armlet_custom_unholy_strength",
	"abilities/items/item_armlet_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_armlet_custom = class({})

function item_armlet_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items_fx/armlet.vpcf", context)
end

function item_armlet_custom:GetIntrinsicModifierName()
	return "modifier_item_armlet_custom"
end

function item_armlet_custom:Spawn()
	self.bonus_damage = self:GetSpecialValueFor("bonus_damage")
	self.bonus_attack_speed = self:GetSpecialValueFor("bonus_attack_speed")
	self.bonus_armor = self:GetSpecialValueFor("bonus_armor")
	self.bonus_health_regen = self:GetSpecialValueFor("bonus_health_regen")
	self.unholy_bonus_damage = self:GetSpecialValueFor("unholy_bonus_damage")
	self.unholy_bonus_strength = self:GetSpecialValueFor("unholy_bonus_strength")
	self.unholy_bonus_armor = self:GetSpecialValueFor("unholy_bonus_armor")
	self.unholy_bonus_slow_resistance = self:GetSpecialValueFor("unholy_bonus_slow_resistance")
	self.unholy_health_drain_per_second = self:GetSpecialValueFor("unholy_health_drain_per_second")
end

function item_armlet_custom:GetAbilityTextureName()
	if self:GetToggleState() then
		return "item_armlet_active"
	end

	return "item_armlet"
end

function item_armlet_custom:OnToggle()
	if self:GetToggleState() then
		local caster = self:GetCaster()
		caster:EmitSound("DOTA_Item.Armlet.Activate")
		self.unholy_mod = caster:AddNewModifier(caster, self, "modifier_item_armlet_custom_unholy_strength", {})
	elseif IsValid(self.unholy_mod) then
		self.unholy_mod:Destroy()
	end
end

modifier_item_armlet_custom = class(mod_hidden)
function modifier_item_armlet_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_armlet_custom:OnCreated()
	self.ability = self:GetAbility()

	self.damage = self.ability.bonus_damage
	self.speed = self.ability.bonus_attack_speed
	self.armor = self.ability.bonus_armor
	self.regen = self.ability.bonus_health_regen
end

function modifier_item_armlet_custom:OnDestroy()
	if not IsServer() then
		return
	end
	if not IsValid(self.ability.unholy_mod) then
		return
	end
	self.ability.unholy_mod:Destroy()
end

function modifier_item_armlet_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_armlet_custom:GetModifierPreAttack_BonusDamage()
	return self.damage
end

function modifier_item_armlet_custom:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_item_armlet_custom:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_item_armlet_custom:GetModifierConstantHealthRegen()
	return self.regen
end

modifier_item_armlet_custom_unholy_strength = class(mod_hidden)
function modifier_item_armlet_custom_unholy_strength:AllowIllusionDuplicate()
	return true
end
function modifier_item_armlet_custom_unholy_strength:GetEffectName()
	return "particles/items_fx/armlet.vpcf"
end
function modifier_item_armlet_custom_unholy_strength:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.damage = self.ability.unholy_bonus_damage
	self.armor = self.ability.unholy_bonus_armor
	self.slow_resist = self.ability.unholy_bonus_slow_resistance
	self.drain = self.ability.unholy_health_drain_per_second
	self.max = 6
	self.strength = self.ability.unholy_bonus_strength / self.max

	if not IsServer() then
		return
	end
	if self.parent:IsIllusion() then
		self:SetStackCount(self.max)
	end

	self.interval = 0.1
	self.drain_count = 0
	self:StartIntervalThink(self.interval)
	self:OnIntervalThink(true)
end

function modifier_item_armlet_custom_unholy_strength:OnIntervalThink(first)
	if not IsServer() then
		return
	end

	if not first and self:GetStackCount() < self.max then
		local health = self.parent:GetHealth()
		local max_health = self.parent:GetMaxHealth()
		self:IncrementStackCount()
		self:UpdateHealth(health, max_health)
	end

	self.drain_count = self.drain_count + self.drain * self.interval
	local drain = math.floor(self.drain_count)
	self.drain_count = self.drain_count - drain
	self.parent:SetHealth(math.max(1, self.parent:GetHealth() - drain))
end

function modifier_item_armlet_custom_unholy_strength:OnRemoved()
	if not IsServer() then
		return
	end
	self.health = self.parent:GetHealth()
	self.max_health = self.parent:GetMaxHealth()
end

function modifier_item_armlet_custom_unholy_strength:OnDestroy()
	if not IsServer() then
		return
	end
	if self.parent:IsIllusion() then
		return
	end
	if self.ability:GetToggleState() then
		self.ability.unholy_mod = nil
		self.ability:ToggleAbility()
	end

	if not self.parent:IsAlive() then
		return
	end
	self.parent:EmitSound("DOTA_Item.Armlet.DeActivate")
	self:UpdateHealth(self.health, self.max_health)
end

function modifier_item_armlet_custom_unholy_strength:UpdateHealth(health, max_health)
	self.parent:CalculateStatBonus(true)
	self.parent:SetHealth(math.max(1, health + self.parent:GetMaxHealth() - max_health))
end

function modifier_item_armlet_custom_unholy_strength:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
	}
end

function modifier_item_armlet_custom_unholy_strength:GetModifierPreAttack_BonusDamage()
	return self.damage
end

function modifier_item_armlet_custom_unholy_strength:GetModifierBonusStats_Strength()
	return self.strength * self:GetStackCount()
end

function modifier_item_armlet_custom_unholy_strength:GetModifierPhysicalArmorBonus()
	if self:GetStackCount() < self.max then
		return
	end
	return self.armor
end

function modifier_item_armlet_custom_unholy_strength:GetModifierSlowResistance_Stacking()
	return self.slow_resist
end