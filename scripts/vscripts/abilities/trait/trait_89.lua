--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_89"
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
		["60"] = 40,
		["61"] = 41,
		["62"] = 40,
		["63"] = 43,
		["64"] = 44,
		["65"] = 43,
		["66"] = 48,
		["67"] = 49,
		["68"] = 48,
		["69"] = 51,
		["70"] = 52,
		["71"] = 53,
		["72"] = 54,
		["73"] = 55,
		["74"] = 56,
		["75"] = 57,
		["78"] = 60,
		["79"] = 61,
		["81"] = 51,
		["82"] = 64,
		["83"] = 65,
		["84"] = 64,
		["85"] = 38,
		["86"] = 31,
		["87"] = 31,
		["88"] = 31,
		["89"] = 31,
		["90"] = 31,
		["91"] = 31,
		["92"] = 31,
		["93"] = 38,
		["95"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_89 = c()
local n = g.trait_89
n.name = "trait_89"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_89"
end
n = e({ j(nil) }, n)
g.trait_89 = n
g.modifier_trait_89 = c()
local o = g.modifier_trait_89
o.name = "modifier_trait_89"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_89_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_89_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_89 = o
g.modifier_trait_89_buff = c()
local q = g.modifier_trait_89_buff
q.name = "modifier_trait_89_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function q.prototype.OnBattleStart(self, p)
	self:StartIntervalThink(self.interval)
end
function q.prototype.OnIntervalThink(self)
	if IsServer() then
		local r = self:GetParent()
		local s = r:GetAbilityByIndex(1)
		local t = r:GetEnemy()
		if not (IsValid(s) and IsInjurable(r, t)) then
			self:StartIntervalThink(-1)
			return
		end
		s:OnSpellStart()
		FireModifierEvent(
			EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
			{ ability = s, unit = r, target = t },
			r,
			t
		)
	end
end
function q.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_LOSS_PERCENTAGE] = 999 }
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_89_buff = q
return g