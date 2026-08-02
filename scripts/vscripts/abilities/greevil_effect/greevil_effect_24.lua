--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_24"
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
		["15"] = 4,
		["16"] = 4,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 5,
		["21"] = 11,
		["22"] = 19,
		["23"] = 11,
		["24"] = 19,
		["25"] = 20,
		["26"] = 21,
		["27"] = 20,
		["28"] = 25,
		["29"] = 26,
		["30"] = 27,
		["31"] = 28,
		["32"] = 29,
		["33"] = 30,
		["34"] = 31,
		["35"] = 32,
		["36"] = 36,
		["37"] = 37,
		["38"] = 37,
		["39"] = 37,
		["40"] = 38,
		["41"] = 39,
		["42"] = 37,
		["43"] = 37,
		["45"] = 47,
		["48"] = 25,
		["49"] = 19,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 11,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 19,
		["60"] = 19,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.greevil_effect.greevil_effect_base")
local m = l.GreevilEffectBase
h.greevil_effect_24 = c()
local n = h.greevil_effect_24
n.name = "greevil_effect_24"
d(n, m)
function n.prototype.spawn(self)
	self:AddCourierBuff("modifier_greevil_effect_24", {})
end
h.modifier_greevil_effect_24 = c()
local o = h.modifier_greevil_effect_24
o.name = "modifier_greevil_effect_24"
d(o, j)
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_REFRESH_LIST }
end
function o.prototype.EOM_GetModifierCustomShopRefreshList(self, p)
	if p.type == "auto" then
		local q = self.parent:GetPlayerOwnerID()
		local r = PlayerData:getplayerData(q)
		local s = r:getAbilityShopProductSlotCount()
		if s > 0 then
			local t = {}
			local u = AbilityShop:getRandomAbility(q, s, { specifyRarity = "r", specifyRarityIgnoreRule = true })
			if #u > 0 then
				e(u, function(v, w)
					local x = ABILITY_COST[w.rarity] or ABILITY_COST.n
					t[#t + 1] = { aid = w.aid, gold = x, type = p.type }
				end)
			end
			return t
		end
	end
end
o = f(
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
	o
)
h.modifier_greevil_effect_24 = o
return h