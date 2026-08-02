--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_82"
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
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 24,
		["35"] = 28,
		["36"] = 29,
		["37"] = 28,
		["38"] = 33,
		["39"] = 34,
		["42"] = 37,
		["43"] = 38,
		["46"] = 39,
		["47"] = 40,
		["50"] = 42,
		["51"] = 43,
		["52"] = 44,
		["54"] = 46,
		["55"] = 47,
		["56"] = 48,
		["57"] = 49,
		["58"] = 49,
		["59"] = 49,
		["60"] = 49,
		["61"] = 49,
		["62"] = 33,
		["63"] = 21,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 21,
		["75"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_82 = c()
local n = g.item_artifact_82
n.name = "item_artifact_82"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_82"
end
n = e({ j(nil) }, n)
g.item_artifact_82 = n
g.modifier_item_artifact_82 = c()
local o = g.modifier_item_artifact_82
o.name = "modifier_item_artifact_82"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.win_count = self:GetAbilitySpecialValueFor("win_count")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function o.prototype.OnBattleEnd(self, p)
	if p.isNeutral ~= nil then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	if not (q == p.losePlayerID or q == p.winPlayerID) then
		return
	end
	local r = p.illusionPlayerID ~= nil and p.illusionPlayerID == q
	if r then
		return
	end
	local s = self.count
	if p.winPlayerID == q then
		s = s + self.win_count
	end
	self:IncrementStackCount(s)
	PlayerData:ModifyFreeRefresh(q, s)
	PlayerData:ModifyFreeRefreshByKey(q, "item_artifact_82", s)
	PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "free_refresh_count", s)
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
g.modifier_item_artifact_82 = o
return g