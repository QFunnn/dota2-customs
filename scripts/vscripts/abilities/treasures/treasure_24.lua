--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_24"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["36"] = 28,
		["37"] = 27,
		["38"] = 26,
		["39"] = 32,
		["40"] = 33,
		["41"] = 34,
		["44"] = 35,
		["45"] = 36,
		["46"] = 37,
		["47"] = 37,
		["48"] = 37,
		["49"] = 37,
		["50"] = 37,
		["51"] = 37,
		["52"] = 37,
		["53"] = 37,
		["54"] = 32,
		["55"] = 19,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 19,
		["65"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_24 = c()
local n = g.treasure_24
n.name = "treasure_24"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_24"
end
n = e({ j(nil) }, n)
g.treasure_24 = n
g.modifier_treasure_24 = c()
local o = g.modifier_treasure_24
o.name = "modifier_treasure_24"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function o.prototype.OnAbilityLearn(self, p)
	local q = SECT_ABILITY_LEVEL[p.abilityUpgradeInfo.rarity]
	if p.heroclass:getAbilityUpgradeLevel(p.abilityname) < q then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	PlayerData:modifyGold(r, self.gold)
	Notification:combatToPlayer(
		r,
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
g.modifier_treasure_24 = o
return g