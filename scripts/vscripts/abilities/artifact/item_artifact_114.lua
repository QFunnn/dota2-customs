--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_114"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 22,
		["34"] = 26,
		["35"] = 27,
		["36"] = 26,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["40"] = 34,
		["41"] = 35,
		["42"] = 36,
		["43"] = 37,
		["44"] = 38,
		["45"] = 38,
		["46"] = 38,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["50"] = 38,
		["51"] = 38,
		["52"] = 43,
		["53"] = 43,
		["54"] = 43,
		["55"] = 43,
		["56"] = 43,
		["58"] = 31,
		["59"] = 19,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 19,
		["70"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_114 = c()
local n = g.item_artifact_114
n.name = "item_artifact_114"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_114"
end
n = e({ j(nil) }, n)
g.item_artifact_114 = n
g.modifier_item_artifact_114 = c()
local o = g.modifier_item_artifact_114
o.name = "modifier_item_artifact_114"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_factor = self:GetAbilitySpecialValueFor("gold_factor")
	self.limit = self:GetAbilitySpecialValueFor("limit")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 } }
end
function o.prototype.OnPrepare(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getplayerData(q)
	local s = self:GetAbility()
	if r.health > 0 then
		local t = math.min(self.limit, r.health * self.gold_factor)
		PlayerData:modifyGold(q, t)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. s:GetAbilityName(),
				int_gold = t,
			}
		)
		r:modifyArtifactExtraData(s:entindex(), "bonus_gold", t)
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
g.modifier_item_artifact_114 = o
return g