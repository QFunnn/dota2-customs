--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/queenofpain"
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
m.name = "queenofpain_1"
d(m, k)
function m.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	n:AddNewModifier(n, self, "modifier_queenofpain_1", { duration = 1 })
	local o = ParticleManager:CreateParticle(
		"particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_v2_start.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlTransformForward(o, 0, n:GetAbsOrigin(), n:GetForwardVector())
	n:EmitSound("Hero_QueenOfPain.Blink_out.Arcana")
	n:SimulateCast({ duration = 2.5 })
end
m = e({ l(nil, {}) }, m)
local p = c()
p.name = "modifier_queenofpain_1"
d(p, h)
function p.prototype.GetAbilitySpecialValue(self)
	self.delay = self:GetAbilitySpecialValueFor("delay")
	self.radius = self:GetAbilitySpecialValueFor("radius")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self:GetParent():AddNoDraw()
		self:StartIntervalThink(self:GetDuration() - 0.1)
	end
end
function p.prototype.OnIntervalThink(self)
	local r = self:GetParent()
	if not IsValid(r) then
		return
	end
	local s = FindEnemiesInRadius(r, r:GetAbsOrigin(), 2000)
	self.enemyPosition = s[1] ~= nil and s[1]:GetAbsOrigin() or r:GetAbsOrigin()
	local t = self.enemyPosition + RandomVector(300)
	local u = CalcDirection2D(self.enemyPosition, t)
	local v = VectorAngles(u)
	FindClearSpaceForUnit(r, t, true)
	r:SetLocalAngles(v.x, v.y, v.z)
	r:RemoveNoDraw()
	r:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
	ParticleManager:CreateParticle(
		"particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_v2_end.vpcf",
		PATTACH_ABSORIGIN,
		r
	)
	local o = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(o, 0, self.enemyPosition)
	ParticleManager:SetParticleControl(o, 1, self.enemyPosition)
	ParticleManager:SetParticleControl(o, 2, Vector(self.radius, self.delay, 0))
	self.parent:GameTimer(self.delay, function()
		ParticleManager:DestroyParticle(o, true)
	end)
end
function p.prototype.OnDestroy(self)
	if IsServer() then
		local r = self:GetParent()
		if not IsValid(r) then
			return
		end
		r:StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
		if self.enemyPosition ~= nil then
			r:AddNewModifier(
				r,
				self:GetAbility(),
				"modifier_queenofpain_1_damage",
				{ duration = self.delay, position = VectorToString(self.enemyPosition) }
			)
		end
	end
end
function p.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function p.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end
p = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	p
)
local w = c()
w.name = "modifier_queenofpain_1_damage"
d(w, h)
function w.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function w.prototype.OnCreated(self, q)
	if IsServer() then
		self.position = StringToVector(q.position)
		self:GetParent():FaceTowards(self.position)
	end
end
function w.prototype.OnDestroy(self)
	if IsServer() then
		local r = self:GetParent()
		local x = self:GetAbility()
		local o = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_queenofpain/queen_blink_shard_end.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(o, 0, self.position)
		ParticleManager:SetParticleControl(o, 1, Vector(self.radius, self.radius, self.radius))
		ParticleManager:SetParticleControl(o, 2, Vector(self.radius, self.radius, self.radius))
		r:EmitSound("Hero_QueenOfPain.Blink_in.Shard")
		r:EmitSound("QueenOfPain.Ability1")
		if IsValid(x) then
			local s = FindEnemiesInRadius(r, self.position, self.radius)
			r:DealDamage(s, x, self.damage)
			Event:Fire("ability_end", { caster = r, ability = x })
		end
	end
end
function w.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function w.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end
w = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	w
)
local y = c()
y.name = "queenofpain_2"
d(y, k)
function y.prototype.OnChannelFinish(self, z)
	local n = self:GetCaster()
	n:RemoveModifierByName("modifier_queenofpain_2")
