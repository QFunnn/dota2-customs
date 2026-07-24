--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_essence_ring_custom", "items/item_essence_ring_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_essence_ring_custom_active", "items/item_essence_ring_custom", LUA_MODIFIER_MOTION_NONE)

item_essence_ring_custom = class({})

function item_essence_ring_custom:GetIntrinsicModifierName()
	return "modifier_item_essence_ring_custom"
end

function item_essence_ring_custom:OnSpellStart()
	if not IsServer() then return end
	local heal = self:GetCaster():GetMaxHealth() / 100 * self:GetSpecialValueFor("health_gain")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_essence_ring_custom_active", {duration = self:GetSpecialValueFor("health_gain_duration")})
	self:GetCaster():Heal(heal, self)
	self:GetCaster():EmitSound("DOTA_Item.EssenceRing.Cast")
end

modifier_item_essence_ring_custom = class({})

function modifier_item_essence_ring_custom:IsHidden() return true end
function modifier_item_essence_ring_custom:IsPurgable() return false end
function modifier_item_essence_ring_custom:IsPurgeException() return false end
function modifier_item_essence_ring_custom:RemoveOnDeath() return false end

function modifier_item_essence_ring_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_item_essence_ring_custom:GetModifierBonusStats_Intellect()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_int")
end

function modifier_item_essence_ring_custom:GetModifierConstantManaRegen()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("mp_regen")
end

modifier_item_essence_ring_custom_active = class({})
function modifier_item_essence_ring_custom_active:GetEffectName() return "particles/items5_fx/essence_ring.vpcf" end
function modifier_item_essence_ring_custom_active:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end
function modifier_item_essence_ring_custom_active:IsPurgable() return false end
function modifier_item_essence_ring_custom_active:IsPurgeException() return false end

function modifier_item_essence_ring_custom_active:OnCreated()
	self.health = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("health_gain")
	if not IsServer() then return end
	self:GetParent():CalculateStatBonus(true)
end

function modifier_item_essence_ring_custom_active:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_BONUS
	}
end

function modifier_item_essence_ring_custom_active:GetModifierHealthBonus()
	return self.health
end