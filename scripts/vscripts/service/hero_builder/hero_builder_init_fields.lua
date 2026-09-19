--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


function HeroBuilderService:InitFields()
	self.pendingSwaps = {}

	self.attackCapabilityChanged = {}

	self.HeroInited = {}
	self.initAegisCount = 2

	if IsInToolsMode() then
		self.initAegisCount = 2
	end

	self.PrecachedHeroList = {}
	---@type table<string, integer> shortHeroName -> spawn group handle прекеша абилок этого героя
	self.SpawnGroupsByHeroNames = {}
	for i = 0, MAX_PLAYER_COUNT - 1 do
		self.HeroInited[i] = false
	end

	self.scepterOwners = {}
end