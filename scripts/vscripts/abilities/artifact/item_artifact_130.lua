--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_130"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
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
		["27"] = 20,
		["28"] = 12,
		["29"] = 20,
		["31"] = 20,
		["32"] = 23,
		["33"] = 12,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 25,
		["38"] = 29,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 30,
		["43"] = 29,
		["44"] = 35,
		["45"] = 36,
		["46"] = 35,
		["47"] = 38,
		["48"] = 39,
		["49"] = 40,
		["50"] = 41,
		["51"] = 42,
		["53"] = 38,
		["54"] = 45,
		["55"] = 46,
		["56"] = 45,
		["57"] = 50,
		["58"] = 51,
		["59"] = 50,
		["60"] = 53,
		["61"] = 54,
		["63"] = 53,
		["64"] = 20,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 20,
		["75"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_130 = c()
local n = g.item_artifact_130
n.name = "item_artifact_130"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_130"
end
n = e({ j(nil) }, n)
g.item_artifact_130 = n
g.modifier_item_artifact_130 = c()
local o = g.modifier_item_artifact_130
o.name = "modifier_item_artifact_130"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.buyInThisRound = true
end
function o.prototype.GetAbilitySpecialValue(self)
	self.base_gold_reduce = self:GetAbilitySpecialValueFor("base_gold_reduce")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self:GetParent() },
	}
end
function o.prototype.OnAbilityBuy(self, p)
	self.buyInThisRound = true
end
function o.prototype.OnRoundChange(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	if self.buyInThisRound then
		AbilityShop:setPlayerAbilityShopFreeCount(q, self.count)
		self.buyInThisRound = false
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES }
end
function o.prototype.EOM_GetModifierExtraWages(self, p)
	return -self.base_gold_reduce
end
function o.prototype.OnDestroy(self)
	if IsServer() then
	end
end
o = e(
	{
		m(
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
g.modifier_item_artifact_130 = o
return g