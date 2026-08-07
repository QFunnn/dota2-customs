--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/city_effect"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ArrayIncludes
local g = b.__TS__ArrayForEach
local h = b.__TS__DecorateLegacy
local i = b.__TS__New
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 1,
		["13"] = 1,
		["15"] = 6,
		["16"] = 6,
		["17"] = 7,
		["19"] = 7,
		["20"] = 9,
		["21"] = 29,
		["22"] = 6,
		["23"] = 31,
		["24"] = 32,
		["25"] = 33,
		["26"] = 34,
		["27"] = 35,
		["28"] = 36,
		["29"] = 37,
		["31"] = 40,
		["32"] = 41,
		["33"] = 31,
		["34"] = 43,
		["35"] = 44,
		["36"] = 45,
		["37"] = 47,
		["38"] = 48,
		["40"] = 49,
		["41"] = 50,
		["42"] = 51,
		["45"] = 63,
		["46"] = 64,
		["47"] = 65,
		["48"] = 66,
		["49"] = 67,
		["50"] = 65,
		["51"] = 69,
		["52"] = 65,
		["53"] = 65,
		["55"] = 72,
		["56"] = 73,
		["57"] = 74,
		["58"] = 75,
		["59"] = 76,
		["61"] = 78,
		["62"] = 78,
		["65"] = 81,
		["66"] = 82,
		["67"] = 83,
		["68"] = 84,
		["69"] = 85,
		["70"] = 86,
		["71"] = 87,
		["72"] = 88,
		["74"] = 90,
		["78"] = 94,
		["79"] = 95,
		["81"] = 97,
		["89"] = 43,
		["90"] = 104,
		["91"] = 105,
		["94"] = 106,
		["95"] = 107,
		["97"] = 109,
		["98"] = 110,
		["100"] = 112,
		["101"] = 113,
		["102"] = 113,
		["103"] = 113,
		["104"] = 113,
		["105"] = 113,
		["106"] = 113,
		["107"] = 113,
		["108"] = 113,
		["109"] = 113,
		["110"] = 122,
		["112"] = 104,
		["113"] = 125,
		["114"] = 125,
		["115"] = 125,
		["117"] = 126,
		["118"] = 127,
		["119"] = 128,
		["120"] = 129,
		["121"] = 130,
		["122"] = 130,
		["123"] = 130,
		["125"] = 130,
		["127"] = 132,
		["128"] = 133,
		["129"] = 133,
		["130"] = 133,
		["131"] = 133,
		["132"] = 134,
		["133"] = 135,
		["134"] = 136,
		["135"] = 137,
		["138"] = 140,
		["139"] = 125,
		["140"] = 144,
		["141"] = 144,
		["142"] = 144,
		["144"] = 145,
		["147"] = 146,
		["150"] = 149,
		["151"] = 150,
		["152"] = 151,
		["153"] = 152,
		["155"] = 144,
		["156"] = 156,
		["157"] = 157,
		["158"] = 156,
		["159"] = 160,
		["160"] = 161,
		["161"] = 162,
		["163"] = 164,
		["164"] = 165,
		["165"] = 160,
		["166"] = 167,
		["167"] = 168,
		["168"] = 169,
		["170"] = 171,
		["171"] = 172,
		["173"] = 174,
		["174"] = 175,
		["175"] = 176,
		["176"] = 177,
		["177"] = 178,
		["178"] = 179,
		["179"] = 179,
		["180"] = 179,
		["181"] = 179,
		["182"] = 179,
		["183"] = 179,
		["184"] = 179,
		["185"] = 179,
		["186"] = 179,
		["187"] = 180,
		["188"] = 181,
		["190"] = 167,
		["191"] = 185,
		["192"] = 186,
		["193"] = 187,
		["194"] = 188,
		["195"] = 188,
		["196"] = 188,
		["197"] = 189,
		["198"] = 189,
		["199"] = 189,
		["200"] = 189,
		["201"] = 189,
		["202"] = 189,
		["203"] = 189,
		["204"] = 189,
		["205"] = 190,
		["206"] = 190,
		["207"] = 190,
		["208"] = 190,
		["209"] = 190,
		["210"] = 190,
		["211"] = 190,
		["212"] = 190,
		["213"] = 191,
		["214"] = 194,
		["215"] = 194,
		["216"] = 188,
		["217"] = 188,
		["218"] = 185,
		["219"] = 206,
		["220"] = 207,
		["221"] = 207,
		["222"] = 207,
		["223"] = 208,
		["224"] = 209,
		["226"] = 207,
		["227"] = 207,
		["228"] = 212,
		["229"] = 206,
		["230"] = 221,
		["231"] = 222,
		["234"] = 223,
		["235"] = 221,
		["236"] = 228,
		["237"] = 228,
		["238"] = 228,
		["240"] = 229,
		["243"] = 230,
		["244"] = 231,
		["245"] = 232,
		["246"] = 233,
		["247"] = 234,
		["248"] = 235,
		["249"] = 235,
		["250"] = 235,
		["251"] = 236,
		["252"] = 237,
		["254"] = 235,
		["255"] = 235,
		["258"] = 242,
		["259"] = 243,
		["260"] = 244,
		["261"] = 245,
		["262"] = 245,
		["263"] = 245,
		["264"] = 246,
		["265"] = 247,
		["267"] = 245,
		["268"] = 245,
		["271"] = 228,
		["272"] = 253,
		["273"] = 254,
		["276"] = 255,
		["277"] = 253,
		["278"] = 258,
		["279"] = 258,
		["280"] = 258,
		["282"] = 259,
		["283"] = 260,
		["284"] = 260,
		["285"] = 261,
		["286"] = 262,
		["288"] = 258,
		["289"] = 266,
		["290"] = 266,
		["291"] = 266,
		["293"] = 267,
		["294"] = 268,
		["295"] = 269,
		["296"] = 269,
		["297"] = 270,
		["298"] = 271,
		["300"] = 266,
		["301"] = 274,
		["302"] = 275,
		["303"] = 276,
		["304"] = 276,
		["305"] = 276,
		["306"] = 276,
		["307"] = 276,
		["309"] = 278,
		["310"] = 279,
		["311"] = 279,
		["312"] = 279,
		["313"] = 279,
		["314"] = 279,
		["317"] = 274,
		["318"] = 283,
		["319"] = 284,
		["320"] = 285,
		["321"] = 285,
		["322"] = 285,
		["323"] = 285,
		["324"] = 285,
		["326"] = 287,
		["327"] = 288,
		["328"] = 288,
		["329"] = 288,
		["330"] = 288,
		["331"] = 288,
		["334"] = 283,
		["335"] = 292,
		["336"] = 293,
		["337"] = 294,
		["338"] = 295,
		["339"] = 296,
		["341"] = 298,
		["342"] = 299,
		["344"] = 301,
		["345"] = 302,
		["346"] = 303,
		["347"] = 304,
		["348"] = 305,
		["349"] = 306,
		["350"] = 307,
		["351"] = 308,
		["353"] = 292,
		["354"] = 6,
		["355"] = 317,
		["356"] = 318,
	}
)
local k = {}
local l = require("lib.tstl-utils")
local m = l.reloadable
local n = c()
n.name = "CCityEffect"
d(n, CModule)
function n.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.cityEffectDummy = { thinker = nil, buff = nil }
	self.Origin = Vector(-1184, 960, 0)
