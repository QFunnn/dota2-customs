--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_test_custom_ability"
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
		["12"] = 4,
		["13"] = 12,
		["14"] = 4,
		["15"] = 12,
		["17"] = 12,
		["18"] = 13,
		["19"] = 13,
		["20"] = 13,
		["21"] = 13,
		["22"] = 13,
		["23"] = 13,
		["24"] = 13,
		["25"] = 13,
		["26"] = 13,
		["27"] = 13,
		["28"] = 13,
		["29"] = 13,
		["30"] = 4,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 27,
		["35"] = 27,
		["36"] = 26,
		["37"] = 28,
		["38"] = 28,
		["39"] = 28,
		["40"] = 26,
		["41"] = 29,
		["42"] = 29,
		["43"] = 29,
		["44"] = 26,
		["45"] = 30,
		["46"] = 30,
		["47"] = 30,
		["48"] = 26,
		["49"] = 31,
		["50"] = 31,
		["51"] = 31,
		["52"] = 26,
		["53"] = 32,
		["54"] = 32,
		["55"] = 32,
		["56"] = 26,
		["57"] = 33,
		["58"] = 33,
		["59"] = 33,
		["60"] = 26,
		["61"] = 34,
		["62"] = 34,
		["63"] = 34,
		["64"] = 26,
		["65"] = 35,
		["66"] = 35,
		["67"] = 35,
		["68"] = 26,
		["69"] = 36,
		["70"] = 36,
		["71"] = 36,
		["72"] = 26,
		["73"] = 37,
		["74"] = 37,
		["75"] = 37,
		["76"] = 26,
		["77"] = 26,
		["78"] = 25,
		["79"] = 41,
		["80"] = 41,
		["81"] = 44,
		["82"] = 45,
		["83"] = 45,
		["84"] = 44,
		["85"] = 47,
		["86"] = 48,
		["87"] = 48,
		["88"] = 47,
		["89"] = 50,
		["90"] = 51,
		["91"] = 51,
		["92"] = 50,
		["93"] = 53,
		["94"] = 54,
		["95"] = 54,
		["96"] = 53,
		["97"] = 56,
		["98"] = 57,
		["99"] = 57,
		["100"] = 56,
		["101"] = 59,
		["102"] = 60,
		["103"] = 60,
		["104"] = 59,
		["105"] = 62,
		["106"] = 63,
		["107"] = 63,
		["108"] = 62,
		["109"] = 65,
		["110"] = 66,
		["111"] = 66,
		["112"] = 65,
		["113"] = 68,
		["114"] = 69,
		["115"] = 69,
		["116"] = 68,
		["117"] = 71,
		["118"] = 72,
		["119"] = 72,
		["120"] = 71,
		["121"] = 12,
		["122"] = 4,
		["123"] = 4,
		["124"] = 4,
		["125"] = 4,
		["126"] = 4,
		["127"] = 4,
		["128"] = 4,
		["129"] = 4,
		["130"] = 12,
		["132"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_test_custom_ability = c()
local k = g.modifier_test_custom_ability
k.name = "modifier_test_custom_ability"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.record = {
		sect_attack = 0,
		sect_evade = 0,
		sect_crit = 0,
		sect_regen = 0,
		sect_ulti = 0,
		sect_poison = 0,
		sect_ice = 0,
		sect_shield = 0,
		sect_injury = 0,
		sect_fury = 0,
	}
end
function k.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent(), -1 },
		[MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function k.prototype.OnBattleEnd(self, l) end
function k.prototype.OnAbilityFullyCast(self, l)
	local m, n = self.record, "sect_ulti"
	m[n] = m[n] + 1
end
function k.prototype.OnCustomAttackLanded(self, o)
	local p, q = self.record, "sect_attack"
	p[q] = p[q] + 1
end
function k.prototype.OnEvasion(self, l)
	local r, s = self.record, "sect_evade"
	r[s] = r[s] + 1
end
function k.prototype.OnCritical(self, l)
	local t, u = self.record, "sect_crit"
	t[u] = t[u] + 1
end
function k.prototype.OnHeal(self, l)
	local v, w = self.record, "sect_regen"
	v[w] = v[w] + 1
end
function k.prototype.OnPoisonGained(self, l)
	local x, y = self.record, "sect_poison"
	x[y] = x[y] + 1
end
function k.prototype.OnIceGained(self, l)
	local z, A = self.record, "sect_ice"
	z[A] = z[A] + 1
end
function k.prototype.OnInjuryGained(self, l)
	local B, C = self.record, "sect_injury"
	B[C] = B[C] + 1
end
function k.prototype.OnShieldGained(self, l)
	local D, E = self.record, "sect_shield"
	D[E] = D[E] + 1
end
function k.prototype.OnFuryGained(self, l)
	local F, G = self.record, "sect_fury"
	F[G] = F[G] + 1
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_test_custom_ability = k
return g