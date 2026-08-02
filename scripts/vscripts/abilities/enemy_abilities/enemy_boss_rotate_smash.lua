--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_rotate_smash"
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
n.name = "enemy_boss_rotate_smash"
d(n, k)
function n.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("swipe_radius")
end
function n.prototype.OnAbilityPhaseStart(self)
	self:CreateRadiusWarningParticle()
	return true
end
function n.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle()
end
function n.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local o = self:GetCaster()
	local p = self:GetCursorPosition()
	local q = CalcDirection(p, o:GetAbsOrigin())
	o:AddNewModifier(o, self, "modifier_enemy_boss_rotate_smash", { direction = q })
end
n = e({ m(nil) }, n)
local r = c()
r.name = "modifier_enemy_boss_rotate_smash"
d(r, h)
function r.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.bonus = 0
	self.ctr = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.swipe_radius = self:GetAbilitySpecialValueFor("swipe_radius")
	self.swipe_damage = self:GetAbilitySpecialValueFor("swipe_damage")
	self.smash_radius = self:GetAbilitySpecialValueFor("smash_radius")
	self.smash_damage = self:GetAbilitySpecialValueFor("smash_damage")
	self.smash_distance = self:GetAbilitySpecialValueFor("smash_distance")
	self.attacks = self:GetAbilitySpecialValueFor("attacks")
	self.movespeed = self:GetAbilitySpecialValueFor("movespeed")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.stagger_duration = self:GetAbilitySpecialValueFor("stagger_duration")
end
function r.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	self.parent:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
	self.forward = StringToVector(s.direction)
	self:StartIntervalThink(self.interval)
	self:OnIntervalThink()
	if not self:ApplyHorizontalMotionController() then
		self.parent:RemoveHorizontalMotionController(self)
	end
end
function r.prototype.OnDestroy(self)
	if IsServer() then
		self.parent:RemoveHorizontalMotionController(self)
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_stagger",
			{ animation = ACT_DOTA_DEFEAT, duration = self.stagger_duration }
		)
	end
end
function r.prototype.UpdateHorizontalMotion(self, t, u)
	local v = t:GetOrigin() + self.forward * self.movespeed * u
	v = GetGroundPosition(v, t)
	if not GridNav:IsTraversable(v) or GridNav:IsBlocked(v) then
		self:Destroy()
		return
	end
	t:SetOrigin(v)
end
function r.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_SILENCED] = true }
end
function r.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING }
end
function r.prototype.GetModifierDisableTurning(self)
	return 1
end
function r.prototype.OnIntervalThink(self)
	self.ctr = self.ctr + 1
	if self.ctr >= self.attacks then
		self:Smash()
	else
		self:Swipe()
	end
end
function r.prototype.Smash(self)
	local w = self.parent:GetOrigin() + self.forward * self.smash_distance
	local x = FindUnitsInRadiusWithAbility(self.parent, w, self.smash_radius, self.ability)
	self.parent:DealDamage(x, self.ability, self.smash_damage)
	self.parent:EmitSound("Hero_Dawnbreaker.Fire_Wreath.Smash")
	self:PlayEffects3(w)
	self:Destroy()
end
function r.prototype.Swipe(self)
	local x = FindUnitsInRadiusWithAbility(self.parent, self.parent:GetAbsOrigin(), self.swipe_radius, self.ability)
	self.parent:DealDamage(x, self.ability, self.swipe_damage)
	self:PlayEffects1()
	self:PlayEffects2()
	self.parent:EmitSound("Hero_Dawnbreaker.Fire_Wreath.Sweep")
end
function r.prototype.PlayEffects1(self)
	local y = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_sweep_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:ReleaseParticleIndex(y)
end
function r.prototype.PlayEffects2(self)
	local z = RotatePosition(Vector(0, 0, 0), QAngle(0, -120, 0), self.forward)
	local y = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_sweep.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		y,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlForward(y, 0, z)
	self:AddParticle(y, false, false, -1, false, false)
end
function r.prototype.PlayEffects3(self, A)
	local y = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_smash.vpcf",
		PATTACH_WORLDORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControl(y, 0, A)
	ParticleManager:ReleaseParticleIndex(y)
end
r = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
return f