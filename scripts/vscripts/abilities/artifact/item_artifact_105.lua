--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_105"
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
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 24,
		["34"] = 25,
		["35"] = 24,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["41"] = 32,
		["42"] = 33,
		["43"] = 34,
		["44"] = 35,
		["45"] = 35,
		["46"] = 35,
		["47"] = 35,
		["48"] = 35,
		["49"] = 36,
		["50"] = 36,
		["51"] = 36,
		["52"] = 36,
		["53"] = 29,
		["54"] = 19,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 19,
		["65"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_105 = c()
local n = g.item_artifact_105
n.name = "item_artifact_105"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_105"
end
n = e({ j(nil) }, n)
g.item_artifact_105 = n
g.modifier_item_artifact_105 = c()
local o = g.modifier_item_artifact_105
o.name = "modifier_item_artifact_105"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function o.prototype.OnHeroLevelUp(self, p)
	local q = self:GetParent()
	if p.player_id ~= q:GetPlayerOwnerID() then
		return
	end
	local r = self.gold * p.up_lvl
	local s = q:GetPlayerOwnerID()
	PlayerData:modifyGold(s, r)
	PlayerData:getplayerData(s):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", r)
	EmitAnnouncerSoundForPlayer("General.Coins", self:GetParent():GetPlayerOwnerID())
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
g.modifier_item_artifact_105 = o
return g