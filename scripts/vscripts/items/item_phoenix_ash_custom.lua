--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_phoenix_ash_custom", "items/item_phoenix_ash_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_phoenix_ash_custom_buff", "items/item_phoenix_ash_custom", LUA_MODIFIER_MOTION_NONE)

item_phoenix_ash_custom = class({})

function item_phoenix_ash_custom:GetIntrinsicModifierName()
	return "modifier_item_phoenix_ash_custom"
end

modifier_item_phoenix_ash_custom = class({})

function modifier_item_phoenix_ash_custom:IsHidden() return true end

function modifier_item_phoenix_ash_custom:IsPurgable() return false end
function modifier_item_phoenix_ash_custom:IsPurgeException() return false end

function modifier_item_phoenix_ash_custom:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_item_phoenix_ash_custom:OnIntervalThink()
	if not IsServer() then return end
	local health = self:GetParent():GetHealthPercent()
	local max = self:GetAbility():GetSpecialValueFor("health_pct")
	if health <= max then
		if not self:GetParent():HasModifier("modifier_item_phoenix_ash_custom_buff") then
			self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_phoenix_ash_custom_buff", {})
		end
	end
end

modifier_item_phoenix_ash_custom_buff = class({})

function modifier_item_phoenix_ash_custom_buff:IsPurgable() return false end

function modifier_item_phoenix_ash_custom_buff:OnCreated()
	self.bonus_regen = self:GetAbility():GetSpecialValueFor("bonus_regen")
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.max = self:GetAbility():GetSpecialValueFor("health_pct")
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_item_phoenix_ash_custom_buff:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():GetHealthPercent() > self.max then
		self:Destroy()
	end
	if not self:GetParent():HasModifier("modifier_item_phoenix_ash_custom") then
		self:Destroy()
	end
end

function modifier_item_phoenix_ash_custom_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_item_phoenix_ash_custom_buff:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_item_phoenix_ash_custom_buff:GetModifierConstantHealthRegen()
	return self.bonus_regen
end