end
function n.prototype.init(self, o)
	if not o then
		self.player_extra_ability_data = {}
		self.player_extra_data = {}
		self.PlayerSelectionData = {}
		self.cityEffect = ""
		self.cityAreaThinkerList = {}
	end
	self:initKV()
	self:reloadScripts()
end
function n.prototype.initKV(self)
	self.cityAbilityValues = {}
	self.cityLandList = {}
	local p = IsCasualMode(nil)
	for q, r in pairs(KeyValues.CityEffectKV) do
		do
			if p then
				if q == "city_20" then
					goto s
				end
			end
			if r.ScriptFile then
				local t = r.ScriptFile
				xpcall(function()
					require(t)
				end, function() end)
			end
			if r.IsHidden ~= 1 then
				local u = r.LandType
				if u then
					if self.cityLandList[u] == nil then
						self.cityLandList[u] = {}
					end
					local v = self.cityLandList[u]
					v[#v + 1] = q
				end
			end
			if type(r.AbilityValues) == "table" then
				self.cityAbilityValues[q] = {}
				for w, x in pairs(r.AbilityValues) do
					if type(x) == "table" then
						self.cityAbilityValues[q][w] = {}
						for y, z in pairs(x) do
							if type(z) == "number" then
								self.cityAbilityValues[q][w][y] = Round(z, 5)
							else
								self.cityAbilityValues[q][w][y] = z
							end
						end
					else
						if type(x) == "number" then
							self.cityAbilityValues[q][w] = Round(x, 5)
						else
							self.cityAbilityValues[q][w] = x
						end
					end
				end
			end
		end
		::s::
	end
end
function n.prototype.reloadScripts(self)
	if not IsServer() then
		return
	end
	if IsValid(self.cityEffectDummy.buff) then
		self.cityEffectDummy.buff:Destroy()
	end
	if IsValid(self.cityEffectDummy.thinker) then
		self.cityEffectDummy.thinker:RemoveSelf()
	end
	if self.cityEffect and KeyValues.CityEffectKV[self.cityEffect] then
		self.cityEffectDummy.thinker = CreateModifierThinker(
			not IsDedicatedServer() and GameRules:GetGameModeEntity() or nil,
			nil,
			"modifier_" .. self.cityEffect,
			nil,
			Vector(0, 0, 0),
			DOTA_TEAM_NOTEAM,
			false
		)
		self.cityEffectDummy.buff = self.cityEffectDummy.thinker:FindModifierByName("modifier_" .. self.cityEffect)
	end
end
function n.prototype.GetSpecialValueFor(self, A, B, C)
	if C == nil then
		C = 1
	end
	local D = 0
	if self.cityAbilityValues[A] ~= nil and self.cityAbilityValues[A][B] ~= nil then
		local E = self.cityAbilityValues[A][B]
		if type(self.cityAbilityValues[A][B]) == "table" then
			local F = self.cityAbilityValues[A][B].value
			if F == nil then
				F = 0
			end
			E = F
		end
		if type(E) == "string" then
			local G = e(tostring(E), " ")
			local H = Clamp(C - 1, 0, #G - 1)
			D = tonumber(G[H + 1])
		elseif type(E) == "number" then
			D = E
		end
	end
	return D
end
function n.prototype.setCityEffect(self, I, J)
	if J == nil then
		J = true
	end
	if not IsServer() then
		return
	end
	if type(I) ~= "string" or KeyValues.CityEffectKV[I] == nil then
		return
	end
	self.cityEffect = I
	self:updateNetTable()
	if J then
		self:createCityEffect()
	end
end
function n.prototype.getCityEffect(self)
	return self.cityEffect
end
function n.prototype.IsExtraArtifactRound(self, K)
	if not self.cityEffect or self.cityEffect ~= "city_31" then
		return false
	end
	local L = self.cityEffectDummy.buff
	return f(L.rounds, K)
end
function n.prototype.createCityEffect(self)
	if IsValid(self.cityEffectDummy.buff) then
		self.cityEffectDummy.buff:Destroy()
	end
	if IsValid(self.cityEffectDummy.thinker) then
		self.cityEffectDummy.thinker:RemoveSelf()
	end
	if self.cityEffect then
		self.player_extra_ability_data = {}
		self.player_extra_data = {}
		self:updateCityEffectAbilitiesNetTable(nil, true)
		self:updateCityEffectExtraDataNetTable(nil, true)
		self.cityEffectDummy.thinker = CreateModifierThinker(
			nil,
			nil,
			"modifier_" .. self.cityEffect,
			nil,
			Vector(0, 0, 0),
			DOTA_TEAM_NOTEAM,
			false
		)
		self.cityEffectDummy.buff = self.cityEffectDummy.thinker:FindModifierByName("modifier_" .. self.cityEffect)
		self:updateNetTable()
	end
end
function n.prototype.createCitySelectionArea(self, M)
	self:destoryCitySelectionArea()
	local N = PlayerResource:GetSelectedHeroEntity(0)
	g(M, function(O, P, Q)
		local R = GetGroundPosition(self.Origin + Rotation2D(nil, vec3_top, math.rad(Q / #M * 360)) * 400, nil)
		local S = CreateUnitByName("npc_dota_dummy", R, false, nil, nil, DOTA_TEAM_NOTEAM)
		local T = S:AddNewModifier(S, nil, "modifier_city_selection_area", { cityName = P })
		local U = self.cityAreaThinkerList
		U[#U + 1] = { thinker = S, buff = T, city_name = P }
	end)
end
function n.prototype.destoryCitySelectionArea(self)
	g(self.cityAreaThinkerList, function(O, V)
		if IsValid(V.thinker) then
			V.thinker:RemoveSelf()
		end
	end)
	self.cityAreaThinkerList = {}
end
function n.prototype.updateNetTable(self)
	if not IsServer() then
		return
	end
	CustomNetTables:SetTableValue("common", "city_effect", { name = self.cityEffect })
end
function n.prototype.setPlayerCitySelection(self, W, X, Y)
	if Y == nil then
		Y = true
	end
	if not IsServer() then
		return
	end
	if Y then
		if self.PlayerSelectionData[W] ~= X then
			local Z = self.PlayerSelectionData[W]
			self.PlayerSelectionData[W] = X
			self:updatePlayerSelectionNetTable()
			g(self.cityAreaThinkerList, function(O, V)
				if (V.city_name == X or V.city_name == Z) and IsValid(V.buff) then
					V.buff:OnPlayerChangeSelection()
				end
			end)
		end
	else
		if self.PlayerSelectionData[W] == X then
			self.PlayerSelectionData[W] = nil
			self:updatePlayerSelectionNetTable()
			g(self.cityAreaThinkerList, function(O, V)
				if V.city_name == X and IsValid(V.buff) then
					V.buff:OnPlayerChangeSelection()
				end
			end)
		end
	end
end
function n.prototype.updatePlayerSelectionNetTable(self)
	if not IsServer() then
		return
	end
	CustomNetTables:SetTableValue("common", "player_city_selection", self.PlayerSelectionData)
end
function n.prototype.addCityEffectAbilites(self, W, _, a0)
	if a0 == nil then
		a0 = true
	end
	self.player_extra_ability_data[W] = self.player_extra_ability_data[W] or {}
	local a1 = self.player_extra_ability_data[W]
	a1[#a1 + 1] = _
	if a0 then
		self:updateCityEffectAbilitiesNetTable(W)
	end
end
function n.prototype.modifyCityEffectExtraData(self, W, B, D, a0)
	if a0 == nil then
		a0 = true
	end
	self.player_extra_data[W] = self.player_extra_data[W] or {}
	self.player_extra_data[W][B] = self.player_extra_data[W][B] or 0
	local a2, a3 = self.player_extra_data[W], B
	a2[a3] = a2[a3] + D
	if a0 then
		self:updateCityEffectExtraDataNetTable(W)
	end
end
function n.prototype.updateCityEffectAbilitiesNetTable(self, W, a4)
	if W ~= nil then
		CustomNetTables:SetTableValue(
			"player_extra_data",
			"city_abilities_" .. tostring(W),
			a4 and {} or self.player_extra_ability_data[W]
		)
	else
		for a5, r in pairs(self.player_extra_ability_data) do
			CustomNetTables:SetTableValue(
				"player_extra_data",
				"city_abilities_" .. tostring(a5),
				a4 and {} or self.player_extra_ability_data[a5]
			)
		end
	end
end
function n.prototype.updateCityEffectExtraDataNetTable(self, W, a4)
	if W ~= nil then
		CustomNetTables:SetTableValue(
			"player_extra_data",
			"city_extra_data_" .. tostring(W),
			a4 and {} or self.player_extra_data[W]
		)
	else
		for a5, r in pairs(self.player_extra_data) do
			CustomNetTables:SetTableValue(
				"player_extra_data",
				"city_extra_data_" .. tostring(a5),
				a4 and {} or self.player_extra_data[a5]
			)
		end
	end
end
function n.prototype.reset(self)
	if IsServer() then
		self:destoryCitySelectionArea()
		if IsValid(self.cityEffectDummy.buff) then
			self.cityEffectDummy.buff:Destroy()
		end
		if IsValid(self.cityEffectDummy.thinker) then
			self.cityEffectDummy.thinker:RemoveSelf()
		end
		self.PlayerSelectionData = {}
		self.cityEffect = ""
		self:updatePlayerSelectionNetTable()
		self:updateNetTable()
		self:updateCityEffectAbilitiesNetTable(nil, true)
		self:updateCityEffectExtraDataNetTable(nil, true)
		self.player_extra_ability_data = {}
		self.player_extra_data = {}
	end
end
n = h({ m }, n)
if _G.CityEffect == nil then
	_G.CityEffect = i(n)
end
return k