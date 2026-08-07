--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_8"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ArrayForEach
local g = b.__TS__DecorateLegacy
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 4,
		["16"] = 12,
		["17"] = 4,
		["18"] = 12,
		["20"] = 12,
		["21"] = 13,
		["22"] = 4,
		["23"] = 16,
		["24"] = 17,
		["25"] = 18,
		["26"] = 16,
		["27"] = 20,
		["28"] = 21,
		["29"] = 20,
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 30,
		["35"] = 31,
		["36"] = 32,
		["37"] = 33,
		["39"] = 35,
		["41"] = 37,
		["42"] = 41,
		["43"] = 41,
		["44"] = 41,
		["45"] = 41,
		["46"] = 41,
		["47"] = 41,
		["48"] = 41,
		["49"] = 42,
		["50"] = 43,
		["51"] = 48,
		["52"] = 41,
		["53"] = 41,
		["54"] = 28,
		["56"] = 25,
		["57"] = 53,
		["58"] = 54,
		["59"] = 55,
		["60"] = 56,
		["61"] = 57,
		["62"] = 58,
		["63"] = 59,
		["64"] = 60,
		["65"] = 60,
		["68"] = 55,
		["70"] = 53,
		["71"] = 66,
		["72"] = 67,
		["73"] = 68,
		["74"] = 68,
		["75"] = 68,
		["76"] = 69,
		["77"] = 70,
		["79"] = 68,
		["80"] = 68,
		["82"] = 66,
		["83"] = 12,
		["84"] = 4,
		["85"] = 4,
		["86"] = 4,
		["87"] = 4,
		["88"] = 4,
		["89"] = 4,
		["90"] = 4,
		["91"] = 4,
		["92"] = 12,
		["94"] = 12,
		["95"] = 78,
		["96"] = 86,
		["97"] = 78,
		["98"] = 86,
		["99"] = 93,
		["100"] = 94,
		["101"] = 95,
		["102"] = 93,
		["103"] = 97,
		["104"] = 98,
		["105"] = 99,
		["106"] = 100,
		["107"] = 101,
		["108"] = 101,
		["109"] = 102,
		["110"] = 103,
		["111"] = 104,
		["112"] = 105,
		["114"] = 107,
		["116"] = 109,
		["118"] = 97,
		["119"] = 112,
		["120"] = 113,
		["121"] = 114,
		["122"] = 114,
		["123"] = 113,
		["124"] = 112,
		["125"] = 118,
		["126"] = 119,
		["127"] = 118,
		["128"] = 121,
		["129"] = 122,
		["130"] = 121,
		["131"] = 126,
		["132"] = 127,
		["135"] = 130,
		["136"] = 131,
		["137"] = 132,
		["138"] = 133,
		["139"] = 133,
		["140"] = 134,
		["141"] = 135,
		["142"] = 136,
		["143"] = 137,
		["144"] = 138,
		["146"] = 140,
		["148"] = 142,
		["149"] = 143,
		["150"] = 147,
		["152"] = 148,
		["153"] = 148,
		["154"] = 149,
		["155"] = 150,
		["156"] = 155,
		["157"] = 148,
		["160"] = 157,
		["161"] = 126,
		["162"] = 86,
		["163"] = 78,
		["164"] = 78,
		["165"] = 78,
		["166"] = 78,
		["167"] = 78,
		["168"] = 78,
		["169"] = 78,
		["170"] = 78,
		["171"] = 86,
		["173"] = 86,
	}
)
local i = {}
local j = require("modifiers.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
local m = require("modifiers.city_effect.city_effect_modifier")
local n = m.CityEffectModifier
i.modifier_city_8 = c()
local o = i.modifier_city_8
o.name = "modifier_city_8"
d(o, n)
function o.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.modifierList = {}
end
function o.prototype.GetAbilitySpecialValue(self)
	self.r_count = self:GetAbilitySpecialValueFor("r_count")
	self.round = self:GetAbilitySpecialValueFor("round")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self, p)
	local q = Rounds:getCurrentRound()
	if q % self.round == 0 then
		PlayerData:eachAlivePlayerHero(function(r, s, t)
			local u = AbilityShop:GetRecommendSectByHeroName(s.unitName)
			local v = {}
			if u ~= "sect_none" then
				v = e(u, "|")
			else
				v = AbilityShop.pickList
			end
			local w = AbilityShop:getRandomAbility(t, self.r_count, { specifySect = v, isAbilityShop = false })
			f(w, function(r, x, y)
				local z
				local A
				A = x.aid
				z = x.rarity
				s:learnAbility(A, true)
				Notification:combatToPlayer(
					t,
					{
						message = "notify_artifact_ability_" .. z,
						string_itemname_artifact = "DOTA_Tooltip_ability_city_8",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. A,
					}
				)
				CityEffect:addCityEffectAbilites(t, A, y == #w - 1)
			end)
		end)
	end
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		PlayerData:eachPlayer(function(r, B)
			local C = PlayerResource:GetSelectedHeroEntity(B.playerID)
			if IsValid(C) then
				local D = C:AddNewModifier(C, nil, "modifier_city_8_buff", nil)
				if IsValid(D) then
					local E = self.modifierList
					E[#E + 1] = D
				end
			end
		end)
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		f(self.modifierList, function(r, F)
			if IsValid(F) then
				F:Destroy()
			end
		end)
	end
end
o = g(
	{
		l(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	o
)
i.modifier_city_8 = o
i.modifier_city_8_buff = c()
local G = i.modifier_city_8_buff
G.name = "modifier_city_8_buff"
d(G, k)
function G.prototype.GetAbilitySpecialValue(self)
	self.count = CityEffect:GetSpecialValueFor("city_8", "count")
	self.card = CityEffect:GetSpecialValueFor("city_8", "card")
end
function G.prototype.OnCreated(self, p)
	if IsServer() then
		self.record = 0
		local t = self:GetParent():GetPlayerOwnerID()
		local H = PlayerData:getplayerData(t)
		local I = H and H.heroName
		local u = AbilityShop:GetRecommendSectByHeroName(I)
		local v = {}
		if u ~= "sect_none" then
			v = e(u, "|")
		else
			v = AbilityShop.pickList
		end
		self.sect = v[RandomInt(0, #v - 1) + 1]
	end
end
function G.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_REFRESH] = { self:GetParent(), -1 } }
end
function G.prototype.OnAbilityRefresh(self, p)
	self.record = self.record + 1
end
function G.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_REFRESH_LIST }
end
function G.prototype.EOM_GetModifierCustomShopRefreshList(self, p)
	if self.record < self.count then
		return
	end
	self.record = 0
	local J = self:GetParent()
	local t = J:GetPlayerOwnerID()
	local K = PlayerData:getplayerData(t)
	local I = K and K.heroName
	local L = p.excludelist
	local u = AbilityShop:GetRecommendSectByHeroName(I)
	local v = {}
	if u ~= "sect_none" then
		v = e(u, "|")
	else
		v = AbilityShop.pickList
	end
	local M = v[RandomInt(0, #v - 1) + 1]
	local N = AbilityShop:getRandomAbility(t, 1, { excludedAbility = L, specifySect = { M } })
	local O = {}
	do
		local P = 0
		while P < #N do
			local F = N[P + 1]
			O[#O + 1] = { aid = F.aid, gold = KeyValues.AbilityUpgradesKvs[F.aid].cost, type = "city" }
			CityEffect:addCityEffectAbilites(t, F.aid, P == #N - 1)
			P = P + 1
		end
	end
	return O
end
G = g(
	{
		l(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	G
)
i.modifier_city_8_buff = G
return i