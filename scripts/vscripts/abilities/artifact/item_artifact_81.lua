--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_81"
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
		["31"] = 23,
		["32"] = 24,
		["33"] = 23,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["39"] = 26,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["44"] = 32,
		["45"] = 37,
		["46"] = 38,
		["47"] = 37,
		["48"] = 42,
		["49"] = 43,
		["50"] = 42,
		["51"] = 21,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 21,
		["63"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_81 = c()
local n = g.item_artifact_81
n.name = "item_artifact_81"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_81"
end
n = e({ j(nil) }, n)
g.item_artifact_81 = n
g.modifier_item_artifact_81 = c()
local o = g.modifier_item_artifact_81
o.name = "modifier_item_artifact_81"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance_bonus = self:GetAbilitySpecialValueFor("chance_bonus")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:OnIntervalThink()
		self:StartIntervalThink(1)
	end
end
function o.prototype.OnIntervalThink(self)
	if IsServer() then
		self:GetAbility():SetCurrentCharges(PlayerData:getArtifactCount(self:GetParent():GetPlayerOwnerID()))
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_RARE_CHANCE_BONUS }
end
function o.prototype.EOM_GetModifierRareChanceBonus(self)
	return self:GetAbility():GetCurrentCharges() * self.chance_bonus
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
g.modifier_item_artifact_81 = o
return g