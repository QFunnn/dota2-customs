--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_83"
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
		["53"] = 45,
		["55"] = 47,
		["57"] = 47,
		["59"] = 48,
		["60"] = 48,
		["61"] = 48,
		["62"] = 48,
		["63"] = 48,
		["64"] = 49,
		["65"] = 33,
		["66"] = 21,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 21,
		["78"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_83 = c()
local n = g.item_artifact_83
n.name = "item_artifact_83"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_83"
end
n = e({ j(nil) }, n)
g.item_artifact_83 = n
g.modifier_item_artifact_83 = c()
local o = g.modifier_item_artifact_83
o.name = "modifier_item_artifact_83"
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
	local s = GetRandomElement(AbilityShop.pickList)
	local t = self.count
	if p.winPlayerID == q then
		t = t + self.win_count
	end
	local u = PlayerData:getHero(q)
	if u ~= nil then
		u:addSectExp(s, t)
	end
	PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "exp_gain", t)
	Notification:combatToPlayer(
		q,
		{
			message = "notify_artifact_48",
			string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_83",
			string_sect = "DOTA_Tooltip_ability_" .. s,
			int_exp = t,
		}
	)
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
g.modifier_item_artifact_83 = o
return g