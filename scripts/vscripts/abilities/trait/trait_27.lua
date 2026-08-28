--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_27"
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
		["61"] = 44,
		["62"] = 45,
		["63"] = 42,
		["64"] = 47,
		["65"] = 48,
		["66"] = 48,
		["67"] = 50,
		["68"] = 50,
		["69"] = 50,
		["70"] = 48,
		["71"] = 48,
		["72"] = 47,
		["73"] = 53,
		["74"] = 54,
		["75"] = 53,
		["76"] = 56,
		["77"] = 57,
		["78"] = 56,
		["79"] = 59,
		["80"] = 60,
		["81"] = 61,
		["82"] = 62,
		["83"] = 64,
		["84"] = 66,
		["86"] = 68,
		["87"] = 68,
		["88"] = 68,
		["89"] = 68,
		["90"] = 68,
		["91"] = 68,
		["92"] = 59,
		["93"] = 38,
		["94"] = 31,
		["95"] = 31,
		["96"] = 31,
		["97"] = 31,
		["98"] = 31,
		["99"] = 31,
		["100"] = 31,
		["101"] = 38,
		["103"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_27 = c()
local n = g.trait_27
n.name = "trait_27"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_27"
end
n = e({ j(nil) }, n)
g.trait_27 = n
g.modifier_trait_27 = c()
local o = g.modifier_trait_27
o.name = "modifier_trait_27"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_27_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_27_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_27 = o
g.modifier_trait_27_buff = c()
local q = g.modifier_trait_27_buff
q.name = "modifier_trait_27_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.fury = self:GetAbilitySpecialValueFor("fury")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function q.prototype.OnBattleStart(self, p)
	self:StartIntervalThink(1)
end
function q.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function q.prototype.OnIntervalThink(self)
	local r = self:GetParent()
	local s = r:GetEnemy()
	local t = self:GetAbility()
	if IsInjurable(s) then
		AddFury(r, self.fury, "trait_27", "Ability")
	end
	r:DealDamage(s, t, GetFury(r) * self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_27_buff = q
return g