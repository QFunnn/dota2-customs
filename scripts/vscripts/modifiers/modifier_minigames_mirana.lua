--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_minigames_mirana = class({
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

	DeclareFunctions = function(self)
		return {
			MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		}
	end,

	GetActivityTranslationModifiers = function(self)
		return "run"
	end,
})