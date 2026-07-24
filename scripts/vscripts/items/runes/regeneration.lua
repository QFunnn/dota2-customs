--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_custom_rune_regeneration", "items/runes/regeneration.lua", LUA_MODIFIER_MOTION_NONE )

if item_custom_rune_regeneration == nil then
	item_custom_rune_regeneration = class({})
end

function item_custom_rune_regeneration:OnSpellStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_custom_rune_regeneration", {duration=5})

	EmitGlobalSound("Rune.Regen")

	UTIL_Remove(self)
end

modifier_item_custom_rune_regeneration = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
        }
    end,

    GetModifierConstantHealthRegen           = function(self) return 2 end,

    GetEffectName			= function(self) return "particles/generic_gameplay/rune_regen_owner.vpcf" end,
})
function item_custom_rune_regeneration:OnChargeCountChanged(iCharges) end