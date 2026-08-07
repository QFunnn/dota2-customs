--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_tomb"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.eom_ability")
local l = k.EOMAbility
local m = k.registerEOMAbility
local n = c()
n.name = "enemy_tomb"
d(n, l)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_enemy_tomb"
end
n = e({ m(nil) }, n)
local o = c()
o.name = "modifier_enemy_tomb"
d(o, i)
function o.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.maxSummonUnits = 5
end
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function o.prototype.OnCreated(self, p)
	self.summonUnits = {}
	if IsServer() then
		self:StartIntervalThink(self.interval)
	else
		local q = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_undying/undying_tombstone_ambient.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		self:AddParticle(q, false, false, -1, false, false)
	end
end
function o.prototype.OnDestroy(self)
	f(self.summonUnits, function(r, s)
		if IsValid(s) and s:IsAlive() then
			s:Kill(self.ability, self.parent)
		end
	end)
	self.summonUnits = {}
end
function o.prototype.CleanupSummonUnits(self)
	local t = {}
	do
		local u = 0
		while u < #self.summonUnits do
			local s = self.summonUnits[u + 1]
			if IsValid(s) and s:IsAlive() then
				t[#t + 1] = s
			end
			u = u + 1
		end
	end
	self.summonUnits = t
end
function o.prototype.OnIntervalThink(self)
	if IsServer() then
		local v = self:GetParent()
		if IsValid(v) and v:IsAlive() then
			self:CleanupSummonUnits()
			if #self.summonUnits >= self.maxSummonUnits then
				return
			end
			local s = v:SummonUnit("skeleton_minion", v:GetAbsOrigin() + RandomVector(RandomInt(100, 300)))
			if IsValid(s) then
				local w = self.summonUnits
				w[#w + 1] = s
			end
		end
	end
end
function o.prototype.EventListener(self)
	return {
		entity_killed = function(r, x)
			if x.victim == self.parent then
				self:Destroy()
			end
		end,
	}
end
o = e(
	{ j(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
return g