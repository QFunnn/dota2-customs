--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
		["42"] = 28,
		["43"] = 33,
		["44"] = 34,
		["45"] = 33,
		["46"] = 38,
		["47"] = 39,
		["50"] = 40,
		["51"] = 38,
		["52"] = 43,
		["53"] = 44,
		["56"] = 45,
		["57"] = 46,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 47,
		["62"] = 48,
		["65"] = 49,
		["66"] = 50,
		["67"] = 51,
		["68"] = 51,
		["69"] = 51,
		["70"] = 51,
		["71"] = 51,
		["72"] = 51,
		["73"] = 51,
		["74"] = 51,
		["75"] = 56,
		["76"] = 56,
		["77"] = 56,
		["78"] = 56,
		["79"] = 56,
		["80"] = 43,
		["81"] = 20,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 11,
		["89"] = 11,
		["90"] = 11,
		["91"] = 20,
		["93"] = 20,
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
		self:tryGrantGold()
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function o.prototype.OnHeroLevelUp(self, p)
	if p.player_id ~= self:GetParent():GetPlayerOwnerID() then
		return
	end
	self:tryGrantGold(p.lvl)
end
function o.prototype.tryGrantGold(self, q)
	if self.used then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	local s = PlayerData:getHero(r)
	local t = math.max(q or 0, s and s:getLevel() or 0)
	if t < self.level then
		return
	end
	self.used = true
	PlayerData:modifyGold(r, self.gold)
	Notification:combatToPlayer(
		r,
		{
			message = "notify_bonus_gold",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			int_gold = self.gold,
		}
	)
	PlayerData:getplayerData(r):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
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