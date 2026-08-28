--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_62"
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
		["30"] = 25,
		["31"] = 26,
		["32"] = 25,
		["33"] = 29,
		["34"] = 30,
		["35"] = 31,
		["36"] = 32,
		["37"] = 29,
		["38"] = 34,
		["39"] = 35,
		["40"] = 34,
		["41"] = 39,
		["42"] = 40,
		["43"] = 39,
		["44"] = 44,
		["45"] = 45,
		["46"] = 46,
		["47"] = 47,
		["48"] = 48,
		["49"] = 50,
		["50"] = 50,
		["51"] = 50,
		["52"] = 50,
		["53"] = 52,
		["55"] = 44,
		["56"] = 55,
		["57"] = 56,
		["58"] = 57,
		["59"] = 58,
		["61"] = 55,
		["62"] = 61,
		["63"] = 62,
		["64"] = 63,
		["66"] = 65,
		["67"] = 61,
		["68"] = 20,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 20,
		["80"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_62 = c()
local n = g.item_artifact_62
n.name = "item_artifact_62"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_62"
end
n = e({ j(nil) }, n)
g.item_artifact_62 = n
g.modifier_item_artifact_62 = c()
local o = g.modifier_item_artifact_62
o.name = "modifier_item_artifact_62"
d(o, l)
function o.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
	self.rounds = self:GetAbilitySpecialValueFor("rounds")
	self.gold_reduce = self:GetAbilitySpecialValueFor("gold_reduce")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_END] = { -1, -1 } }
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self.rounds)
		self:GetAbility():SetCurrentCharges(self:GetStackCount())
		local q = self:GetParent()
		PlayerData:modifyGold(q:GetPlayerOwnerID(), self.gold_bonus)
		EmitSoundOn("DOTA_Item.Hand_Of_Midas", q)
	end
end
function o.prototype.OnRoundEnd(self)
	if self:GetStackCount() > 0 then
		self:DecrementStackCount()
		self:GetAbility():SetCurrentCharges(self:GetStackCount())
	end
end
function o.prototype.EOM_GetModifierExtraWages(self)
	if self:GetStackCount() > 0 then
		return -self.gold_reduce
	end
	return 0
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
g.modifier_item_artifact_62 = o
return g