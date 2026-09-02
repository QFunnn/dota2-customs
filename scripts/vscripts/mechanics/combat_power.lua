--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "mechanics/combat_power"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectKeys
local f = b.__TS__ObjectAssign
local g = b.__TS__DecorateLegacy
local h = b.__TS__New
local i = {}
local j = require("lib.tstl-utils")
local k = j.reloadable
local l = {
	attackCombatPowerPerDps = 1,
	skillCombatPowerPerDps = 1,
	ehpCombatPowerPerPoint = 1,
	defenseIntensityBase = 1000,
	utilityCombatPowerPerPoint = 1,
	standardSkillDps = 20,
	standardSkillMana = 100,
	skillManaEfficiency = 0.05,
	cooldownReductionCap = 80,
	evasionCap = 0.75,
	conditionalCoverage = {
		boss_damage_boost = 0.3,
		elite_damage_boost = 0.4,
		minion_damage_boost = 0.8,
		execute_damage = 0.2,
		finisher_damage = 0.2,
		backstab_damage_boost = 0.35,
		barrier_damage_boost = 0.3,
		damage_vs_bleeding_targets = 0.6,
		damage_vs_frozen_targets = 0.6,
		damage_vs_shocked_targets = 0.6,
		damage_vs_poisoned_targets = 0.6,
		melee_damage_boost = 0.5,
		ranged_damage_boost = 0.5,
	},
}
local m = {
	"aoe_amplify",
	"attack_range",
	"attack_range_melee",
	"attack_range_ranger",
	"bullet_range",
	"split_count",
	"ability_charge_dodge",
	"ability_charge_defense",
	"movespeed_amplify",
	"buff_duration",
	"debuff_duration",
}
local n = c()
n.name = "CCombatPower"
d(n, CModule)
function n.prototype.init(self, o) end
function n.prototype.GetPrivilegeCombatPowerFactor(self, p)
	local q = 0
	for r, s in ipairs({ { "effects", p.effects }, { "myth", p.myth } }) do
		local t = s[1]
		local u = s[2]
		do
			if u == nil then
				goto v
			end
			for r, w in ipairs(e(u)) do
				do
					local x = toFiniteNumber(u[w], 0)
					if x == 0 then
						goto y
					end
					local z = toFiniteNumber
					local A = KeyValues.privilegeKv
					local B = A and A[w]
					if B ~= nil then
						B = B.CombatPowerFactor
					end
					local C = z(B, 0)
					q = q + C
				end
				::y::
			end
		end
		::v::
	end
	print("[combat_power] privilege_factor_total=" .. tostring(q))
	return q
end
function n.prototype.GetPropertyValue(self, D, E)
	return toFiniteNumber(D[E], 0)
end
function n.prototype.SumProperties(self, D, F)
	local G = 0
	for r, E in ipairs(F) do
		G = G + self:GetPropertyValue(D, E)
	end
	return G
end
function n.prototype.GetCritFactor(self, D, H)
	local I = Clamp(
		self:SumProperties(D, H and { "crit_chance", "spell_crit_chance" } or { "crit_chance", "attack_crit_chance" })
			* 0.01,
		0,
		1
	)
	local J =
		self:SumProperties(D, H and { "crit_damage", "spell_crit_damage" } or { "crit_damage", "attack_crit_damage" })
	local K = 1 + self:GetPropertyValue(D, "crit_damage_mult") * 0.01
	local L = (1 + self:GetPropertyValue(D, "crit_damage_amplify") * 0.01)
		* (1 + self:GetPropertyValue(D, H and "spell_crit_damage_boost" or "attack_crit_damage_boost") * 0.01)
	return 1 + I * (math.max(J * 0.01 * K * L, 1) - 1)
