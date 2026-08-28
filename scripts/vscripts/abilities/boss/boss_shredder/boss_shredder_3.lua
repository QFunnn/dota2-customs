--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_shredder/boss_shredder_3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_shredder_3"
d(j, h)
function j.prototype.OnAbilityPhaseStart(self)
	local k = self:GetCaster()
	self:CircleWarning(k, self:GetSpecialValueFor("radius"), self:GetCastPoint())
	return true
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local l = self:GetSpecialValueFor("radius")
	local m = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_shredder/shredder_whirling_death.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlEnt(m, 0, k, PATTACH_POINT_FOLLOW, "attach_hitloc", k:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(m, 1, k, PATTACH_POINT_FOLLOW, "attach_hitloc", k:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(m, 2, Vector(l, l, l))
	ParticleManager:SetParticleControlEnt(m, 3, k, PATTACH_POINT_FOLLOW, "attach_hitloc", k:GetAbsOrigin(), true)
	k:EmitSound("Hero_Shredder.WhirlingDeath.Cast")
	local n = self:GetSpecialValueFor("damage")
	local o = FindUnitsInRadius(
		k:GetTeamNumber(),
		k:GetAbsOrigin(),
		nil,
		l,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_ANY_ORDER,
		false
	)
	local p = k:FindAbilityByName("boss_shredder_1")
	for q, r in ipairs(o) do
		if k:IsFriendly(r) then
			if IsValid(p) and r:GetUnitName() == "shredder_tree" then
				p:CutDownTree(r)
			end
		else
			k:DealDamage(o, self, n)
		end
	end
end
j = e({ i(nil, {}) }, j)
return f