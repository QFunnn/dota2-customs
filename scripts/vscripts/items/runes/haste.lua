--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_custom_rune_haste", "items/runes/haste.lua", LUA_MODIFIER_MOTION_NONE )

if item_custom_rune_haste == nil then
	item_custom_rune_haste = class({})
end

function item_custom_rune_haste:OnSpellStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_custom_rune_haste", {duration=10})

	EmitGlobalSound("Rune.Haste")

	UTIL_Remove(self)
end

function item_custom_rune_haste:OnChargeCountChanged(iCharges) end


modifier_item_custom_rune_haste = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
        }
    end,

    GetModifierMoveSpeedBonus_Constant           = function(self) return 550 end,

	GetEffectName			= function(self) return "particles/generic_gameplay/rune_haste_owner.vpcf" end,
})