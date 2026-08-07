--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_113"
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
		["27"] = 19,
		["28"] = 11,
		["29"] = 19,
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 28,
		["36"] = 27,
		["37"] = 33,
		["38"] = 34,
		["41"] = 35,
		["42"] = 36,
		["43"] = 37,
		["44"] = 38,
		["45"] = 39,
		["46"] = 39,
		["47"] = 39,
		["48"] = 39,
		["49"] = 39,
		["50"] = 39,
		["51"] = 39,
		["52"] = 39,
		["53"] = 44,
		["54"] = 44,
		["55"] = 44,
		["56"] = 44,
		["57"] = 44,
		["59"] = 33,
		["60"] = 19,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 19,
		["71"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_113 = c()
local n = g.item_artifact_113
n.name = "item_artifact_113"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_113"
end
n = e({ j(nil) }, n)
g.item_artifact_113 = n
g.modifier_item_artifact_113 = c()
local o = g.modifier_item_artifact_113
o.name = "modifier_item_artifact_113"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
	self.round = self:GetAbilitySpecialValueFor("round")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 },
	}
end
function o.prototype.OnRoundStart(self, p)
	if self.flag then
		return
	end
	if Rounds:getCurrentRound() >= self.round then
		self.flag = true
		local q = self:GetParent():GetPlayerOwnerID()
		PlayerData:modifyGold(q, self.gold)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				int_gold = self.gold,
			}
		)
		PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
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
g.modifier_item_artifact_113 = o
return g