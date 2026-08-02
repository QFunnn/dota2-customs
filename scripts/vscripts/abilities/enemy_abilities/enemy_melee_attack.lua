--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_melee_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.registerAbility
local j = c()
j.name = "enemy_melee_attack"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.melee_radius = 100
end
function j.prototype.ProcsMagicStick(self)
	return false
end
function j.prototype.GetCooldown(self, k)
	return self:GetCaster():GetSecondsPerAttack(false)
end
function j.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
	end
	return 0
end
function j.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false)
end
function j.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCursorPosition()
	local m = self:GetCaster()
	local n = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, m)
	ParticleManager:SetParticleControl(n, 0, l)
	ParticleManager:SetParticleControl(n, 1, l)
	ParticleManager:SetParticleControl(n, 2, Vector(self.melee_radius, self:GetCastPoint(), 0))
	m:EmitSound(KeyValues:GetAttackSoundSet(m, "SoundSet") .. ".PreAttack")
	return true
end
function j.prototype.OnSpellStart(self)
	local m = self:GetCaster()
	local l = self:GetCursorPosition()
	local o = FindUnitsInRadius(
		m:GetTeam(),
		l,
		nil,
		self.melee_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING + DOTA_UNIT_TARGET_OTHER,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_ANY_ORDER,
		false
	)
	for p, q in ipairs(o) do
		m:Attack(q)
	end
	m:EmitSound(KeyValues:GetAttackSoundSet(m, "SoundSet") .. ".Attack")
end
j = e({ i(nil) }, j)
return f