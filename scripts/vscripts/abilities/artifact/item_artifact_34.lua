--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_34"
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
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 25,
		["34"] = 26,
		["35"] = 27,
		["36"] = 27,
		["37"] = 27,
		["38"] = 27,
		["40"] = 25,
		["41"] = 30,
		["42"] = 31,
		["43"] = 32,
		["44"] = 32,
		["45"] = 31,
		["46"] = 30,
		["47"] = 35,
		["48"] = 36,
		["49"] = 36,
		["50"] = 36,
		["51"] = 36,
		["52"] = 36,
		["53"] = 35,
		["54"] = 20,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 20,
		["66"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_34 = c()
local n = g.item_artifact_34
n.name = "item_artifact_34"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_34"
end
n = e({ j(nil) }, n)
g.item_artifact_34 = n
g.modifier_item_artifact_34 = c()
local o = g.modifier_item_artifact_34
o.name = "modifier_item_artifact_34"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.random_gold_reduce = self:GetAbilitySpecialValueFor("random_gold_reduce")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		PlayerData:setRandomGoldCost(self:GetParent():GetPlayerOwnerID(), -self.random_gold_reduce)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_RANDOM] = { self:GetParent(), -1 } }
end
function o.prototype.OnShopRandom(self)
	PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
		:modifyArtifactExtraData(self:GetAbility():entindex(), "gold_reduce", self.random_gold_reduce)
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_34 = o
return g