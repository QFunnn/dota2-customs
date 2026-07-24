--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_marci_special_delivery", "heroes/hero_marci/special_delivery", LUA_MODIFIER_MOTION_NONE )

if ability_marci_special_delivery == nil then
	ability_marci_special_delivery = class({})
end

function ability_marci_special_delivery:Precache(context)
	PrecacheResource("particle", "particles/items_fx/black_king_bar_avatar.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_avatar.vpcf", context)
end

function ability_marci_special_delivery:OnSpellStart()
	local caster = self:GetCaster()
	local Duration = self:GetSpecialValueFor("duration")

	caster:AddNewModifier(caster, self, "modifier_ability_marci_special_delivery", {duration=Duration})
	EmitSoundOn( "DOTA_Item.BlackKingBar.Activate", caster )

	caster:Purge(false, true, false, false, false)
end

modifier_ability_marci_special_delivery = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        }
    end,

	CheckState				= function(self)
		return {
			[MODIFIER_STATE_DEBUFF_IMMUNE]=true,
		}
	end,

	GetModifierMagicalResistanceBonus	= function(self)
		return self.MagicalResistance or 0
	end,

	GetEffectName 						= function(self)
		return "particles/items_fx/black_king_bar_avatar.vpcf"
	end,

	GetStatusEffectName					= function(self)
		return "particles/status_fx/status_effect_avatar.vpcf"
	end,
})

function modifier_ability_marci_special_delivery:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.MagicalResistance = ability:GetSpecialValueFor("magical_resistance")
	end
end