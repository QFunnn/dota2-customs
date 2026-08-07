--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_8"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayMap
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 4,
		["16"] = 5,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 4,
		["24"] = 5,
		["26"] = 5,
		["27"] = 10,
		["28"] = 17,
		["29"] = 10,
		["30"] = 17,
		["31"] = 19,
		["32"] = 20,
		["33"] = 19,
		["34"] = 22,
		["35"] = 23,
		["36"] = 22,
		["37"] = 25,
		["38"] = 29,
		["41"] = 31,
		["42"] = 31,
		["43"] = 31,
		["44"] = 31,
		["45"] = 31,
		["46"] = 35,
		["47"] = 35,
		["48"] = 35,
		["49"] = 35,
		["50"] = 25,
		["51"] = 17,
		["52"] = 10,
		["53"] = 10,
		["54"] = 10,
		["55"] = 10,
		["56"] = 10,
		["57"] = 10,
		["58"] = 10,
		["59"] = 17,
		["61"] = 17,
		["62"] = 42,
		["63"] = 43,
		["64"] = 44,
		["65"] = 44,
		["66"] = 44,
		["67"] = 44,
		["68"] = 44,
		["69"] = 44,
		["71"] = 42,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.treasure_8 = c()
local o = h.treasure_8
o.name = "treasure_8"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_8"
end
o = e({ k(nil) }, o)
h.treasure_8 = o
h.modifier_treasure_8 = c()
local p = h.modifier_treasure_8
p.name = "modifier_treasure_8"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function p.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_REFRESH_LIST }
end
function p.prototype.EOM_GetModifierCustomShopRefreshList(self, q)
	if q.type ~= "auto" then
		return
	end
	local r = AbilityShop:getRandomAbility(
		self:GetParent():GetPlayerOwnerID(),
		self.count,
		{ excludedAbility = q.excludelist, specifyRarity = "r" }
	)
	return f(r, function(s, t)
		return { aid = t.aid, gold = KeyValues.AbilityUpgradesKvs[t.aid].cost, type = "trait" }
	end)
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_treasure_8 = p
local function u(self, v, w)
	if IsServer() then
		v:GetParent():AddNewModifier(v:GetParent(), v:GetAbility(), w, {})
	end
end
return h