--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_panic_button_custom", "items/item_panic_button_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_panic_button_custom_buff", "items/item_panic_button_custom", LUA_MODIFIER_MOTION_NONE)

item_panic_button_custom = class({})

function item_panic_button_custom:GetIntrinsicModifierName()
	return "modifier_item_panic_button_custom"
end

modifier_item_panic_button_custom = class({})

function modifier_item_panic_button_custom:IsHidden() return true end

function modifier_item_panic_button_custom:IsPurgable() return false end
function modifier_item_panic_button_custom:IsPurgeException() return false end

function modifier_item_panic_button_custom:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_item_panic_button_custom:OnIntervalThink()
	if not IsServer() then return end
	local health = self:GetParent():GetHealthPercent()
	local max = self:GetAbility():GetSpecialValueFor("health_pct")
	if health <= max then
		if not self:GetParent():HasModifier("modifier_item_panic_button_custom_buff") then
			self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_panic_button_custom_buff", {})
		end
	end
end

function modifier_item_panic_button_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MANA_BONUS,
	}
end

function modifier_item_panic_button_custom:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

modifier_item_panic_button_custom_buff = class({})

function modifier_item_panic_button_custom_buff:IsPurgable() return false end

function modifier_item_panic_button_custom_buff:OnCreated()
	self.bonus_int = self:GetAbility():GetSpecialValueFor("bonus_int")
	self.max = self:GetAbility():GetSpecialValueFor("health_pct")
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_item_panic_button_custom_buff:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():GetHealthPercent() > self.max then
		self:Destroy()
	end
	if not self:GetParent():HasModifier("modifier_item_panic_button_custom") then
		self:Destroy()
	end
end

function modifier_item_panic_button_custom_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_item_panic_button_custom_buff:GetModifierBonusStats_Intellect()
	return self.bonus_int
end