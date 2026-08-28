--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/host_privilege"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__ObjectValues
local g = b.__TS__ArrayIncludes
local h = b.__TS__StringSplit
local i = b.__TS__ArraySome
local j = b.__TS__DecorateLegacy
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 4,
		["17"] = 5,
		["18"] = 4,
		["19"] = 5,
		["21"] = 5,
		["22"] = 6,
		["23"] = 7,
		["24"] = 8,
		["25"] = 9,
		["26"] = 10,
		["27"] = 11,
		["28"] = 13,
		["29"] = 14,
		["30"] = 16,
		["31"] = 4,
		["32"] = 17,
		["33"] = 18,
		["34"] = 19,
		["35"] = 19,
		["36"] = 19,
		["37"] = 19,
		["38"] = 19,
		["39"] = 19,
		["40"] = 19,
		["41"] = 19,
		["42"] = 20,
		["43"] = 20,
		["44"] = 20,
		["45"] = 20,
		["46"] = 20,
		["47"] = 20,
		["48"] = 20,
		["49"] = 20,
		["50"] = 17,
		["51"] = 22,
		["52"] = 23,
		["53"] = 23,
		["54"] = 23,
		["55"] = 23,
		["56"] = 24,
		["57"] = 24,
		["58"] = 24,
		["59"] = 24,
		["60"] = 25,
		["61"] = 22,
		["62"] = 27,
		["63"] = 28,
		["64"] = 29,
		["66"] = 27,
		["67"] = 32,
		["68"] = 33,
		["69"] = 34,
		["70"] = 35,
		["71"] = 40,
		["72"] = 41,
		["73"] = 42,
		["75"] = 44,
		["77"] = 32,
		["78"] = 48,
		["79"] = 49,
		["82"] = 50,
		["83"] = 51,
		["84"] = 52,
		["85"] = 53,
		["86"] = 54,
		["88"] = 48,
		["89"] = 57,
		["90"] = 58,
		["91"] = 59,
		["92"] = 60,
		["94"] = 62,
		["95"] = 62,
		["96"] = 62,
		["97"] = 62,
		["99"] = 64,
		["100"] = 65,
		["101"] = 66,
		["104"] = 69,
		["105"] = 57,
		["106"] = 71,
		["107"] = 71,
		["108"] = 71,
		["110"] = 72,
		["111"] = 73,
		["112"] = 74,
		["114"] = 76,
		["115"] = 77,
		["116"] = 78,
		["117"] = 79,
		["118"] = 80,
		["120"] = 82,
		["121"] = 83,
		["123"] = 85,
		["124"] = 86,
		["125"] = 87,
		["127"] = 89,
		["128"] = 90,
		["129"] = 91,
		["132"] = 94,
		["133"] = 71,
		["134"] = 96,
		["135"] = 97,
		["136"] = 98,
		["138"] = 100,
		["139"] = 101,
		["140"] = 101,
		["142"] = 102,
		["143"] = 103,
		["144"] = 104,
		["145"] = 106,
		["146"] = 107,
		["148"] = 109,
		["149"] = 111,
		["150"] = 112,
		["151"] = 112,
		["152"] = 112,
		["153"] = 112,
		["154"] = 116,
		["156"] = 119,
		["157"] = 120,
		["158"] = 121,
		["159"] = 121,
		["160"] = 121,
		["161"] = 121,
		["162"] = 125,
		["164"] = 127,
		["165"] = 127,
		["167"] = 128,
		["168"] = 129,
		["169"] = 129,
		["170"] = 129,
		["171"] = 129,
		["172"] = 130,
		["173"] = 132,
		["174"] = 132,
		["175"] = 132,
		["176"] = 132,
		["177"] = 136,
		["179"] = 138,
		["186"] = 143,
		["187"] = 144,
		["188"] = 148,
		["190"] = 150,
		["191"] = 151,
		["192"] = 155,
		["194"] = 157,
		["195"] = 158,
		["200"] = 172,
		["201"] = 173,
		["203"] = 177,
		["204"] = 96,
		["205"] = 5,
		["206"] = 4,
		["207"] = 5,
		["209"] = 5,
	}
)
local l = {}
local m = require("abilities.privilege.privilege_base_class")
local n = m.PrivilegeBase
local o = m.registerPrivilege
l.host_privilege = c()
local p = l.host_privilege
p.name = "host_privilege"
d(p, n)
function p.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.activated = false
	self.option = 0
	self.sect_list = {}
	self.CustomEventIDs = {}
	self.GameEventIDs = {}
	self.state = false
	self.tick = 2
	self.recommendSects = {}
	self.DefaultSavedGold = 1000
end
function p.prototype.OnCreate(self)
	self:refreshRecommendSects()
	local q = self.CustomEventIDs
	q[#q + 1] = CustomUIEvent("on_host_privilege", function(self, ...)
		return self:OnHostPrivilege(...)
	end, self)
	local r = self.GameEventIDs
	r[#r + 1] = GameEvent("custom_game_state_change", function(self, ...)
		return self:OnCustomGameStateChange(...)
	end, self)
