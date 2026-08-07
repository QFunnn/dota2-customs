--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_earthshaker_aftershock_dash"
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
n.name = "enemy_boss_earthshaker_aftershock_dash"
d(n, k)
function n.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function n.prototype.OnAbilityPhaseStart(self)
	local o = self:GetCaster()
	local p = self:GetCursorPosition()
	local q = o:GetAbsOrigin()
	local r = CalcDistance(q, p)
	local s = CalcDirection(p, q)
	local t = self:GetSpecialValueFor("height")
	o:Dash(s, r, t, self:GetCastPoint())
	self:CreateRadiusWarningParticle()
	return true
end
function n.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle()
end
function n.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local o = self:GetCaster()
	local p = self:GetCursorPosition()
	local u = o:FindAbilityByName("enemy_boss_earthshaker_aftershock")
	if u ~= nil then
		u:OnSpellStart()
		if self:GetLevel() >= 2 then
			o:AddNewModifier(
				o,
				self,
				"modifier_enemy_boss_earthshaker_aftershock_dash",
				{ duration = (u and u:GetSpecialValueFor("stagger_duration")) + 0.1 }
			)
		end
	end
end
n = e({ m(nil) }, n)
local v = c()
v.name = "modifier_enemy_boss_earthshaker_aftershock_dash"
d(v, h)
function v.prototype.OnDestroy(self)
	if IsServer() then
		local u = self.parent:FindAbilityByName("enemy_boss_earthshaker_fissure")
		if u ~= nil then
			u:AutoSpell()
		end
	end
end
v = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	v
)
return f