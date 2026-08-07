--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_37"
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
		["36"] = 28,
		["38"] = 25,
		["39"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 33,
		["43"] = 32,
		["44"] = 31,
		["45"] = 36,
		["46"] = 37,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["50"] = 38,
		["51"] = 38,
		["53"] = 36,
		["54"] = 42,
		["55"] = 43,
		["56"] = 44,
		["57"] = 45,
		["59"] = 42,
		["60"] = 20,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 20,
		["72"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_37 = c()
local n = g.item_artifact_37
n.name = "item_artifact_37"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_37"
end
n = e({ j(nil) }, n)
g.item_artifact_37 = n
g.modifier_item_artifact_37 = c()
local o = g.modifier_item_artifact_37
o.name = "modifier_item_artifact_37"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.refresh_gold_reduce = self:GetAbilitySpecialValueFor("refresh_gold_reduce")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		PlayerData:setRefreshGoldCost(q, -self.refresh_gold_reduce)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH] = { self:GetParent(), -1 } }
end
function o.prototype.OnShopRefresh(self, p)
	if p.free ~= 1 then
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "gold_reduce", self.refresh_gold_reduce)
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		PlayerData:setRefreshGoldCost(q, self.refresh_gold_reduce)
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_37 = o
return g