--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_51"
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
		["30"] = 19,
		["31"] = 20,
		["32"] = 21,
		["33"] = 21,
		["34"] = 20,
		["35"] = 19,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 25,
		["45"] = 18,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 18,
		["55"] = 18,
		["56"] = 31,
		["57"] = 38,
		["58"] = 31,
		["59"] = 38,
		["60"] = 43,
		["61"] = 44,
		["62"] = 45,
		["63"] = 46,
		["64"] = 43,
		["65"] = 49,
		["66"] = 50,
		["67"] = 49,
		["68"] = 54,
		["69"] = 55,
		["70"] = 56,
		["71"] = 57,
		["72"] = 54,
		["73"] = 60,
		["74"] = 61,
		["75"] = 60,
		["76"] = 64,
		["77"] = 65,
		["78"] = 64,
		["79"] = 38,
		["80"] = 31,
		["81"] = 31,
		["82"] = 31,
		["83"] = 31,
		["84"] = 31,
		["85"] = 31,
		["86"] = 31,
		["87"] = 38,
		["89"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_51 = c()
local n = g.treasure_51
n.name = "treasure_51"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_51"
end
n = e({ j(nil) }, n)
g.treasure_51 = n
g.modifier_treasure_51 = c()
local o = g.modifier_treasure_51
o.name = "modifier_treasure_51"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_treasure_51_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_51_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_51 = o
g.modifier_treasure_51_buff = c()
local q = g.modifier_treasure_51_buff
q.name = "modifier_treasure_51_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.base = self:GetAbilitySpecialValueFor("base")
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.expBonus = self:GetAbilitySpecialValueFor("exp_bonus")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function q.prototype.OnBattleStartBefore(self, p)
	local r = self:GetParent():GetPlayerOwnerID()
	local s = PlayerData:getHero(r):getSectAbilityExp("sect_shield")
	self:SetStackCount(math.max(0, s - self.threshold) * self.expBonus)
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT }
end
function q.prototype.EOM_GetModifierShieldPermanent(self)
	return self.base + self:GetStackCount()
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_51_buff = q
return g