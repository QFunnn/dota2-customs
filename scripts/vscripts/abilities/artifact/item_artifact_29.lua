--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_29"
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
		["35"] = 25,
		["36"] = 30,
		["37"] = 31,
		["38"] = 30,
		["39"] = 35,
		["40"] = 36,
		["41"] = 37,
		["42"] = 38,
		["44"] = 35,
		["45"] = 41,
		["46"] = 42,
		["47"] = 43,
		["48"] = 44,
		["49"] = 45,
		["50"] = 46,
		["51"] = 46,
		["52"] = 46,
		["53"] = 46,
		["54"] = 46,
		["55"] = 47,
		["57"] = 41,
		["58"] = 20,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 20,
		["70"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_29 = c()
local n = g.item_artifact_29
n.name = "item_artifact_29"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_29"
end
n = e({ j(nil) }, n)
g.item_artifact_29 = n
g.modifier_item_artifact_29 = c()
local o = g.modifier_item_artifact_29
o.name = "modifier_item_artifact_29"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES }
end
function o.prototype.OnBattleEnd(self, p)
	if
		self:GetParent():GetPlayerOwnerID() == p.losePlayerID
		and p.illusionPlayerID ~= p.losePlayerID
		and p.isNeutral == nil
	then
		self:SetStackCount(self.gold_bonus)
		self:GetAbility():SetCurrentCharges(self:GetStackCount())
	end
end
function o.prototype.EOM_GetModifierExtraWages(self)
	if IsServer() then
		local q = self:GetStackCount()
		self:SetStackCount(0)
		self:GetAbility():SetCurrentCharges(0)
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", q)
		return q
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
g.modifier_item_artifact_29 = o
return g