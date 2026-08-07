--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_split_ice_bomb"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.bt_ability_ai")
local h = g.EOMBTAbilityAI
local i = require("abilities.eom_ability")
local j = i.registerEOMAbility
local k = c()
k.name = "enemy_split_ice_bomb"
d(k, h)
function k.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = CalcDirection2D(m, l)
	local o = l:GetAbsOrigin()
	return true
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local p = CalcDistance(m, l)
	local n = CalcDirection2D(m, l)
	l:EmitSound("n_creep_ice_shaman.IceBomb.Cast")
	local q = self:GetSpecialValueFor("duration")
	local r = self:GetSpecialValueFor("distance")
	local s = self:GetSpecialValueFor("radius")
	local t = ParticleManager:CreateParticle("particles/neutral_fx/icefire_bomb_custom.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt(t, 0, l, PATTACH_ABSORIGIN_FOLLOW, nil, l:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(t, 1, m)
	ParticleManager:SetParticleControl(t, 2, Vector(p / (q * 0.7), 0, 0))
	local u = {}
	local v = self:GetSpecialValueFor("split")
	Bullet:SplitAction(n, v, 360 / v, function(w, x, y)
		u[#u + 1] = x
		self:LineWarning(m, m + x * r, BULLET_WIDTH, q)
	end)
	Timer:GameTimer(q, function()
		ParticleManager:DestroyParticle(t, false)
		if not IsValid(self) then
			return
		end
		if not l:IsAlive() then
			return
		end
		l:EmitSound("n_creep_ice_shaman.IceBomb.Target", m)
		local z = l:GetProjectileSpeed()
		for A, x in ipairs(u) do
			Bullet:CreateLinearBullet({
				caster = l,
				direction = x,
				distance = r,
				moveSpeed = z,
				radius = BULLET_WIDTH,
				reflectable = true,
				teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
				typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				ability = self,
				spawnOrigin = m,
				ParticleCreator = function(B)
					local C = ParticleManager:CreateParticle(
						"particles/base_attacks/ranged_tower_good_linear.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(C, 0, m)
					ParticleManager:SetParticleControl(C, 1, x * z)
					return C
				end,
				OnBulletHit = function(D, m, B)
					l:Attack(D)
					EmitSoundOn("Creep_Good_Range.ProjectileImpact", D)
				end,
			})
		end
	end)
end
k = e({ j(nil) }, k)
return f