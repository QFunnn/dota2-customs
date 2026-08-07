--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_54"
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
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["35"] = 25,
		["36"] = 32,
		["37"] = 33,
		["38"] = 32,
		["39"] = 38,
		["40"] = 39,
		["41"] = 38,
		["42"] = 43,
		["43"] = 44,
		["44"] = 45,
		["45"] = 45,
		["46"] = 44,
		["47"] = 43,
		["48"] = 49,
		["49"] = 50,
		["50"] = 51,
		["52"] = 53,
		["53"] = 49,
		["54"] = 55,
		["55"] = 56,
		["56"] = 57,
		["57"] = 58,
		["58"] = 58,
		["59"] = 58,
		["60"] = 58,
		["61"] = 58,
		["63"] = 55,
		["64"] = 19,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 19,
		["75"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_54 = c()
local n = g.item_artifact_54
n.name = "item_artifact_54"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_54"
end
n = e({ j(nil) }, n)
g.item_artifact_54 = n
g.modifier_item_artifact_54 = c()
local o = g.modifier_item_artifact_54
o.name = "modifier_item_artifact_54"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.max_stack_gold = self:GetAbilitySpecialValueFor("max_stack_gold")
	self.interest_rate_reduce = self:GetAbilitySpecialValueFor("interest_rate_reduce")
	self.calculated_bonus_interest = self:GetAbilitySpecialValueFor("calculated_bonus_interest")
	self.city_effected_bonus = self:GetAbilitySpecialValueFor("city_effected_bonus")
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INTEREST_RATE_CONSTANT] = -self.interest_rate_reduce }
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_GET_INTEREST] = { self:GetParent(), -1 } }
end
function o.prototype.EOM_GetModifierExtraInterest_Limit(self, p)
	if CityEffect:getCityEffect() == "city_2" then
		return self.city_effected_bonus
	end
	return self.calculated_bonus_interest
end
function o.prototype.OnGetInterest(self, p)
	local q = getInterestConfig(nil)
	if p.interest > q.Max then
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", p.interest - q.Max)
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
g.modifier_item_artifact_54 = o
return g