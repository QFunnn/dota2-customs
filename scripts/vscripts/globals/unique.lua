--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "globals/unique"
local b = require("lualib_bundle")
local c = b.__TS__ArraySplice
local d = b.__TS__ArrayConcat
local e = b.__TS__ArraySort
local f = b.__TS__StringSplit
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 217,
		["10"] = 218,
		["11"] = 219,
		["12"] = 220,
		["14"] = 222,
		["15"] = 223,
		["17"] = 225,
		["18"] = 217,
		["19"] = 1,
		["20"] = 2,
		["21"] = 3,
		["22"] = 6,
		["23"] = 7,
		["24"] = 8,
		["26"] = 9,
		["27"] = 9,
		["28"] = 10,
		["29"] = 11,
		["30"] = 12,
		["31"] = 13,
		["33"] = 9,
		["36"] = 16,
		["37"] = 17,
		["38"] = 18,
		["41"] = 6,
		["42"] = 22,
		["43"] = 23,
		["45"] = 27,
		["46"] = 28,
		["47"] = 29,
		["49"] = 31,
		["50"] = 32,
		["51"] = 33,
		["52"] = 34,
		["53"] = 35,
		["54"] = 36,
		["55"] = 38,
		["56"] = 40,
		["57"] = 41,
		["58"] = 42,
		["59"] = 43,
		["60"] = 44,
		["61"] = 45,
		["63"] = 47,
		["64"] = 48,
		["65"] = 1,
		["67"] = 52,
		["68"] = 53,
		["69"] = 54,
		["70"] = 55,
		["71"] = 56,
		["73"] = 57,
		["74"] = 52,
		["75"] = 60,
		["76"] = 61,
		["77"] = 62,
		["78"] = 63,
		["79"] = 64,
		["81"] = 66,
		["83"] = 69,
		["84"] = 70,
		["85"] = 71,
		["86"] = 72,
		["88"] = 74,
		["89"] = 74,
		["90"] = 76,
		["91"] = 77,
		["93"] = 79,
		["95"] = 74,
		["98"] = 82,
		["99"] = 82,
		["100"] = 82,
		["101"] = 82,
		["102"] = 82,
		["103"] = 60,
		["104"] = 85,
		["105"] = 86,
		["106"] = 86,
		["107"] = 86,
		["108"] = 86,
		["109"] = 87,
		["110"] = 87,
		["111"] = 87,
		["112"] = 87,
		["113"] = 87,
		["114"] = 86,
		["115"] = 86,
		["116"] = 90,
		["117"] = 85,
		["118"] = 93,
		["119"] = 94,
		["120"] = 95,
		["121"] = 96,
		["122"] = 97,
		["124"] = 99,
		["126"] = 102,
		["127"] = 103,
		["128"] = 104,
		["129"] = 105,
		["131"] = 107,
		["132"] = 107,
		["133"] = 109,
		["134"] = 110,
		["136"] = 112,
		["138"] = 107,
		["141"] = 115,
		["142"] = 115,
		["143"] = 115,
		["144"] = 115,
		["145"] = 115,
		["146"] = 93,
		["147"] = 118,
		["148"] = 119,
		["150"] = 120,
		["151"] = 120,
		["152"] = 121,
		["153"] = 120,
		["156"] = 123,
		["157"] = 123,
		["158"] = 123,
		["159"] = 123,
		["160"] = 124,
		["161"] = 118,
		["163"] = 128,
		["164"] = 129,
		["165"] = 128,
		["167"] = 132,
		["168"] = 133,
		["169"] = 132,
		["171"] = 150,
		["173"] = 154,
		["174"] = 155,
		["175"] = 155,
		["177"] = 156,
		["178"] = 157,
		["179"] = 158,
		["180"] = 159,
		["181"] = 159,
		["182"] = 159,
		["183"] = 159,
		["184"] = 160,
		["186"] = 162,
		["187"] = 163,
		["189"] = 165,
		["190"] = 166,
		["191"] = 167,
		["192"] = 168,
		["193"] = 169,
		["194"] = 169,
		["195"] = 169,
		["196"] = 169,
		["199"] = 173,
		["200"] = 174,
		["201"] = 175,
		["203"] = 178,
		["204"] = 179,
		["205"] = 180,
		["207"] = 182,
		["209"] = 184,
		["210"] = 185,
		["211"] = 185,
		["212"] = 185,
		["213"] = 185,
		["214"] = 186,
		["216"] = 188,
		["218"] = 154,
		["220"] = 193,
		["221"] = 194,
		["222"] = 193,
		["224"] = 197,
		["225"] = 198,
		["226"] = 197,
		["228"] = 209,
		["229"] = 210,
		["230"] = 209,
		["232"] = 213,
		["233"] = 214,
		["234"] = 213,
		["236"] = 228,
		["237"] = 229,
		["238"] = 228,
		["240"] = 233,
		["241"] = 234,
		["242"] = 233,
	}
)
function IsGroupMode(self)
	if GetMapName() == "tournament_map" then
		if IsServer() then
			return Match.tournamentGroupMode
		end
		local h = CustomNetTables:GetTableValue("common", "tournament_group_mode")
		return (h and h.enabled) == 1
	end
	return GetMapName() == "2v2v2v2"
