--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/common/custom_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.registerAbility
local j = c()
j.name = "custom_attack"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.melee_radius = 100
	self.warningParticleID = {}
end
function j.prototype.Spawn(self)
	if self.attackPlaybackRate == nil then
		local k = KeyValues:GetUnitData(self:GetCaster(), "AttackPlaybackRate")
		if k ~= nil and k > 0 then
			self.attackPlaybackRate = k
		else
			self.attackPlaybackRate = 1
		end
	end
end
function j.prototype.OnCreated(self)
	local l = toFiniteNumber
	local m = KeyValues.units[self:GetCaster():GetUnitName()]
	if m ~= nil then
		m = m.custom_aoe_attack
	end
	self.backswingTime = l(m, 0.2)
end
function j.prototype.ProcsMagicStick(self)
	return false
end
function j.prototype.GetCooldown(self, n)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function j.prototype.GetCastRange(self, o, p)
	return self:GetCaster():Script_GetAttackRange()
end
function j.prototype.GetBackswingTime(self)
	return self.backswingTime * self:GetCaster():GetSecondsPerAttack(false) / self:GetCaster():GetBaseAttackTime(false)
end
function j.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
			/ self.attackPlaybackRate
	end
	return 0
end
function j.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false) * self.attackPlaybackRate
end
function j.prototype.OnAbilityPhaseStart(self)
	local q = self:GetCursorPosition()
	local r = self:GetCaster()
	if r:GetRangedProjectileName() == "" then
		local s = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, r)
		ParticleManager:SetParticleControl(s, 0, q)
		ParticleManager:SetParticleControl(s, 1, q)
		ParticleManager:SetParticleControl(s, 2, Vector(self.melee_radius, self:GetCastPoint(), 0))
		local t = self.warningParticleID
		t[#t + 1] = s
	end
	local u = KeyValues:GetUnitData(r, "AttackWarning")
	if u ~= nil and u ~= "" then
		local s = ParticleManager:CreateParticle(u, PATTACH_ABSORIGIN_FOLLOW, r)
		local v = self.warningParticleID
		v[#v + 1] = s
	end
	r:EmitSound(KeyValues:GetAttackSoundSet(r, "SoundSet") .. ".PreAttack")
	Event:Fire("pre_attack_event", { attacker = r, position = q })
	return true
end
function j.prototype.DestroyWarningParticle(self, w)
	if w == nil then
		w = false
	end
	for x, y in ipairs(self.warningParticleID) do
		ParticleManager:DestroyParticle(y, w)
		ParticleManager:ReleaseParticleIndex(y)
	end
	self.warningParticleID = {}
end
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle(true)
end
function j.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local r = self:GetCaster()
	local z = r:GetAbsOrigin()
	local q = self:GetCursorPosition()
	local A = CalcDirection2D(q, z)
	r:SimulateCast({ duration = self:GetBackswingTime() })
	r:StartGesture(ACT_SCRIPT_CUSTOM_21)
	if r:GetRangedProjectileName() ~= "" then
		local B = r:Script_GetAttackRange() + 400
		local C = r:GetProjectileSpeed()
		local D = {
			caster = r,
			direction = A,
			effectName = r:GetRangedProjectileName(),
			spawnOrigin = z
				+ A * (r:GetHullRadius() + 100)
				+ Vector(0, 0, r:GetAttachmentPosition("attach_hitloc").z * 0.5),
			moveSpeed = C,
			radius = BULLET_WIDTH,
			lifeTime = B / C,
			reflectable = true,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
			OnBulletHit = function(p, q, E)
				r:Attack(p)
				return true
			end,
			OnBulletDestroy = function(E) end,
		}
		local F = GetUnitKeyValuesByName(r:GetUnitName())
		if F ~= nil then
			if F.GuidanceAngularVelocity ~= nil and F.GuidanceAngularVelocity ~= "" then
				D.angularVelocity = toFiniteNumber(F.GuidanceAngularVelocity)
			end
			if F.ProjectileType ~= nil and F.ProjectileType == "PROJECTILE_TYPE_LINEAR" then
				D.angularVelocity = 0
			end
		end
		Bullet:CreateGuidedBullet(D)
	else
		local G = FindUnitsInRadius(
			r:GetTeam(),
			q,
			nil,
			self.melee_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING + DOTA_UNIT_TARGET_OTHER,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
			FIND_ANY_ORDER,
			false
		)
		for x, H in ipairs(G) do
			r:Attack(H)
		end
	end
	r:EmitSound(KeyValues:GetAttackSoundSet(r, "SoundSet") .. ".Attack")
	Event:Fire("attack_event", { attacker = r, position = q })
end
j = e({ i(nil) }, j)
return f