--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_75"
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
		["31"] = 20,
		["32"] = 23,
		["33"] = 11,
		["34"] = 24,
		["35"] = 25,
		["36"] = 26,
		["37"] = 24,
		["38"] = 28,
		["39"] = 29,
		["40"] = 30,
		["41"] = 31,
		["42"] = 32,
		["43"] = 33,
		["44"] = 34,
		["47"] = 28,
		["48"] = 38,
		["49"] = 39,
		["50"] = 38,
		["51"] = 43,
		["52"] = 44,
		["53"] = 45,
		["56"] = 46,
		["59"] = 49,
		["60"] = 50,
		["61"] = 51,
		["62"] = 52,
		["63"] = 52,
		["64"] = 52,
		["65"] = 52,
		["66"] = 52,
		["67"] = 52,
		["68"] = 52,
		["69"] = 52,
		["70"] = 57,
		["71"] = 57,
		["72"] = 57,
		["73"] = 57,
		["74"] = 57,
		["75"] = 58,
		["77"] = 43,
		["78"] = 20,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 20,
		["90"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_75 = c()
local n = g.item_artifact_75
n.name = "item_artifact_75"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_75"
end
n = e({ j(nil) }, n)
g.item_artifact_75 = n
g.modifier_item_artifact_75 = c()
local o = g.modifier_item_artifact_75
o.name = "modifier_item_artifact_75"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.used = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.level = self:GetAbilitySpecialValueFor("level")
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		if r:getLevel() >= self.level then
			PlayerData:modifyGold(q, self.gold)
			self.used = true
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function o.prototype.OnHeroLevelUp(self, p)
	local s = self:GetParent()
	if p.player_id ~= s:GetPlayerOwnerID() then
		return
	end
	if self.used then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	if p.lvl >= self.level then
		PlayerData:modifyGold(q, self.gold)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				int_gold = self.gold,
			}
		)
		PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
		self.used = true
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
g.modifier_item_artifact_75 = o
return g