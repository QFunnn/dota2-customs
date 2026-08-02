--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/attack/custom_hammer_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.registerAbility
local j = c()
j.name = "custom_hammer_attack"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.warningParticleID = {}
	self.melee_radius = 200
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
function j.prototype.GetCooldown(self, l)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
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
function j.prototype.GetCastAnimation(self)
	return ACT_DOTA_CAST_ABILITY_2
end
function j.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false) * self.attackPlaybackRate
end
function j.prototype.OnAbilityPhaseStart(self)
	local m = self:GetCaster()
	local n = self:GetCursorPosition()
	self:CircleWarning(n, self.melee_radius, self:GetCastPoint())
	m:EmitSound(KeyValues:GetAttackSoundSet(m, "SoundSet") .. ".PreAttack")
	Event:Fire("pre_attack_event", { attacker = m, position = n })
	return true
end
function j.prototype.DestroyWarningParticle(self, o)
	if o == nil then
		o = false
	end
	for p, q in ipairs(self.warningParticleID) do
		ParticleManager:DestroyParticle(q, o)
		ParticleManager:ReleaseParticleIndex(q)
	end
	self.warningParticleID = {}
end
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle(true)
end
function j.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local m = self:GetCaster()
	local n = self:GetCursorPosition()
	local r = FindUnitsInRadius(
		m:GetTeam(),
		n,
		nil,
		self.melee_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING + DOTA_UNIT_TARGET_OTHER,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_ANY_ORDER,
		false
	)
	for p, s in ipairs(r) do
		m:Attack(s)
	end
	m:EmitSound(KeyValues:GetAttackSoundSet(m, "SoundSet") .. ".Attack")
	Event:Fire("attack_event", { attacker = m, position = n })
end
j = e({ i(nil) }, j)
return f