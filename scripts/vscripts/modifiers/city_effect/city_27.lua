--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_27"
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
		["15"] = 4,
		["16"] = 12,
		["17"] = 4,
		["18"] = 12,
		["20"] = 12,
		["21"] = 13,
		["22"] = 4,
		["23"] = 14,
		["24"] = 15,
		["25"] = 16,
		["26"] = 17,
		["27"] = 18,
		["28"] = 19,
		["29"] = 20,
		["30"] = 21,
		["31"] = 21,
		["34"] = 16,
		["36"] = 14,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["40"] = 29,
		["41"] = 29,
		["42"] = 30,
		["43"] = 31,
		["45"] = 29,
		["46"] = 29,
		["48"] = 27,
		["49"] = 12,
		["50"] = 4,
		["51"] = 4,
		["52"] = 4,
		["53"] = 4,
		["54"] = 4,
		["55"] = 4,
		["56"] = 4,
		["57"] = 4,
		["58"] = 12,
		["60"] = 12,
		["62"] = 39,
		["63"] = 47,
		["64"] = 39,
		["65"] = 47,
		["66"] = 48,
		["67"] = 49,
		["68"] = 49,
		["69"] = 49,
		["70"] = 49,
		["71"] = 48,
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
h.modifier_city_27 = c()
local n = h.modifier_city_27
n.name = "modifier_city_27"
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
				local s = r:AddNewModifier(r, nil, "modifier_city_27_buff", nil)
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
h.modifier_city_27 = n
h.modifier_city_27_buff = c()
local v = h.modifier_city_27_buff
v.name = "modifier_city_27_buff"
d(v, j)
function v.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES] = CityEffect:GetSpecialValueFor("city_27", "gain"),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT] = -CityEffect:GetSpecialValueFor(
			"city_27",
			"limit_reduce"
		),
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
h.modifier_city_27_buff = v
return h