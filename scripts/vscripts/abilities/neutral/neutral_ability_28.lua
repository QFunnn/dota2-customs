--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_28"
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
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["33"] = 22,
		["34"] = 23,
		["35"] = 22,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 26,
		["41"] = 25,
		["42"] = 30,
		["43"] = 31,
		["44"] = 32,
		["45"] = 32,
		["46"] = 32,
		["47"] = 32,
		["49"] = 30,
		["50"] = 20,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 20,
		["61"] = 20,
		["62"] = 37,
		["63"] = 38,
		["64"] = 37,
		["65"] = 38,
		["67"] = 38,
		["68"] = 39,
		["69"] = 37,
		["70"] = 40,
		["71"] = 41,
		["72"] = 42,
		["73"] = 43,
		["74"] = 43,
		["75"] = 43,
		["76"] = 44,
		["77"] = 45,
		["78"] = 45,
		["79"] = 45,
		["80"] = 45,
		["81"] = 45,
		["82"] = 45,
		["83"] = 47,
		["85"] = 43,
		["86"] = 43,
		["87"] = 40,
		["88"] = 51,
		["89"] = 52,
		["90"] = 53,
		["91"] = 54,
		["92"] = 51,
		["93"] = 38,
		["94"] = 37,
		["95"] = 38,
		["97"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.neutral_talent_28 = c()
local q = g.neutral_talent_28
q.name = "neutral_talent_28"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_28"
end
q = e({ j(nil) }, q)
g.neutral_talent_28 = q
g.modifier_neutral_talent_28 = c()
local r = g.modifier_neutral_talent_28
r.name = "modifier_neutral_talent_28"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.mana_restore = self:GetAbilitySpecialValueFor("mana_restore")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomAbilityFullyCast(self, s)
	if s then
		Restore(self:GetParent(), self.mana_restore)
	end
end
r = e(
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
	r
)
g.modifier_neutral_talent_28 = r
g.neutral_ult_28 = c()
local t = g.neutral_ult_28
t.name = "neutral_ult_28"
d(t, o)
function t.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.record = 0
end
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local v = u:GetEnemy()
	self:GameTimer(0.55, function()
		if IsInjurable(v) then
			u:DealDamage(v, self, self:GetDamage(), EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			self.record = self.record + 1
		end
	end)
end
function t.prototype.GetDamage(self)
	local u = self:GetCaster()
	local w = self:GetSpecialValueFor("base_damage") + self:GetSpecialValueFor("damage_stack") * self.record
	return w
end
t = e({ p(nil) }, t)
g.neutral_ult_28 = t
return g