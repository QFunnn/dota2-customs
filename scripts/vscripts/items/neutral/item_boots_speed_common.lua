--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_boots_speed_common = class({})
LinkLuaModifier(
	"modifier_item_boots_speed_common",
	"items/neutral/item_boots_speed_common.lua",
	LUA_MODIFIER_MOTION_NONE
)

function item_boots_speed_common:GetIntrinsicModifierName()
	return "modifier_item_boots_speed_common"
end

modifier_item_boots_speed_common = class({})

function modifier_item_boots_speed_common:IsHidden()
	return true
end
function modifier_item_boots_speed_common:IsPurgable()
	return false
end
function modifier_item_boots_speed_common:RemoveOnDeath()
	return false
end
function modifier_item_boots_speed_common:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_boots_speed_common:OnCreated()
	if IsServer() then
		if not self:GetAbility() then
			self:Destroy()
		end
	end

	if not IsServer() then
		return
	end
end

function modifier_item_boots_speed_common:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_boots_speed_common:GetModifierMoveSpeedBonus_Percentage()
	if self:GetAbility() then
		return 25
	end
end