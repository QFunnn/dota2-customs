--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


modifier_test_nears = class({
	IsHidden = function(self)
		return false
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

	DeclareFunctions = function(self)
		return {
			MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
		}
	end,

	GetModifierPercentageCasttime = function(self)
		return 100
	end,
})