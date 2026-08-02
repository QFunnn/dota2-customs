--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_84"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 3,
		["13"] = 12,
		["14"] = 3,
		["15"] = 12,
		["16"] = 16,
		["17"] = 17,
		["18"] = 18,
		["19"] = 16,
		["20"] = 20,
		["21"] = 21,
		["22"] = 22,
		["23"] = 23,
		["24"] = 24,
		["25"] = 25,
		["26"] = 26,
		["27"] = 27,
		["28"] = 28,
		["29"] = 29,
		["30"] = 30,
		["32"] = 32,
		["34"] = 34,
		["35"] = 35,
		["37"] = 38,
		["38"] = 38,
		["39"] = 39,
		["40"] = 40,
		["41"] = 38,
		["45"] = 20,
		["46"] = 44,
		["47"] = 45,
		["48"] = 44,
		["49"] = 49,
		["50"] = 54,
		["51"] = 55,
		["52"] = 56,
		["53"] = 56,
		["54"] = 57,
		["55"] = 58,
		["56"] = 59,
		["57"] = 60,
		["58"] = 61,
		["60"] = 63,
		["62"] = 65,
		["63"] = 66,
		["64"] = 70,
		["66"] = 71,
		["67"] = 71,
		["68"] = 72,
		["69"] = 73,
		["70"] = 71,
		["73"] = 79,
		["74"] = 49,
		["75"] = 12,
		["76"] = 3,
		["77"] = 3,
		["78"] = 3,
		["79"] = 3,
		["80"] = 3,
		["81"] = 3,
		["82"] = 3,
		["83"] = 3,
		["84"] = 3,
		["85"] = 12,
		["87"] = 12,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
h.modifier_card_effect_84 = c()
local l = h.modifier_card_effect_84
l.name = "modifier_card_effect_84"
d(l, j)
function l.prototype.GetAbilitySpecialValue(self)
	self.card = self:GetEffectCardValueFor("card")
	self.count = self:GetEffectCardValueFor("count")
end
function l.prototype.OnCreated(self, m)
	if IsServer() then
		local n = self:GetParent()
		local o = n:GetPlayerOwnerID()
		local p = PlayerData:getplayerData(o)
		local q = p and p.heroName
		local r = p and p.hero
		local s = AbilityShop:GetRecommendSectByHeroName(q)
		local t = {}
		if s ~= "sect_none" then
			t = e(s, "|")
		else
			t = AbilityShop.pickList
		end
		local u = t[RandomInt(0, #t - 1) + 1]
		local v = AbilityShop:getRandomAbility(o, self.card, { specifySect = { u } })
		do
			local w = 0
			while w < #v do
				local x = v[w + 1]
				r:learnAbility(x.aid, true)
				w = w + 1
			end
		end
	end
end
function l.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_REFRESH_LIST }
end
function l.prototype.EOM_GetModifierCustomShopRefreshList(self, m)
	local n = self:GetParent()
	local o = n:GetPlayerOwnerID()
	local y = PlayerData:getplayerData(o)
	local q = y and y.heroName
	local z = m.excludelist
	local s = AbilityShop:GetRecommendSectByHeroName(q)
	local t = {}
	if s ~= "sect_none" then
		t = e(s, "|")
	else
		t = AbilityShop.pickList
	end
	local u = t[RandomInt(0, #t - 1) + 1]
	local v = AbilityShop:getRandomAbility(o, self.count, { excludedAbility = z, specifySect = { u } })
	local A = {}
	do
		local w = 0
		while w < #v do
			local x = v[w + 1]
			A[#A + 1] = { aid = x.aid, gold = KeyValues.AbilityUpgradesKvs[x.aid].cost, type = "card" }
			w = w + 1
		end
	end
	return A
end
l = f(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	l
)
h.modifier_card_effect_84 = l
return h