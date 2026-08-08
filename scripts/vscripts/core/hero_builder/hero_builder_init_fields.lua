--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


function HeroBuilder:InitFields()
	self.pendingSwaps = {}

	self.attackCapabilityChanged = {}

	self.HeroInited = {}
	self.initAegisCount = 2

	if IsInToolsMode() then
		self.initAegisCount = 2
	end

	self.PrecachedHeroList = {}
	for i = 0, CHC_MAX_PLAYER_COUNT - 1 do
		self.HeroInited[i] = false
	end

	self.scepterOwners = {}
end