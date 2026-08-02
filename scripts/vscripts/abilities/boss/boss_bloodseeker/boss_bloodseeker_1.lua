--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_bloodseeker/boss_bloodseeker_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_bloodseeker_1"
d(j, h)
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
end
function j.prototype.OnAbilityPhaseStart(self)
	if IsServer() then
		local k = self:GetCaster()
		local l = self:GetCursorPosition()
		local m = self:GetSpecialValueFor("width")
		k:SetForwardVector(CalcDirection2D(l, k))
		k:FaceTowards(l)
		local n = self:GetCastRange(vec3_zero, nil)
		local o = FindEnemiesInRadius(k, l, n, FIND_CLOSEST)
		local p = o[1]
		if IsValid(p) then
			local q = 30
			local r = CalcDirection2D(l, k)
			if (l - k:GetAbsOrigin()):Length2D() <= 0 then
				r = CalcDirection2D(p:GetAbsOrigin(), k)
			end
			local s = k:GetAbsOrigin() + r * n
			local t = self:FacingSupport(s, p, q, n)
			self:LineWarning(k, t, m, self:GetCastPoint())
			self:LockFacingTarget(p, q)
		end
	end
	return true
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local u = AnglesToVector(k:GetLocalAngles())
	local n = self:GetCastRange(vec3_zero, nil)
	local s = k:GetAbsOrigin()
	local v = s + u * n
	local w = self:GetSpecialValueFor("damage")
	local m = self:GetSpecialValueFor("width")
	k:SimulateCast({
		castAnimation = ACT_SCRIPT_CUSTOM_2,
		castPoint = 0.2,
		duration = 0.87,
		OnSpellStart = function()
			local o = FindEnemiesInLine(k, s, v, m)
			k:DealDamage(o, self, w)
			FindClearSpaceForUnit(k, v, true)
			local x = ParticleManager:CreateParticle(
				"particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(x, 0, s)
			ParticleManager:SetParticleControl(x, 1, v)
		end,
	})
	k:EmitSound("Hero_VoidSpirit.Pulse.Target")
end
j = e({ i(nil) }, j)
return f