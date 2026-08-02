--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_suicide"
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
n.name = "enemy_suicide"
d(n, k)
function n.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function n.prototype.OnAbilityPhaseStart(self)
	local o = self:GetCursorPosition()
	local p = self:GetAOERadius()
	local q = ParticleManager:CreateParticle(
		"particles/econ/events/darkmoon_2017/darkmoon_calldown_marker.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(q, 0, o)
	ParticleManager:SetParticleControl(q, 1, Vector(p, -p, -p))
	ParticleManager:SetParticleControl(q, 2, Vector(self:GetCastPoint(), 0, 0))
	local r = self.warnParticleId
	r[#r + 1] = q
	return true
end
function n.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle()
end
function n.prototype.OnSpellStart(self)
	local s = self:GetCaster()
	local o = self:GetCursorPosition()
	local t = s:GetAbsOrigin()
	local u = CalcDistance(o, t)
	local v = CalcDirection(o, t)
	local w = self:GetSpecialValueFor("speed")
	local p = self:GetAOERadius()
	local x = s:AddNewModifier(s, self, "modifier_enemy_suicide", { duration = u / w + 1 })
	s:Dash(v, u, 500, u / w, function(t, y)
		if IsValid(x) then
			x:Destroy()
		end
		self:DestroyWarningParticle()
		if not IsValid(s) or not y or s:IsAlive() == false then
			return
		end
		local z = s:GetAbsOrigin()
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_techies/techies_blast_off.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(A, 0, z)
		ParticleManager:SetParticleControl(A, 1, Vector(p, 0, 1))
		ParticleManager:SetParticleControl(A, 2, Vector(p, 0, 1))
		ParticleManager:ReleaseParticleIndex(A)
		local B = FindUnitsInRadiusWithAbility(s, z, p, self)
		s:DealDamage(B, self, self:GetSpecialValueFor("damage"))
		EmitSoundOn("Hero_Techies.Suicide", s)
	end)
	EmitSoundOn("Hero_Techies.BlastOff.Cast", s)
end
n = e({ m(nil) }, n)
local C = c()
C.name = "modifier_enemy_suicide"
d(C, h)
function C.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true }
end
function C.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function C.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_OVERRIDE_ABILITY_2
end
C = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	C
)
return f