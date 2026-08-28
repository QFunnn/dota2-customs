--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_lion/boss_lion_5"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_lion_5"
d(j, h)
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
end
function j.prototype.OnAbilityPhaseStart(self)
	if IsServer() then
		local k = self:GetCaster()
		local l = self:GetCursorPosition()
		local m = self:GetSpecialValueFor("width")
		local n = CalcDirection2D(l, k:GetAbsOrigin())
		k:SetForwardVector(CalcDirection2D(l, k))
		k:FaceTowards(l)
		local o = self:GetCastRange(vec3_zero, nil)
		local p = FindEnemiesInRadius(k, l, o, FIND_CLOSEST)
		local q = p[1]
		if IsValid(q) then
			local r = 30
			local s = CalcDirection2D(l, k)
			if (l - k:GetAbsOrigin()):Length2D() <= 0 then
				s = CalcDirection2D(q:GetAbsOrigin(), k)
			end
			local t = k:GetAbsOrigin() + s * o
			local u = self:FacingSupport(t, q, r, o)
			self:LineWarning(k, u, m, self:GetCastPoint())
			self:LockFacingTarget(q, r)
		end
	end
	return true
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local n = AnglesToVector(k:GetLocalAngles())
	local o = self:GetCastRange(vec3_zero, nil)
	local m = self:GetSpecialValueFor("width")
	local t = k:GetAbsOrigin() + n * m
	local v = t + n * o
	local w = self:GetSpecialValueFor("damage")
	k:SimulateCast({
		castPoint = 0.13,
		duration = 0.77,
		castAnimation = ACT_SCRIPT_CUSTOM_21,
		OnSpellStart = function()
			local p = FindEnemiesInLine(k, t, v, m)
			k:DealDamage(p, self, w)
			local x = k:GetAttachmentPosition("attach_attack2")
			v.z = x.z
			local y = ParticleManager:CreateParticle(
				"particles/econ/items/lion/dungeon_poacher/dungeon_poacher_finger.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlEnt(y, 0, k, PATTACH_POINT_FOLLOW, "attach_attack2", t, true)
			ParticleManager:SetParticleControlForward(y, 0, n)
			ParticleManager:SetParticleControl(y, 1, v)
			ParticleManager:ReleaseParticleIndex(y)
			EmitSoundOn("Hero_Lion.FingerOfDeathImpact", k)
		end,
	})
end
j = e({ i(nil) }, j)
return f