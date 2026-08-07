--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/card_effect_new"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__New
local g = b.__TS__ArrayForEach
local h = b.__TS__Number
local i = b.__TS__ArraySort
local j = b.__TS__ArrayIncludes
local k = b.__TS__ArrayMap
local l = b.__TS__ArrayFilter
local m = b.__TS__DecorateLegacy
local n = b.__TS__SourceMapTraceBack
n(
	debug.getinfo(1).short_src,
	{
		["16"] = 2,
		["17"] = 2,
		["18"] = 3,
		["19"] = 3,
		["21"] = 6,
		["22"] = 6,
		["23"] = 7,
		["25"] = 7,
		["26"] = 9,
		["27"] = 11,
		["28"] = 13,
		["29"] = 6,
		["30"] = 15,
		["31"] = 16,
		["32"] = 17,
		["34"] = 15,
		["35"] = 42,
		["36"] = 43,
		["37"] = 44,
		["38"] = 45,
		["39"] = 46,
		["40"] = 46,
		["41"] = 47,
		["42"] = 46,
		["43"] = 48,
		["44"] = 46,
		["45"] = 46,
		["46"] = 50,
		["47"] = 51,
		["48"] = 52,
		["49"] = 53,
		["50"] = 54,
		["51"] = 55,
		["52"] = 55,
		["53"] = 56,
		["54"] = 57,
		["56"] = 59,
		["57"] = 42,
		["58"] = 63,
		["59"] = 65,
		["60"] = 65,
		["61"] = 65,
		["62"] = 66,
		["63"] = 65,
		["64"] = 65,
		["65"] = 63,
		["66"] = 69,
		["67"] = 70,
		["68"] = 71,
		["69"] = 72,
		["70"] = 73,
		["72"] = 74,
		["73"] = 75,
		["74"] = 76,
		["77"] = 79,
		["78"] = 79,
		["79"] = 79,
		["80"] = 79,
		["81"] = 80,
		["82"] = 81,
		["85"] = 91,
		["86"] = 92,
		["88"] = 94,
		["89"] = 95,
		["90"] = 95,
		["91"] = 95,
		["92"] = 95,
		["93"] = 96,
		["94"] = 97,
		["95"] = 98,
		["96"] = 99,
		["97"] = 99,
		["98"] = 99,
		["99"] = 100,
		["100"] = 99,
		["101"] = 99,
		["102"] = 102,
		["103"] = 103,
		["106"] = 107,
		["107"] = 108,
		["108"] = 108,
		["109"] = 109,
		["110"] = 110,
		["111"] = 111,
		["112"] = 112,
		["114"] = 114,
		["115"] = 115,
		["119"] = 120,
		["120"] = 121,
		["122"] = 123,
		["123"] = 123,
		["124"] = 123,
		["125"] = 123,
		["129"] = 69,
		["130"] = 127,
		["131"] = 128,
		["132"] = 129,
		["133"] = 129,
		["134"] = 129,
		["135"] = 130,
		["136"] = 129,
		["137"] = 129,
		["138"] = 135,
		["139"] = 135,
		["140"] = 135,
		["141"] = 135,
		["142"] = 135,
		["144"] = 137,
		["145"] = 138,
		["146"] = 138,
		["147"] = 138,
		["148"] = 139,
		["149"] = 138,
		["150"] = 138,
		["151"] = 144,
		["152"] = 144,
		["153"] = 144,
		["154"] = 144,
		["155"] = 144,
		["156"] = 137,
		["158"] = 127,
		["159"] = 153,
		["160"] = 154,
		["161"] = 155,
		["163"] = 157,
		["164"] = 158,
		["165"] = 158,
		["166"] = 158,
		["167"] = 158,
		["169"] = 160,
		["170"] = 153,
		["171"] = 164,
		["172"] = 165,
		["173"] = 166,
		["174"] = 166,
		["175"] = 166,
		["176"] = 167,
		["177"] = 166,
		["178"] = 166,
		["180"] = 170,
		["181"] = 171,
		["182"] = 172,
		["183"] = 173,
		["184"] = 164,
		["185"] = 6,
		["186"] = 181,
		["187"] = 182,
	}
)
local o = {}
local p = require("class.weight_pool")
local q = p.CWeightPool
local r = require("lib.tstl-utils")
local s = r.reloadable
local t = c()
t.name = "CCardEffectNew"
d(t, CModule)
function t.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.cardPool = {}
	self.shopCardEffect = {}
	self.playerCardEffect = {}
