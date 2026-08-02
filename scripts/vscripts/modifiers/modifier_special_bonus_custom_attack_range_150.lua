--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_special_bonus_custom_attack_range_150 = class({
	IsHidden = function(self)
		return true
	end,
	IsPurgable = function(self)
		return false
	end,
	IsPurgeException = function(self)
		return false
	end,
	IsDebuff = function(self)
		return false
	end,
	RemoveOnDeath = function(self)
		return false
	end,

	DeclareFunctions = function(self)
		return {
			MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		}
	end,

	GetModifierAttackRangeBonus = function(self)
		return self.AttackRange or 0
	end,
})

function modifier_special_bonus_custom_attack_range_150:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.AttackRange = ability:GetSpecialValueFor("value")
	end
end