--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_special_bonus_custom_debuff_amp_15 = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    RemoveOnDeath           = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_STATUS_RESISTANCE_CASTER,
        }
    end,

	GetModifierStatusResistanceCaster	= function(self)
		return -(self.DebuffAmp or 0)
	end,
})

function modifier_special_bonus_custom_debuff_amp_15:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.DebuffAmp = ability:GetSpecialValueFor("value")
    end
end