--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_custom_rune_double_damage", "items/runes/double_damage.lua", LUA_MODIFIER_MOTION_NONE )

if item_custom_rune_double_damage == nil then
	item_custom_rune_double_damage = class({})
end

function item_custom_rune_double_damage:OnSpellStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_custom_rune_double_damage", {duration=10})

	EmitGlobalSound("Rune.DD")

	UTIL_Remove(self)
end


modifier_item_custom_rune_double_damage = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
        }
    end,

    GetModifierPreAttack_BonusDamage           = function(self, params)
        if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
            _G.Players:QueueAttackBonus(params.attacker, params.target, 2, "rune_double_damage", DAMAGE_TYPE_PHYSICAL)
        end
        return 2
    end,

	GetEffectName			= function(self) return "particles/generic_gameplay/rune_doubledamage_owner.vpcf" end,
})
function item_custom_rune_double_damage:OnChargeCountChanged(iCharges) end