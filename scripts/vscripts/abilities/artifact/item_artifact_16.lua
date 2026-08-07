--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_16"
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
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 24,
		["34"] = 28,
		["35"] = 29,
		["36"] = 28,
		["37"] = 34,
		["38"] = 35,
		["39"] = 34,
		["40"] = 37,
		["41"] = 38,
		["42"] = 37,
		["43"] = 40,
		["44"] = 41,
		["45"] = 40,
		["46"] = 46,
		["47"] = 47,
		["48"] = 48,
		["49"] = 49,
		["50"] = 49,
		["51"] = 49,
		["52"] = 49,
		["53"] = 49,
		["55"] = 46,
		["56"] = 52,
		["57"] = 53,
		["58"] = 54,
		["59"] = 55,
		["60"] = 56,
		["62"] = 52,
		["63"] = 20,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 20,
		["75"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_16 = c()
local n = g.item_artifact_16
n.name = "item_artifact_16"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_16"
end
n = e({ j(nil) }, n)
g.item_artifact_16 = n
g.modifier_item_artifact_16 = c()
local o = g.modifier_item_artifact_16
o.name = "modifier_item_artifact_16"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.extra_bonus = self:GetAbilitySpecialValueFor("extra_bonus")
	self.extra_bonus_limit = self:GetAbilitySpecialValueFor("extra_bonus_limit")
end
function o.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_BONUS_LIMIT,
	}
end
function o.prototype.EOM_GetModifierExtraBonus(self)
	return self.extra_bonus
end
function o.prototype.EOM_GetModifierExtraBonus_Limit(self)
	return self.extra_bonus_limit
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_GET_INTEREST] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function o.prototype.OnGetInterest(self, p)
	if p.battleGold > 0 and self.isWin then
		self.isWin = false
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.extra_bonus)
	end
end
function o.prototype.OnBattleEnd(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = p.illusionPlayerID == nil or p.illusionPlayerID ~= q
	if r and p.winPlayerID == q then
		self.isWin = true
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
g.modifier_item_artifact_16 = o
return g