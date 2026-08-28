--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_19"
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
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 5,
		["14"] = 5,
		["15"] = 5,
		["16"] = 5,
		["18"] = 5,
		["19"] = 6,
		["20"] = 5,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 10,
		["25"] = 7,
		["26"] = 14,
		["27"] = 22,
		["28"] = 14,
		["29"] = 22,
		["30"] = 26,
		["31"] = 27,
		["32"] = 26,
		["33"] = 45,
		["34"] = 46,
		["35"] = 45,
		["36"] = 50,
		["37"] = 51,
		["38"] = 52,
		["39"] = 53,
		["40"] = 54,
		["41"] = 55,
		["42"] = 56,
		["45"] = 59,
		["46"] = 60,
		["47"] = 61,
		["48"] = 62,
		["50"] = 65,
		["53"] = 71,
		["54"] = 72,
		["55"] = 50,
		["56"] = 22,
		["57"] = 14,
		["58"] = 14,
		["59"] = 14,
		["60"] = 14,
		["61"] = 14,
		["62"] = 14,
		["63"] = 14,
		["64"] = 14,
		["65"] = 22,
		["67"] = 22,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.greevil_effect.greevil_effect_base")
local l = k.GreevilEffectBase
g.greevil_effect_19 = c()
local m = g.greevil_effect_19
m.name = "greevil_effect_19"
d(m, l)
function m.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.flag = false
end
function m.prototype.spawn(self)
	self:AddCourierBuff("modifier_greevil_effect_19", {})
	local n = self:getSpecialValueFor("health")
	PlayerData:modifyHealth(self.playerID, n)
end
g.modifier_greevil_effect_19 = c()
local o = g.modifier_greevil_effect_19
o.name = "modifier_greevil_effect_19"
d(o, i)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_health_pctg = self:GetGreevilEffectValueFor("greevil_effect_19", "gold_health_pctg")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_REFRESH_REPLACE }
end
function o.prototype.EOM_GetModifierCustomShopRefreshReplace(self, p)
	local q = -1
	local r = ""
	for s, t in pairs(p) do
		if t.index > q then
			r = tostring(s)
			q = t.index
		end
	end
	if r ~= "" then
		if p[r].gold > 0 then
			local u = math.ceil(p[r].gold * self.gold_health_pctg * 0.01)
			p[r].health = u
		else
			p[r].health = 0
		end
	end
	print("EOM_GetModifierCustomShopRefreshReplace", p)
	return p
end
o = e(
	{
		j(
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
g.modifier_greevil_effect_19 = o
return g