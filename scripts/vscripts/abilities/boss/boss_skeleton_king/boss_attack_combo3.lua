--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_attack_combo3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_attack_combo3"
d(j, h)
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local l = self:GetCursorPosition()
	local m = CalcDirection2D(l, k)
	k:Dash(m, CalcDistance(l, k) - 300, 150, 0.8, function(l)
		k:PushOff(l)
	end)
	local n = 1
	local o = self:GetSpecialValueFor("radius")
	local p = self:GetSpecialValueFor("damage")
	self:CircleWarning(l, o, n)
	self:StartThink(n, function()
		local q = ParticleManager:CreateParticle(
			"particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(q, 0, l)
		ParticleManager:SetParticleControl(q, 1, Vector(o, 0, 0))
		local r = FindEnemiesInRadius(k, l, o)
		k:DealDamage(r, nil, p)
		k:EmitSound("n_creep_Thunderlizard_Big.Stomp")
		return -1
	end)
	k:SimulateCast({
		orderType = DOTA_UNIT_ORDER_CAST_POSITION,
		position = l,
		castPoint = 0.8,
		castAnimation = ACT_SCRIPT_CUSTOM_14,
		duration = 1.47,
		OnSpellStart = function()
			k:StartGesture(ACT_SCRIPT_CUSTOM_15)
		end,
	})
end
j = e({ i(nil) }, j)
return f