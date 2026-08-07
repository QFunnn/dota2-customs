--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/maps/base_0016_map"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFindIndex
local f = b.__TS__ArraySome
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 3,
		["16"] = 3,
		["17"] = 4,
		["18"] = 3,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 8,
		["23"] = 8,
		["24"] = 8,
		["25"] = 8,
		["26"] = 8,
		["27"] = 8,
		["28"] = 6,
		["29"] = 10,
		["30"] = 11,
		["31"] = 12,
		["32"] = 12,
		["33"] = 12,
		["34"] = 12,
		["35"] = 13,
		["36"] = 13,
		["37"] = 13,
		["38"] = 13,
		["39"] = 14,
		["40"] = 15,
		["43"] = 10,
		["44"] = 19,
		["45"] = 20,
		["46"] = 21,
		["47"] = 22,
		["48"] = 23,
		["50"] = 25,
		["52"] = 19,
		["53"] = 28,
		["54"] = 28,
		["55"] = 28,
		["57"] = 29,
		["58"] = 30,
		["59"] = 31,
		["60"] = 32,
		["61"] = 33,
		["62"] = 34,
		["63"] = 35,
		["64"] = 36,
		["65"] = 37,
		["66"] = 37,
		["67"] = 37,
		["68"] = 37,
		["69"] = 37,
		["73"] = 44,
		["74"] = 45,
		["75"] = 46,
		["76"] = 47,
		["81"] = 52,
		["82"] = 53,
		["84"] = 55,
		["85"] = 56,
		["86"] = 56,
		["87"] = 56,
		["88"] = 57,
		["89"] = 58,
		["91"] = 56,
		["92"] = 56,
		["94"] = 28,
		["95"] = 63,
		["96"] = 64,
		["97"] = 65,
		["98"] = 66,
		["99"] = 67,
		["100"] = 68,
		["101"] = 68,
		["102"] = 68,
		["103"] = 68,
		["104"] = 68,
		["107"] = 63,
		["108"] = 75,
		["109"] = 76,
		["110"] = 77,
		["111"] = 78,
		["112"] = 79,
		["113"] = 80,
		["114"] = 81,
		["115"] = 82,
		["116"] = 83,
		["118"] = 85,
		["119"] = 86,
		["121"] = 88,
		["126"] = 93,
		["127"] = 75,
		["128"] = 95,
		["129"] = 96,
		["130"] = 97,
		["132"] = 95,
	}
)
local h = {}
local i = require("abilities.maps.map_base")
local j = i.MapBase
h.base_0016_map = c()
local k = h.base_0016_map
k.name = "base_0016_map"
d(k, j)
function k.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.screenIDList = {}
end
function k.prototype.spawn(self)
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END, self.OnBattleEnd)
	self.eventID = CustomUIEvent("teleport_player_area", function(self, ...)
		return self:OnTeleportPlayerArea(...)
	end, self)
end
function k.prototype.OnTeleportPlayerArea(self, l)
	if #self.screenIDList > 0 then
		local m = e(self.screenIDList, function(n, o)
			return o.playerID == l.PlayerID
		end)
		if m > -1 and not f(self.screenIDList, function(n, o)
			return o.playerID == l.targetPlayerID
		end) then
			local p = table.remove(self.screenIDList, m + 1)
			ParticleManager:DestroyParticle(p.id, true)
		end
	end
end
function k.prototype.OnBattleEnd(self, q)
	if q.illusionPlayerID ~= self.playerID and q.winPlayerID == self.playerID then
		local r
		if q.isNeutral == nil and q.illusionPlayerID ~= q.losePlayerID then
			r = q.losePlayerID
		end
		self:Victory(self.playerID, r, q.isNeutral ~= nil)
	end
end
function k.prototype.Victory(self, s, r, t)
	if t == nil then
		t = false
	end
	self.screenIDList = {}
	if t then
		local u = PlayerData:getplayerData(self.playerID)
		if u and u.viewPlayerID == self.playerID then
			local v = self.playerID
			local w = PlayerResource:GetSelectedHeroEntity(v)
			local x = PlayerResource:GetPlayer(v)
			if IsValid(w) and x then
				local y = self.screenIDList
				y[#y + 1] = {
					id = ParticleManager:CreateParticleForPlayer(
						"models/eom/props/base_0016_map/base_0016_map_screen_victory_fx.vpcf",
						PATTACH_MAIN_VIEW,
						w,
						x
					),
					playerID = v,
				}
			end
		end
	else
		local z = CustomNetTables:GetTableValue("common", "battle_data")
		if z then
			for A, o in pairs(z) do
				if o.customerPlayer.illusion == 0 and o.customerPlayer.PlayerID == s then
					return
				end
			end
		end
		self:createVictoryParticle(s, z)
		self:createVictoryParticle(r, z)
	end
	if #self.screenIDList > 0 then
		GameTimer(3, function()
			if self then
				self.screenIDList = {}
			end
		end)
	end
end
function k.prototype.createVictoryParticle(self, v, z)
	if v ~= nil and self:isWatchMainLand(v, z) then
		local w = PlayerResource:GetSelectedHeroEntity(v)
		local u = PlayerResource:GetPlayer(v)
		if IsValid(w) and u then
			local B = self.screenIDList
			B[#B + 1] = {
				id = ParticleManager:CreateParticleForPlayer(
					"models/eom/props/base_0016_map/base_0016_map_screen_victory_fx.vpcf",
					PATTACH_MAIN_VIEW,
					w,
					u
				),
				playerID = v,
			}
		end
	end
end
function k.prototype.isWatchMainLand(self, v, z)
	if z then
		local u = PlayerData:getplayerData(v)
		local C = self.playerID
		if u then
			for A, o in pairs(z) do
				if o.mainPlayer.illusion == 0 and o.mainPlayer.PlayerID == C then
					if not u.viewIllusion and u.viewPlayerID == C then
						return true
					end
					if
						u.viewIllusion == (o.customerPlayer.illusion == 1)
						and u.viewPlayerID == o.customerPlayer.PlayerID
					then
						return true
					end
					return false
				end
			end
		end
	end
	return true
end
function k.prototype.dispose(self)
	if self.eventID then
		CustomGameEventManager:UnregisterListener(self.eventID)
	end
end
return h