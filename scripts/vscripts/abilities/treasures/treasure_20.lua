--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_20"
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
		["26"] = 10,
		["27"] = 17,
		["28"] = 10,
		["29"] = 17,
		["30"] = 19,
		["31"] = 20,
		["32"] = 19,
		["33"] = 22,
		["34"] = 26,
		["35"] = 22,
		["36"] = 30,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["40"] = 33,
		["41"] = 33,
		["42"] = 33,
		["43"] = 33,
		["44"] = 33,
		["46"] = 34,
		["47"] = 35,
		["48"] = 35,
		["49"] = 35,
		["50"] = 35,
		["51"] = 35,
		["52"] = 35,
		["54"] = 30,
		["55"] = 17,
		["56"] = 10,
		["57"] = 10,
		["58"] = 10,
		["59"] = 10,
		["60"] = 10,
		["61"] = 10,
		["62"] = 10,
		["63"] = 17,
		["65"] = 17,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_20 = c()
local n = g.treasure_20
n.name = "treasure_20"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_20"
end
n = e({ j(nil) }, n)
g.treasure_20 = n
g.modifier_treasure_20 = c()
local o = g.modifier_treasure_20
o.name = "modifier_treasure_20"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function o.prototype.OnBattleStartBefore(self)
	local p = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	if IsValid(p.illusion) then
		AddStateImmunity(self:GetParent(), p.illusion, self:GetAbility(), self.duration)
	end
	if IsValid(p.hero) then
		AddStateImmunity(self:GetParent(), p.hero, self:GetAbility(), self.duration)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_20 = o
return g