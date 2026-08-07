--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_45"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 24,
		["34"] = 25,
		["35"] = 24,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 32,
		["40"] = 33,
		["41"] = 37,
		["43"] = 38,
		["44"] = 38,
		["45"] = 39,
		["46"] = 38,
		["49"] = 45,
		["51"] = 29,
		["52"] = 19,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 19,
		["62"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_45 = c()
local n = g.trait_45
n.name = "trait_45"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_45"
end
n = e({ j(nil) }, n)
g.trait_45 = n
g.modifier_trait_45 = c()
local o = g.modifier_trait_45
o.name = "modifier_trait_45"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_REFRESH_LIST }
end
function o.prototype.EOM_GetModifierCustomShopRefreshList(self, p)
	if p.type == "auto" then
		local q = p.excludelist
		local r = self:GetParent():GetPlayerOwnerID()
		local s = AbilityShop:getRandomAbility(r, self.count, { excludedAbility = q, specifyRarity = "r" })
		local t = {}
		do
			local u = 0
			while u < #s do
				t[#t + 1] =
					{ aid = s[u + 1].aid, gold = KeyValues.AbilityUpgradesKvs[s[u + 1].aid].cost, type = "trait" }
				u = u + 1
			end
		end
		return t
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_45 = o
return g