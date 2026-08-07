--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["19"] = 7,
		["22"] = 11,
		["23"] = 12,
		["24"] = 12,
		["25"] = 12,
		["26"] = 12,
		["27"] = 6,
		["28"] = 15,
		["29"] = 16,
		["30"] = 15,
		["31"] = 5,
		["32"] = 4,
		["33"] = 5,
		["35"] = 5,
		["36"] = 20,
		["37"] = 27,
		["38"] = 20,
		["39"] = 27,
		["40"] = 30,
		["41"] = 31,
		["42"] = 30,
		["43"] = 34,
		["44"] = 35,
		["45"] = 34,
		["46"] = 38,
		["47"] = 39,
		["48"] = 40,
		["49"] = 41,
		["50"] = 42,
		["51"] = 43,
		["52"] = 44,
		["55"] = 48,
		["56"] = 49,
		["57"] = 50,
		["59"] = 53,
		["60"] = 38,
		["61"] = 27,
		["62"] = 20,
		["63"] = 20,
		["64"] = 20,
		["65"] = 20,
		["66"] = 20,
		["67"] = 20,
		["68"] = 20,
		["69"] = 27,
		["71"] = 27,
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
function n.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local o = self:GetCaster():GetPlayerOwnerID()
	PlayerData:modifyHealth(o, self:GetSpecialValueFor("health"))
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_41"
end
n = e({ j(nil) }, n)
g.treasure_41 = n
g.modifier_treasure_41 = c()
local p = g.modifier_treasure_41
p.name = "modifier_treasure_41"
d(p, l)
function p.prototype.GetAbilitySpecialValue(self)
	self.goldHealthPct = self:GetAbilitySpecialValueFor("gold_health_pctg")
end
function p.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_REFRESH_REPLACE }
end
function p.prototype.EOM_GetModifierCustomShopRefreshReplace(self, q)
	local r = -1
	local s = ""
	for t, u in pairs(q) do
		if u.index > r then
			r = u.index
			s = tostring(t)
		end
	end
	if s ~= "" then
		local u = q[s]
		u.health = u.gold > 0 and math.ceil(u.gold * self.goldHealthPct * 0.01) or 0
	end
	return q
end
p = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
g.modifier_treasure_41 = p
return g