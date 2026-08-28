--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 12,
		["16"] = 4,
		["17"] = 12,
		["19"] = 12,
		["20"] = 13,
		["21"] = 4,
		["22"] = 14,
		["23"] = 15,
		["24"] = 16,
		["25"] = 17,
		["26"] = 18,
		["27"] = 19,
		["28"] = 20,
		["29"] = 21,
		["30"] = 21,
		["33"] = 16,
		["35"] = 14,
		["36"] = 27,
		["37"] = 28,
		["38"] = 29,
		["39"] = 29,
		["40"] = 29,
		["41"] = 30,
		["42"] = 31,
		["44"] = 29,
		["45"] = 29,
		["47"] = 27,
		["48"] = 12,
		["49"] = 4,
		["50"] = 4,
		["51"] = 4,
		["52"] = 4,
		["53"] = 4,
		["54"] = 4,
		["55"] = 4,
		["56"] = 4,
		["57"] = 12,
		["59"] = 12,
		["61"] = 39,
		["62"] = 47,
		["63"] = 39,
		["64"] = 47,
		["65"] = 50,
		["66"] = 51,
		["67"] = 52,
		["68"] = 50,
		["69"] = 55,
		["70"] = 56,
		["71"] = 55,
		["72"] = 47,
		["73"] = 39,
		["74"] = 39,
		["75"] = 39,
		["76"] = 39,
		["77"] = 39,
		["78"] = 39,
		["79"] = 39,
		["80"] = 39,
		["81"] = 47,
		["83"] = 47,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("modifiers.city_effect.city_effect_modifier")
local m = l.CityEffectModifier
h.modifier_city_2 = c()
local n = h.modifier_city_2
n.name = "modifier_city_2"
d(n, m)
function n.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.modifierList = {}
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		PlayerData:eachPlayer(function(p, q)
			local r = PlayerResource:GetSelectedHeroEntity(q.playerID)
			if IsValid(r) then
				local s = r:AddNewModifier(r, nil, "modifier_city_2_buff", nil)
				if IsValid(s) then
					local t = self.modifierList
					t[#t + 1] = s
				end
			end
		end)
	end
end
function n.prototype.OnDestroy(self)
	if IsServer() then
		e(self.modifierList, function(p, u)
			if IsValid(u) then
				u:Destroy()
			end
		end)
	end
end
n = f(
	{
		k(
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
	n
)
h.modifier_city_2 = n
h.modifier_city_2_buff = c()
local v = h.modifier_city_2_buff
v.name = "modifier_city_2_buff"
d(v, j)
function v.prototype.GetAbilitySpecialValue(self)
	self.fixed_interest = CityEffect:GetSpecialValueFor("city_2", "fixed_interest") - getInterestConfig(nil).Max
	self.interest_threshold = CityEffect:GetSpecialValueFor("city_2", "interest_threshold")
end
function v.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INTEREST_RATE_CONSTANT] = -self.interest_threshold,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT] = self.fixed_interest,
	}
end
v = f(
	{
		k(
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
	v
)
h.modifier_city_2_buff = v
return h