--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_78"
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
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 28,
		["35"] = 25,
		["36"] = 30,
		["37"] = 31,
		["38"] = 30,
		["39"] = 35,
		["40"] = 36,
		["41"] = 37,
		["42"] = 38,
		["43"] = 39,
		["44"] = 39,
		["45"] = 39,
		["46"] = 39,
		["47"] = 39,
		["48"] = 40,
		["49"] = 41,
		["50"] = 42,
		["51"] = 42,
		["52"] = 42,
		["53"] = 42,
		["54"] = 42,
		["55"] = 43,
		["56"] = 43,
		["57"] = 43,
		["58"] = 43,
		["59"] = 43,
		["60"] = 43,
		["61"] = 43,
		["64"] = 35,
		["65"] = 21,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 21,
		["77"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_78 = c()
local n = g.item_artifact_78
n.name = "item_artifact_78"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_78"
end
n = e({ j(nil) }, n)
g.item_artifact_78 = n
g.modifier_item_artifact_78 = c()
local o = g.modifier_item_artifact_78
o.name = "modifier_item_artifact_78"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
	self.max_regen = self:GetAbilitySpecialValueFor("max_regen")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_BEFORE_PREPARE] = { -1, -1 } }
end
function o.prototype.OnBeforePrepare(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = math.floor(PlayerData:getGold(q) / self.gold_bonus)
	if r > 0 then
		local s = math.min(self.max_regen, PlayerData:GetLossHealth(q), self.hp_regen * r)
		if s > 0 then
			PlayerData:modifyHealth(q, s)
			PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_health", s)
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), s, self:GetParent():GetPlayerOwner())
		end
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
g.modifier_item_artifact_78 = o
return g