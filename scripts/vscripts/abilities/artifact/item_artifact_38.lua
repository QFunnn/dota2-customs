--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_38"
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
		["37"] = 28,
		["38"] = 28,
		["39"] = 28,
		["40"] = 29,
		["41"] = 29,
		["42"] = 29,
		["43"] = 29,
		["44"] = 29,
		["45"] = 29,
		["46"] = 29,
		["48"] = 25,
		["49"] = 20,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 11,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 20,
		["61"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = k.EOMModifier
g.item_artifact_38 = c()
local n = g.item_artifact_38
n.name = "item_artifact_38"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_38"
end
n = e({ j(nil) }, n)
g.item_artifact_38 = n
g.modifier_item_artifact_38 = c()
local o = g.modifier_item_artifact_38
o.name = "modifier_item_artifact_38"
d(o, m)
function o.prototype.GetAbilitySpecialValue(self)
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent()
		PlayerData:modifyHealth(q:GetPlayerOwnerID(), self.hp_regen)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, q, self.hp_regen, q:GetPlayerOwner())
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
g.modifier_item_artifact_38 = o
return g