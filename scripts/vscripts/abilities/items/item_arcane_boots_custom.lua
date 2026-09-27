--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


item_arcane_boots_custom = class({})

LinkLuaModifier(
	"modifier_item_arcane_boots_custom",
	"abilities/items/item_arcane_boots_custom",
	LUA_MODIFIER_MOTION_NONE
)

function item_arcane_boots_custom:GetIntrinsicModifierName()
	return "modifier_item_arcane_boots_custom"
end

function item_arcane_boots_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items_fx/arcane_boots.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/arcane_boots_recipient.vpcf", context)
end

function item_arcane_boots_custom:Spawn()
	self.replenish_amount = self:GetSpecialValueFor("replenish_amount")
	self.radius = self:GetSpecialValueFor("radius")
	self.bonus_movement = self:GetSpecialValueFor("bonus_movement")
	self.mana_regen = self:GetSpecialValueFor("mana_regen")
	self.mana_bonus = self:GetSpecialValueFor("mana_bonus")
end

function item_arcane_boots_custom:OnSpellStart()
	local caster = self:GetCaster()
	local replenish_amount = self.replenish_amount
	local radius = self.radius

	caster:EmitSound("DOTA_Item.ArcaneBoots.Activate")

	caster:GenericParticle("particles/items_fx/arcane_boots.vpcf")

	local friends = caster:FindFriends(radius, nil, nil, DOTA_UNIT_TARGET_FLAG_INVULNERABLE)

	for _, friend in pairs(friends) do
		friend:GenericParticle("particles/items_fx/arcane_boots_recipient.vpcf")
		friend:GiveMana(replenish_amount)

		friend:SendNumber(OVERHEAD_ALERT_MANA_ADD, replenish_amount)
	end
end

modifier_item_arcane_boots_custom = class(mod_hidden)
function modifier_item_arcane_boots_custom:RemoveOnDeath()
	return false
end
function modifier_item_arcane_boots_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
end

function modifier_item_arcane_boots_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_item_arcane_boots_custom:GetModifierMoveSpeedBonus_Special_Boots()
	return self.ability.bonus_movement
end

function modifier_item_arcane_boots_custom:GetModifierConstantManaRegen()
	return self.ability.mana_regen
end

function modifier_item_arcane_boots_custom:GetModifierManaBonus()
	return self.ability.mana_bonus
end