--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_custom_rune_invisibility", "items/runes/invisibility", LUA_MODIFIER_MOTION_NONE )

if item_custom_rune_invisibility == nil then
	item_custom_rune_invisibility = class({})
end

function item_custom_rune_invisibility:OnSpellStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_custom_rune_invisibility", {duration=5})

	EmitGlobalSound("Rune.Invis")

	UTIL_Remove(self)
end

modifier_item_custom_rune_invisibility = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    CheckState				= function(self)
		return {
			[MODIFIER_STATE_INVISIBLE] = true
		}
	end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_INVISIBILITY_LEVEL
        }
    end,

    GetModifierInvisibilityLevel           = function(self) return 1 end,
})
function item_custom_rune_invisibility:OnChargeCountChanged(iCharges) end