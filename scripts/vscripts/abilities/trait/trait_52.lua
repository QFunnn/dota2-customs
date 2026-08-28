--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_52"
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
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 22,
		["34"] = 21,
		["35"] = 20,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 25,
		["45"] = 19,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 19,
		["55"] = 19,
		["56"] = 31,
		["57"] = 38,
		["58"] = 31,
		["59"] = 38,
		["60"] = 42,
		["61"] = 43,
		["62"] = 44,
		["63"] = 42,
		["64"] = 46,
		["65"] = 47,
		["66"] = 46,
		["67"] = 51,
		["68"] = 52,
		["69"] = 53,
		["70"] = 54,
		["71"] = 55,
		["72"] = 55,
		["73"] = 55,
		["74"] = 55,
		["75"] = 55,
		["76"] = 55,
		["78"] = 57,
		["79"] = 51,
		["80"] = 59,
		["81"] = 60,
		["82"] = 61,
		["83"] = 62,
		["84"] = 63,
		["85"] = 63,
		["86"] = 63,
		["87"] = 63,
		["88"] = 63,
		["89"] = 63,
		["91"] = 65,
		["93"] = 59,
		["94"] = 38,
		["95"] = 31,
		["96"] = 31,
		["97"] = 31,
		["98"] = 31,
		["99"] = 31,
		["100"] = 31,
		["101"] = 31,
		["102"] = 38,
		["104"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_52 = c()
local n = g.trait_52
n.name = "trait_52"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_52"
end
n = e({ j(nil) }, n)
g.trait_52 = n
g.modifier_trait_52 = c()
local o = g.modifier_trait_52
o.name = "modifier_trait_52"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_52_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_52_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_52 = o
g.modifier_trait_52_buff = c()
local q = g.modifier_trait_52_buff
q.name = "modifier_trait_52_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.time = self:GetAbilitySpecialValueFor("time")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function q.prototype.OnBattleStartBefore(self, p)
	local r = self:GetParent()
	local s = r:GetEnemy()
	if IsInjurable(self.parent, s) then
		AddStun(self.parent, s, self.parent:GetDummyAbility(), self.duration)
	end
	self:StartIntervalThink(self.time)
end
function q.prototype.OnIntervalThink(self)
	if IsServer() then
		local s = self.parent:GetEnemy()
		if IsInjurable(self.parent, s) then
			AddStun(self.parent, s, self.parent:GetDummyAbility(), self.duration)
		end
		self:StartIntervalThink(-1)
	end
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_52_buff = q
return g