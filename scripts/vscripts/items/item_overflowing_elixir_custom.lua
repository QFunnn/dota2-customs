--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_overflowing_elixir_custom", "items/item_overflowing_elixir_custom", LUA_MODIFIER_MOTION_NONE)

item_overflowing_elixir_custom = class({})

function item_overflowing_elixir_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_overflowing_elixir_custom", {duration = duration})
	self:GetCaster():EmitSound("Bottle.Drink")
end

modifier_item_overflowing_elixir_custom = class({})

function modifier_item_overflowing_elixir_custom:IsPurgable() return false end

function modifier_item_overflowing_elixir_custom:OnCreated()
	self.health = self:GetAbility():GetSpecialValueFor("health") / self:GetAbility():GetSpecialValueFor("duration")
	self.mana = self:GetAbility():GetSpecialValueFor("mana") / self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_item_overflowing_elixir_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end

function modifier_item_overflowing_elixir_custom:OnTakeDamage(params)
	if params.unit ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end
	if not params.attacker:IsHero() then return end
	self:Destroy()
end

function modifier_item_overflowing_elixir_custom:GetEffectName()
	return "particles/econ/events/ti5/bottle_ti5.vpcf"
end

function modifier_item_overflowing_elixir_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_overflowing_elixir_custom:GetModifierConstantHealthRegen()
	return self.health
end

function modifier_item_overflowing_elixir_custom:GetModifierConstantManaRegen()
	return self.mana
end