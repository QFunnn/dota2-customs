--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_27"
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
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["38"] = 26,
		["39"] = 20,
		["40"] = 11,
		["41"] = 11,
		["42"] = 11,
		["43"] = 11,
		["44"] = 11,
		["45"] = 11,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 20,
		["51"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = k.EOMModifier
g.item_artifact_27 = c()
local n = g.item_artifact_27
n.name = "item_artifact_27"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_27"
end
n = e({ j(nil) }, n)
g.item_artifact_27 = n
g.modifier_item_artifact_27 = c()
local o = g.modifier_item_artifact_27
o.name = "modifier_item_artifact_27"
d(o, m)
function o.prototype.GetAbilitySpecialValue(self)
	self.legend_free = self:GetAbilitySpecialValueFor("legend_free")
end
function o.prototype.OnCreated(self, p)
	if self.legend_free == 1 and IsServer() then
		PlayerData.playerData[self:GetParent():GetPlayerOwnerID()].abilityLegendFree = true
		PlayerData:updateNetTable()
	end
end
o = e(
	{
		l(
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
g.modifier_item_artifact_27 = o
return g