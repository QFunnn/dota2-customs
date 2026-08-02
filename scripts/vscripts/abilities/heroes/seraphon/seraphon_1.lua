--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/seraphon/seraphon_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__ArrayConcat
local g = b.__TS__DecorateLegacy
local h = {}
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.ability_ai")
local m = l.EOMAbilityAI
local n = require("abilities.eom_ability")
local o = n.AbilityValue
local p = n.registerEOMAbility
local q = 40
local r = c()
r.name = "seraphon_1"
d(r, m)
function r.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.bulletList = {}
end
function r.prototype.GetCooldown(self, s)
	return math.max(m.prototype.GetCooldown(self, s) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function r.prototype.IsValidDropLandingPosition(self, t)
	return GridNav:IsValidPosition(t) and not GridNav:IsHole(t)
end
function r.prototype.OnDestroy(self)
	e(self.bulletList, function(u, v)
		Bullet:DestroyBulletByID(v)
	end)
end
function r.prototype.ResolveDropEndPosition(self, w, x)
	local y = Vector(x.x, x.y, w.z)
	if not GridNav:IsHole(y) then
		return y
	end
	local z = math.max((y - w):Length2D(), 300)
	do
		local A = 0
		while A < 16 do
			local B = y + RandomVector(RandomFloat(120, z))
			B.z = w.z
			if self:IsValidDropLandingPosition(B) then
				return B
			end
			A = A + 1
		end
	end
	if self:IsValidDropLandingPosition(w) then
		return Vector(w.x, w.y, w.z)
	end
	return y
end
function r.prototype.GetDropThinkerDirection(self, C, D)
	local E = D
	if E.__dropCurrentDirection ~= nil and not VectorIsZero(E.__dropCurrentDirection) then
		return E.__dropCurrentDirection
	end
	return C
end
function r.prototype.CastFilterResultLocation(self, F)
	local G = self:GetCaster()
	local H = FindEnemiesInRadius(G, F, 400, FIND_CLOSEST)
	if #H > 0 then
		self.target = H[1]
		return UF_SUCCESS
	end
	return UF_FAIL_ENEMY
end
function r.prototype.OnSpellStart(self)
	if not IsValid(self.target) then
		return
	end
	local G = self:GetCaster()
	local t = self:GetCursorPosition()
	local I = CalcDirection2D(t, G:GetAbsOrigin())
	local J = self:GetSpecialValueFor("speed")
	local K = self:GetSpecialValueFor("damage")
	local L = self:GetSpecialValueFor("count")
	local M = L
	local N = self:GetSpecialValueFor("drop_time")
	local O = self:GetSpecialValueFor("bounce_radius_inc")
	local P = 0
	Bullet:CreateTrackingBullet({
		caster = G,
		ability = self,
		effectName = "particles/mushi_fx/mushi_fx_chuizi_qu_02.vpcf",
		spawnOrigin = G:GetAbsOrigin() + Vector(0, 0, 75) + I * 50,
		target = self.target,
		moveSpeed = J,
		OnBulletCreated = function(Q)
			if Q.__particleID ~= nil then
				ParticleManager:SetParticleControlEnt(
					Q.__particleID,
					7,
					G.__weapon,
					PATTACH_ABSORIGIN,
					nil,
					vec3_zero,
					true
				)
			end
		end,
		OnBulletHit = function(R, t, Q)
			if R ~= G then
				if G:HasAbilityUpgrade("seraphon_upgrade_8") then
					local S = G:GetAbilityByTag(AbilityTag.Ultimate)
					if IsValid(S) then
						S:Punishment(R)
					end
				end
				G:DealDamage(R, self, K, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE)
				G:EmitSound("Hero_Omniknight.HammerOfPurity.Target", t)
				if self.heal > 0 then
					G:Heal(self.heal, self)
				end
			else
				M = M + 1
			end
			if M > 0 then
				P = P + (O + 100) * 0.01
				local H = FindEnemiesInRadius(G, t, self.radius + P, FIND_CLOSEST)
				ArrayRemove(H, R)
				if G:HasAbilityUpgrade("seraphon_upgrade_7") then
					H[#H + 1] = G
				end
				if #H > 0 then
					Q.target = H[1]
					if Q.__particleID ~= nil then
						ParticleManager:SetParticleControlTransformForward(
							Q.__particleID,
							0,
							t,
							Q.__velocity:Normalized()
						)
						ParticleManager:SetParticleControlEnt(
							Q.__particleID,
							1,
							Q.target,
							PATTACH_POINT_FOLLOW,
							"attach_hitloc",
							Q.target:GetAbsOrigin(),
							false
						)
					end
					if R:IsLowHealth() and G:HasAbilityUpgrade("seraphon_upgrade_30") then
						M = M + 1
					end
					M = M - 1
					return false
				end
			end
		end,
		OnBulletDestroy = function(Q)
			local w = Q.__position
			local T
			local I
			local U = G:HasAbilityUpgrade("seraphon_upgrade_9")
			if U then
				T = G:GetAbsOrigin()
				I = CalcDirection2D(T, w)
			else
				I = Q.__velocity:Normalized()
				T = I * 300 + w
			end
			if not U then
				T = self:ResolveDropEndPosition(w, T)
			end
			I = CalcDirection2D(T, w)
			Bullet:CreateCustomBullet({
				caster = G,
				spawnOrigin = w,
				lifeTime = N,
				hasThinker = true,
				ParticleCreator = function(D)
					local V = ParticleManager:CreateParticle(
						"particles/mushi_fx/mushi_fx_chuizi_bao_01.vpcf",
						PATTACH_CUSTOMORIGIN,
						G
					)
					ParticleManager:SetParticleControl(V, 0, w)
					ParticleManager:SetParticleControlEnt(
						V,
						1,
						D.__thinker,
						PATTACH_ABSORIGIN_FOLLOW,
						nil,
						D.__thinker:GetAbsOrigin(),
						true
					)
					ParticleManager:SetParticleControlEnt(
						V,
						3,
						D.__thinker,
						PATTACH_ABSORIGIN_FOLLOW,
						nil,
						D.__thinker:GetAbsOrigin(),
						true
					)
					ParticleManager:SetParticleControlEnt(V, 7, G.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
					return V
				end,
				PathFunction = function(W, D)
					local E = D
					if D.__lifeTime == nil or D.__lifeTimeRemaining == nil then
						return T
					end
					local X = D.__lifeTime
					if X <= 0 then
						return T
					end
					if E.__dropCurrentDirection == nil then
						E.__dropCurrentDirection = I
						E.__dropHorizontalDistance = (T - w):Length2D()
						E.__dropLastElapsed = 0
					end
					local Y = math.min(math.max(X - D.__lifeTimeRemaining, 0), X)
					local Z = E.__dropLastElapsed or 0
					local _ = math.max(Y - Z, 0)
					E.__dropLastElapsed = Y
					local a0 = Vector(D.__position.x, D.__position.y, w.z)
					if U then
						local a1 = G:GetAbsOrigin()
						local a2 = Vector(a1.x, a1.y, w.z)
						local a3 = a2 - a0
						local a4 = math.max(X - Z, _)
						local a5 = a4 > 0 and math.min(_ / a4, 1) or 1
						E.__dropCurrentDirection = CalcDirection2D(a2, a0)
						a0 = a0 + a3 * a5
					else
						local a6 = E.__dropCurrentDirection or vec3_zero
						local a7 = E.__dropHorizontalDistance or 0
						local a8 = X > 0 and a7 * _ / X or 0
						if a8 > 0 and not VectorIsZero(a6) then
							a0 = a0 + a6 * a8
							a0.z = w.z
							if not GridNav:IsValidPosition(a0) then
								local a9 = a6 * -1
								E.__dropCurrentDirection = a9
								a0 = D.__position + a9 * a8
								a0.z = w.z
								if not GridNav:IsValidPosition(a0) then
									a0 = Vector(D.__position.x, D.__position.y, w.z)
								end
							end
						end
					end
					local aa = math.min(math.max(Y / X, 0), 1)
					local ab = 200 * 4 * aa * (1 - aa)
					return Vector(a0.x, a0.y, w.z + ab)
				end,
				OnBulletDestroy = function(D)
					local ac = GetGroundPosition(U and G:GetAbsOrigin() or T, G) + Vector(0, 0, 10)
					local ad = U and CalcDirection2D(ac, D.__position) or self:GetDropThinkerDirection(I, D)
					if G:HasAbilityUpgrade("seraphon_upgrade_19") then
						local ae = G:GetAbilityByTag(AbilityTag.Ultimate)
						if ae ~= nil then
							ae:CreateAura(
								ac,
								self:GetSpecialValueFor("radius_pct"),
								self:GetSpecialValueFor("duration_pct")
							)
						end
					end
					CreateModifierThinker(
						G,
						self,
						"modifier_seraphon_1",
						{ duration = 4, direction = VectorToString(ad), bounce_count = L - M },
						ac,
						G:GetTeamNumber(),
						false
					)
					local af = self:GetSpecialValueFor("pull_radius")
					if af > 0 then
						local H = FindEnemiesInRadius(G, ac, af)
						e(H, function(u, ag)
							ag:KnockBack(
								CalcDirection2D(ac, ag:GetAbsOrigin()),
								CalcDistance(ac, ag:GetAbsOrigin()) * 0.8,
								100,
								0.4
							)
						end)
					end
				end,
			})
		end,
	})
	if G:HasAbilityUpgrade("seraphon_upgrade_20") then
		local ah = self:GetSpecialValueFor("ring_count")
		local ai = self:GetSpecialValueFor("ring_duration")
		self:RingHammer(ah, ai)
	end
	G:EmitSound("Hero_Omniknight.HammerOfPurity.Heal")
end
function r.prototype.RingHammer(self, ah, ai)
	local G = self:GetCaster()
	local aj = G:Script_GetAttackRange() * 0.8
	do
		local A = #self.bulletList - 1
		while A >= 0 do
			local ak = self.bulletList[A + 1]
			if Bullet:GetBulletData(ak) == nil then
				table.remove(self.bulletList, A)
			end
			A = A - 1
		end
	end
	ah = math.min(ah, q - #self.bulletList)
	if ah <= 0 then
		return
	end
	local al = Bullet:CreateGroupSurroundBullet(ah, {
		caster = G,
		ability = self,
		group = "seraphon_ring" .. tostring(G:entindex()),
		circleRadius = aj,
		angularVelocity = self:GetSpecialValueFor("ring_speed"),
		offset = 128,
		lifeTime = ai,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		radius = 100,
		ParticleCreator = function(Q)
			local V =
				ParticleManager:CreateParticle("particles/mushi_fx/mushi_fx_chuizi_qu_03.vpcf", PATTACH_CUSTOMORIGIN, G)
			ParticleManager:SetParticleControlEnt(
				V,
				0,
				Q.__thinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				Q.__thinker:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				V,
				1,
				Q.__thinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				Q.__thinker:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				V,
				3,
				Q.__thinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				Q.__thinker:GetAbsOrigin(),
				true
			)
			return V
		end,
		OnBulletHit = function(R, F, am)
			G:DealDamage(
				R,
				self,
				self:GetSpecialValueFor("damage"),
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				EOM_DAMAGE_FLAGS.RING_DAMAGE
			)
		end,
	})
	self.bulletList = f(self.bulletList, al)
end
function r.prototype.EventListener(self)
	return {
		property_changed = function(u, an)
			if not IsValid(self) or not IsValid(self:GetCaster()) then
				return
			end
			if an.key ~= self:GetCaster():entindex() then
				return
			end
			if an.propertyId == "ring_speed_amplify" then
				local ao = Bullet.surroundGroup["seraphon_ring" .. tostring(self:GetCaster():entindex())]
				if ao ~= nil then
					ao.angularVelocity = self:GetSpecialValueFor("ring_speed")
				end
			end
		end,
	}
end
g({ o(nil) }, r.prototype, "radius", nil)
g({ o(nil) }, r.prototype, "heal", nil)
r = g({ p(nil, {
	funcCondition = function(u, ae)
		return ae:GetAutoCastState()
	end,
}) }, r)
local ap = c()
ap.name = "modifier_seraphon_1"
d(ap, j)
function ap.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.pickup_radius = 240
	self.bounce_count = 0
	self.bonus_attack_duration = 0
end
function ap.prototype.GetAbilitySpecialValue(self)
	self.pickup_radius_pct = self:GetAbilitySpecialValueFor("pickup_radius_pct") * self.bounce_count
	self.pick_damage_radius_pct = self:GetAbilitySpecialValueFor("pick_damage_radius_pct") * self.bounce_count
	self.pick_damage_pct = self:GetAbilitySpecialValueFor("pick_damage_pct") * self.bounce_count
	self.pick_damage = self:GetAbilitySpecialValueFor("pick_damage") * (1 + self.pick_damage_pct * 0.01)
	self.pick_radius = self:GetAbilitySpecialValueFor("pick_radius") * (1 + self.pick_damage_radius_pct * 0.01)
	self.pickup_radius = self.pickup_radius * (1 + self.pickup_radius_pct * 0.01)
	self.bonus_attack_duration = self:GetAbilitySpecialValueFor("bonus_attack_duration")
end
function ap.prototype.OnCreated(self, aq)
	if IsServer() then
		local I = StringToVector(aq.direction):Normalized()
		local V = ParticleManager:CreateParticle(
			"particles/mushi_fx/mushi_fx_chuizi_bao_dixia_01.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControlTransformForward(V, 0, self:GetParent():GetAbsOrigin(), I)
		ParticleManager:SetParticleControlEnt(V, 7, self:GetCaster().__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
		self:AddParticle(V, false, false, -1, false, false)
		self:StartIntervalThink(0.1)
		self.bounce_count = aq.bounce_count
		self:GetAbilitySpecialValue()
		ParticleManager:SetParticleControl(V, 20, Vector(self.pickup_radius * 0.5, 0, 0))
	end
end
function ap.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveSelf()
	end
end
function ap.prototype.OnIntervalThink(self)
	local ar = self:GetParent()
	local G = self:GetCaster()
	if IsValid(G) and CalcDistance(G, ar) < self.pickup_radius then
		local ae = self:GetAbility()
		if IsValid(ae) then
			ae:EndCooldown()
			ae:RestoreCharges()
		end
		G:EmitSound("Hero_Dawnbreaker.Fire_Wreath.Layer")
		local V =
			ParticleManager:CreateParticle("particles/mushi_fx/mushi_fx_chuizi_jian_01.vpcf", PATTACH_CUSTOMORIGIN, G)
		ParticleManager:SetParticleControlEnt(V, 3, G, PATTACH_POINT_FOLLOW, "attach_attack1", G:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(V, 7, G.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
		self:Destroy()
		if G:HasAbilityUpgrade("seraphon_upgrade_6") then
			local as = G:GetAbilityByTag(AbilityTag.Defense)
			if IsValid(as) then
				as:Purify()
			end
		end
		if self.bonus_attack_duration > 0 then
			G:AddNewModifier(
				G,
				ae,
				"modifier_seraphon_1_bonus_attack_damage",
				{ duration = self.bonus_attack_duration }
			)
		end
	end
end
ap = g(
	{ k(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	ap
)
local at = c()
at.name = "modifier_seraphon_1_bonus_attack_damage"
d(at, j)
function at.prototype.GetAbilitySpecialValue(self)
	self.bonus_attack_damage = self:GetAbilitySpecialValueFor("bonus_attack_damage")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function at.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACK_DAMAGE_PROC] = self.damage * self.bonus_attack_damage * 0.01 }
end
at = g(
	{ k(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	at
)
return h