--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_50"
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
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["41"] = 34,
		["42"] = 36,
		["43"] = 36,
		["44"] = 36,
		["45"] = 36,
		["46"] = 37,
		["47"] = 37,
		["48"] = 37,
		["49"] = 37,
		["50"] = 37,
		["51"] = 39,
		["52"] = 39,
		["53"] = 39,
		["54"] = 39,
		["55"] = 31,
		["56"] = 20,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 20,
		["68"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_50 = c()
local n = g.item_artifact_50
n.name = "item_artifact_50"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_50"
end
n = e({ j(nil) }, n)
g.item_artifact_50 = n
g.modifier_item_artifact_50 = c()
local o = g.modifier_item_artifact_50
o.name = "modifier_item_artifact_50"
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
	local r = p.lvl * self.gold
	PlayerData:modifyGold(q:GetPlayerOwnerID(), r)
	PlayerData:getplayerData(q:GetPlayerOwnerID())
		:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", r)
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_50 = o
return g