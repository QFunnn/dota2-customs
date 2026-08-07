--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_15"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 28,
		["36"] = 27,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["43"] = 38,
		["44"] = 38,
		["45"] = 38,
		["46"] = 38,
		["47"] = 38,
		["48"] = 39,
		["49"] = 39,
		["50"] = 39,
		["51"] = 39,
		["52"] = 39,
		["53"] = 39,
		["54"] = 39,
		["56"] = 32,
		["57"] = 20,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 20,
		["69"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_15 = c()
local n = g.item_artifact_15
n.name = "item_artifact_15"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_15"
end
n = e({ j(nil) }, n)
g.item_artifact_15 = n
g.modifier_item_artifact_15 = c()
local o = g.modifier_item_artifact_15
o.name = "modifier_item_artifact_15"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self, p)
	local q = self:GetParent()
	local r = q:GetPlayerOwnerID()
	local s = PlayerData:getplayerData(r)
	if PlayerData:isAlivePlayer(r) and s and s.health < self.threshold then
		PlayerData:modifyHealth(r, self.hp_regen)
		s:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_health", self.hp_regen)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, q, self.hp_regen, q:GetPlayerOwner())
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
g.modifier_item_artifact_15 = o
return g