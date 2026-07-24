--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_trusty_shovel_custom", "items/item_trusty_shovel_custom", LUA_MODIFIER_MOTION_NONE)

item_trusty_shovel_custom = class({})

function item_trusty_shovel_custom:GetIntrinsicModifierName()
	return "modifier_item_trusty_shovel_custom"
end

modifier_item_trusty_shovel_custom = class({})

function modifier_item_trusty_shovel_custom:IsHidden() return true end

function modifier_item_trusty_shovel_custom:IsPurgable() return false end
function modifier_item_trusty_shovel_custom:IsPurgeException() return false end
function modifier_item_trusty_shovel_custom:RemoveOnDeath() return false end

function modifier_item_trusty_shovel_custom:OnCreated()
	if not IsServer() then return end
	self.bonus_exp_min = self:GetAbility():GetSpecialValueFor("bonus_exp_min") / 60
	self:StartIntervalThink(1)
end

function modifier_item_trusty_shovel_custom:OnIntervalThink()
	if not IsServer() then return end

	if self:GetParent():IsRealHero() then
		self:GetParent():AddExperience(self.bonus_exp_min, DOTA_ModifyXP_Outpost, false, true)
	end

	if not self:GetParent():IsHero() and not self:GetParent():IsRealHero() and self:GetParent():GetOwner() ~= nil then
		self:GetParent():GetOwner():AddExperience(self.bonus_exp_min, DOTA_ModifyXP_Outpost, false, true)
	end
end























