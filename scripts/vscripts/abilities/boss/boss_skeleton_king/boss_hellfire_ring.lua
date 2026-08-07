--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_hellfire_ring"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "boss_hellfire_ring"
d(m, k)
function m.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.bulletGroup = {}
end
function m.prototype.OnAbilityPhaseStart(self)
	self:CircleWarning(self:GetCaster():GetAbsOrigin(), 300, self:GetCastPoint())
	return true
end
function m.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
end
function m.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local o = self:GetSpecialValueFor("duration")
	local p = self:GetSpecialValueFor("damage")
	local q = self:GetSpecialValueFor("count")
	local r = self:GetSpecialValueFor("speed")
	local s = CreateModifierThinker(
		n,
		self,
		"modifier_custom_thinker",
		{ duration = o },
		n:GetAbsOrigin(),
		n:GetTeamNumber(),
		false
	)
	local t = self:GetSpecialValueFor("debuff_duration")
	self.bulletGroup = Bullet:CreateGroupSurroundBullet(q, {
		lifeTime = o,
		caster = s,
		ability = self,
		circleRadius = 1,
		radius = 100,
		offset = 120,
		reflectable = true,
		angularVelocity = r,
		group = DoUniqueString("boss_hellfire_ring"),
		ParticleCreator = function(u)
			local v = ParticleManager:CreateParticle(
				"particles/units/boss/boss_skeleton_king/hellfireblast_lock.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(v, 0, u.__position + Vector(0, 0, 100))
			ParticleManager:SetParticleControlEnt(
				v,
				3,
				u.__thinker,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				u.__thinker:GetAbsOrigin(),
				true
			)
			return v
		end,
		OnBulletThink = function(w, u)
			if u.circleRadius < 800 then
				u.circleRadius = u.circleRadius + 10
			end
		end,
		OnBulletHit = function(x, w, u)
			n:DealDamage(x, nil, p)
			x:EmitSound("Hero_SkeletonKing.Hellfire_BlastImpact")
		end,
	})
	n:EmitSound("skeleton_king_skel_arc_move_02")
	n:EmitSound("Hero_AbyssalUnderlord.Firestorm.Start")
end
function m.prototype.OnDestroy(self)
	for y, z in ipairs(self.bulletGroup) do
		Bullet:DestroyBulletByID(z)
	end
end
m = e({ l(nil, { startCooldown = 30 }) }, m)
local A = c()
A.name = "modifier_boss_hellfire_ring"
d(A, h)
function A.prototype.GetEffectName(self)
	return "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast_debuff.vpcf"
end
function A.prototype.StaticProperty(self)
	return { [PropertyFunction.MOVESPEED_AMPLIFY] = -self:GetAbilitySpecialValueFor("movespeed_pct") }
end
A = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	A
)
return f