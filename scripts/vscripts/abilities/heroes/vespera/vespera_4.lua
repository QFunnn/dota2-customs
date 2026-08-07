--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/vespera/vespera_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.ability_ai")
local h = g.EOMAbilityAI
local i = require("abilities.eom_ability")
local j = i.AbilityValue
local k = i.registerEOMAbility
local l = c()
l.name = "vespera_4"
d(l, h)
function l.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.stack = 0
end
function l.prototype.GetAOERadius(self)
	return 400
end
function l.prototype.GetManaCost(self, m)
	return h.prototype.GetManaCost(self, m) - self.mana_reduce - GetUltimateManaCostReduce(self:GetCaster())
end
function l.prototype.GetCooldown(self, m)
	return math.max(h.prototype.GetCooldown(self, m) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function l.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	n:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	return true
end
function l.prototype.OnAbilityPhaseInterrupted(self)
	local n = self:GetCaster()
	n:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
end
function l.prototype.OnCreated(self)
	self:StartThink(0.1, function()
		self.stack = math.min(self.stack + 0.1, SWORD_INTENT_MAX_STACK)
	end)
end
function l.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local o = self:GetSpecialValueFor("suriken_count")
	if n:HasAbilityUpgrade("vespera_4_upgrade_f") then
		o = o + AbilityUpgrade:GetUpgradeLevelSumByAbilityName(n, "vespera_4")
	end
	local p = self:GetSpecialValueFor("speed")
	local q = self:GetSpecialValueFor("damage")
	local r = self:GetSpecialValueFor("damage_pct") + 100
	local s = self:GetSpecialValueFor("delay")
	n:FindAbilityByName("vespera_1"):CircleSurikenToss(o, p, q, r, s)
	if AbilityUpgrade:HasAbilityUpgrade(n, "vespera_upgrade_8") then
		local t = n:GetAbilityByTag(AbilityTag.Defense)
		if IsValid(t) then
			t:OnSpellStart()
			Event:Fire(
				"ability_cast_complete",
				{ ability = t, caster = n, position = t:GetCursorPosition(), abilityTag = t:GetAbilityTag() }
			)
		end
	end
	local u = self:GetSpecialValueFor("blade_wave_count")
	if u > 0 then
		self:StartThink(0.25, "blade", function()
			local v = 1 + self.stack * SWORD_INTENT_PCT_PER_STACK * 0.01
			n:SwordCircle(self:GetSpecialValueFor("blade_wave_damage"), v)
			self.stack = 0
			u = u - 1
			if u <= 0 then
				return -1
			end
		end)
	end
end
e({ j(nil) }, l.prototype, "mana_reduce", nil)
l = e({ k(nil, {
	funcCondition = function(w, t)
		return t:GetAutoCastState()
	end,
}) }, l)
return f