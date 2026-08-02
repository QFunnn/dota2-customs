--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_97"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 24,
		["34"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 28,
		["40"] = 29,
		["41"] = 30,
		["42"] = 30,
		["44"] = 31,
		["45"] = 31,
		["46"] = 31,
		["47"] = 31,
		["48"] = 31,
		["49"] = 31,
		["50"] = 31,
		["51"] = 31,
		["52"] = 31,
		["53"] = 37,
		["54"] = 37,
		["55"] = 37,
		["56"] = 37,
		["57"] = 37,
		["58"] = 24,
		["59"] = 40,
		["60"] = 41,
		["61"] = 40,
		["62"] = 45,
		["63"] = 46,
		["64"] = 47,
		["65"] = 48,
		["66"] = 49,
		["67"] = 50,
		["68"] = 50,
		["70"] = 51,
		["71"] = 51,
		["72"] = 51,
		["73"] = 51,
		["74"] = 51,
		["75"] = 51,
		["76"] = 51,
		["77"] = 51,
		["78"] = 51,
		["79"] = 57,
		["80"] = 57,
		["81"] = 57,
		["82"] = 57,
		["83"] = 57,
		["84"] = 45,
		["85"] = 19,
		["86"] = 12,
		["87"] = 12,
		["88"] = 12,
		["89"] = 12,
		["90"] = 12,
		["91"] = 12,
		["92"] = 12,
		["93"] = 19,
		["95"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_97 = c()
local n = g.trait_97
n.name = "trait_97"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_97"
end
n = e({ j(nil) }, n)
g.trait_97 = n
g.modifier_trait_97 = c()
local o = g.modifier_trait_97
o.name = "modifier_trait_97"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.OnCreated(self, p)
	if not PlayerData then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getHero(q)
	local s = GetRandomElement(AbilityShop.pickList)
	local t = self.count
	if r ~= nil then
		r:addSectExp(s, t)
	end
	Notification:combatToPlayer(
		q,
		{
			message = "notify_artifact_48",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			string_sect = "DOTA_Tooltip_ability_" .. s,
			int_exp = t,
		}
	)
	PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "exp_gain", t)
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getHero(q)
	local s = GetRandomElement(AbilityShop.pickList)
	local t = self.count
	if r ~= nil then
		r:addSectExp(s, t)
	end
	Notification:combatToPlayer(
		q,
		{
			message = "notify_artifact_48",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			string_sect = "DOTA_Tooltip_ability_" .. s,
			int_exp = t,
		}
	)
	PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "exp_gain", t)
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_97 = o
return g