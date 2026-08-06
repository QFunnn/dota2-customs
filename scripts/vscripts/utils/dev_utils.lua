--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


DevUtils = DevUtils or {}

function DevUtils:Check()
	--return false -- Можно заменить на это чтобы иммитировать реальную игру, ОБЯЗАТЕЛЬНО ЗАКОММЕНТИТЬ ДЛЯ ПРОДА
	return IsInToolsMode() or GameRulesCustom:IsCheatMode()
end