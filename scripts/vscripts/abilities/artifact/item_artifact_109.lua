--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_109"
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
		["30"] = 22,
		["31"] = 23,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["39"] = 27,
		["40"] = 32,
		["41"] = 22,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 34,
		["46"] = 38,
		["47"] = 39,
		["48"] = 38,
		["49"] = 44,
		["50"] = 45,
		["51"] = 46,
		["52"] = 47,
		["53"] = 48,
		["54"] = 49,
		["55"] = 50,
		["56"] = 50,
		["57"] = 50,
		["58"] = 50,
		["59"] = 50,
		["60"] = 50,
		["61"] = 50,
		["62"] = 50,
		["63"] = 55,
		["64"] = 55,
		["65"] = 55,
		["66"] = 55,
		["67"] = 55,
		["68"] = 44,
		["69"] = 57,
		["70"] = 58,
		["71"] = 57,
		["72"] = 19,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 19,
		["83"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_109 = c()
local n = g.item_artifact_109
n.name = "item_artifact_109"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_109"
end
n = e({ j(nil) }, n)
g.item_artifact_109 = n
g.modifier_item_artifact_109 = c()
local o = g.modifier_item_artifact_109
o.name = "modifier_item_artifact_109"
d(o, l)
function o.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local p = 0
	PlayerData:eachPlayer(function(q, r, s)
		if not PlayerData:isAlivePlayer(s) then
			p = p + 1
		end
	end)
	self:SetStackCount(p)
end
function o.prototype.GetAbilitySpecialValue(self)
	self.base_gold = self:GetAbilitySpecialValueFor("base_gold")
	self.extra_gold = self:GetAbilitySpecialValueFor("extra_gold")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_KILLED] = { -1, -1 },
	}
end
function o.prototype.OnPrepare(self, t)
	local s = self:GetParent():GetPlayerOwnerID()
	local u = PlayerData:getplayerData(s)
	local v = self:GetAbility()
	local w = self.base_gold + self.extra_gold * self:GetStackCount()
	PlayerData:modifyGold(s, w)
	Notification:combatToPlayer(
		s,
		{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_" .. v:GetAbilityName(), int_gold = w }
	)
	u:modifyArtifactExtraData(v:entindex(), "bonus_gold", w)
end
function o.prototype.OnPlayerKilled(self, x)
	self:IncrementStackCount()
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
g.modifier_item_artifact_109 = o
return g