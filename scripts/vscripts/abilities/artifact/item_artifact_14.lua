--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_14"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 2,
		["10"] = 2,
		["11"] = 2,
		["12"] = 3,
		["13"] = 3,
		["14"] = 3,
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
		["31"] = 23,
		["32"] = 24,
		["33"] = 23,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 28,
		["38"] = 27,
		["39"] = 26,
		["40"] = 31,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["48"] = 31,
		["49"] = 21,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 21,
		["61"] = 21,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_14 = c()
local o = h.item_artifact_14
o.name = "item_artifact_14"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_14"
end
o = e({ k(nil) }, o)
h.item_artifact_14 = o
h.modifier_item_artifact_14 = c()
local p = h.modifier_item_artifact_14
p.name = "modifier_item_artifact_14"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.exp_bonus = self:GetAbilitySpecialValueFor("exp_bonus")
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function p.prototype.OnAbilityLearn(self, q)
	local r = q.abilityUpgradeInfo.rarity
	if r == "r" then
		local s = f(q.abilityUpgradeInfo.sect, "|")
		for t, u in ipairs(s) do
			q.heroclass:addSectExp(u, self.exp_bonus)
		end
	end
end
p = e(
	{
		n(
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
	p
)
h.modifier_item_artifact_14 = p
return h