end
function n.prototype.GetCombatPowerFromSnapshot(self, M)
	local D = f({}, M.attributes or {})
	local N = (self:GetPropertyValue(D, "base_attack") + self:GetPropertyValue(D, "attack"))
		* (1 + self:GetPropertyValue(D, "attack_amplify") * 0.01)
	local O = INTENSITY_FACTOR
		* self:GetPropertyValue(D, "damage_intensity")
		* (1 + self:GetPropertyValue(D, "damage_intensity_boost") * 0.01)
	local P = 1
		+ CompoundIncrease(
				CompoundIncrease(self:GetPropertyValue(D, "damage_boost"), self:GetPropertyValue(D, "damage_amplify")),
				O,
				self:GetPropertyValue(D, "hero_damage_boost"),
				self:GetPropertyValue(D, "damage_boost_mult"),
				self:GetPropertyValue(D, "final_damage"),
				self:GetPropertyValue(D, "final_damage_101"),
				self:GetPropertyValue(D, "final_damage_102"),
				self:GetPropertyValue(D, "final_damage_103")
			)
			* 0.01
	local Q = 1
		+ CompoundIncrease(
				CompoundIncrease(
					self:GetPropertyValue(D, "attack_damage_boost"),
					self:GetPropertyValue(D, "attack_damage_amplify")
				)
			)
			* 0.01
	local R = CompoundIncrease(
		self:GetPropertyValue(D, "physical_damage_boost"),
		self:GetPropertyValue(D, "physical_damage_amplify")
	)
	local S = CompoundIncrease(
		self:GetPropertyValue(D, "magical_damage_boost"),
		self:GetPropertyValue(D, "magical_damage_amplify")
	)
	local T = 1 + (R * 0.5 + S * 0.5) * 0.01
	local U = 0
	for r, E in ipairs(e(l.conditionalCoverage)) do
		U = U + self:GetPropertyValue(D, E) * l.conditionalCoverage[E]
	end
	local V = 1 + U * 0.01
	local W = P * T * V
	local X = self:GetPropertyValue(D, "attackspeed")
		+ self:GetPropertyValue(D, "attack_speed_boost")
		- self:GetPropertyValue(D, "attackspeed_reduction")
	local Y = math.max(0.2, (100 + X) * 0.01)
	local Z = N * self:GetCritFactor(D, false) * Q * Y
	local _ = self:GetPropertyValue(D, "base_mana")
	local a0 = self:GetPropertyValue(D, "mana")
	local a1 = self:GetPropertyValue(D, "mana_amplify")
	local a2 = _ ~= 0 or a0 ~= 0 or a1 ~= 0
	local a3 = math.max(0, (_ + a0) * (1 + a1 * 0.01))
	local a4 = math.max(0, a3 - l.standardSkillMana)
	local a5 = a2 and Clamp(1 + a4 / math.max(l.standardSkillMana, 1) * l.skillManaEfficiency, 0.95, 1.25) or 1
	local a6 = self:GetPropertyValue(D, "spell_damage_proc") + self:GetPropertyValue(D, "spell_damage_proc_target")
	local a7 = CompoundIncrease(
		self:GetPropertyValue(D, "spell_damage_boost"),
		self:GetPropertyValue(D, "spell_damage_amplify")
	)
	local a8 = (
		CompoundIncrease(
			self:GetPropertyValue(D, "skill_damage_boost"),
			self:GetPropertyValue(D, "skill_damage_amplify")
		)
		+ CompoundIncrease(
			self:GetPropertyValue(D, "dodge_damage_boost"),
			self:GetPropertyValue(D, "dodge_damage_amplify")
		)
		+ CompoundIncrease(
			self:GetPropertyValue(D, "defense_damage_boost"),
			self:GetPropertyValue(D, "defense_damage_amplify")
		)
		+ CompoundIncrease(
			self:GetPropertyValue(D, "ultimate_damage_boost"),
			self:GetPropertyValue(D, "ultimate_damage_amplify")
		)
	) * 0.25
	local a9 = 1 + (a7 + a8) * 0.01
	local aa = Clamp(self:GetPropertyValue(D, "cooldown_reduction"), 0, l.cooldownReductionCap)
	local ab = 1 / math.max(1 - aa * 0.01, 0.05)
	local ac = (l.standardSkillDps * self:GetCritFactor(D, true) + a6) * a9 * ab * a5
	local ad = self:GetPropertyValue(D, "defense_intensity")
		* (1 + self:GetPropertyValue(D, "defense_intensity_boost") * 0.01)
	local ae = l.defenseIntensityBase
	local af = (ae + ad)
			* (1 + self:GetPropertyValue(D, "hero_defense_boost") * 0.01)
			* (1 + self:GetPropertyValue(D, "final_defense") * 0.01)
		- ae
	local ag = (self:GetPropertyValue(D, "base_health") + self:GetPropertyValue(D, "health"))
		* (1 + self:GetPropertyValue(D, "health_amplify") * 0.01)
		* (1 + af * INTENSITY_FACTOR * 0.01)
	local ah = math.max(
		1 + (self:GetPropertyValue(D, "incoming_damage_amplify") - self:GetPropertyValue(D, "damage_reduction")) * 0.01,
		0.05
	)
	local ai = Clamp(self:GetPropertyValue(D, "evasion") * 0.01, 0, l.evasionCap)
	local aj = ag * 1 / ah * 1 / math.max(1 - ai, 0.05) + (self:GetPropertyValue(D, "min_health") > 0 and 100 or 0)
	local ak = self:SumProperties(D, m) + self:GetPropertyValue(D, "block") + self:GetPropertyValue(D, "avoid_damage")
	local al = (Z * l.attackCombatPowerPerDps + ac * l.skillCombatPowerPerDps) * W
	local am = aj * l.ehpCombatPowerPerPoint
	local an = ak * l.utilityCombatPowerPerPoint
	local ao = math.floor(math.max(0, al + am + an))
	local ap = self:GetPrivilegeCombatPowerFactor(M)
	local aq = math.floor(math.max(0, ao * (1 + ap)))
	return { combatPower = aq, privilegeFactor = ap, attackDps = Z, skillDps = ac, sharedDamageFactor = W, ehp = aj, utilityScore = ak }
end
n = g({ k }, n)
if CombatPower == nil then
	CombatPower = h(n)
end
return i