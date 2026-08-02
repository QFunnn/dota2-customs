--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_wave_motion"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionHorizontal
local i = g.registerEOMModifier
local j = require("abilities.bt_ability_ai")
local k = j.EOMBTAbilityAI
local l = require("abilities.eom_ability")
local m = l.registerEOMAbility
local n = c()
n.name = "enemy_wave_motion"
d(n, k)
function n.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("width")
end
function n.prototype.OnAbilityPhaseStart(self)
	local o = self:GetCaster()
	local p = o:GetAbsOrigin()
	self.direction = CalcDirection(self:GetCursorPosition(), p)
	local q = p + self.direction * self:GetCastRange(vec3_zero, nil)
	self:LineWarning(p, q, self:GetSpecialValueFor("width"), self:GetCastPoint())
	o:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.5)
	return true
end
function n.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle()
end
function n.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local o = self:GetCaster()
	local r = self:GetSpecialValueFor("speed")
	local s = self:GetCursorPosition()
	local t = self:GetCastRange(vec3_zero, nil)
	local u = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_life_stealer/life_stealer_infest_cast.vpcf",
		PATTACH_CUSTOMORIGIN,
		o
	)
	ParticleManager:SetParticleControl(u, 0, s)
	ParticleManager:SetParticleControlEnt(u, 1, o, PATTACH_POINT_FOLLOW, "attach_hitloc", o:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(u)
	o:EmitSound("Hero_LifeStealer.Rage")
	o:AddNewModifier(
		o,
		self,
		"modifier_enemy_wave_motion",
		{ direction = VectorToString(self.direction), duration = t / r }
	)
end
n = e({ m(nil) }, n)
local v = c()
v.name = "modifier_enemy_wave_motion"
d(v, h)
function v.prototype.GetAbilitySpecialValue(self)
	self.width = self:GetAbilitySpecialValueFor("width")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.speed = self:GetAbilitySpecialValueFor("speed")
end
function v.prototype.OnCreated(self, w)
	if IsServer() then
		self.direction = StringToVector(w.direction)
		self:ApplyHorizontalMotionController()
		self.bulletID = Bullet:CreateLinearBullet({
			caster = self.parent,
			direction = self.direction,
			distance = self.speed * self:GetDuration(),
			moveSpeed = self.speed,
			radius = self.width,
			ability = self.ability,
			spawnOrigin = self.parent:GetAbsOrigin(),
			interval = 0.3,
			OnBulletHit = function(x, y, z)
				self.parent:DealDamage(x, self.ability, self.damage)
				self:Destroy()
			end,
		})
		self.parent:StartGesture(ACT_DOTA_LIFESTEALER_INFEST_END)
	end
end
function v.prototype.OnDestroy(self)
	if IsServer() then
		local A = self:GetParent()
		A:RemoveHorizontalMotionController(self)
		if self.bulletID ~= nil then
			Bullet:DestroyBulletByID(self.bulletID)
		end
		A:StopAnimation()
		A:Stop()
		A:Stagger(1)
	end
end
function v.prototype.UpdateHorizontalMotion(self, A, B)
	if not IsServer() or not IsValid(A) then
		return
	end
	local C = A:GetAbsOrigin() + self.direction * self.speed * B
	if not GridNav:IsTraversable(C) or GridNav:IsBlocked(C) then
		self:Destroy()
		return
	end
	A:SetAbsOrigin(C)
end
function v.prototype.OnHorizontalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
function v.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_STUNNED] = true }
end
function v.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_RUN, [MODIFIER_PROPERTY_DISABLE_TURNING] = 1 }
end
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
return f