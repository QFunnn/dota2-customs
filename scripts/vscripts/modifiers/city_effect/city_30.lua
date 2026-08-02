--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_30"
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
		["21"] = 15,
		["22"] = 16,
		["23"] = 5,
		["24"] = 17,
		["25"] = 18,
		["26"] = 17,
		["27"] = 20,
		["28"] = 21,
		["29"] = 22,
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["37"] = 29,
		["40"] = 24,
		["42"] = 20,
		["43"] = 36,
		["44"] = 37,
		["45"] = 38,
		["46"] = 39,
		["47"] = 39,
		["48"] = 39,
		["49"] = 40,
		["50"] = 41,
		["52"] = 39,
		["53"] = 39,
		["55"] = 36,
		["56"] = 47,
		["57"] = 48,
		["58"] = 47,
		["59"] = 13,
		["60"] = 5,
		["61"] = 5,
		["62"] = 5,
		["63"] = 5,
		["64"] = 5,
		["65"] = 5,
		["66"] = 5,
		["67"] = 5,
		["68"] = 13,
		["70"] = 13,
		["71"] = 52,
		["72"] = 60,
		["73"] = 52,
		["74"] = 60,
		["75"] = 61,
		["76"] = 62,
		["77"] = 61,
		["78"] = 60,
		["79"] = 52,
		["80"] = 52,
		["81"] = 52,
		["82"] = 52,
		["83"] = 52,
		["84"] = 52,
		["85"] = 52,
		["86"] = 52,
		["87"] = 60,
		["89"] = 60,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("modifiers.city_effect.city_effect_modifier")
local m = l.CityEffectModifier
h.modifier_city_30 = c()
local n = h.modifier_city_30
n.name = "modifier_city_30"
d(n, m)
function n.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.enable = true
	self.modifierList = {}
end
function n.prototype.GetAbilitySpecialValue(self)
	self.legend_cnt = self:GetAbilitySpecialValueFor("legend_cnt")
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		AbilityShop:setLegendCnt(self:GetLegendCnt())
		AbilityShop:RollLegendCard()
		PlayerData:eachPlayer(function(p, q)
			local r = PlayerResource:GetSelectedHeroEntity(q.playerID)
			if IsValid(r) then
				local s = r:AddNewModifier(r, nil, "modifier_city_30_buff", nil)
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
		AbilityShop:setLegendCnt(-1)
		e(self.modifierList, function(p, u)
			if IsValid(u) then
				u:Destroy()
			end
		end)
	end
end
function n.prototype.GetLegendCnt(self)
	return self.legend_cnt
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
h.modifier_city_30 = n
h.modifier_city_30_buff = c()
local v = h.modifier_city_30_buff
v.name = "modifier_city_30_buff"
d(v, j)
function v.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_LEGEND_CHANCE_BONUS] = CityEffect:GetSpecialValueFor(
			"city_30",
			"chance"
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
h.modifier_city_30_buff = v
return h