end
function y.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("width")
end
function y.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	local A = self:GetSpecialValueFor("count")
	local B = self:GetSpecialValueFor("width")
	local C = self:GetCastRange(vec3_zero, nil)
	local u = CalcDirection2D(self:GetCursorPosition(), n)
	Bullet:SplitAction(u, A, 360 / A, function(D, u)
		local E = n:GetAbsOrigin()
		local F = E + u * C
		self:LineWarning(E, F, B, self:GetCastPoint())
	end)
	return true
end
function y.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles(true)
end
function y.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local n = self:GetCaster()
	n:SimulateCast({ duration = 1.04 })
	local A = self:GetSpecialValueFor("count")
	local B = self:GetSpecialValueFor("width")
	local G = self:GetSpecialValueFor("speed")
	local H = self:GetSpecialValueFor("damage")
	local C = self:GetCastRange(vec3_zero, nil)
	local I = self:GetLevel() > 1
	local J = 2
	local u = CalcDirection2D(self:GetCursorPosition(), n)
	Bullet:SplitAction(u, A, 360 / A, function(D, u)
		local E = n:GetAbsOrigin()
		local F = E + u * C
		Bullet:CreateLinearBullet({
			caster = n,
			direction = u,
			distance = C,
			moveSpeed = G,
			radius = B,
			ability = self,
			reflectable = true,
			spawnOrigin = n:GetAbsOrigin(),
			ParticleCreator = function(K)
				local F = K.spawnOrigin + K.direction * K.distance
				local o = ParticleManager:CreateParticle(
					"particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(o, 0, K.spawnOrigin + Vector(0, 0, 75))
				ParticleManager:SetParticleControl(o, 1, F + Vector(0, 0, 75))
				ParticleManager:SetParticleControl(o, 2, Vector(G, 0, 0))
				return o
			end,
			OnBulletHit = function(L, M, K)
				n:DealDamage(L, self, H)
			end,
			OnBulletDestroy = function(K)
				if I then
					local o = ParticleManager:CreateParticle(
						"particles/units/boss/boss_queen_of_pain/shadow_strike_static.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(o, 0, GetGroundPosition(K.__position, n) + Vector(0, 0, 75))
					ParticleManager:ReleaseParticleIndex(o)
					local s = FindEnemiesInRadius(n, n:GetAbsOrigin(), 2000)
					local N = IsValid(s[1]) and CalcDirection2D(s[1], K.__position) or -u
					self:LineWarning(K.__position, K.__position + N * C, B, J)
					self:StartThink(J, DoUniqueString("return"), function()
						Bullet:CreateLinearBullet({
							caster = n,
							direction = N,
							distance = C,
							moveSpeed = G,
							radius = B,
							ability = self,
							ignoreBlock = true,
							reflectable = true,
							spawnOrigin = K.__position,
							ParticleCreator = function(K)
								local F = K.spawnOrigin + K.direction * K.distance
								local o = ParticleManager:CreateParticle(
									"particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike.vpcf",
									PATTACH_CUSTOMORIGIN,
									nil
								)
								ParticleManager:SetParticleControl(o, 0, K.spawnOrigin + Vector(0, 0, 75))
								ParticleManager:SetParticleControl(o, 1, F + Vector(0, 0, 75))
								ParticleManager:SetParticleControl(o, 2, Vector(G, 0, 0))
								return o
							end,
							OnBulletHit = function(L, M, K)
								n:DealDamage(L, self, H)
							end,
						})
						return -1
					end)
				end
			end,
		})
	end)
	n:EmitSound("Greevil.ShadowStrike")
end
y = e({ l(nil) }, y)
local O = c()
O.name = "queenofpain_3"
d(O, k)
function O.prototype.OnChannelFinish(self, z)
	local n = self:GetCaster()
	n:RemoveModifierByName("modifier_queenofpain_3")
end
function O.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("width")
end
function O.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	local M = self:GetCursorPosition()
	local u = CalcDirection2D(M, n:GetAbsOrigin())
	local A = self:GetSpecialValueFor("count")
	local G = self:GetSpecialValueFor("speed")
	local B = self:GetSpecialValueFor("width")
	local C = self:GetCastRange(vec3_zero, nil)
	Bullet:SplitAction(u, A, 60 / A, function(D, u)
		local E = n:GetAbsOrigin()
		local F = E + u * C
		self:LineWarning(E, F, B, C / G)
	end)
	return true
end
function O.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles(true)
end
function O.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local n = self:GetCaster()
	local M = self:GetCursorPosition()
	local u = CalcDirection2D(M, n:GetAbsOrigin())
	local C = self:GetCastRange(vec3_zero, nil)
	local A = self:GetSpecialValueFor("count")
	local B = self:GetSpecialValueFor("width")
	local G = self:GetSpecialValueFor("speed")
	local H = self:GetSpecialValueFor("damage")
	local P = self:GetSpecialValueFor("wave")
	self:StartThink(0.2, function()
		Bullet:SplitAction(u, A, 60 / A, function(D, Q)
			Bullet:CreateLinearBullet({
				caster = n,
				direction = Q,
				distance = C,
				moveSpeed = G,
				radius = B,
				reflectable = true,
				ability = self,
				spawnOrigin = n:GetAbsOrigin(),
				ParticleCreator = function(K)
					local F = K.spawnOrigin + K.direction * K.distance
					local o = ParticleManager:CreateParticle(
						"particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_projectile.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(o, 0, K.spawnOrigin + Vector(0, 0, 75))
					ParticleManager:SetParticleControl(o, 1, F + Vector(0, 0, 75))
					ParticleManager:SetParticleControl(o, 2, Vector(G, 0, 0))
					return o
				end,
				OnBulletHit = function(L, M, K)
					n:DealDamage(L, self, H)
				end,
			})
		end)
		n:EmitSound("Hero_QueenOfPain.ScreamOfPain")
		P = P - 1
		if P <= 0 then
			return -1
		end
	end)
	n:SimulateCast({ castAnimation = ACT_DOTA_CAST_ABILITY_3_END, duration = 0.2 * P + 0.5 })
end
O = e({ l(nil) }, O)
local R = c()
R.name = "modifier_queenofpain_3"
d(R, h)
function R.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.width = self:GetAbilitySpecialValueFor("width")
	self.speed = self:GetAbilitySpecialValueFor("speed")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.wave = self:GetAbilitySpecialValueFor("wave")
end
function R.prototype.OnCreated(self, q)
	if IsServer() then
		self.direction = StringToVector(q.direction)
		self.distance = q.distance
		self:StartIntervalThink(0.2)
		self:OnIntervalThink()
	else
		ParticleManager:CreateParticle(
			"particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_owner_blue.vpcf",
			PATTACH_ABSORIGIN,
			self:GetParent()
		)
	end
end
function R.prototype.OnIntervalThink(self)
	local r = self:GetParent()
	local x = self:GetAbility()
	if not IsValid(r) or not IsValid(x) then
		self:Destroy()
		return
	end
	Bullet:SplitAction(self.direction, self.count, 60 / self.count, function(D, u)
		Bullet:CreateLinearBullet({
			caster = r,
			direction = u,
			distance = self.distance,
			moveSpeed = self.speed,
			radius = self.width,
			reflectable = true,
			ability = x,
			spawnOrigin = r:GetAbsOrigin(),
			ParticleCreator = function(K)
				local F = K.spawnOrigin + K.direction * K.distance
				local o = ParticleManager:CreateParticle(
					"particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_projectile_blue.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(o, 0, K.spawnOrigin + Vector(0, 0, 75))
				ParticleManager:SetParticleControl(o, 1, F + Vector(0, 0, 75))
				ParticleManager:SetParticleControl(o, 2, Vector(self.speed, 0, 0))
				return o
			end,
			OnBulletHit = function(L, M, K)
				r:DealDamage(L, x, self.damage)
			end,
		})
	end)
	r:EmitSound("Hero_QueenOfPain.ScreamOfPain")
	self.wave = self.wave - 1
	if self.wave <= 0 then
		self:Destroy()
	end
end
function R.prototype.OnDestroy(self)
	if IsServer() then
		Event:Fire("ability_end", { caster = self:GetParent(), ability = self:GetAbility() })
	end
end
R = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	R
)
local S = c()
S.name = "queenofpain_4"
d(S, k)
function S.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
end
function S.prototype.OnAbilityPhaseStart(self)
	if IsServer() then
		local n = self:GetCaster()
		local M = self:GetCursorPosition()
		n:SetForwardVector(CalcDirection2D(M, n))
		n:FaceTowards(M)
		local C = self:GetCastRange(vec3_zero, nil)
		local s = FindEnemiesInRadius(n, M, C, FIND_CLOSEST)
		local L = s[1]
		local B = self:GetSpecialValueFor("width")
		if not IsValid(L) then
			return false
		end
		local T = 20
		local U = CalcDirection2D(M, n)
		if (M - n:GetAbsOrigin()):Length2D() <= 0 then
			U = CalcDirection2D(L:GetAbsOrigin(), n)
		end
		local E = n:GetAbsOrigin() + U * C
		local V = self:FacingSupport(E, L, T, C)
		self:LineWarning(n, V, B, self:GetCastPoint())
		self:LockFacingTarget(L, T)
	end
	return true
end
function S.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local u = AnglesToVector(n:GetLocalAngles())
	local B = self:GetSpecialValueFor("width")
	local H = self:GetSpecialValueFor("damage")
	local C = self:GetCastRange(vec3_zero, nil)
	local W = self:GetLevel() >= 2
	n:SimulateCast({
		castPoint = 0.1,
		castAnimation = ACT_DOTA_CAST_ABILITY_4_END,
		duration = 1.1,
		OnSpellStart = function()
			n:Dash(u, C, 0, 0.3)
			n:EmitSound("Hero_QueenOfPain.Blink_in.Shard")
			Bullet:CreateCustomBullet({
				spawnOrigin = n:GetAbsOrigin(),
				lifeTime = 0.3,
				radius = B,
				PathFunction = function()
					return n:GetAbsOrigin()
				end,
				FuncUnitFinder = function(X, M, Y, K)
					return Bullet:FindUnitInLine(
						n:GetTeamNumber(),
						X,
						M,
						Y,
						Y,
						DOTA_UNIT_TARGET_TEAM_ENEMY,
						DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
						DOTA_UNIT_TARGET_FLAG_NONE
					)
				end,
				OnBulletThink = function(K)
					if W then
						self:CreateHellfireBlast(Rotation2D(u, 90, true), 0.5)
						self:CreateHellfireBlast(Rotation2D(u, -90, true), 0.5)
					end
				end,
				OnBulletHit = function(Z, M, K)
					Z:KnockBack(u, 150, 0, 0.06)
					n:DealDamage(Z, nil, H)
				end,
			})
		end,
	})
end
function S.prototype.CreateHellfireBlast(self, u, _)
	if _ == nil then
		_ = 1
	end
	local n = self:GetCaster()
	local C = 1200
	local G = 1200 * _
	local a0 = {
		caster = n,
		direction = u,
		ability = self,
		effectName = "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_projectile.vpcf",
		spawnOrigin = n:GetAttachmentPosition("attach_hitloc"),
		moveSpeed = G,
		radius = 100,
		reflectable = true,
		lifeTime = C / G,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		OnBulletHit = function(L, M, K)
			n:DealDamage(L, self, self:GetSpecialValueFor("damage"))
		end,
	}
	Bullet:CreateGuidedBullet(a0)
end
S = e({ l(nil) }, S)
local a1 = c()
a1.name = "queenofpain_5"
d(a1, k)
function a1.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	local M = self:GetCursorPosition()
	n:SetForwardVector(CalcDirection2D(M, n))
	n:FaceTowards(M)
	local C = self:GetCastRange(vec3_zero, nil)
	local a2 = self:GetCastPoint()
	local a3 = self:GetSpecialValueFor("turn_rate")
	local s = FindEnemiesInRadius(n, M, 600, FIND_CLOSEST)
	local L = s[1]
	if not IsValid(L) then
		return false
	end
	local A = self:GetSpecialValueFor("count")
	local a4 = 20
	local U = CalcDirection2D(M, n)
	if (M - n:GetAbsOrigin()):Length2D() <= 0 then
		U = CalcDirection2D(L:GetAbsOrigin(), n)
	end
	if A > 1 then
		local A = self:GetSpecialValueFor("count")
		local a5 = (A - 1) * a4
		do
			local a6 = 1
			while a6 <= A do
				local a7 = -a5 * 0.5 + (a6 - 1) * a4
				local a8 = RotatePosition(Vector(0, 0, 0), QAngle(0, a7, 0), U)
				local E = n:GetAbsOrigin() + a8 * C
				local V = self:FacingSupport(E, L, a3, C, a2, a7)
				self:LineWarning(n, V, 100, a2)
				a6 = a6 + 1
			end
		end
	else
		local E = n:GetAbsOrigin() + U * C
		local V = self:FacingSupport(E, L, a3, C, a2)
		self:LineWarning(n, V, 100, a2)
	end
	self:LockFacingTarget(L, a3, a2)
	return true
end
function a1.prototype.OnAbilityPhaseInterrupted(self)
	if IsServer() then
		self:DestroyWarningParticles(true)
	end
end
function a1.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local n = self:GetCaster()
	local u = AnglesToVector(n:GetLocalAngles())
	local M = n:GetAbsOrigin() + u * self:GetCastRange(vec3_zero, nil)
	n:SetForwardVector(u)
	n:FaceTowards(M)
	n:SimulateCast({ castAnimation = ACT_DOTA_ATTACK2, duration = 0.8 })
	local A = self:GetSpecialValueFor("count")
	local a4 = 30
	Bullet:SplitAction(u, A, a4, function(D, a9)
		self:CreateHellfireBlast(a9)
	end)
	n:EmitSound("Greevil.ShadowStrike")
end
function a1.prototype.CreateHellfireBlast(self, u, _)
	if _ == nil then
		_ = 1
	end
	local n = self:GetCaster()
	local C = self:GetCastRange(vec3_zero, nil)
	local G = self:GetSpecialValueFor("speed") * _
	local a0 = {
		caster = n,
		direction = u,
		ability = self,
		effectName = "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike.vpcf",
		spawnOrigin = n:GetAttachmentPosition("attach_attack2"),
		moveSpeed = G,
		radius = 100,
		reflectable = true,
		lifeTime = C / G,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		OnBulletHit = function(L, M, K)
			n:DealDamage(L, self, self:GetSpecialValueFor("damage"))
		end,
	}
	Bullet:CreateGuidedBullet(a0)
end
a1 = e({ l(nil) }, a1)
local aa = c()
aa.name = "queenofpain_6"
d(aa, k)
function aa.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	self.initDirection = n:GetForwardVector()
	Bullet:SplitAction(self.initDirection, 4, 90, function(D, u)
		self:LineWarning(
			n:GetAbsOrigin(),
			n:GetAbsOrigin() + u * self:GetCastRange(vec3_zero, nil),
			100,
			self:GetCastPoint()
		)
	end)
	return true
end
function aa.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local A = 0
	n:SimulateCast({ castAnimation = ACT_SCRIPT_CUSTOM_3, duration = 3.13 })
	self:StartThink(0.2, function()
		Bullet:SplitAction(Rotation2D(self.initDirection, 10 * A, true), 4, 90, function(D, u)
			self:CreateHellfireBlast(u)
		end)
		A = A + 1
		if A >= 10 then
			return -1
		end
		n:EmitSound("Hero_QueenOfPain.ScreamOfPain")
	end)
end
function aa.prototype.CreateHellfireBlast(self, u, _)
	if _ == nil then
		_ = 1
	end
	local n = self:GetCaster()
	local C = self:GetCastRange(vec3_zero, nil)
	local G = self:GetSpecialValueFor("speed") * _
	local a0 = {
		caster = n,
		direction = u,
		ability = self,
		effectName = "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_projectile.vpcf",
		spawnOrigin = n:GetAttachmentPosition("attach_attack2"),
		moveSpeed = G,
		radius = 100,
		reflectable = true,
		lifeTime = C / G,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		OnBulletHit = function(L, M, K)
			n:DealDamage(L, self, self:GetSpecialValueFor("damage"))
		end,
	}
	Bullet:CreateGuidedBullet(a0)
end
aa = e({ l(nil) }, aa)
local ab = c()
ab.name = "queenofpain_7"
d(ab, k)
function ab.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	n:EmitSound("QueenOfPain.Ability7.Voice")
	n:EmitSound("Hero_QueenOfPain.Blink_out.Arcana")
	self:StartThink(0.3, "channel", function()
		self:Callback()
	end)
	return true
end
function ab.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	n:SimulateCast({ castAnimation = ACT_SCRIPT_CUSTOM_5, duration = 4.4 })
end
function ab.prototype.Callback(self)
	local n = self:GetCaster()
	local ac = n:GetAbsOrigin()
	local Y = self:GetSpecialValueFor("radius")
	local H = self:GetSpecialValueFor("damage")
	local A = self:GetSpecialValueFor("count")
	local ad = {}
	Bullet:SplitAction(RandomVector(1), A, 360 / A, function(D, u, ae)
		local M = ac + u * RandomInt(200, 1200)
		ad[#ad + 1] = M
		self:CircleWarning(M, Y, 1)
	end)
	self:StartThink(1, DoUniqueString("1"), function()
		for D, M in ipairs(ad) do
			local o = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_queenofpain/queen_blink_shard_end.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(o, 0, M)
			ParticleManager:SetParticleControl(o, 1, Vector(Y, Y, Y))
			ParticleManager:SetParticleControl(o, 2, Vector(Y, Y, Y))
			local s = FindEnemiesInRadius(n, M, Y)
			n:DealDamage(s, nil, H)
		end
		n:EmitSound("QueenOfPain.Ability7")
		return -1
	end)
end
function ab.prototype.OnChannelFinish(self, z)
	self:StartThink(-1, "channel")
end
ab = e({ l(nil) }, ab)
local af = c()
af.name = "queenofpain_8"
d(af, k)
function af.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local J = 0.5
	local B = 100
	local C = 600
	local H = self:GetSpecialValueFor("damage")
	n:EmitSound("Hero_QueenOfPain.Blink_out.Arcana")
	local o = ParticleManager:CreateParticle(
		"particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_v2_start.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlTransformForward(o, 0, n:GetAbsOrigin(), n:GetForwardVector())
	n:AddNewModifier(n, self, "modifier_queenofpain_8_hide", { duration = J })
	local s = FindEnemiesInRadius(n, n:GetAbsOrigin(), 2000)
	local M = IsValid(s[1]) and s[1]:GetAbsOrigin() + RandomVector(300) or n:GetAbsOrigin() + RandomVector(300)
	local u = RandomVector(1)
	if IsValid(s[1]) then
		u = CalcDirection2D(s[1]:GetAbsOrigin(), M)
		local v = VectorAngles(u)
		n:SetLocalAngles(v.x, v.y, v.z)
	end
	local E = M + u * B
	local F = E + u * C
	self:LineWarning(E, F, B, 0.43 + J)
	n:SimulateCast({
		castPoint = J,
		OnSpellStart = function()
			ParticleManager:CreateParticle(
				"particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_v2_end.vpcf",
				PATTACH_ABSORIGIN,
				n
			)
			FindClearSpaceForUnit(n, M, true)
			n:SimulateCast({
				castAnimation = ACT_SCRIPT_CUSTOM_7,
				castPoint = 0.43,
				duration = 0.86,
				OnSpellStart = function()
					self:Spike(E, u)
					n:EmitSound("QueenOfPain.Ability1")
					n:EmitSound("Hero_Lion.Impale")
				end,
			})
		end,
	})
end
function af.prototype.Spike(self, E, u)
	local n = self:GetCaster()
	local H = self:GetSpecialValueFor("damage")
	Bullet:CreateLinearBullet({
		spawnOrigin = E,
		caster = n,
		ability = self,
		moveSpeed = 1800,
		direction = u,
		distance = 600,
		radius = 100,
		effectName = "particles/econ/items/lion/lion_ti9/lion_spell_impale_ti9.vpcf",
		OnBulletHit = function(L)
			n:DealDamage(L, self, H)
		end,
	})
end
af = e({ l(nil) }, af)
local ag = c()
ag.name = "modifier_queenofpain_8_hide"
d(ag, h)
function ag.prototype.OnCreated(self, q)
	if IsServer() then
		self:GetParent():AddNoDraw()
	end
end
function ag.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveNoDraw()
	end
end
function ag.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function ag.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end
ag = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	ag
)
local ah = c()
ah.name = "queenofpain_9"
d(ah, k)
function ah.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	self.direction = n:GetForwardVector()
	Bullet:SplitAction(self.direction, 7, 45, function(D, a9)
		local E = n:GetAbsOrigin() + a9 * 100
		local F = E + a9 * 1600
		self:LineWarning(E, F, 100, 300, self:GetCastPoint())
	end)
	return true
end
function ah.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local H = self:GetSpecialValueFor("damage")
	Bullet:SplitAction(self.direction, 7, 45, function(D, a9)
		local E = n:GetAbsOrigin() + a9 * 100
		Bullet:CreateLinearBullet({
			caster = n,
			ability = self,
			spawnOrigin = E,
			moveSpeed = 1200,
			direction = a9,
			debug = true,
			ignoreBlock = true,
			startRadius = 100,
			endRadius = 300,
			distance = 1600,
			effectName = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_sonic_wave.vpcf",
			OnBulletHit = function(L)
				n:DealDamage(L, self, H)
			end,
		})
	end)
	n:EmitSound("Hero_QueenOfPain.SonicWave.Arcana.Target")
	n:EmitSound("Hero_QueenOfPain.SonicWave.ArcanaLayer")
end
ah = e({ l(nil) }, ah)
local ai = c()
ai.name = "queenofpain_10"
d(ai, k)
function ai.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	local M = self:GetCursorPosition()
	local u = CalcDirection2D(M, n)
	local E = n:GetAbsOrigin() + u * 100
	local F = E + u * 1200
	self:LineWarning(E, F, 100, self:GetCastPoint())
	return true
end
function ai.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local M = self:GetCursorPosition()
	local u = CalcDirection2D(M, n)
	local E = n:GetAbsOrigin() + u * 100
	self:Spike(E, u)
	n:SimulateCast({ castAnimation = ACT_SCRIPT_CUSTOM_12, duration = 0.43 })
	n:EmitSound("QueenOfPain.Ability1")
	n:EmitSound("Hero_Lion.Impale")
end
function ai.prototype.Spike(self, E, u)
	local n = self:GetCaster()
	local H = self:GetSpecialValueFor("damage")
	Bullet:CreateLinearBullet({
		spawnOrigin = E,
		caster = n,
		ability = self,
		moveSpeed = 2200,
		direction = u,
		distance = 1200,
		radius = 100,
		effectName = "particles/econ/items/lion/lion_ti9/lion_spell_impale_ti9.vpcf",
		OnBulletHit = function(L)
			n:DealDamage(L, self, H)
		end,
	})
end
ai = e({ l(nil) }, ai)
return f