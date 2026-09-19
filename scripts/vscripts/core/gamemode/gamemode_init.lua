--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


function GameMode:InitSystems()
	Security:Init()
	HeroBuilderService:Init()
	Debugger:Init()
	PvpService:Init()
	Pass:Init()
	Illusion:Init()
	ExtraCreature:Init()
	WereableSystem:Init()
	DataManager:Init()
	ExtenderStash:Init()
	DebugTool:Init()
	-- Roulette:Init()
	Cases:Init()
	PlayerTips:Init()
end