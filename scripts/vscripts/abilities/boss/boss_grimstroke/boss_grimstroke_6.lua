--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_grimstroke/boss_grimstroke_6"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_grimstroke_6"
d(j, h)
function j.prototype.GetPathPoints(self, k)
	local l = self:GetCaster()
	local m = l:GetAbsOrigin()
	local n = self:GetCursorPosition()
	local o = CalcDirection2D(n, m)
	local p = RotatePosition(vec3_zero, QAngle(0, 90, 0), o)
	local q = m + o * 450 + p * 350 * k
	local r = self:GetQuadraticBezierControlPoint(m, q, n)
	return { start = m, target = n, direction = o, turnPoint = q, controlPoint = r }
end
function j.prototype.GetShotSides(self, s)
	local t = math.max(1, math.min(2, s))
	local u = { 1 }
	if t >= 2 then
		table.insert(u, -1)
	end
	return u
end
function j.prototype.GetQuadraticBezierControlPoint(self, m, v, n)
	return Vector(2 * v.x - 0.5 * (m.x + n.x), 2 * v.y - 0.5 * (m.y + n.y), 2 * v.z - 0.5 * (m.z + n.z))
end
function j.prototype.GetQuadraticBezierPoint(self, w, m, x, n)
	local y = 1 - w
	return Vector(
		y * y * m.x + 2 * y * w * x.x + w * w * n.x,
		y * y * m.y + 2 * y * w * x.y + w * w * n.y,
		y * y * m.z + 2 * y * w * x.z + w * w * n.z
	)
end
function j.prototype.EstimateQuadraticBezierLength(self, m, x, n, z)
	local A = 0
	local B = m
	do
		local C = 1
		while C <= z do
			local w = C / z
			local D = self:GetQuadraticBezierPoint(w, m, x, n)
			A = A + VectorDistance(B, D)
			B = D
			C = C + 1
		end
	end
	return A
end
function j.prototype.GetExtendedEndPoint(self, m, n, o, E)
	local F = n - m
	local G = 1
	local H = 2 * F:Dot(o)
	local I = F:Dot(F) - E * E
	local J = H * H - 4 * G * I
	if J <= 0 then
		return n
	end
	local K = math.sqrt(J)
	local L = (-H + K) / (2 * G)
	local M = (-H - K) / (2 * G)
	local N = math.max(L, M, 0)
	return n + o * N
end
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
end
function j.prototype.OnAbilityPhaseStart(self)
	local s = self:GetSpecialValueFor("count")
	local E = self:GetCastRange(vec3_zero, nil)
	local O = self:GetSpecialValueFor("radius")
	self:DestroyWarningParticles()
	local l = self:GetCaster()
	local P = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_grimstroke/grimstroke_cast2_ground.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlEnt(P, 0, l, PATTACH_POINT_FOLLOW, "attach_attack2", l:GetAbsOrigin(), true)
	self:AddWarningParticle(P)
	local u = self:GetShotSides(s)
	do
		local C = 0
		while C < #u do
			local Q = self:GetPathPoints(u[C + 1])
			local R = (Q.target - Q.controlPoint):Normalized()
			local S = self:GetExtendedEndPoint(Q.start, Q.target, R, E)
			local T = ParticleManager:CreateParticle(
				"particles/units/boss/boss_grimstroke/boss_grimstroke_curved_preview.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(T, 1, Vector(3, O, 0))
			ParticleManager:SetParticleControl(T, 24, Q.start)
			ParticleManager:SetParticleControl(T, 10, S)
			ParticleManager:SetParticleControl(T, 11, Q.turnPoint)
			self:AddWarningParticle(T)
			C = C + 1
		end
	end
	l:EmitSound("Hero_Grimstroke.DarkArtistry.PreCastPoint")
	l:EmitSound("Grimstroke.Ability6")
	return true
end
function j.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local l = self:GetCaster()
	local U = self:GetSpecialValueFor("speed")
	local s = self:GetSpecialValueFor("count")
	local O = self:GetSpecialValueFor("radius")
	local V = self:GetSpecialValueFor("damage")
	local E = self:GetCastRange(vec3_zero, nil)
	local u = self:GetShotSides(s)
	local W = {}
	do
		local C = 0
		while C < #u do
			local Q = self:GetPathPoints(u[C + 1])
			local m = Q.start
			local n = Q.target
			local r = Q.controlPoint
			local X = self:EstimateQuadraticBezierLength(m, r, n, 16)
			local R = (n - r):Normalized()
			local S = self:GetExtendedEndPoint(m, n, R, E)
			W[#W + 1] = { start = m, target = n, controlPoint = r, pathLength = X, endDirection = R, finalPoint = S }
			C = C + 1
		end
	end
	l:SimulateCast({
		castPoint = 0.2,
		duration = 0.73,
		castAnimation = ACT_SCRIPT_CUSTOM_9,
		OnSpellStart = function()
			l:EmitSound("Hero_Grimstroke.DarkArtistry.Projectile")
			do
				local C = 0
				while C < #W do
					local Y = W[C + 1]
					local m = Y.start
					local n = Y.target
					local r = Y.controlPoint
					local X = Y.pathLength
					local R = Y.endDirection
					local S = Y.finalPoint
					local Z = GameRules:GetGameTime()
					if C == 0 then
						l:EmitSound("Hero_Grimstroke.DarkArtistry.Damage", n)
					end
					Bullet:CreateCustomBullet({
						caster = l,
						ability = self,
						spawnOrigin = m,
						moveSpeed = U,
						hasThinker = true,
						radius = O,
						ParticleCreator = function(_)
							local P = ParticleManager:CreateParticle(
								"particles/units/boss/boss_grimstroke/darkartistry_tracking.vpcf",
								PATTACH_CUSTOMORIGIN,
								nil
							)
							ParticleManager:SetParticleControl(P, 0, _.__thinker:GetAbsOrigin())
							ParticleManager:SetParticleControlEnt(
								P,
								1,
								_.__thinker,
								PATTACH_ABSORIGIN_FOLLOW,
								nil,
								_.__thinker:GetAbsOrigin(),
								true
							)
							ParticleManager:SetParticleControl(P, 5, S)
							return P
						end,
						OnBulletThink = function(a0, _)
							if CalcDistance(a0, m) > E then
								Bullet:DestroyBulletByID(_.__projIndex)
							end
						end,
						FuncUnitFinder = function(a1, a0, O, _)
							return Bullet:FindUnitInLine(
								l:GetTeamNumber(),
								a1,
								a0,
								O,
								O,
								DOTA_UNIT_TARGET_TEAM_ENEMY,
								DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
								DOTA_UNIT_TARGET_FLAG_NONE
							)
						end,
						PathFunction = function(a2, _)
							local a3 = GameRules:GetGameTime() - Z
							local a4 = a3 * U
							if a4 >= X then
								return n + R * (a4 - X)
							end
							local w = a4 / X
							if w < 0 then
								w = 0
							end
							if w > 1 then
								w = 1
							end
							return self:GetQuadraticBezierPoint(w, m, r, n)
						end,
						OnBulletHit = function(n)
							l:DealDamage(n, self, V)
							l:EmitSound("Hero_Grimstroke.DarkArtistry.Damage", n:GetAbsOrigin())
						end,
					})
					C = C + 1
				end
			end
		end,
	})
end
j = e({ i(nil) }, j)
return f