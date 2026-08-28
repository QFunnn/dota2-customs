--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_25"
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
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 18,
		["28"] = 11,
		["29"] = 18,
		["31"] = 18,
		["32"] = 20,
		["33"] = 11,
		["34"] = 21,
		["35"] = 22,
		["36"] = 21,
		["37"] = 24,
		["38"] = 25,
		["41"] = 26,
		["42"] = 27,
		["43"] = 28,
		["44"] = 29,
		["45"] = 24,
		["46"] = 31,
		["47"] = 32,
		["48"] = 32,
		["49"] = 32,
		["50"] = 32,
		["51"] = 32,
		["53"] = 31,
		["54"] = 34,
		["55"] = 35,
		["56"] = 34,
		["57"] = 39,
		["58"] = 40,
		["59"] = 41,
		["61"] = 39,
		["62"] = 44,
		["63"] = 45,
		["64"] = 46,
		["65"] = 46,
		["66"] = 47,
		["69"] = 48,
		["70"] = 49,
		["71"] = 50,
		["72"] = 51,
		["76"] = 55,
		["77"] = 44,
		["78"] = 18,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 18,
		["88"] = 18,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_25 = c()
local n = g.treasure_25
n.name = "treasure_25"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_25"
end
n = e({ j(nil) }, n)
g.treasure_25 = n
g.modifier_treasure_25 = c()
local o = g.modifier_treasure_25
o.name = "modifier_treasure_25"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.randomCostOffset = 0
end
function o.prototype.GetAbilitySpecialValue(self)
	self.price = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local p = self:GetParent():GetPlayerOwnerID()
	self.randomCostOffset = self.price - PlayerData:getRandomGoldCost(p)
	PlayerData:setRandomGoldCost(p, self.randomCostOffset)
	self:applyShopPrice()
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		PlayerData:setRandomGoldCost(self:GetParent():GetPlayerOwnerID(), -self.randomCostOffset)
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_SHOP_CARD_COST }
end
function o.prototype.EOM_GetModifierAbilityShopCardCost(self, q)
	if q.gold > 0 then
		return self.price
	end
end
function o.prototype.applyShopPrice(self)
	local p = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getHero(p)
	local s = r and r.abilityShopData
	if not s then
		return
	end
	for t, u in pairs(s) do
		if not u.soldOut then
			if u.gold > 0 then
				u.gold = self.price
			end
		end
	end
	AbilityShop:updateNetTable(p)
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_25 = o
return g