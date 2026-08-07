--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "custom_net_data"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__New
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 3,
		["13"] = 4,
		["14"] = 10,
		["15"] = 11,
		["16"] = 12,
		["17"] = 13,
		["18"] = 14,
		["20"] = 16,
		["21"] = 16,
		["22"] = 16,
		["23"] = 16,
		["24"] = 16,
		["25"] = 16,
		["26"] = 16,
		["27"] = 17,
		["28"] = 17,
		["29"] = 17,
		["30"] = 17,
		["31"] = 17,
		["32"] = 17,
		["33"] = 17,
		["34"] = 10,
		["35"] = 19,
		["36"] = 20,
		["37"] = 22,
		["38"] = 23,
		["39"] = 23,
		["40"] = 23,
		["41"] = 24,
		["42"] = 25,
		["43"] = 26,
		["45"] = 24,
		["46"] = 29,
		["47"] = 23,
		["48"] = 23,
		["50"] = 19,
		["51"] = 33,
		["52"] = 34,
		["53"] = 35,
		["54"] = 36,
		["57"] = 39,
		["59"] = 33,
		["60"] = 42,
		["61"] = 43,
		["62"] = 44,
		["63"] = 45,
		["65"] = 47,
		["66"] = 48,
		["68"] = 50,
		["69"] = 51,
		["71"] = 42,
		["72"] = 55,
		["73"] = 56,
		["74"] = 57,
		["75"] = 58,
		["77"] = 60,
		["78"] = 61,
		["80"] = 63,
		["82"] = 65,
		["84"] = 67,
		["85"] = 68,
		["87"] = 70,
		["89"] = 72,
		["91"] = 55,
		["92"] = 75,
		["93"] = 76,
		["94"] = 77,
		["97"] = 80,
		["100"] = 83,
		["101"] = 84,
		["102"] = 85,
		["103"] = 86,
		["104"] = 87,
		["105"] = 87,
		["106"] = 87,
		["107"] = 88,
		["108"] = 87,
		["109"] = 87,
		["112"] = 92,
		["113"] = 93,
		["114"] = 93,
		["115"] = 93,
		["116"] = 94,
		["117"] = 93,
		["118"] = 93,
		["120"] = 75,
		["121"] = 98,
		["122"] = 99,
		["123"] = 100,
		["124"] = 101,
		["125"] = 102,
		["126"] = 102,
		["127"] = 102,
		["128"] = 102,
		["129"] = 102,
		["130"] = 102,
		["131"] = 102,
		["132"] = 102,
		["135"] = 108,
		["136"] = 108,
		["137"] = 108,
		["138"] = 108,
		["139"] = 108,
		["140"] = 108,
		["141"] = 108,
		["143"] = 98,
		["144"] = 114,
		["145"] = 115,
		["146"] = 116,
		["147"] = 117,
		["148"] = 118,
		["149"] = 118,
		["150"] = 118,
		["151"] = 118,
		["152"] = 118,
		["153"] = 118,
		["154"] = 118,
		["155"] = 118,
		["158"] = 124,
		["159"] = 124,
		["160"] = 124,
		["161"] = 124,
		["162"] = 124,
		["163"] = 124,
		["164"] = 124,
		["166"] = 114,
		["167"] = 130,
		["168"] = 131,
		["169"] = 132,
		["170"] = 133,
		["171"] = 130,
		["172"] = 3,
		["173"] = 139,
		["174"] = 140,
	}
)
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = c()
k.name = "CCustomNetData"
d(k, CModule)
function k.prototype.init(self, l)
	if not l then
		self.data = {}
		self.playerData = {}
		self.tIsReconnected = {}
	end
	GameEvent("game_rules_state_change", function(self, ...)
		return self:OnGameRulesStateChange(...)
	end, self)
	CustomUIEvent("custom_require_init_net_data", function(self, ...)
		return self:OnRequireInit(...)
	end, self)
end
function k.prototype.OnGameRulesStateChange(self, m)
	local n = GameRules:State_Get()
	if n == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		Timer(1, function()
			Game:EachPlayer(function(o, p)
				if PlayerResource:GetConnectionState(p) == DOTA_CONNECTION_STATE_DISCONNECTED then
					self.tIsReconnected[p] = true
				end
			end)
			return 1
		end)
	end
end
function k.prototype.GetData(self, q, p)
	if p then
		if self.playerData[p] then
			return self.playerData[p][q]
		end
	else
		return self.data[q]
	end
end
function k.prototype.CoverData(self, q, r, p)
	if p then
		if self.playerData[p] == nil then
			self.playerData[p] = {}
		end
		self.playerData[p][q] = r
		self:CoverData2Client(q, r, p)
	else
		self.data[q] = r
		self:CoverData2Client(q, r)
	end
end
function k.prototype.UpdateData(self, q, r, p)
	if p then
		if self.playerData[p] == nil then
			self.playerData[p] = {}
		end
		if self.playerData[p][q] == nil then
			self.playerData[p][q] = r
		else
			self.playerData[p][q] = ServiceTableOverride(self.playerData[p][q], r)
		end
		self:UpdateData2Client(q, r, p)
	else
		if self.data[q] == nil then
			self.data[q] = r
		else
			self.data[q] = ServiceTableOverride(self.data[q], r)
		end
		self:UpdateData2Client(q, r)
	end
end
function k.prototype.OnRequireInit(self, s)
	local p = s.PlayerID
	if p == nil then
		return
	end
	if s.force ~= 1 and self.tIsReconnected[p] ~= true then
		return
	end
	self.tIsReconnected[p] = nil
	local t = 0
	if self.playerData[p] then
		for u, v in pairs(self.playerData[p]) do
			Timer(0 + t / 10, function()
				self:CoverData2Client(u, v, p)
			end)
		end
	end
	for u, v in pairs(self.playerData[p]) do
		Timer(0 + t / 10, function()
			self:CoverData2Client(u, v)
		end)
	end
end
function k.prototype.UpdateData2Client(self, q, r, p)
	if p then
		local w = PlayerResource:GetPlayer(p)
		if w then
			CustomGameEventManager:Send_ServerToPlayer(w, "custom_update_net_data", { key = q, data = json.encode(r) })
		end
	else
		CustomGameEventManager:Send_ServerToAllClients("custom_update_net_data", { key = q, data = json.encode(r) })
	end
end
function k.prototype.CoverData2Client(self, q, r, p)
	if p then
		local w = PlayerResource:GetPlayer(p)
		if w then
			CustomGameEventManager:Send_ServerToPlayer(w, "custom_cover_net_data", { key = q, data = json.encode(r) })
		end
	else
		CustomGameEventManager:Send_ServerToAllClients("custom_cover_net_data", { key = q, data = json.encode(r) })
	end
end
function k.prototype.DebugResetPlayer(self, p)
	self.tIsReconnected[p] = nil
	self.data = {}
	self.playerData[p] = nil
end
k = e({ j }, k)
if _G.CustomNetData == nil then
	_G.CustomNetData = f(k)
end
return h