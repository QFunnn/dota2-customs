--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		n:SetAbsOrigin(o)
		local t = n:GetHullRadius() + 50
		local u = FindEnemiesInRadius(n, o, t)
		for v, w in ipairs(u) do
			w:KnockBack(CalcDirection2D(w, o), t - CalcDistance(w, o), 0, 0.1)
		end
	end)
	n:EmitSound("skeleton_king_skel_arc_attack_12")
	self:StartThink(0.9, "landed", function()
		self:CircleWarning(o, 350, 0.56)
		n:StartGesture(ACT_DOTA_CAST_ABILITY_3)
		n:Dash(q, p + s - 300, 150, 0.56, function(x)
			n:SetAbsOrigin(x)
			local t = n:GetHullRadius() + 50
			local u = FindEnemiesInRadius(n, x, t)
			for v, w in ipairs(u) do
				w:KnockBack(CalcDirection2D(w, x), t - CalcDistance(w, x), 0, 0.1)
			end
			local y = FindEnemiesInRadius(n, o, 350)
			for v, w in ipairs(y) do
				n:DealDamage(w, nil, r)
			end
			local z = n:GetAbsOrigin() + n:GetForwardVector() * 200 + Vector(0, 0, 50)
			local A = ParticleManager:CreateParticle(
				"particles/econ/items/wraith_king/wraith_king_arcana/wk_arc_weapon_blur_critical.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlTransformForward(A, 0, z, n:GetForwardVector())
			ParticleManager:ReleaseParticleIndex(A)
			local B = ParticleManager:CreateParticle(
				"particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(B, 0, o)
			ParticleManager:SetParticleControl(B, 1, Vector(350, 0, 0))
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
	local C = n:GetAbsOrigin()
	local D = self:GetSpecialValueFor("raze_damage")
	local E = {}
	Bullet:SplitAction(n:GetForwardVector(), 8, 360 / 8, function(v, q, F)
		local o = C + q * RandomInt(400, 900)
		E[#E + 1] = o
		local G = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, n)
		ParticleManager:SetParticleControl(G, 0, o)
		ParticleManager:SetParticleControl(G, 1, o)
		ParticleManager:SetParticleControl(G, 2, Vector(200, 1, 0))
	end)
	self:StartThink(1, "shadow_raze", function()
		for v, o in ipairs(E) do
			local y = FindEnemiesInRadius(n, o, 200)
			for v, w in ipairs(y) do
				n:DealDamage(w, nil, D)
			end
			local B = ParticleManager:CreateParticle(
				"particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(B, 0, o)
			ParticleManager:ReleaseParticleIndex(B)
		end
		n:EmitSound("Hero_Nevermore.Shadowraze")
		return -1
	end)
end
m = e({ l(nil) }, m)
local H = c()
H.name = "modifier_boss_mortal_strike"
d(H, h)
H = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	H
)
return f