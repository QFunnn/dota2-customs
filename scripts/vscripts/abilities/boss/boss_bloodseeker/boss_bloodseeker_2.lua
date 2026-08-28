--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_bloodseeker/boss_bloodseeker_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_bloodseeker_2"
d(j, h)
function j.prototype.OnAbilityPhaseStart(self)
	self:GetCaster():EmitSound("Hero_Bloodseeker.BloodRite.Cast")
	return true
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCursorTarget()
	if not IsValid(k) then
		return
	end
	local l = self:GetCaster()
	local m = self:GetSpecialValueFor("count")
	local n = self:GetSpecialValueFor("radius")
	local o = self:GetSpecialValueFor("damage")
	l:SimulateCast({ duration = 0.3 })
	self:BloodRitual(k:GetAbsOrigin(), n * 1.5, o, 2)
	self:StartThink(0.4, "Summon", function()
		local p = k:GetAbsOrigin()
		self:BloodRitual(p, n, o)
		m = m - 1
		if m <= 0 then
			return -1
		end
	end)
end
function j.prototype.BloodRitual(self, p, n, o, q)
	if q == nil then
		q = 1
	end
	local l = self:GetCaster()
	local r = ParticleManager:CreateParticle(
		"particles/units/boss/boss_bloodseeker/boss_bloodseeker_bloodritual_ring.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(r, 0, p)
	ParticleManager:SetParticleControl(r, 1, Vector(n, n, n))
	ParticleManager:SetParticleControl(r, 2, Vector(q, 0, 0))
	ParticleManager:ReleaseParticleIndex(r)
	self:StartThink(1, DoUniqueString("damage"), function()
		local s = FindEnemiesInRadius(l, p, n)
		l:DealDamage(s, self, o)
		l:EmitSound("hero_bloodseeker.bloodRite.silence", p)
		return -1
	end)
end
j = e({ i(nil) }, j)
return f