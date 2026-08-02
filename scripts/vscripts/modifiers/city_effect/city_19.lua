--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_19"
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
		["15"] = 5,
		["16"] = 13,
		["17"] = 5,
		["18"] = 13,
		["20"] = 13,
		["21"] = 14,
		["22"] = 15,
		["23"] = 5,
		["24"] = 16,
		["25"] = 17,
		["26"] = 18,
		["27"] = 19,
		["28"] = 20,
		["29"] = 21,
		["30"] = 22,
		["31"] = 23,
		["32"] = 23,
		["35"] = 18,
		["37"] = 16,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 32,
		["44"] = 33,
		["46"] = 31,
		["47"] = 31,
		["49"] = 29,
		["50"] = 13,
		["51"] = 5,
		["52"] = 5,
		["53"] = 5,
		["54"] = 5,
		["55"] = 5,
		["56"] = 5,
		["57"] = 5,
		["58"] = 5,
		["59"] = 13,
		["61"] = 13,
		["62"] = 40,
		["63"] = 48,
		["64"] = 40,
		["65"] = 48,
		["66"] = 49,
		["67"] = 50,
		["68"] = 50,
		["69"] = 50,
		["70"] = 50,
		["71"] = 50,
		["72"] = 49,
		["73"] = 48,
		["74"] = 40,
		["75"] = 40,
		["76"] = 40,
		["77"] = 40,
		["78"] = 40,
		["79"] = 40,
		["80"] = 40,
		["81"] = 40,
		["82"] = 48,
		["84"] = 48,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("modifiers.city_effect.city_effect_modifier")
local m = l.CityEffectModifier
h.modifier_city_19 = c()
local n = h.modifier_city_19
n.name = "modifier_city_19"
d(n, m)
function n.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.modifierList = {}
	self.particleIDList = {}
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		PlayerData:eachPlayer(function(p, q)
			local r = PlayerResource:GetSelectedHeroEntity(q.playerID)
			if IsValid(r) then
				local s = r:AddNewModifier(r, nil, "modifier_city_19_buff", nil)
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
h.modifier_city_19 = n
h.modifier_city_19_buff = c()
local v = h.modifier_city_19_buff
v.name = "modifier_city_19_buff"
d(v, j)
function v.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_BONUS_LIMIT_PERCENTAGE] = CityEffect:GetSpecialValueFor(
			"city_19",
			"up_pct"
		),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_WIN_GOLD_PERCENTAGE] = CityEffect:GetSpecialValueFor(
			"city_19",
			"up_pct"
		),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_LOSE_GOLD_PERCENTAGE] = CityEffect:GetSpecialValueFor(
			"city_19",
			"up_pct"
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
h.modifier_city_19_buff = v
return h