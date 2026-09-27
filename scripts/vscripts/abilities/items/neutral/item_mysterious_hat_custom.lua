--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_mysterious_hat_custom",
	"abilities/items/neutral/item_mysterious_hat_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_mysterious_hat_custom = class({})

function item_mysterious_hat_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_item_mysterious_hat_custom"
end

function item_mysterious_hat_custom:Spawn()
	self.damage = self:GetSpecialValueFor("damage")
	self.resist = self:GetSpecialValueFor("resist")
	self.health = self:GetSpecialValueFor("health")
end

modifier_item_mysterious_hat_custom = class(mod_hidden)
function modifier_item_mysterious_hat_custom:RemoveOnDeath()
	return false
end
function modifier_item_mysterious_hat_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.damage = self.ability.damage
	self.resist = self.ability.resist
	self.health = self.ability.health
end

function modifier_item_mysterious_hat_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_item_mysterious_hat_custom:GetModifierSpellAmplify_Percentage()
	if self.parent:GetHealthPercent() < self.health then
		return
	end
	return self.damage
end

function modifier_item_mysterious_hat_custom:GetModifierMagicalResistanceBonus()
	if self.parent:GetHealthPercent() >= self.health then
		return
	end
	return self.resist
end