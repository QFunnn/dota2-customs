--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_77"
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
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 21,
		["29"] = 12,
		["30"] = 21,
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 24,
		["35"] = 28,
		["36"] = 29,
		["37"] = 28,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["43"] = 38,
		["44"] = 39,
		["45"] = 40,
		["46"] = 40,
		["47"] = 40,
		["48"] = 40,
		["49"] = 40,
		["50"] = 41,
		["51"] = 41,
		["52"] = 41,
		["53"] = 41,
		["54"] = 41,
		["55"] = 41,
		["56"] = 41,
		["59"] = 33,
		["60"] = 21,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 21,
		["72"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_77 = c()
local n = g.item_artifact_77
n.name = "item_artifact_77"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_77"
end
n = e({ j(nil) }, n)
g.item_artifact_77 = n
g.modifier_item_artifact_77 = c()
local o = g.modifier_item_artifact_77
o.name = "modifier_item_artifact_77"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_BEFORE_PREPARE] = { -1, -1 } }
end
function o.prototype.OnBeforePrepare(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	if PlayerData:getGold(q) >= self.gold_bonus then
		local r = PlayerData:GetLossHealth(q)
		local s = r >= self.hp_regen and self.hp_regen or r
		if s > 0 then
			PlayerData:modifyHealth(q, s)
			PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_health", s)
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), s, self:GetParent():GetPlayerOwner())
		end
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
g.modifier_item_artifact_77 = o
return g