end
function G_Reset(self)
	SyncEntity:StopPing()
	GameState:resetToGameStateNone()
	PlayerData:eachPlayer(function(i, j, k)
		local l = PlayerResource:GetSelectedHeroEntity(k)
		if IsValid(l) then
			do
				local m = DOTA_ITEM_SLOT_1
				while m < DOTA_ITEM_SLOT_9 do
					local n = l:GetItemInSlot(m)
					if IsValid(n) then
						l:TakeItem(n)
						n:Remove()
					end
					m = m + 1
				end
			end
			local o = l:FindModifierByName("modifier_courier")
			if IsValid(o) then
				o:SetStackCount(0)
			end
		end
	end)
	if GAMEPLAY_MODULE_LIST.rune_task then
		RuneTask:reset()
	end
	CardEffect:reset()
	if GAMEPLAY_MODULE_LIST.city_effect then
		CityEffect:reset()
	end
	Rounds:reset()
	AbilityShop:reset()
	Match:reset()
	CombatLog:reset()
	Roshan:reset()
	MatchBattleNew:reset()
	UIBattleInfo:reset()
	AbilityUpgrades:reset()
	Selection:reset()
	PlayerData:reset()
	Greevil:reset()
	if IsGroupMode(nil) then
		GroupTeam:reset()
	end
	CustomNetTables:SetTableValue("common", "battle_data", {})
	CustomNetTables:SetTableValue("common", "neutral_data", {})
end
function stringCompare(self, p, q)
	if #p > #q then
		return true
	elseif #p == #q then
		return p > q
	end
	return false
end
function quickSort(self, r, s)
	if #r <= 1 then
		local t = {}
		for i, u in ipairs(r) do
			t[#t + 1] = u
		end
		return t
	end
	local v = math.floor(#r / 2)
	local w = c(r, v, 1)[1]
	local x = {}
	local y = {}
	do
		local z = 0
		while z < #r do
			if s(nil, r[z + 1], w) then
				x[#x + 1] = r[z + 1]
			else
				y[#y + 1] = r[z + 1]
			end
			z = z + 1
		end
	end
	return d(quickSort(nil, x, s), { w }, quickSort(nil, y, s))
end
function copyAndSort(self, A)
	local t = quickSort(nil, A, function(i, p, q)
		return stringCompare(nil, p:GetName(), q:GetName())
	end)
	return t
end
function quickSortStrings(self, r)
	if #r <= 1 then
		local t = {}
		for i, u in ipairs(r) do
			t[#t + 1] = u
		end
		return t
	end
	local v = math.floor(#r / 2)
	local w = c(r, v, 1)[1]
	local x = {}
	local y = {}
	do
		local z = 0
		while z < #r do
			if stringCompare(nil, r[z + 1], w) then
				x[#x + 1] = r[z + 1]
			else
				y[#y + 1] = r[z + 1]
			end
			z = z + 1
		end
	end
	return d(quickSortStrings(nil, x), { w }, quickSortStrings(nil, y))
end
function StringKeysToNumberKeys(self, B)
	local C = {}
	do
		local z = 0
		while z < #B do
			C[#C + 1] = B[z + 1]
			z = z + 1
		end
	end
	e(C, function(i, p, q)
		return p > q and 1 or (p == q and 0 or -1)
	end)
	return C
end
function HeroIDToName(self, D)
	return KeyValues.HeroIDCache[D]
end
function NameToHeroID(self, E)
	return KeyValues.CommonUnitsKv[E].Hid
end
addedValueFunctionMap = {}
function GetAbilityValues(self, F, G, H, I)
	if G == 0 or F == nil then
		return I or 0
	end
	local J = I
	if type(F) == "table" then
		if J == nil then
			local K = f(tostring(IsTurboMode(nil) and (F._turbo or F.value) or F.value), " ")
			J = tonumber(K[math.min(G, #K)])
		end
		if H == nil then
			return J
		end
		for L, M in pairs(F) do
			local M = F[L]
			if addedValueFunctionMap[L] then
				local N = _G[addedValueFunctionMap[L]]
				J = J + toFiniteNumber(N(H) * M, 0)
			end
		end
		local O = F._ulti
		if O and O > 0 then
			J = J * (1 + GetUltiPower(H) * 0.01)
		end
		local P = F._wisp_interval
		if P and P > 0 then
			J = J - GetModifierProperty(H, EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_INTERVAL)
		end
		return J
	else
		if J == nil then
			local K = f(tostring(F), " ")
			J = tonumber(K[math.min(G, #K)])
		end
		return J
	end
end
function IsRankMode(self)
	return GetMapName() == "junior_rank_1"
		or GetMapName() == "senior_rank_2"
		or GetMapName() == "rank_3"
		or GetMapName() == "rank_map"
end
function IsCompetitionMode(self)
	return GetMapName() == "tournament_map"
end
function IsKingsRankMode(self)
	return GetMapName() == "peak_arena"
end
function IsCasualMode(self)
	return GetMapName() == "casual_map"
end
function IsCompetitionBanRune(self)
	return false
end
function getGameplayModuleState(self, Q)
	return GAMEPLAY_MODULE_LIST[Q]
end