--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/vespera/vespera_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectAssign
local f = b.__TS__Delete
local g = b.__TS__DecorateLegacy
local h = b.__TS__ArraySort
local i = b.__TS__ArraySplice
local j = b.__TS__ObjectKeys
local k = {}
local l = require("modifiers.eom_modifier.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
local o = require("abilities.ability_ai")
local p = o.EOMAbilityAI
local q = require("abilities.eom_ability")
local r = q.registerEOMAbility
local s = c()
s.name = "vespera_1"
d(s, p)
function s.prototype.____constructor(self, ...)
	p.prototype.____constructor(self, ...)
	self.bullet_particle_width = 0.8
	self.hitCount = 0
	self.surikenHoverData = {}
end
function s.prototype.GetAICastRange(self)
	return self:GetSpecialValueFor("distance")
end
function s.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("width")
end
function s.prototype.GetLinearEndWidth(self)
	return self:GetSpecialValueFor("width")
end
function s.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("distance")
end
function s.prototype.GetBehavior(self)
	if self:GetCaster():HasAbilityUpgrade("vespera_upgrade_21") then
		return tonumber(tostring(p.prototype.GetBehavior(self))) + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return p.prototype.GetBehavior(self)
end
function s.prototype.GetCastPoint(self)
	return math.max(p.prototype.GetCastPoint(self) - self:GetSpecialValueFor("cast_point"), 0)
end
function s.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():HasAbilityUpgrade("vespera_upgrade_21") and 2 or 1
end
function s.prototype.config(self)
	return {
		distance = self:GetSpecialValueFor("distance"),
		width = self:GetSpecialValueFor("width"),
		outDuration = self:GetSpecialValueFor("out_duration"),
		returnDuration = self:GetSpecialValueFor("return_duration"),
		damage = self:GetSpecialValueFor("damage"),
		damagePerDistance = self:GetSpecialValueFor("damage_per_distance"),
		reduceDuration = self:GetSpecialValueFor("reduce_duration"),
		delay = self:GetSpecialValueFor("delay"),
		bounce = self:GetSpecialValueFor("bounce"),
	}
end
function s.prototype.OnAbilityPhaseStart(self)
	local t = self:GetCaster()
	return true
end
function s.prototype.OnAbilityPhaseInterrupted(self)
	local t = self:GetCaster()
end
function s.prototype.CreateHitEffect(self, u)
	local v = u
	local w = v.target
	local x = v.location
	local y = v.direction
	local z = v.bonusDamage
	if z == nil then
		z = 0
	end
	local A = v.damagePct
	if A == nil then
		A = 100
	end
	local B = v.damageMultiplier
	if B == nil then
		B = 1
	end
	local C = v.damageFlags
	if C == nil then
		C = EOM_DAMAGE_FLAGS.NO_OUTGOING_ADJUST
	end
	local D = v.sourceAbility
	local t = self:GetCaster()
	local E = self:config()
	local F = E.damage
	local G = E.reduceDuration
	local H = D ~= nil and D or self
	local I = H == self
	local J = 0
	self.hitCount = (self.hitCount + 1) % 5
	if t:HasAbilityUpgrade("vespera_1_upgrade_6") and self.hitCount == 0 then
		J = self:GetSpecialValueFor("fifth_damage")
	end
	local K = 0
	local L = t:HasAbilityUpgrade("vespera_1_upgrade_8")
	local M = w:FindModifierByName("modifier_vespera_1_vulnerability")
	if I and L and IsValid(M) then
		local N = M:GetStackCountForPlayer(t:GetPlayerOwnerID())
		local O = self:GetSpecialValueFor("suiken_damage")
		local P = self:GetSpecialValueFor("suiken_damage_max")
		K = math.min(N * O, P)
	end
	if t:HasAbilityUpgrade("vespera_upgrade_17") then
		local Q = y or CalcDirection2D(w, x)
		if math.abs(AngleDiff(VectorToAngles(Q).y, VectorToAngles(w:GetForwardVector()).y)) < 90 then
			C = C + EOM_DAMAGE_FLAGS.Backstab
		end
	end
	local R = 1 + self:GetSpecialValueFor("suriken_damage_multiplier") * 0.01
	local S = (F + z) * (A + J + K) * 0.01 * B * R
	local T = ParticleManager:CreateParticleWithCaster(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_fx_shouji_01.vpcf",
		PATTACH_ABSORIGIN,
		w,
		t,
		ParticleEffectLevel.Low
	)
	if T ~= -1 then
		ParticleManager:SetParticleControl(T, 2, x)
		ParticleManager:ReleaseParticleIndex(T)
	end
	w:AddNewModifier(t, self, "modifier_vespera_1_debuff", { duration = G })
	t:DealDamage(w, H, S, nil, C)
	if I and L and IsValid(w) and w:IsAlive() then
		if not IsValid(M) then
			M = w:AddNewModifier(t, self, "modifier_vespera_1_vulnerability", {})
		end
		if IsValid(M) then
			local O = self:GetSpecialValueFor("suiken_damage")
			local P = self:GetSpecialValueFor("suiken_damage_max")
			local U = O > 0 and math.ceil(P / O) or 0
			M:AddStackForPlayer(t:GetPlayerOwnerID(), self:GetSpecialValueFor("suiken_buff_dur"), U)
		end
	end
	local V = self:GetSpecialValueFor("poison")
	t:Poison(w, V)
end
function s.prototype.ThrowSuriken(self, W)
	local X = W
	local y = X.direction
	local Y = X.isCircle
	local Z = X.isPrimary
	local _ = X.startPosition
	local a0 = X.returnTarget
	local z = X.bonusDamage
	if z == nil then
		z = 0
	end
	local A = X.damagePct
	if A == nil then
		A = 100
	end
	local B = X.damageMultiplier
	if B == nil then
		B = 1
	end
	local a1 = X.delay
	if a1 == nil then
		a1 = 0
	end
	local a2 = X.widthScale
	if a2 == nil then
		a2 = 1
	end
	local a3 = X.useGiantParticle
	if a3 == nil then
		a3 = false
	end
	local a4 = X.uniqueID
	local D = X.sourceAbility
	local t = self:GetCaster()
	local a5 = self:config()
	local a6 = a5.distance
	local a7 = a5.width
	local a8 = a5.outDuration
	local a9 = a5.bounce
	local aa = a5.damagePerDistance
	local ab = a7 * a2
	local ac = a6 / a8
	local ad = _ or t:GetAttachmentPosition("attach_hitloc")
	local ae = a0 or t
	local af = a3 and "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_giant_linear.vpcf"
		or "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_linear.vpcf"
	Bullet:CreateLinearBullet({
		ability = self,
		caster = t,
		spawnOrigin = ad,
		direction = y,
		moveSpeed = ac,
		distance = a6,
		radius = ab,
		bounce = a9,
		destroyOnBounce = false,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		OnBulletHit = function(w, x, ag)
			local ah = CalcDistance(ad, x) * aa
			self:CreateHitEffect({
				target = w,
				location = x,
				direction = ag.__velocity,
				bonusDamage = z,
				damagePct = A + ah,
				damageMultiplier = B,
				damageFlags = W.damageFlags,
				sourceAbility = D,
			})
		end,
		OnBulletBounceEnd = function(ai)
			ParticleManager:SetParticleControl(ai.__particleID, 1, ai.__velocity)
		end,
		ParticleCreator = function(ai)
			local T = ParticleManager:CreateParticle(af, PATTACH_CUSTOMORIGIN, t)
			ParticleManager:SetParticleControlTransformForward(T, 0, ad, ai.__velocity:Normalized())
			ParticleManager:SetParticleControl(T, 1, ai.__velocity)
			ParticleManager:SetParticleControlEnt(T, 7, t.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
			ParticleManager:SetParticleControl(T, 60, Weapon:GetWeaponColor(t, Vector(99, 75, 255)))
			ParticleManager:SetParticleControl(T, 10, Vector(ab * self.bullet_particle_width, 0, 0))
			return T
		end,
		OnBulletDestroy = function(ag)
			self:CreateReturningSuriken(
				ag.__position,
				{
					isPrimary = Z,
					isCircle = Y,
					bonusDamage = z,
					damagePct = A,
					damageMultiplier = B,
					delay = a1,
					start = ad,
					speed = ac,
					damageFlags = W.damageFlags or EOM_DAMAGE_FLAGS.NONE,
					widthScale = a2,
					useGiantParticle = a3,
					uniqueID = a4,
					sourceAbility = D,
					returnTarget = ae,
				}
			)
		end,
	})
end
function s.prototype.CreateReturningSuriken(self, aj, ak)
	local al = ak
	local Z = al.isPrimary
	local Y = al.isCircle
	local z = al.bonusDamage
	local A = al.damagePct
	local B = al.damageMultiplier
	local a1 = al.delay
	local ad = al.start
	local ac = al.speed
	local C = al.damageFlags
	local a2 = al.widthScale
	local a3 = al.useGiantParticle
	local a4 = al.uniqueID
	local a0 = al.returnTarget
	local D = al.sourceAbility
	local t = self:GetCaster()
	local am = self:config()
	local a7 = am.width
	local an = am.returnDuration
	local aa = am.damagePerDistance
	local ab = a7 * a2
	local ao = a3 and "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_giant_static.vpcf"
		or "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_static.vpcf"
	local ap = a3 and "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_giant_track.vpcf"
		or "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_track.vpcf"
	local T = ParticleManager:CreateParticle(ao, PATTACH_CUSTOMORIGIN, t)
	ParticleManager:SetParticleControl(T, 0, aj)
	ParticleManager:SetParticleControl(T, 1, Vector(a1, 0, 0))
	ParticleManager:SetParticleControlEnt(T, 7, t.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
	ParticleManager:SetParticleControl(T, 60, Weapon:GetWeaponColor(t, Vector(99, 75, 255)))
	ParticleManager:SetParticleControl(T, 10, Vector(ab * self.bullet_particle_width, 0, 0))
	if AbilityUpgrade:HasAbilityUpgrade(t, "vespera_upgrade_13") and Y then
		local aq, ar = self.surikenHoverData, a4
		if aq[ar] == nil then
			aq[ar] = {}
		end
		local as = self.surikenHoverData[a4]
		as[#as + 1] = { position = aj, radius = CalcDistance(aj, ad), angle = VectorAngles(CalcDirection2D(aj, ad)).y }
	end
	if t:HasAbilityUpgrade("vespera_upgrade_11_2") then
		local at = t:GetAbilityByTag(AbilityTag.Attack)
		at:CuttingStorm(aj, self:GetSpecialValueFor("aoe_static_factor"))
	end
	if AbilityUpgrade:HasAbilityUpgrade(t, "vespera_upgrade_18") and Y and IsValid(D) then
		local au = D:GetSpecialValueFor("static_damage_interval")
		local av = D:GetSpecialValueFor("static_damage_pct")
		Bullet:CreateCustomBullet({
			spawnOrigin = aj,
			lifeTime = a1,
			interval = au,
			OnIntervalThink = function(ai)
				local aw = FindEnemiesInRadius(t, aj, ab)
				for ax, w in ipairs(aw) do
					local ah = CalcDistance(ad, aj) * aa
					self:CreateHitEffect({
						target = w,
						location = aj,
						bonusDamage = z,
						damagePct = (A + ah) * av * 0.01,
						damageMultiplier = B,
						damageFlags = C,
						sourceAbility = D,
					})
				end
			end,
		})
	end
	if AbilityUpgrade:HasAbilityUpgrade(t, "vespera_upgrade_13") and Y then
		return
	end
	self:StartThink(a1, nil, function()
		Bullet:CreateTrackingBullet({
			ability = self,
			caster = t,
			spawnOrigin = aj,
			debug = true,
			effectName = ap,
			target = a0,
			ignoreBlock = true,
			moveSpeed = math.max(ac, CalcDistance(aj, a0:GetAbsOrigin()) / an),
			radius = ab,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			FuncUnitFinder = function(ay, aj, az, aA, ai)
				return Bullet:FindUnitInLine(
					ai.__teamNumber,
					ay,
					ai.__position,
					az,
					aA,
					ai.teamFilter,
					ai.typeFilter,
					ai.flagFilter
				)
			end,
			ParticleCreator = function(ai)
				local T = ParticleManager:CreateParticle(ap, PATTACH_CUSTOMORIGIN, t)
				ParticleManager:SetParticleControlTransformForward(T, 0, aj, ai.__velocity:Normalized())
				ParticleManager:SetParticleControlEnt(
					T,
					1,
					ai.target,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					ai.target:GetAbsOrigin(),
					false
				)
				ParticleManager:SetParticleControl(T, 2, Vector(ai.moveSpeed, 0, 0))
				ParticleManager:SetParticleControlEnt(T, 7, t.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
				ParticleManager:SetParticleControl(T, 10, Vector(ab * self.bullet_particle_width, 0, 0))
				ParticleManager:SetParticleControl(T, 60, Weapon:GetWeaponColor(t, Vector(99, 75, 255)))
				return T
			end,
			OnBulletHit = function(w, x, ag)
				if w == a0 then
					if Z and not Y and AbilityUpgrade:HasAbilityUpgrade(t, "vespera_upgrade_14") then
						self:ReduceCooldown(self:GetSpecialValueFor("reduce_cd"))
					end
					if Z and not Y and t:HasAbilityUpgrade("vespera_upgrade_11_4") then
						local at = t:GetAbilityByTag(AbilityTag.Attack)
						at:CuttingStorm(t, self:GetSpecialValueFor("aoe_return_factor"))
					end
					return
				end
				local ah = CalcDistance(ad, x) * aa
				self:CreateHitEffect({
					target = w,
					location = x,
					direction = ag.__velocity,
					bonusDamage = z,
					damagePct = A + ah,
					damageMultiplier = B,
					damageFlags = C,
					sourceAbility = D,
				})
			end,
		})
		return -1
	end)
end
function s.prototype.SurikenToss(self, aB, aC)
	if aC == nil then
		aC = false
	end
	local t = self:GetCaster()
	local aj = aB and aB.castPosition or self:GetCursorPosition()
	local aD = self:GetSpecialValueFor("suriken_count")
	local aE = t:HasAbilityUpgrade("vespera_upgrade_1_2_1")
	local aF = math.max(aD - 1, 0)
	local aG = aE and 1 + aF * self:GetSpecialValueFor("giant_scale_per_suriken") * 0.01 or 1
	local aH = aE and 1 + aF * self:GetSpecialValueFor("giant_damage_per_suriken") * 0.01 or 1
	local aI = aE and 1 or aD
	local aJ = self:GetSpecialValueFor("angle_per_suriken")
	local aK = self:GetSpecialValueFor("damage_reduce")
	local a1 = self:GetSpecialValueFor("delay")
	local _ = aB and aB.startPosition or t:GetAttachmentPosition("attach_hitloc")
	local a0 = aB and aB.returnTarget or t
	local aL = CalcDirection2D(aj, _)
	if AbilityUpgrade:HasAbilityUpgrade(t, "vespera_1_upgrade_6") then
		aK = 0
	end
	local aM = math.ceil((aI - 1) / 2)
	local aN = 0
	Bullet:SplitAction(aL, aI, aJ, function(aO, y)
		local Z = aN == aM
		self:ThrowSuriken({
			direction = y,
			isCircle = false,
			isPrimary = Z,
			startPosition = _,
			returnTarget = a0,
			delay = a1,
			damagePct = Z and 100 or 100 - aK,
			damageMultiplier = aH,
			damageFlags = aD > 1 and EOM_DAMAGE_FLAGS.SPLIT_DAMAGE or EOM_DAMAGE_FLAGS.NONE,
			widthScale = aG,
			useGiantParticle = aE,
			uniqueID = DoUniqueString("surikenHoverData"),
			sourceAbility = aB and aB.sourceAbility,
		})
		aN = aN + 1
	end)
	t:EmitSound("Hero_BountyHunter.Shuriken")
	if not aC and ((aB and aB.sourceAbility) == nil or aB.sourceAbility == self) then
		local aP = self:GetSpecialValueFor("double_cast_prob")
		if aP > 0 and self:PRD(aP, "vespera_1_upgrade_wp42") then
			local aQ = aB ~= nil and e({}, aB) or {}
			aQ.castPosition = aQ and aQ.castPosition or aj
			aQ.returnTarget = aQ and aQ.returnTarget or a0
			aQ.startPosition = aQ and aQ.startPosition or _
			self:StartThink(0.3, nil, function()
				if IsValid(self) and IsValid(t) then
					self:SurikenToss(aQ, true)
				end
				return -1
			end)
		end
	end
end
function s.prototype.OnSpellStart(self)
	self:SurikenToss()
end
function s.prototype.CircleSurikenToss(self, aD, aR, z, A, aS)
	local t = self:GetCaster()
	local aJ = 360 / aD
	local aL = t:GetForwardVector()
	local a4 = DoUniqueString("surikenHoverData")
	local D = t:GetAbilityByTag(AbilityTag.Ultimate)
	Bullet:SplitAction(aL, aD, aJ, function(aO, y)
		self:ThrowSuriken({
			direction = y,
			isCircle = true,
			isPrimary = true,
			damagePct = A,
			bonusDamage = z,
			delay = aS,
			damageFlags = EOM_DAMAGE_FLAGS.SPLIT_DAMAGE,
			uniqueID = a4,
			sourceAbility = D,
		})
	end)
	if AbilityUpgrade:HasAbilityUpgrade(t, "vespera_upgrade_13") then
		self:CreateShrinkingSurroundBullets(aD, aR, z, aS, a4, D)
	end
	t:EmitSound("Hero_BountyHunter.Shuriken")
end
function s.prototype.CreateShrinkingSurroundBullets(self, aT, aR, z, aS, a4, D)
	local t = self:GetCaster()
	local aU = self:config()
	local a6 = aU.distance
	local a7 = aU.width
	local a8 = aU.outDuration
	local aa = aU.damagePerDistance
	local ad = t:GetAbsOrigin()
	self:StartThink(aS + a8, nil, function()
		local aV = shallowcopy(self.surikenHoverData[a4])
		f(self.surikenHoverData, a4)
		local aW = 0
		local aX = GameRules:GetGameTime()
		local aY = Bullet:CreateTrackingBullet({
			spawnOrigin = ad,
			moveSpeed = CalcDistance(ad, t:GetAbsOrigin()) / aS,
			target = t,
			thinker = true,
			OnBulletThink = function(aj, ai)
				if IsValid(t) then
					local aZ = GameRules:GetGameTime() - aX
					local a_ = aS - aZ
					if a_ > 0 then
						ai.moveSpeed = CalcDistance(aj, t:GetAbsOrigin()) / a_
					end
				end
			end,
		})
		local b0 = Bullet
		local b1 = Bullet.CreateGroupSurroundBullet
		local b2 = aT
		local b3 = t
		local b4
		if aY ~= nil then
			b4 = Bullet:GetData(aY, "__thinker")
		else
			b4 = nil
		end
		b1(b0, b2, {
			caster = b3,
			followEntity = b4,
			ability = self,
			group = DoUniqueString("vespera_upgrade_13"),
			circleRadius = a6,
			angularVelocity = aR,
			offset = 128,
			track = false,
			lifeTime = aS,
			radius = a7,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			OnBulletCreated = function(ai)
				local b5 = aV[aW + 1]
				if b5 ~= nil then
					ai.__position = b5.position
					ai.circleRadius = b5.radius
					ai.angle = b5.angle
					Bullet:SaveData(ai.__projIndex, "InitRadius", b5.radius)
				end
				aW = aW + 1
			end,
			OnBulletThink = function(aj, ai)
				ai.circleRadius = ai.circleRadius - Bullet:GetData(ai.__projIndex, "InitRadius", a6) / aS * FrameTime()
			end,
			ParticleCreator = function(ai)
				local T = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_linear.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControlEnt(
					T,
					0,
					ai.__thinker,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					ai.__thinker:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(T, 7, t.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
				ParticleManager:SetParticleControl(T, 60, Weapon:GetWeaponColor(t, Vector(99, 75, 255)))
				ParticleManager:SetParticleControl(T, 10, Vector(a7, 0, 0))
				return T
			end,
			OnBulletHit = function(w, x, ag)
				if w == t then
					return
				end
				local ad = t:GetAttachmentPosition("attach_hitloc")
				local ah = CalcDistance(ad, x) * aa
				self:CreateHitEffect({
					target = w,
					location = x,
					bonusDamage = z,
					damagePct = 100 + ah,
					damageFlags = EOM_DAMAGE_FLAGS.RING_DAMAGE,
					sourceAbility = D,
				})
			end,
		})
		return -1
	end)
end
s = g(
	{
		r(nil, {
			searchBehavior = AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_LINE_TARGET,
			funcCondition = function(aO, at)
				return at:GetAutoCastState()
			end,
		}),
	},
	s
)
local b6 = c()
b6.name = "modifier_vespera_1_debuff"
d(b6, m)
function b6.prototype.OnCreated(self, ak)
	if IsServer() then
	else
		local b7 = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_debuff.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		self:AddParticle(b7, false, false, -1, false, false)
	end
end
function b6.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function b6.prototype.GetModifierMoveSpeedBonus_Constant(self)
	return -self:GetAbilitySpecialValueFor("reduce_move_speed")
end
b6 = g(
	{
		n(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	b6
)
local b8 = c()
b8.name = "modifier_vespera_1_vulnerability"
d(b8, m)
function b8.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.vulnerabilityData = {}
end
function b8.prototype.OnCreated(self, ak)
	if IsServer() then
		self:StartIntervalThink(0.2)
	end
end
function b8.prototype.AddStackForPlayer(self, b9, ba, U)
	if not IsServer() or ba <= 0 or U <= 0 then
		return
	end
	local bb = GameRules:GetGameTime()
	self:RemoveExpiredStacks(b9, bb)
	local bc, bd = self.vulnerabilityData, b9
	if bc[bd] == nil then
		bc[bd] = { expireTimes = {} }
	end
	local be = self.vulnerabilityData[b9]
	local bf = be.expireTimes
	bf[#bf + 1] = bb + ba
	h(be.expireTimes, function(aO, bg, bh)
		return bg - bh
	end)
	while #be.expireTimes > U do
		i(be.expireTimes, 0, 1)
	end
	self:UpdateDisplayStackCount()
end
function b8.prototype.GetStackCountForPlayer(self, b9)
	if not IsServer() then
		return 0
	end
	self:RemoveExpiredStacks(b9, GameRules:GetGameTime())
	self:UpdateDisplayStackCount()
	local bi = self.vulnerabilityData[b9]
	return bi and #bi.expireTimes or 0
end
function b8.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local bb = GameRules:GetGameTime()
	for b9 in pairs(self.vulnerabilityData) do
		self:RemoveExpiredStacks(b9, bb)
	end
	self:UpdateDisplayStackCount()
	if #j(self.vulnerabilityData) <= 0 then
		self:Destroy()
	end
end
function b8.prototype.RemoveExpiredStacks(self, b9, bb)
	local be = self.vulnerabilityData[b9]
	if be == nil then
		return
	end
	do
		local ax = #be.expireTimes - 1
		while ax >= 0 do
			if be.expireTimes[ax + 1] <= bb then
				i(be.expireTimes, ax, 1)
			end
			ax = ax - 1
		end
	end
	if #be.expireTimes <= 0 then
		f(self.vulnerabilityData, b9)
	end
end
function b8.prototype.UpdateDisplayStackCount(self)
	local bj = 0
	for bk, be in pairs(self.vulnerabilityData) do
		bj = bj + #be.expireTimes
	end
	self:SetStackCount(bj)
end
b8 = g(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	b8
)
return k