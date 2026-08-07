--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_91"
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
		["33"] = 25,
		["34"] = 25,
		["35"] = 25,
		["36"] = 26,
		["37"] = 26,
		["38"] = 26,
		["39"] = 26,
		["40"] = 24,
		["41"] = 28,
		["42"] = 29,
		["43"] = 28,
		["44"] = 33,
		["45"] = 34,
		["46"] = 35,
		["47"] = 36,
		["48"] = 37,
		["49"] = 38,
		["50"] = 38,
		["51"] = 38,
		["52"] = 38,
		["53"] = 38,
		["54"] = 39,
		["56"] = 41,
		["57"] = 33,
		["58"] = 21,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 21,
		["70"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_91 = c()
local n = g.item_artifact_91
n.name = "item_artifact_91"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_91"
end
n = e({ j(nil) }, n)
g.item_artifact_91 = n
g.modifier_item_artifact_91 = c()
local o = g.modifier_item_artifact_91
o.name = "modifier_item_artifact_91"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_min = math.floor(Round(self:GetAbilitySpecialValueFor("gold_min") / 10, 5))
	self.gold_max = math.floor(Round(self:GetAbilitySpecialValueFor("gold_max") / 10, 5))
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self)
	local p = self:GetParent():GetPlayerOwnerID()
	local q = RandomInt(self.gold_min, self.gold_max) * 10
	if q > 0 then
		PlayerData:modifyGold(p, q)
		PlayerData:getplayerData(p):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", q)
		EmitAnnouncerSoundForPlayer("General.Coins", p)
	end
	Notification:combatToPlayer(
		p,
		{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_91", int_gold = q }
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
g.modifier_item_artifact_91 = o
return g