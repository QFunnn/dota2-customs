--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_mortal_strike"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "boss_mortal_strike"
d(m, k)
function m.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	n:SimulateCast({ duration = 1.46 })
	local o = self:GetCursorPosition()
	local p = CalcDistance(o, n)
	local q = CalcDirection2D(o, n)
	local r = self:GetSpecialValueFor("damage")
	local s = RemapValClamped(p, 0, 1200, 600, 200)
	n:SetForwardVector(q)
	n:StartGesture(ACT_DOTA_TELEPORT_END)
	n:KnockBack(-q, s, 0, 0.6, function(o)
		FindClearSpaceForUnit(n, o, true)
		local t = n:GetAbsOrigin()
		local u = n:GetHullRadius() + 50
		local v = FindEnemiesInRadius(n, t, u)
		for w, x in ipairs(v) do
			x:KnockBack(CalcDirection2D(x, t), u - CalcDistance(x, t), 0, 0.1)
		end
	end)
	n:EmitSound("skeleton_king_skel_arc_attack_12")
	self:StartThink(0.9, "landed", function()
		self:CircleWarning(o, 350, 0.56)
		n:StartGesture(ACT_DOTA_CAST_ABILITY_3)
		n:Dash(q, p + s - 300, 150, 0.56, function(y)
			FindClearSpaceForUnit(n, y, true)
			local z = n:GetAbsOrigin()
			local u = n:GetHullRadius() + 50
			local v = FindEnemiesInRadius(n, z, u)
			for w, x in ipairs(v) do
				x:KnockBack(CalcDirection2D(x, z), u - CalcDistance(x, z), 0, 0.1)
			end
			local A = FindEnemiesInRadius(n, o, 350)
			for w, x in ipairs(A) do
				n:DealDamage(x, nil, r)
			end
			local B = n:GetAbsOrigin() + n:GetForwardVector() * 200 + Vector(0, 0, 50)
			local C = ParticleManager:CreateParticle(
				"particles/econ/items/wraith_king/wraith_king_arcana/wk_arc_weapon_blur_critical.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlTransformForward(C, 0, B, n:GetForwardVector())
			ParticleManager:ReleaseParticleIndex(C)
			local D = ParticleManager:CreateParticle(
				"particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(D, 0, o)
			ParticleManager:SetParticleControl(D, 1, Vector(350, 0, 0))
			n:EmitSound("Hero_SkeletonKing.CriticalStrike.TI8")
			n:EmitSound("n_creep_Thunderlizard_Big.Stomp")
			self:SummonShadowRaze()
			self:DestroyWarningParticles()
		end)
		return -1
	end)
end
function m.prototype.SummonShadowRaze(self)
	local n = self:GetCaster()
	local E = n:GetAbsOrigin()
	local F = self:GetSpecialValueFor("raze_damage")
	local G = {}
	Bullet:SplitAction(n:GetForwardVector(), 8, 360 / 8, function(w, q, H)
		local o = E + q * RandomInt(400, 900)
		G[#G + 1] = o
		local I = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, n)
		ParticleManager:SetParticleControl(I, 0, o)
		ParticleManager:SetParticleControl(I, 1, o)
		ParticleManager:SetParticleControl(I, 2, Vector(200, 1, 0))
	end)
	self:StartThink(1, "shadow_raze", function()
		for w, o in ipairs(G) do
			local A = FindEnemiesInRadius(n, o, 200)
			for w, x in ipairs(A) do
				n:DealDamage(x, nil, F)
			end
			local D = ParticleManager:CreateParticle(
				"particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(D, 0, o)
			ParticleManager:ReleaseParticleIndex(D)
		end
		n:EmitSound("Hero_Nevermore.Shadowraze")
		return -1
	end)
end
m = e({ l(nil) }, m)
local J = c()
J.name = "modifier_boss_mortal_strike"
d(J, h)
J = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	J
)
return f