end
function p.prototype.OnDestory(self)
	e(self.CustomEventIDs, function(s, t)
		return StopCustomUIEvent(t)
	end)
	e(self.GameEventIDs, function(s, t)
		return StopGameEvent(t)
	end)
	self:OnActive(false)
end
function p.prototype.OnCustomGameStateChange(self, u)
	if u.state_name == "GameState_HeroShow" and u.life_cycle == "End" then
		self:refreshRecommendSects()
	end
end
function p.prototype.refreshRecommendSects(self)
	local v = PlayerData:getplayerData(self.playerID)
	self.recommendSects = {}
	if v and v.heroName then
		self.selfPlayer = v
		if self.selfPlayer.hostPrivilegeState and #self.sect_list > 0 then
			self.recommendSects = self.sect_list
		end
		self:OnActive(self.selfPlayer.hostPrivilegeState)
	end
end
function p.prototype.OnHostPrivilege(self, u)
	if u.PlayerID ~= self.playerID then
		return
	end
	self:OnActive(u.active == 1)
	self.option = u.option
	self.sect_list = f(u.sect_list)
	if #self.sect_list > 0 then
		self.recommendSects = self.sect_list
	end
end
function p.prototype.OnActive(self, w)
	if w then
		if self.AITimer ~= nil then
			StopTimer(self.AITimer)
		end
		self.AITimer = GameTimer(0, function()
			return self:OnThinker()
		end)
	else
		if self.AITimer ~= nil then
			StopTimer(self.AITimer)
			self.AITimer = nil
		end
	end
	PlayerData:setHostPrivilegeState(self.playerID, w)
end
function p.prototype.isGoldEnough(self, x, y)
	if y == nil then
		y = 0
	end
	if x == "proc" then
		if PlayerData:getGold(self.playerID) > self.DefaultSavedGold then
			return true
		end
	elseif x == "refresh" then
		local z = PlayerData:getFreeRefresh(self.playerID)
		local A = PlayerData:getRefreshGoldCost(self.playerID)
		if z > 0 then
			A = 0
		end
		if PlayerData:getGold(self.playerID) - A >= self.DefaultSavedGold + 100 then
			return true
		end
	elseif x == "buy" then
		if PlayerData:getGold(self.playerID) - y >= self.DefaultSavedGold then
			return true
		end
	elseif x == "random" then
		if PlayerData:getGold(self.playerID) - PlayerData:getRandomGoldCost(self.playerID) >= self.DefaultSavedGold then
			return true
		end
	end
	return false
end
function p.prototype.OnThinker(self)
	if self.selfPlayer == nil then
		self.selfPlayer = PlayerData:getplayerData(self.playerID)
	else
		local B = self.selfPlayer.hero
		if not B then
			return self.tick
		end
		if self:isGoldEnough("proc") then
			if #self.recommendSects > 0 then
				local C = B.abilityShopData
				local D = false
				for E, F in pairs(C) do
					do
						if not F.soldOut then
							if F.gold == 0 then
								AbilityShop:OnAbilityShop({ PlayerID = self.playerID, abilityName = tostring(E) })
								return self.tick
							end
							local G = KeyValues.AbilityUpgradesKvs[E]
							if G.rarity == "sr" and g(self.recommendSects, "SR") then
								AbilityShop:OnAbilityShop({ PlayerID = self.playerID, abilityName = tostring(E) })
								return self.tick
							end
							if G.sect == nil then
								goto H
							end
							local I = h(G.sect, "|")
							if i(I, function(s, J)
								return g(self.recommendSects, J)
							end) then
								if self:isGoldEnough("buy", F.gold) then
									AbilityShop:OnAbilityShop({ PlayerID = self.playerID, abilityName = tostring(E) })
									return self.tick
								else
									D = true
								end
							end
						end
					end
					::H::
				end
				if
					not D
					and not self.selfPlayer.lockAbilityShop
					and self:isGoldEnough("refresh")
					and self.option == 1
				then
					AbilityShop:OnAbilityShop({ PlayerID = self.playerID, refresh = 1 })
					return self.tick
				end
				if
					not D
					and not self.selfPlayer.lockAbilityShop
					and self:isGoldEnough("random")
					and self.option == 2
				then
					AbilityShop:OnAbilityShop({ PlayerID = self.playerID, random = 1 })
					return self.tick
				end
				if self.selfPlayer.lockAbilityShop then
					return self.tick
				end
			end
		end
	end
	if GameState:getStateName() == "GameState_Prepare" and self.selfPlayer and not self.selfPlayer.prepareReady then
		PlayerData:OnPrepareReady({ PlayerID = self.playerID })
	end
	return self.tick
end
p = j({ o(nil) }, p)
l.host_privilege = p
return l