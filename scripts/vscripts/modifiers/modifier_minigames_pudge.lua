--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


modifier_minigames_pudge = class({
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
})