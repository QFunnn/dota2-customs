--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_42"
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
		["27"] = 18,
		["28"] = 11,
		["29"] = 18,
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 22,
		["34"] = 27,
		["35"] = 28,
		["36"] = 27,
		["37"] = 33,
		["38"] = 34,
		["41"] = 38,
		["42"] = 39,
		["43"] = 40,
		["44"] = 41,
		["45"] = 41,
		["46"] = 41,
		["47"] = 41,
		["48"] = 41,
		["49"] = 41,
		["50"] = 41,
		["51"] = 42,
		["52"] = 43,
		["53"] = 43,
		["54"] = 43,
		["55"] = 43,
		["56"] = 43,
		["57"] = 43,
		["58"] = 43,
		["59"] = 43,
		["60"] = 33,
		["61"] = 18,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 18,
		["71"] = 18,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_42 = c()
local n = g.treasure_42
n.name = "treasure_42"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_42"
end
n = e({ j(nil) }, n)
g.treasure_42 = n
g.modifier_treasure_42 = c()
local o = g.modifier_treasure_42
o.name = "modifier_treasure_42"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.health = self:GetAbilitySpecialValueFor("health")
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = {} }
end
function o.prototype.OnRoundChange(self)
	if not IsServer() then
		return
	end
	local p = self:GetParent():GetPlayerOwnerID()
	local q = PlayerResource:GetSelectedHeroEntity(p)
	PlayerData:modifyHealth(p, self.health)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, q, self.health, q:GetPlayerOwner())
	PlayerData:modifyGold(p, self.gold)
	Notification:combatToPlayer(
		p,
		{
			message = "notify_bonus_gold",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			int_gold = self.gold,
		}
	)
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_42 = o
return g