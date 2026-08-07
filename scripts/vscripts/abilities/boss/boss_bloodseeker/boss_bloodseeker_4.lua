--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_bloodseeker/boss_bloodseeker_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.AbilityValue
local l = j.EOMAbility
local m = j.registerEOMAbility
local n = c()
n.name = "boss_bloodseeker_4"
d(n, l)
function n.prototype.OnAbilityPhaseStart(self)
	self:CircleWarning(self:GetCaster(), self:GetSpecialValueFor("radius"), self:GetCastPoint())
	return true
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	local p = self:GetSpecialValueFor("duration")
	o:SimulateCast({ duration = p })
	o:AddNewModifier(o, self, "modifier_boss_bloodseeker_4", { duration = p })
end
n = e({ m(nil) }, n)
local q = c()
q.name = "modifier_boss_bloodseeker_4"
d(q, h)
function q.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_ULTRA
end
function q.prototype.OnCreated(self, r)
	local s = self:GetParent()
	if IsServer() then
		s:EmitSound("Greevil.BladeFuryStart")
		self:StartIntervalThink(0.25)
		self:StartThink(0, function()
			local t = Bullet:GetBulletInRadius(s:GetAbsOrigin(), self.radius)
			s:ShootDown(t)
		end)
		local u = FindEnemiesInRadius(s, s:GetAbsOrigin(), 3000)
		if IsValid(u[1]) then
			s:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_TARGET, u[1])
		end
	else
		local v = ParticleManager:CreateParticle(
			"particles/econ/items/juggernaut/bladekeeper_bladefury/_dc_juggernaut_blade_fury.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			s
		)
		ParticleManager:SetParticleControl(v, 5, Vector(self.radius, self.radius, self.radius))
		self:AddParticle(v, false, false, -1, false, false)
	end
end
function q.prototype.OnDestroy(self)
	local s = self:GetParent()
	if IsServer() then
		s:StopSound("Greevil.BladeFuryStart")
		s:EmitSound("Greevil.BladeFuryStop")
	end
end
function q.prototype.OnIntervalThink(self)
	local s = self:GetParent()
	local w = self:GetAbility()
	local x = FindEnemiesInRadius(s, s:GetAbsOrigin(), self.radius)
	s:DealDamage(x, w, self.damage)
	local u = FindEnemiesInRadius(s, s:GetAbsOrigin(), 3000)
	if IsValid(u[1]) then
		s:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_TARGET, u[1])
	end
end
function q.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_OVERRIDE_ABILITY_1 }
end
function q.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = false, [MODIFIER_STATE_DISARMED] = false }
end
e({ k(nil) }, q.prototype, "radius", nil)
e({ k(nil) }, q.prototype, "damage", nil)
q = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
return f