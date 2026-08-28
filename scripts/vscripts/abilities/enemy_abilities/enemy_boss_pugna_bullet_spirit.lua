--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_pugna_bullet_spirit"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.bt_ability_ai")
local i = h.EOMBTAbilityAI
local j = require("abilities.eom_ability")
local k = j.registerEOMAbility
local l = c()
l.name = "enemy_boss_pugna_bullet_spirit"
d(l, i)
function l.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("width")
end
function l.prototype.GetStartPosition(self, m, n)
	return
end
function l.prototype.OnAbilityPhaseStart(self)
	local m = self:GetCaster()
	local o = m:GetAbsOrigin()
	local p = self:GetCursorPosition()
	self.direction = CalcDirection(p, o)
	o = o + self.direction * m:GetHullRadius()
	local q = self:GetSpecialValueFor("distance")
	local r = self:GetSpecialValueFor("count")
	local s = self:GetSpecialValueFor("angle")
	Bullet:SplitAction(self.direction, r, s, function(t, u, v)
		self:CreateLinerWarningParticle(o, o + u * q)
	end)
	m:EmitSound("Hero_DeathProphet.SpiritSiphon.Cast")
	return true
end
function l.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle()
end
function l.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local w = {}
	local m = self:GetCaster()
	local o = m:GetAbsOrigin() + self.direction * m:GetHullRadius()
	local r = self:GetSpecialValueFor("count")
	local s = self:GetSpecialValueFor("angle")
	local q = self:GetSpecialValueFor("distance")
	local x = self:GetSpecialValueFor("speed")
	local y = self:GetSpecialValueFor("width")
	local z = self:GetSpecialValueFor("angular_velocity")
	local A = self:GetSpecialValueFor("bounce_count")
	local B = "particles/units/heroes/hero_death_prophet/death_prophet_spirit_model.vpcf"
	local function C(t, n, D)
		return {
			caster = m,
			direction = n,
			ability = self,
			ignoreBlock = true,
			effectName = B,
			spawnOrigin = D,
			moveSpeed = x,
			radius = y,
			lifeTime = q / x,
			angularVelocity = z,
			bounce = A,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
			OnBulletHit = function(E, p, F)
				if e(w, E) then
					return
				end
				w[#w + 1] = E
				m:DealDamage(E, self, self:GetSpecialValueFor("damage"))
			end,
			ParticleCreator = function(F)
				local G = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_death_prophet/death_prophet_spirit_model.vpcf",
					PATTACH_CUSTOMORIGIN,
					m
				)
				ParticleManager:SetParticleControlEnt(
					G,
					0,
					F.__thinker,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					F.__thinker:GetAbsOrigin(),
					false
				)
				return G
			end,
		}
	end
	Bullet:SplitAction(self.direction, r, s, function(t, u, v)
		local H = C(nil, u, o)
		Bullet:CreateGuidedBullet(H)
	end)
end
l = f({ k(nil) }, l)
return g