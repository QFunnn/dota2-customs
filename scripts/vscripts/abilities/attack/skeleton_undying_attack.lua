--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/attack/skeleton_undying_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.registerAbility
local j = c()
j.name = "skeleton_undying_attack"
d(j, h)
function j.prototype.GetCastRange(self, k, l)
	return self:GetCaster():Script_GetAttackRange()
end
function j.prototype.GetCooldown(self, m)
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
function j.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	local o = self:GetCursorPosition()
	local p = CalcDirection2D(o, n)
	local q = n:GetAbsOrigin()
	local r = q + p * n:Script_GetAttackRange()
	local s = 120
	self:LineWarning(q, r, s, self:GetCastPoint())
	n:EmitSound(KeyValues:GetAttackSoundSet(n, "SoundSet") .. ".PreAttack")
	Event:Fire("pre_attack_event", { attacker = n, position = o })
	return true
end
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles(true)
end
function j.prototype.GetBackswingTime(self)
	return 0.63
end
function j.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local n = self:GetCaster()
	local o = self:GetCursorPosition()
	local p = CalcDirection2D(o, n)
	local t = n:Script_GetAttackRange()
	local q = n:GetAbsOrigin()
	n:SimulateCast({ duration = self:GetBackswingTime() })
	n:StartGesture(ACT_SCRIPT_CUSTOM_21)
	local s = 120
	local u = 1000
	Bullet:CreateLinearBullet({
		caster = n,
		ability = self,
		spawnOrigin = q,
		moveSpeed = u,
		direction = p,
		distance = t,
		radius = s,
		ParticleCreator = function()
			local v = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(v, 0, q)
			ParticleManager:SetParticleControl(v, 1, p * u)
			return v
		end,
		OnBulletHit = function(l, o, w)
			n:Attack(l)
		end,
	})
	n:EmitSound(KeyValues:GetAttackSoundSet(n, "SoundSet") .. ".Attack")
	Event:Fire("attack_event", { attacker = n, position = o })
end
j = e({ i(nil) }, j)
return f