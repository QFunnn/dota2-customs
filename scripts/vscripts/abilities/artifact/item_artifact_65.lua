--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_65"
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
		["33"] = 27,
		["34"] = 24,
		["35"] = 29,
		["36"] = 30,
		["37"] = 29,
		["38"] = 34,
		["39"] = 35,
		["40"] = 36,
		["41"] = 37,
		["42"] = 37,
		["43"] = 37,
		["44"] = 37,
		["45"] = 39,
		["46"] = 39,
		["47"] = 39,
		["48"] = 39,
		["50"] = 34,
		["51"] = 42,
		["52"] = 43,
		["53"] = 44,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 45,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 47,
		["63"] = 42,
		["64"] = 20,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 20,
		["76"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_65 = c()
local n = g.item_artifact_65
n.name = "item_artifact_65"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_65"
end
n = e({ j(nil) }, n)
g.item_artifact_65 = n
g.modifier_item_artifact_65 = c()
local o = g.modifier_item_artifact_65
o.name = "modifier_item_artifact_65"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
	self.gold_bonus_next = self:GetAbilitySpecialValueFor("gold_bonus_next")
	self.round = self:GetAbilitySpecialValueFor("round")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
	self:DecrementStackCount()
	if self:GetStackCount() == 0 then
		PlayerData:modifyGold(self:GetParent():GetPlayerOwnerID(), self.gold_bonus_next)
		EmitAnnouncerSoundForPlayer("General.Coins", self:GetParent():GetPlayerOwnerID())
	end
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self.round)
		PlayerData:modifyGold(self:GetParent():GetPlayerOwnerID(), self.gold_bonus)
		EmitAnnouncerSoundForPlayer("General.Coins", self:GetParent():GetPlayerOwnerID())
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
g.modifier_item_artifact_65 = o
return g