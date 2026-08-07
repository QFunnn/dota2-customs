--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_139"
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
		["18"] = 5,
		["19"] = 5,
		["20"] = 5,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 7,
		["27"] = 8,
		["28"] = 7,
		["29"] = 8,
		["30"] = 11,
		["31"] = 12,
		["32"] = 13,
		["33"] = 11,
		["34"] = 15,
		["35"] = 15,
		["36"] = 15,
		["37"] = 16,
		["38"] = 17,
		["41"] = 18,
		["42"] = 19,
		["45"] = 20,
		["46"] = 21,
		["47"] = 22,
		["48"] = 22,
		["49"] = 22,
		["50"] = 22,
		["51"] = 22,
		["52"] = 23,
		["53"] = 23,
		["54"] = 23,
		["55"] = 23,
		["56"] = 23,
		["57"] = 23,
		["58"] = 23,
		["59"] = 16,
		["60"] = 8,
		["61"] = 7,
		["62"] = 7,
		["63"] = 7,
		["64"] = 7,
		["65"] = 7,
		["66"] = 7,
		["67"] = 7,
		["68"] = 7,
		["69"] = 8,
		["71"] = 8,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_139 = c()
local n = g.item_artifact_139
n.name = "item_artifact_139"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_139"
end
n = e({ j(nil) }, n)
g.item_artifact_139 = n
g.modifier_item_artifact_139 = c()
local o = g.modifier_item_artifact_139
o.name = "modifier_item_artifact_139"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.health = self:GetAbilitySpecialValueFor("health")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function o.prototype.OnBattleEnd(self, p)
	if
		p.isNeutral
		or p.illusionPlayerID
		or p.winPlayerID ~= self:GetParent():GetPlayerOwnerID()
		or not RollPercentage(self.chance)
	then
		return
	end
	local q = p.losePlayerID ~= nil and p.losePlayerID or p.illusionPlayerID
	if q == nil then
		return
	end
	PlayerData:modifyHealth(p.winPlayerID, self.health, true)
	local r = self:GetParent()
	PlayerData:getplayerData(p.winPlayerID)
		:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_health", self.health)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, r, self.health, r:GetPlayerOwner())
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
g.modifier_item_artifact_139 = o
return g