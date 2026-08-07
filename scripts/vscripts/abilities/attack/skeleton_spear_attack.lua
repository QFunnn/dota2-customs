--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/attack/skeleton_spear_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.registerAbility
local j = c()
j.name = "skeleton_spear_attack"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.warnParticleId = {}
end
function j.prototype.GetCooldown(self, k)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
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
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles(true)
end
function j.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	local m = l:GetAbsOrigin()
	local n = self:GetCursorPosition()
	local o = CalcDirection2D(n, m)
	local p = l:Script_GetAttackRange() + 50
	local q = m + o * p
	local r = 100
	self:LineWarning(l, q, r, self:GetCastPoint())
	l:EmitSound(KeyValues:GetAttackSoundSet(l, "SoundSet") .. ".PreAttack")
	Event:Fire("pre_attack_event", { attacker = l, position = n })
	return true
end
function j.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local l = self:GetCaster()
	local m = l:GetAbsOrigin()
	local n = self:GetCursorPosition()
	local o = CalcDirection2D(n, m)
	local p = l:Script_GetAttackRange() + 50
	local q = m + o * p
	local r = 100
	local s = Vector(-o.y, o.x, 0)
	local t = m + s * r
	local u = m - s * r
	local v = q - s * r
	local w = q + s * r
	local x = { t, u, v, w }
	local y = FindEnemiesInLine(l, m, q, r)
	for z, A in ipairs(y) do
		if IsPointInPolygon(A:GetAbsOrigin(), x) then
			l:Attack(A)
		end
	end
	l:SimulateCast({ castAnimation = ACT_SCRIPT_CUSTOM_18, duration = 0.73 })
	l:EmitSound(KeyValues:GetAttackSoundSet(l, "SoundSet") .. ".Attack")
	Event:Fire("attack_event", { attacker = l, position = n })
end
j = e({ i(nil) }, j)
return f