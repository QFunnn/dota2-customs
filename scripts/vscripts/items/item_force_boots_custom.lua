--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_force_boots_custom", "items/item_force_boots_custom", LUA_MODIFIER_MOTION_NONE)

item_force_boots_custom = class({})

function item_force_boots_custom:OnSpellStart()
	if not IsServer() then
		return
	end
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_force_boots_active",
		{ push_length = self:GetSpecialValueFor("push_length"), duration = self:GetSpecialValueFor("push_duration") }
	)
	self:GetCaster():RemoveGesture(ACT_DOTA_DISABLED)
	self:GetCaster():Purge(false, true, false, false, false)
	EmitSoundOn("DOTA_Item.ForceStaff.Activate", self:GetCaster())
end

function item_force_boots_custom:GetIntrinsicModifierName()
	return "modifier_item_force_boots_custom"
end

modifier_item_force_boots_custom = class({})
function modifier_item_force_boots_custom:IsHidden()
	return true
end
function modifier_item_force_boots_custom:IsPurgable()
	return false
end
function modifier_item_force_boots_custom:IsPurgeException()
	return false
end