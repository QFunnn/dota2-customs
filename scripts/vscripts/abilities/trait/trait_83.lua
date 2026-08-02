--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_83"
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
		["31"] = 19,
		["32"] = 23,
		["33"] = 12,
		["34"] = 24,
		["35"] = 25,
		["36"] = 26,
		["37"] = 27,
		["38"] = 24,
		["39"] = 29,
		["40"] = 30,
		["41"] = 29,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["46"] = 38,
		["47"] = 39,
		["48"] = 40,
		["49"] = 41,
		["50"] = 41,
		["51"] = 41,
		["52"] = 41,
		["53"] = 41,
		["54"] = 41,
		["55"] = 41,
		["56"] = 41,
		["57"] = 46,
		["58"] = 46,
		["59"] = 46,
		["60"] = 46,
		["61"] = 46,
		["64"] = 49,
		["65"] = 50,
		["66"] = 50,
		["67"] = 50,
		["68"] = 50,
		["69"] = 50,
		["71"] = 34,
		["72"] = 19,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 19,
		["82"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_83 = c()
local n = g.trait_83
n.name = "trait_83"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_83"
end
n = e({ j(nil) }, n)
g.trait_83 = n
g.modifier_trait_83 = c()
local o = g.modifier_trait_83
o.name = "modifier_trait_83"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.lossStack = 0
end
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.base = self:GetAbilitySpecialValueFor("base")
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	if self:PRD(self.chance) then
		local r = PlayerData:getplayerData(q)
		if r then
			local s = (self.base + self.lossStack) * self.gold
			PlayerData:modifyGold(q, s)
			Notification:combatToPlayer(
				q,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					int_gold = s,
				}
			)
			PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", s)
		end
	else
		self.lossStack = self.lossStack + 1
		PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "roll_fail_count", 1)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_83 = o
return g