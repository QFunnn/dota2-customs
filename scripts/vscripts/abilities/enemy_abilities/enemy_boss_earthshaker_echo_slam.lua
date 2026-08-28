--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_earthshaker_echo_slam"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.bt_ability_ai")
local k = j.EOMBTAbilityAI
local l = require("abilities.eom_ability")
local m = l.registerEOMAbility
local n = c()
n.name = "enemy_boss_earthshaker_echo_slam"
d(n, k)
function n.prototype.GetAOERadius(self)
	return self:GetCastRange(vec3_zero, nil)
end
function n.prototype.OnAbilityPhaseStart(self)
	local o = self:GetCaster()
	self.direction = o:GetForwardVector()
	self:CreateWarningParticle(o, self.direction)
	return true
end
function n.prototype.CreateWarningParticle(self, p, q)
	local r = self:GetSpecialValueFor("angle")
	local s = self:GetSpecialValueFor("count")
	self:CreateSectorWarningParticle(p:GetAbsOrigin(), q, r)
	if s >= 2 then
		self:CreateSectorWarningParticle(p:GetAbsOrigin(), q * -1, r)
	end
	if s >= 3 then
		self:CreateSectorWarningParticle(p:GetAbsOrigin(), Rotation2D(q, 90, true), r)
	end
end
function n.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle()
end
function n.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local o = self:GetCaster()
	o:AddNewModifier(o, self, "modifier_enemy_boss_earthshaker_echo_slam", { direction = self.direction })
end
n = e({ m(nil) }, n)
local t = c()
t.name = "modifier_enemy_boss_earthshaker_echo_slam"
d(t, h)
function t.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.distance = self.ability:GetAOERadius()
	self.speed = self:GetAbilitySpecialValueFor("speed")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.angle = self:GetAbilitySpecialValueFor("angle")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.times = self:GetAbilitySpecialValueFor("times")
	self.stagger_duration = self:GetAbilitySpecialValueFor("stagger_duration")
end
function t.prototype.OnCreated(self, u)
	if IsServer() then
		self.direction = StringToVector(u.direction)
		self:OnIntervalThink()
		self:StartIntervalThink(self.interval)
	end
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		local v = self.ability
		if v ~= nil then
			v:DestroyWarningParticle()
		end
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_stagger",
			{ animation = ACT_DOTA_TELEPORT, duration = self.stagger_duration }
		)
	end
end
function t.prototype.echoSlamHit(self, q)
	local w = self.parent:GetAbsOrigin()
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_mars/mars_shield_bash.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlTransformForward(x, 0, w, q)
	ParticleManager:SetParticleControl(x, 1, Vector(self.distance, self.distance, self.distance))
	ParticleManager:ReleaseParticleIndex(x)
	local y = FindUnitsInSectorWithAbility(self.parent, w, self.distance, q, self.angle, self.ability)
	for z, A in ipairs(y) do
		do
			if A:TriggerSpellAbsorb(self.ability) then
				goto B
			end
			local x = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlTransformForward(x, 0, A:GetAbsOrigin(), CalcDirection(A, self.parent))
			self.parent:DealDamage(A, self.ability, self.damage)
		end
		::B::
	end
end
function t.prototype.OnIntervalThink(self)
	if IsServer() then
		if not IsValid(self.ability) then
			self:Destroy()
			return
		end
		self.ability:DestroyWarningParticle()
		self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1.21 / self.interval)
		self:echoSlamHit(self.direction)
		if self.count >= 2 then
			self:echoSlamHit(self.direction * -1)
		end
		if self.count >= 3 then
			self:echoSlamHit(Rotation2D(self.direction, 90, true))
		end
		self.parent:EmitSound("Hero_EarthShaker.EchoSlam")
		self.times = self.times - 1
		if self.times <= 0 then
			self:Destroy()
			return
		end
		self.direction = Rotation2D(self.direction, 90, true)
		self.parent:SetForwardVector(self.direction)
		self.ability:CreateWarningParticle(self.parent, self.direction)
	end
end
function t.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_SILENCED] = true }
end
function t.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING }
end
function t.prototype.GetModifierDisableTurning(self)
	return 1
end
t = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
return f