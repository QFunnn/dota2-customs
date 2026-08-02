--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_lion/boss_lion_1"
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
n.name = "boss_lion_1"
d(n, l)
function n.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
end
function n.prototype.OnAbilityPhaseStart(self)
	if IsServer() then
		local o = self:GetCursorPosition()
		self:CircleWarning(o, self.radius, self:GetCastPoint())
	end
	return true
end
function n.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	local o = self:GetCursorPosition()
	local q = self:GetCastRange(vec3_zero, nil)
	local r = FindEnemiesInRadius(p, o, q, FIND_CLOSEST)
	local s = r[1]
	if IsValid(s) then
		local t = CreateModifierThinker(
			p,
			self,
			"modifier_boss_lion_1_thinker",
			{ duration = self.duration, target_index = s:entindex(), turnRate = self.turn_rate },
			o,
			p:GetTeamNumber(),
			false
		)
		self:LockFacingTarget(t, self.turn_rate, self.duration)
		local u = nil
		p:SimulateCast({
			castAnimation = ACT_SCRIPT_CUSTOM_8,
			castPoint = 0.2,
			duration = self.duration,
			OnSpellStart = function()
				u = t:AddNewModifier(p, self, "modifier_boss_lion_1_buff", { duration = self.duration })
			end,
			OnFinish = function()
				if u ~= nil then
					u:Destroy()
				end
				p:RemoveGesture(ACT_SCRIPT_CUSTOM_8)
			end,
		})
	end
end
e({ k(nil) }, n.prototype, "radius", nil)
e({ k(nil) }, n.prototype, "duration", nil)
e({ k(nil) }, n.prototype, "turn_rate", nil)
n = e({ m(nil) }, n)
local v = c()
v.name = "modifier_boss_lion_1_thinker"
d(v, h)
function v.prototype.GetAbilitySpecialValue(self)
	self.move_speed = self:GetAbilitySpecialValueFor("move_speed")
	self.radius = self:GetAbilitySpecialValueFor("radius")
end
function v.prototype.OnCreated(self, w)
	if IsServer() then
		local s = EntIndexToHScript(w.target_index)
		local p = self:GetCaster()
		if not IsValid(s) or not IsValid(p) then
			self:Destroy()
			return
		end
		self.target = s
		local x = w.turnRate
		if x == nil then
			x = 50
		end
		self.turnRate = x
		self.currentYaw = VectorToAngles(CalcDirection2D(self.parent, p)).y
		self:StartIntervalThink(0)
		local y = ParticleManager:CreateParticle(
			"particles/units/boss/boss_lion/boss_lion_skill_explosion_fx.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(
			y,
			0,
			self.parent,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			y,
			1,
			self.parent,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControl(y, 2, Vector(2, self:GetDuration(), 0))
		ParticleManager:SetParticleControl(y, 4, Vector(2, 3, 3))
		self:AddParticle(y, false, false, -1, false, false)
	end
end
function v.prototype.OnIntervalThink(self)
	if IsServer() then
		local z = self:GetCaster()
		if not (z and z:IsAlive()) then
			self:Destroy()
			return
		end
		local A = CalcDirection2D(self.target:GetAbsOrigin(), self.parent)
		local B = VectorToAngles(A).y
		local C = AngleDiff(B, self.currentYaw)
		local D = self.turnRate * FrameTime()
		local E = math.max(-D, math.min(D, C))
		local F = self.currentYaw + E
		if math.abs(C) <= D then
			F = B
		end
		self.currentYaw = F
		local G = AnglesToVector(QAngle(0, F, 0))
		local H = self.parent:GetOrigin() + G * self.move_speed * FrameTime()
		H = GetGroundPosition(H, self.parent)
		self.parent:SetLocalOrigin(H)
	end
end
function v.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveSelf()
	end
end
function v.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
v = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	v
)
local I = c()
I.name = "modifier_boss_lion_1_buff"
d(I, h)
function I.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.tick_interval = self:GetAbilitySpecialValueFor("tick_interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.mana = self:GetAbilitySpecialValueFor("mana")
end
function I.prototype.OnCreated(self, w)
	if IsServer() then
		self:PlayEffects()
		self:StartIntervalThink(self.tick_interval)
	end
end
function I.prototype.PlayEffects(self)
	local J = "particles/units/heroes/hero_lion/lion_spell_mana_drain.vpcf"
	local K = ParticleManager:CreateParticle(J, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(
		K,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		K,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_mouth",
		Vector(0, 0, 0),
		true
	)
	self:AddParticle(K, false, false, -1, false, false)
	EmitSoundOn("Hero_Lion.ManaDrain", self:GetParent())
end
function I.prototype.OnIntervalThink(self)
	if IsServer() then
		local L = self:GetCaster()
		if not (L and L:IsAlive()) then
			self:Destroy()
			return
		end
		local r = FindEnemiesInRadius(self:GetCaster(), self:GetParent():GetAbsOrigin(), self.radius, FIND_CLOSEST)
		if #r > 0 then
			self:GetCaster():DealDamage(r, self:GetAbility(), self.damage * self.tick_interval)
			for M, s in ipairs(r) do
				s:SpendMana(self.mana, self:GetAbility())
			end
		end
	end
end
function I.prototype.OnDestroy(self)
	if IsServer() then
		StopSoundOn("Hero_Lion.ManaDrain", self:GetParent())
	end
end
I = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	I
)
return f