--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_29"
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
		["39"] = 51,
		["40"] = 52,
		["41"] = 53,
		["42"] = 54,
		["43"] = 54,
		["44"] = 54,
		["45"] = 55,
		["46"] = 56,
		["47"] = 57,
		["48"] = 58,
		["49"] = 58,
		["52"] = 54,
		["53"] = 54,
		["54"] = 53,
		["55"] = 63,
		["57"] = 65,
		["58"] = 66,
		["59"] = 67,
		["61"] = 51,
		["62"] = 70,
		["63"] = 71,
		["64"] = 72,
		["65"] = 73,
		["66"] = 74,
		["67"] = 75,
		["68"] = 76,
		["69"] = 77,
		["71"] = 79,
		["73"] = 79,
		["74"] = 79,
		["75"] = 79,
		["76"] = 80,
		["77"] = 80,
		["78"] = 80,
		["79"] = 80,
		["80"] = 79,
		["81"] = 79,
		["83"] = 82,
		["84"] = 88,
		["85"] = 88,
		["86"] = 88,
		["87"] = 89,
		["88"] = 88,
		["89"] = 88,
		["90"] = 91,
		["91"] = 92,
		["92"] = 92,
		["94"] = 94,
		["95"] = 94,
		["96"] = 94,
		["97"] = 94,
		["98"] = 98,
		["99"] = 99,
		["100"] = 99,
		["101"] = 100,
		["102"] = 103,
		["103"] = 94,
		["104"] = 94,
		["105"] = 94,
		["106"] = 94,
		["107"] = 94,
		["109"] = 71,
		["110"] = 70,
		["111"] = 13,
		["112"] = 5,
		["113"] = 5,
		["114"] = 5,
		["115"] = 5,
		["116"] = 5,
		["117"] = 5,
		["118"] = 5,
		["119"] = 5,
		["120"] = 13,
		["122"] = 13,
	}
)
local j = {}
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = require("modifiers.city_effect.city_effect_modifier")
local n = m.CityEffectModifier
j.modifier_city_29 = c()
local o = j.modifier_city_29
o.name = "modifier_city_29"
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
		local x = AbilityShop:GetRecommendSectByHeroName(r.unitName)
		local y
		if x ~= "sect_none" then
			y = f(x, "|")
		end
		local z = y
		if z ~= nil then
			e(y, function(q, t)
				w = g(w, function(q, A)
					return A ~= t
				end)
			end)
		end
		local B = AbilityShop:getRandomAbility(
			s,
			3,
			{ specifySect = w, isAbilityShop = false, specifyRarity = "sr", specifyRarityIgnoreRule = true }
		)
		e(B, function(q, t)
			v[#v + 1] = t.aid
		end)
		if r:IsBotData() then
			local C = self.abilityNames
			C[#C + 1] = { playerId = s, name = B[1].aid }
		else
			Selection:AddSpecialSelection(s, "ability_card", v, function(q, D)
				local E = self.abilityNames
				E[#E + 1] = { playerId = s, name = D }
				CityEffect:addCityEffectAbilites(s, D)
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
j.modifier_city_29 = o
return j