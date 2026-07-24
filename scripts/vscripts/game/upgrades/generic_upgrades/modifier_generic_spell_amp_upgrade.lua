--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_spell_amp_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_spell_amp_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("spell_amp")
end

function modifier_generic_spell_amp_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_spell_amp_upgrade:OnRefresh()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_spell_amp_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_generic_spell_amp_upgrade:GetModifierSpellAmplify_Percentage()
	return self.bonus
end