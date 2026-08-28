--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_41"
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
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 6,
		["20"] = 15,
		["21"] = 16,
		["22"] = 15,
		["23"] = 5,
		["24"] = 4,
		["25"] = 5,
		["27"] = 5,
		["28"] = 20,
		["29"] = 27,
		["30"] = 20,
		["31"] = 27,
		["32"] = 30,
		["33"] = 31,
		["34"] = 30,
		["35"] = 34,
		["36"] = 35,
		["37"] = 34,
		["38"] = 38,
		["39"] = 39,
		["40"] = 40,
		["41"] = 41,
		["42"] = 42,
		["43"] = 43,
		["44"] = 44,
		["47"] = 48,
		["48"] = 49,
		["49"] = 50,
		["51"] = 53,
		["52"] = 38,
		["53"] = 27,
		["54"] = 20,
		["55"] = 20,
		["56"] = 20,
		["57"] = 20,
		["58"] = 20,
		["59"] = 20,
		["60"] = 20,
		["61"] = 27,
		["63"] = 27,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_41 = c()
local n = g.treasure_41
n.name = "treasure_41"
d(n, i)
function n.prototype.Spawn(self) end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_41"
end
n = e({ j(nil) }, n)
g.treasure_41 = n
g.modifier_treasure_41 = c()
local o = g.modifier_treasure_41
o.name = "modifier_treasure_41"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.goldHealthPct = self:GetAbilitySpecialValueFor("gold_health_pctg")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_REFRESH_REPLACE }
end
function o.prototype.EOM_GetModifierCustomShopRefreshReplace(self, p)
	local q = -1
	local r = ""
	for s, t in pairs(p) do
		if t.index > q then
			q = t.index
			r = tostring(s)
		end
	end
	if r ~= "" then
		local t = p[r]
		t.health = t.gold > 0 and math.ceil(t.gold * self.goldHealthPct * 0.01) or 0
	end
	return p
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_41 = o
return g