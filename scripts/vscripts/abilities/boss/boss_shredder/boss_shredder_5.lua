--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_shredder/boss_shredder_5"
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
n.name = "boss_shredder_5"
d(n, l)
function n.prototype.OnAbilityPhaseStart(self)
	local o = self:GetCaster()
	local p = self:GetCursorTarget()
	if not IsValid(p) then
		return false
	end
	o:SetForwardVector(CalcDirection2D(p, o))
	o:FaceTowards(p:GetAbsOrigin())
	self:SectorWarning(
		o:GetAbsOrigin(),
		o:GetForwardVector(),
		self:GetSpecialValueFor("radius") * 2,
		60,
		self:GetCastPoint()
	)
	o:EmitSound("Hero_Batrider.Firefly.Cast")
	return true
end
function n.prototype.OnSpellStart(self)
	local p = self:GetCursorTarget()
	if not IsValid(p) then
		return
	end
	local o = self:GetCaster()
	o:SimulateCast({ duration = self:GetSpecialValueFor("duration") })
	o:AddNewModifier(
		o,
		self,
		"modifier_boss_shredder_5_buff",
		{ entindex = p:entindex(), duration = self:GetSpecialValueFor("duration") }
	)
	o:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_TARGET, p)
	Bullet:CreateGuidedBullet({
		caster = o,
		spawnOrigin = o:GetAbsOrigin(),
		moveSpeed = 300,
		direction = o:GetForwardVector(),
		target = p,
		lifeTime = self:GetSpecialValueFor("duration"),
		angularVelocity = 90,
		bounce = 99,
		OnBulletThink = function(q, r)
			local s = CalcDirection2D(p:GetAbsOrigin(), o)
			local t = VectorToAngles(s).y
			local u = AngleDiff(t, o:GetLocalAngles().y)
			r.moveSpeed = RemapValClamped(math.abs(u), 0, 180, 300, 1)
			r.angularVelocity = RemapValClamped(math.abs(u), 0, 180, 30, 90)
			o:SetLocalAngles(0, VectorToAngles(r.__velocity).y, 0)
			o:SetForwardVector(AnglesToVector(o:GetLocalAngles()))
			o:FaceTowards(o:GetAbsOrigin() + o:GetForwardVector())
			o:SetAbsOrigin(q)
		end,
	})
end
n = e({ m(nil, {}) }, n)
f.modifier_boss_shredder_5_buff = c()
local v = f.modifier_boss_shredder_5_buff
v.name = "modifier_boss_shredder_5_buff"
d(v, h)
function v.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_ULTRA
end
function v.prototype.OnCreated(self, w)
	local x = self:GetParent()
	if IsServer() then
		x:EmitSound("Hero_Batrider.Firefly.loop")
		self.currentYaw = x:GetLocalAngles().y
		self.target = EntIndexToHScript(w.entindex)
		if not IsValid(self.target) then
			self:Destroy()
			return
		end
		self:StartIntervalThink(0.25)
	else
		local y = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_shredder/shredder_flame_thrower.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(y, 0, x, PATTACH_POINT_FOLLOW, "attach_hitloc", x:GetAbsOrigin(), true)
		self:AddParticle(y, false, false, -1, false, false)
	end
end
function v.prototype.OnDestroy(self)
	local x = self:GetParent()
	if IsServer() then
		x:StopSound("Hero_Batrider.Firefly.loop")
	end
end
function v.prototype.OnIntervalThink(self)
	if not IsValid(self.target) then
		self:Destroy()
		return
	end
	local x = self:GetParent()
	local z = self:GetAbility()
	local A = FindEnemiesInSector(x, x:GetAbsOrigin(), self.radius, x:GetForwardVector(), 120)
	x:DealDamage(A, z, self.damage)
end
function v.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_RUN }
end
function v.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
e({ k(nil) }, v.prototype, "radius", nil)
e({ k(nil) }, v.prototype, "damage", nil)
v = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	v
)
f.modifier_boss_shredder_5_buff = v
return f