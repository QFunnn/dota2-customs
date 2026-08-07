--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_38"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__StringSplit
local g = b.__TS__ArrayFilter
local h = b.__TS__DecorateLegacy
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["16"] = 5,
		["17"] = 13,
		["18"] = 5,
		["19"] = 13,
		["21"] = 13,
		["22"] = 18,
		["23"] = 19,
		["24"] = 5,
		["25"] = 21,
		["26"] = 22,
		["27"] = 23,
		["28"] = 21,
		["29"] = 25,
		["30"] = 26,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["35"] = 25,
		["36"] = 32,
		["37"] = 33,
		["38"] = 32,
		["39"] = 37,
		["40"] = 38,
		["41"] = 39,
		["42"] = 40,
		["43"] = 40,
		["44"] = 40,
		["45"] = 41,
		["46"] = 42,
		["47"] = 43,
		["48"] = 44,
		["49"] = 44,
		["52"] = 40,
		["53"] = 40,
		["54"] = 39,
		["55"] = 49,
		["57"] = 51,
		["58"] = 52,
		["59"] = 53,
		["61"] = 37,
		["62"] = 56,
		["63"] = 57,
		["64"] = 58,
		["65"] = 59,
		["66"] = 60,
		["67"] = 61,
		["68"] = 62,
		["69"] = 63,
		["70"] = 64,
		["72"] = 66,
		["74"] = 66,
		["75"] = 66,
		["76"] = 66,
		["77"] = 67,
		["78"] = 67,
		["79"] = 67,
		["80"] = 67,
		["81"] = 66,
		["82"] = 66,
		["85"] = 69,
		["86"] = 69,
		["87"] = 70,
		["88"] = 69,
		["91"] = 73,
		["92"] = 74,
		["93"] = 74,
		["94"] = 74,
		["95"] = 75,
		["96"] = 74,
		["97"] = 74,
		["98"] = 77,
		["99"] = 78,
		["100"] = 79,
		["101"] = 79,
		["104"] = 82,
		["105"] = 82,
		["106"] = 82,
		["107"] = 82,
		["108"] = 86,
		["109"] = 87,
		["110"] = 87,
		["111"] = 88,
		["112"] = 89,
		["113"] = 82,
		["114"] = 82,
		["115"] = 82,
		["116"] = 82,
		["117"] = 82,
		["119"] = 57,
		["120"] = 56,
		["121"] = 13,
		["122"] = 5,
		["123"] = 5,
		["124"] = 5,
		["125"] = 5,
		["126"] = 5,
		["127"] = 5,
		["128"] = 5,
		["129"] = 5,
		["130"] = 13,
		["132"] = 13,
	}
)
local j = {}
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = require("modifiers.city_effect.city_effect_modifier")
local n = m.CityEffectModifier
j.modifier_city_38 = c()
local o = j.modifier_city_38
o.name = "modifier_city_38"
d(o, n)
function o.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.enable = true
	self.enable2 = true
end
function o.prototype.GetAbilitySpecialValue(self)
	self.select_round = self:GetAbilitySpecialValueFor("select_round")
	self.affect_round = self:GetAbilitySpecialValueFor("affect_round")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.keys = {}
		self.abilityNames = {}
		self.players = {}
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self, p)
	if self.enable and self.affect_round <= Rounds:getCurrentRound() then
		PlayerData:eachAlivePlayerHero(function(q, r, s)
			e(self.abilityNames, function(q, t)
				if s == t.playerId then
					if r then
						r:learnAbility(t.name, true)
						local u = self.players
						u[#u + 1] = s
					end
				end
			end)
		end)
		self.enable = false
	end
	if self.enable2 and self.select_round <= Rounds:getCurrentRound() then
		self.enable2 = false
		self:EffectFunc()
	end
end
function o.prototype.EffectFunc(self)
	PlayerData:eachAlivePlayerHero(function(q, r, s)
		local v = {}
		local w = AbilityShop.pickList
		local x = {}
		local y = AbilityShop:GetRecommendSectByHeroName(r.unitName)
		local z
		if y ~= "sect_none" then
			z = f(y, "|")
		end
		local A = z
		if A ~= nil then
			e(z, function(q, t)
				w = g(w, function(q, B)
					return B ~= t
				end)
			end)
		end
		do
			local C = 0
			while C < #w do
				x[#x + 1] = AbilityShop:GetSectLegendCard(w[C + 1])
				C = C + 1
			end
		end
		local D = PickList(x, 3)
		e(D, function(q, t)
			v[#v + 1] = t
		end)
		if r:IsBotData() then
			if D[1] then
				local E = self.abilityNames
				E[#E + 1] = { playerId = s, name = D[1] }
			end
		else
			Selection:AddSpecialSelection(s, "ability_card", v, function(q, F)
				local G = self.abilityNames
				G[#G + 1] = { playerId = s, name = F }
				CityEffect:addCityEffectAbilites(s, F)
				return true
			end, nil, 0, true)
		end
	end)
end
o = h(
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
j.modifier_city_38 = o
return j