end
function t.prototype.init(self, u)
	if not u then
		self:reset()
	end
end
function t.prototype.newEffectCard(self, v, w)
	local x
	local y = KeyValues.CardEffectKV[w].ScriptFile
	local z
	xpcall(function()
		z = require(y)
	end, function(A) end)
	local B = e(y, "/card_effect/")[2]
	if z and z[B] then
		z = z[B]
		x = f(z, v, w)
		self.playerCardEffect[v] = self.playerCardEffect[v] or {}
		local C = self.playerCardEffect[v]
		C[#C + 1] = x
		x:spawn()
		self:updateNetList(v)
	end
	return x
end
function t.prototype.resetCardPool(self, D)
	g(PlayerData:getAlivePlayerIDList(), function(E, v)
		self:_resetCardPool(v, D)
	end)
end
function t.prototype._resetCardPool(self, v, D)
	local F = Rounds:getCurrentRound()
	self.cardPool[v] = f(q, {})
	local G = PlayerData:getHero(v)
	for H, I in pairs(KeyValues.CardEffectKV) do
		do
			if type(I.AppearRound) == "number" then
				if F < I.AppearRound then
					goto J
				end
			else
				local K = e(tostring(I.AppearRound), "-")
				if not (#K == 2 and (F > h(K[1]) and F <= h(K[2]))) then
					goto J
				end
			end
			if I.Limit ~= nil and self:getPlayerCardCount(v, H) >= I.Limit then
				goto J
			end
			if I.Condition ~= nil then
				local L = e(tostring(I.Condition), ",")
				local M = L[1]
				local N = L[2]
				if M == "max_level" then
					local O = i(shallowcopy(AbilityShop.pickList), function(E, P, Q)
						return G:getSectLevel(Q) - G:getSectLevel(P)
					end)[1]
					if O ~= N then
						goto J
					end
				end
				if M == "hero_sect" then
					local R = PlayerData:getplayerData(v)
					local S = R and R.heroName
					local T = AbilityShop:GetRecommendSectByHeroName(S)
					local U
					if T ~= "sect_none" then
						U = e(T, "|")
					end
					if not U or not j(U, N) then
						goto J
					end
				end
			end
			if I.Sect ~= nil and not j(AbilityShop.pickList, I.Sect) then
				goto J
			end
			self.cardPool[v]:set(H, tonumber(I.Weight))
		end
		::J::
	end
end
function t.prototype.updateNetList(self, v)
	if v then
		local V = k(self.playerCardEffect[v] or {}, function(E, I)
			return { cardName = I.cardName, round = I.round }
		end)
		CustomNetTables:SetTableValue("common", "card_effect_list_" .. tostring(v), V)
	else
		PlayerData:eachPlayer(function(E, W, v)
			local V = k(self.playerCardEffect[v] or {}, function(E, I)
				return { cardName = I.cardName, round = I.round }
			end)
			CustomNetTables:SetTableValue("common", "card_effect_list_" .. tostring(v), V)
		end)
	end
end
function t.prototype.getPlayerCardCount(self, v, w)
	if self.playerCardEffect[v] == nil then
		return 0
	end
	if w then
		return #l(self.playerCardEffect[v], function(E, I)
			return I.cardName == w
		end)
	end
	return #self.playerCardEffect[v]
end
function t.prototype.reset(self)
	for H, I in pairs(self.playerCardEffect) do
		g(I, function(E, I)
			I:dispose()
		end)
	end
	self.cardPool = {}
	self.shopCardEffect = {}
	self.playerCardEffect = {}
	self:updateNetList()
end
t = m({ s }, t)
if _G.CardEffectNew == nil then
	_G.CardEffectNew = f(t)
end
return o