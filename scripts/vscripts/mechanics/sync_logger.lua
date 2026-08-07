--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/mechanics/sync_logger.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__DecorateLegacy
local f = c.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 5,
		["14"] = 7,
		["15"] = 8,
		["16"] = 7,
		["18"] = 17,
		["19"] = 18,
		["20"] = 7,
		["21"] = 19,
		["22"] = 20,
		["23"] = 21,
		["24"] = 19,
		["25"] = 24,
		["26"] = 25,
		["29"] = 28,
		["30"] = 28,
		["31"] = 28,
		["32"] = 28,
		["33"] = 28,
		["34"] = 28,
		["35"] = 28,
		["36"] = 36,
		["37"] = 36,
		["38"] = 36,
		["39"] = 36,
		["40"] = 37,
		["41"] = 37,
		["43"] = 36,
		["44"] = 36,
		["45"] = 36,
		["46"] = 36,
		["47"] = 40,
		["48"] = 41,
		["49"] = 41,
		["50"] = 41,
		["51"] = 41,
		["52"] = 41,
		["53"] = 41,
		["54"] = 41,
		["55"] = 41,
		["57"] = 43,
		["58"] = 24,
		["59"] = 46,
		["60"] = 48,
		["61"] = 50,
		["62"] = 51,
		["64"] = 53,
		["65"] = 55,
		["66"] = 56,
		["67"] = 56,
		["68"] = 56,
		["69"] = 56,
		["71"] = 59,
		["72"] = 46,
		["73"] = 62,
		["74"] = 63,
		["77"] = 66,
		["78"] = 66,
		["79"] = 66,
		["80"] = 66,
		["81"] = 62,
		["82"] = 69,
		["83"] = 70,
		["86"] = 74,
		["89"] = 77,
		["90"] = 78,
		["91"] = 79,
		["92"] = 79,
		["93"] = 79,
		["94"] = 79,
		["95"] = 80,
		["96"] = 80,
		["97"] = 80,
		["98"] = 80,
		["99"] = 80,
		["100"] = 80,
		["101"] = 80,
		["102"] = 91,
		["103"] = 91,
		["104"] = 91,
		["105"] = 91,
		["106"] = 91,
		["107"] = 91,
		["108"] = 91,
		["109"] = 91,
		["110"] = 92,
		["111"] = 93,
		["112"] = 93,
		["113"] = 93,
		["114"] = 93,
		["115"] = 93,
		["116"] = 93,
		["117"] = 93,
		["118"] = 93,
		["120"] = 95,
		["121"] = 79,
		["122"] = 79,
		["123"] = 69,
		["124"] = 9,
		["125"] = 10,
		["126"] = 11,
		["127"] = 12,
		["128"] = 13,
		["129"] = 7,
		["130"] = 8,
	}
)
local g = {}
local h = require("lib.tstl-utils")
local i = h.reloadable
local j = require("service.http_utils")
local k = j.HttpUtils
local l = require("service.sync_entity")
local m = l.CSyncEntity
local n = true
g.CSyncLogger = d()
local o = g.CSyncLogger
o.name = "CSyncLogger"
function o.prototype.____constructor(self)
	self.syncLogSN = 0
	self.cachedLogs = ""
end
function o.prototype.SyncLogReset(self)
	self.syncLogSN = 0
	self.cachedLogs = ""
end
function o.prototype.syncLogHttpFlush(self, p, q, r)
	if Match.playerAmount <= 1 then
		return
	end
	local s =
		{ sn = p, from = PlayerData:LocalSteamID(), game_id = tostring(Match:getMatchID()), round = q, log = self.cachedLogs }
	k:Put("/v1/c4/sync_log", s, function(t, u, v, w)
		if r ~= nil then
			r(nil)
		end
	end, g.CSyncLogger.URL, m.TOKEN)
	if g.CSyncLogger.URL2 and #g.CSyncLogger.URL2 > 0 then
		k:Put("/v1/c4/sync_log", s, function(t, u, v, w) end, g.CSyncLogger.URL2, m.TOKEN)
	end
	self.cachedLogs = ""
end
function o.prototype.syncLog(self, x, y)
	local z = (("<!><SyncLog> [" .. x) .. "]") .. y
	if #self.cachedLogs > 0 then
		self.cachedLogs = self.cachedLogs .. "\n"
	end
	self.cachedLogs = self.cachedLogs .. z
	if self.syncLogSN % 50 == 0 then
		self:syncLogHttpFlush(self.syncLogSN, Rounds:getCurrentRound())
	end
	self.syncLogSN = self.syncLogSN + 1
end
function o.prototype.FlushCachedSyncLog(self)
	if Match.playerAmount <= 1 then
		return
	end
	self:syncLogHttpFlush(self.syncLogSN, Rounds:getCurrentRound())
end
function o.prototype.RequestSaveSyncLog(self)
	if Match.playerAmount <= 1 then
		return
	end
	if not n then
		return
	end
	local A = tostring(Match:getMatchID())
	local q = Rounds:getCurrentRound()
	self:syncLogHttpFlush(self.syncLogSN, q, function()
		local s =
			{ sn = self.syncLogSN, from = PlayerData:LocalSteamID(), game_id = A, round = q, log = "FlushSyncLog" }
		k:Put("/v1/c4/sync_log", s, function(t, u, v, w) end, g.CSyncLogger.URL, m.TOKEN)
		if g.CSyncLogger.URL2 and #g.CSyncLogger.URL2 > 0 then
			k:Put("/v1/c4/sync_log", s, function(t, u, v, w) end, g.CSyncLogger.URL2, m.TOKEN)
		end
		self.syncLogSN = 0
	end)
end
o.URL_CB01 = "http://110.40.187.139:8056"
o.URL_INTERAL_FRP = "http://124.220.236.14:8189"
o.URL_INTERAL = "http://192.168.1.99:8189"
o.URL = SYNC_LOGIC_DEBUG_FAST_MODE and g.CSyncLogger.URL_CB01 or g.CSyncLogger.URL_CB01
o.URL2 = SYNC_LOGIC_DEBUG_FAST_MODE and g.CSyncLogger.URL_INTERAL or ""
o = e({ i }, o)
g.CSyncLogger = o
return g