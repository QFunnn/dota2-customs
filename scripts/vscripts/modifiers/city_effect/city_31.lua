--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_31"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 2,
		["11"] = 2,
		["13"] = 5,
		["14"] = 13,
		["15"] = 5,
		["16"] = 13,
		["18"] = 13,
		["19"] = 15,
		["20"] = 5,
		["21"] = 16,
		["22"] = 17,
		["23"] = 17,
		["24"] = 17,
		["25"] = 17,
		["26"] = 17,
		["27"] = 16,
		["28"] = 19,
		["29"] = 20,
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 24,
		["35"] = 19,
		["36"] = 27,
		["37"] = 28,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 30,
		["43"] = 34,
		["45"] = 27,
		["46"] = 38,
		["47"] = 38,
		["48"] = 13,
		["49"] = 5,
		["50"] = 5,
		["51"] = 5,
		["52"] = 5,
		["53"] = 5,
		["54"] = 5,
		["55"] = 5,
		["56"] = 5,
		["57"] = 13,
		["59"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.registerEOMModifier
local j = require("modifiers.city_effect.city_effect_modifier")
local k = j.CityEffectModifier
g.modifier_city_31 = c()
local l = g.modifier_city_31
l.name = "modifier_city_31"
d(l, k)
function l.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.enable = true
end
function l.prototype.GetAbilitySpecialValue(self)
	self.rounds = {
		self:GetAbilitySpecialValueFor("round1"),
		self:GetAbilitySpecialValueFor("round2"),
		self:GetAbilitySpecialValueFor("round3"),
	}
end
function l.prototype.OnCreated(self, m)
	if IsServer() then
		PlayerData:eachPlayer(function(n, o, p)
			o:setChangeSelectArtifactRound(self.rounds)
		end)
		GameState:setCustomArtifactRounds(self.rounds)
	end
end
function l.prototype.OnDestroy(self)
	if IsServer() then
		if PlayerData then
			PlayerData:eachPlayer(function(n, o, p)
				o:setChangeSelectArtifactRound({})
			end)
		end
		GameState:setCustomArtifactRounds({})
	end
end
function l.prototype.EffectFunc(self) end
l = e(
	{
		i(
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
	l
)
g.modifier_city_31 = l
return g