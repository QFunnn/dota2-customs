--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_90"
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
		["31"] = 25,
		["32"] = 26,
		["33"] = 26,
		["34"] = 26,
		["35"] = 26,
		["36"] = 27,
		["37"] = 27,
		["38"] = 27,
		["39"] = 27,
		["40"] = 28,
		["41"] = 25,
		["42"] = 30,
		["43"] = 31,
		["44"] = 30,
		["45"] = 35,
		["46"] = 36,
		["47"] = 37,
		["48"] = 38,
		["49"] = 39,
		["50"] = 40,
		["51"] = 40,
		["52"] = 40,
		["53"] = 40,
		["54"] = 40,
		["55"] = 41,
		["57"] = 43,
		["58"] = 35,
		["59"] = 21,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 21,
		["71"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_90 = c()
local n = g.item_artifact_90
n.name = "item_artifact_90"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_90"
end
n = e({ j(nil) }, n)
g.item_artifact_90 = n
g.modifier_item_artifact_90 = c()
local o = g.modifier_item_artifact_90
o.name = "modifier_item_artifact_90"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_min = math.floor(Round(self:GetAbilitySpecialValueFor("gold_min") / 10, 5))
	self.gold_max = math.floor(Round(self:GetAbilitySpecialValueFor("gold_max") / 10, 5))
	self.round_gold = self:GetAbilitySpecialValueFor("round_gold")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self)
	local p = self:GetParent():GetPlayerOwnerID()
	local q = self.round_gold + RandomInt(self.gold_min, self.gold_max) * 10
	if q > 0 then
		PlayerData:modifyGold(p, q)
		PlayerData:getplayerData(p):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", q)
		EmitAnnouncerSoundForPlayer("General.Coins", p)
	end
	Notification:combatToPlayer(
		p,
		{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_90", int_gold = q }
	)
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
g.modifier_item_artifact_90 = o
return g