--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "class/battle_record_publisher"
local b = require("lualib_bundle")
local c = b.__TS__Number
local d = b.__TS__Class
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 20,
		["8"] = 21,
		["10"] = 22,
		["11"] = 23,
		["12"] = 23,
		["14"] = 24,
		["15"] = 25,
		["16"] = 26,
		["17"] = 27,
		["19"] = 29,
		["23"] = 31,
		["24"] = 20,
		["26"] = 35,
		["27"] = 40,
		["28"] = 41,
		["29"] = 35,
		["30"] = 44,
		["31"] = 45,
		["32"] = 46,
		["33"] = 47,
		["34"] = 48,
		["35"] = 49,
		["36"] = 50,
		["40"] = 54,
		["41"] = 55,
		["43"] = 58,
		["44"] = 59,
		["45"] = 60,
		["46"] = 61,
		["47"] = 62,
		["49"] = 64,
		["50"] = 44,
		["51"] = 67,
		["52"] = 72,
		["53"] = 72,
		["55"] = 73,
		["56"] = 73,
		["58"] = 76,
		["59"] = 77,
		["60"] = 78,
		["61"] = 79,
		["63"] = 81,
		["64"] = 82,
		["65"] = 83,
		["67"] = 85,
		["69"] = 86,
		["70"] = 87,
		["71"] = 87,
		["73"] = 88,
		["74"] = 89,
		["75"] = 90,
		["76"] = 91,
		["77"] = 92,
		["78"] = 93,
		["79"] = 94,
		["83"] = 98,
		["84"] = 99,
		["87"] = 102,
		["88"] = 103,
		["89"] = 103,
		["90"] = 103,
		["91"] = 103,
		["96"] = 106,
		["97"] = 67,
		["98"] = 109,
		["99"] = 110,
		["100"] = 111,
		["101"] = 111,
		["102"] = 111,
		["104"] = 111,
		["106"] = 111,
		["108"] = 114,
		["109"] = 115,
		["110"] = 116,
		["111"] = 117,
		["112"] = 117,
		["114"] = 117,
		["115"] = 117,
		["117"] = 117,
		["118"] = 118,
		["119"] = 119,
		["120"] = 120,
		["123"] = 123,
		["124"] = 109,
		["125"] = 126,
		["126"] = 127,
		["127"] = 128,
		["129"] = 130,
		["130"] = 131,
		["131"] = 132,
		["133"] = 134,
		["134"] = 126,
		["136"] = 138,
		["137"] = 138,
		["138"] = 138,
		["139"] = 144,
		["140"] = 144,
		["141"] = 139,
		["142"] = 140,
		["143"] = 141,
		["144"] = 142,
		["145"] = 144,
		["146"] = 146,
		["147"] = 147,
		["150"] = 150,
		["151"] = 151,
		["152"] = 151,
		["153"] = 146,
		["154"] = 154,
		["155"] = 155,
		["156"] = 156,
		["157"] = 157,
		["159"] = 159,
		["160"] = 160,
		["161"] = 154,
		["162"] = 163,
		["163"] = 164,
		["164"] = 165,
		["165"] = 166,
		["166"] = 167,
		["167"] = 168,
		["168"] = 169,
		["169"] = 170,
		["170"] = 171,
		["171"] = 171,
		["172"] = 171,
		["173"] = 171,
		["174"] = 171,
		["175"] = 172,
		["179"] = 176,
		["180"] = 177,
		["181"] = 163,
		["182"] = 180,
		["183"] = 181,
		["184"] = 182,
		["185"] = 183,
		["186"] = 184,
		["187"] = 180,
	}
)
local f = {}
function f.findBattleRecordPairEntityIndexes(self, g, h)
	for i in pairs(g) do
		do
			local j = g[i]
			if j.index ~= h then
				goto k
			end
			local l = { j.index }
			local m = g[j.enemy_key]
			if m and m.index ~= j.index then
				l[#l + 1] = m.index
			end
			return l
		end
		::k::
	end
	return {}
end
function f.findBattleRecordEntityIndexesForViewer(self, g, n, o)
	local j = g[(o and "I_" or "P_") .. tostring(n)]
	return j and f.findBattleRecordPairEntityIndexes(nil, g, j.index) or {}
end
function f.findBattleRecordRecipients(self, g, h)
	local p
	local j
	for i in pairs(g) do
		if g[i].index == h then
			p = i
			j = g[i]
			break
		end
	end
	if not j or not p then
		return {}
	end
	local m = g[j.enemy_key]
	local q = j.type == "main" and j or m
	local r = j.type == "custom" and j or m
	if string.sub(p, 1, 1) == "P" and string.sub(j.enemy_key, 1, 1) == "P" then
		return q and r and q.id ~= r.id and { q.id, r.id } or { j.id }
	end
	return { q and q.id or j.id }
end
function f.findBattleRecordSnapshotsForPlayer(self, g, s, t, u, v, w, x)
	if v == nil then
		v = {}
	end
	if w == nil then
		w = {}
	end
	local y = {}
	local z = {}
	for A, h in ipairs(w) do
		z[h] = true
	end
	local B = {}
	for A, h in ipairs(x or {}) do
		B[h] = true
	end
	for i in pairs(s) do
		do
			local h = c(i)
			if x and not B[h] then
				goto C
			end
			local D = u
			if not D then
				local E = f.findBattleRecordRecipients(nil, g, h)
				local F = #E > 0 and E or (v[h] or {})
				for A, G in ipairs(F) do
					if G == t then
						D = true
						break
					end
				end
				if not D and z[h] then
					D = true
				end
			end
			if D then
				y[#y + 1] = { key = i, value = s[c(i)] }
			end
		end
		::C::
	end
	return y
end
local function H(self, j, I)
	if type(j) ~= "table" or j == nil then
		local J
		if j ~= I then
			J = j
		else
			J = nil
		end
		return J
	end
	local K = {}
	local L = false
	for i in pairs(j) do
		local M = H
		local N = j[i]
		local O
		if I ~= nil then
			O = I[i]
		end
		local P = M(nil, N, O)
		if P ~= nil then
			K[i] = P
			L = true
		end
	end
	return L and K or nil
end
local function Q(self, R)
	if type(R) ~= "table" or R == nil then
		return R
	end
	local S = {}
	for i in pairs(R) do
		S[i] = Q(nil, R[i])
	end
	return S
end
f.BattleRecordPublisher = d()
local T = f.BattleRecordPublisher
T.name = "BattleRecordPublisher"
function T.prototype.____constructor(self, U)
	self.transport = U
	self.changedEntities = {}
	self.changedEntityLookup = {}
	self.publishedRecords = {}
	self.lastSnapshotRequestTimes = {}
end
function T.prototype.markChanged(self, h)
	if self.changedEntityLookup[h] then
		return
	end
	self.changedEntityLookup[h] = true
	local V = self.changedEntities
	V[#V + 1] = h
end
function T.prototype.shouldServeSnapshotRequest(self, t, W)
	local X = self.lastSnapshotRequestTimes[t]
	if X ~= nil and W - X < 1 then
		return false
	end
	self.lastSnapshotRequestTimes[t] = W
	return true
end
function T.prototype.publish(self, s)
	for A, h in ipairs(self.changedEntities) do
		local Y = s[h]
		if Y then
			local Z = Y
			local _ = self.publishedRecords[h]
			local a0 = H(nil, Z, _)
			if a0 then
				self.transport:publish(tostring(h), a0, _ and "delta" or "snapshot")
				self.publishedRecords[h] = Q(nil, Z)
			end
		end
	end
	self.changedEntities = {}
	self.changedEntityLookup = {}
end
function T.prototype.reset(self)
	self.changedEntities = {}
	self.changedEntityLookup = {}
	self.publishedRecords = {}
	self.lastSnapshotRequestTimes = {}
end
return f