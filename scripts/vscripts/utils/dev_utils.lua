--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


DevUtils = DevUtils or {}

function DevUtils:Check()
	--return false -- Можно заменить на это чтобы иммитировать реальную игру, ОБЯЗАТЕЛЬНО ЗАКОММЕНТИТЬ ДЛЯ ПРОДА
	return IsInToolsMode() or GameRulesCustom:IsCheatMode()
end