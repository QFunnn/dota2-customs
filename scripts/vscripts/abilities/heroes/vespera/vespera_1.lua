--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/vespera/vespera_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__DecorateLegacy
local g = b.__TS__ArraySort
local h = b.__TS__ArraySplice
local i = b.__TS__ObjectKeys
local j = {}
local k = require("modifiers.eom_modifier.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.ability_ai")
local o = n.EOMAbilityAI
local p = require("abilities.eom_ability")
local q = p.registerEOMAbility
local r = c()
r.name = "vespera_1"
d(r, o)
function r.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.bullet_particle_width = 0.8
	self.hitCount = 0
	self.surikenHoverData = {}
end
function r.prototype.GetAICastRange(self)
	return self:GetSpecialValueFor("distance")
end
function r.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("width")
end
function r.prototype.GetLinearEndWidth(self)
	return self:GetSpecialValueFor("width")
end
function r.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("distance")
end
function r.prototype.GetBehavior(self)
	if self:GetCaster():HasAbilityUpgrade("vespera_upgrade_21") then
		return tonumber(tostring(o.prototype.GetBehavior(self))) + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return o.prototype.GetBehavior(self)
end
function r.prototype.GetCastPoint(self)
	return math.max(o.prototype.GetCastPoint(self) - self:GetSpecialValueFor("cast_point"), 0)
end
function r.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():HasAbilityUpgrade("vespera_upgrade_21") and 2 or 1
end
function r.prototype.config(self)
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
function r.prototype.OnAbilityPhaseStart(self)
	local s = self:GetCaster()
	return true
end
function r.prototype.OnAbilityPhaseInterrupted(self)
	local s = self:GetCaster()
end
function r.prototype.CreateHitEffect(self, t)
	local u = t
	local v = u.target
	local w = u.location
	local x = u.direction
	local y = u.bonusDamage
	if y == nil then
		y = 0
	end
	local z = u.damagePct
	if z == nil then
		z = 100
	end
	local A = u.damageMultiplier
	if A == nil then
		A = 1
	end
	local B = u.damageFlags
	if B == nil then
		B = EOM_DAMAGE_FLAGS.NO_OUTGOING_ADJUST
	end
	local C = u.sourceAbility
	local s = self:GetCaster()
	local D = self:config()
	local E = D.damage
	local F = D.reduceDuration
	local G = C ~= nil and C or self
	local H = G == self
	local I = 0
	self.hitCount = (self.hitCount + 1) % 5
	if s:HasAbilityUpgrade("vespera_1_upgrade_6") and self.hitCount == 0 then
		I = self:GetSpecialValueFor("fifth_damage")
	end
	local J = 0
	local K = s:HasAbilityUpgrade("vespera_1_upgrade_8")
	local L = v:FindModifierByName("modifier_vespera_1_vulnerability")
	if H and K and IsValid(L) then
		local M = L:GetStackCountForPlayer(s:GetPlayerOwnerID())
		local N = self:GetSpecialValueFor("suiken_damage")
		local O = self:GetSpecialValueFor("suiken_damage_max")
		J = math.min(M * N, O)
	end
	if s:HasAbilityUpgrade("vespera_upgrade_17") then
		local P = x or CalcDirection2D(v, w)
		if math.abs(AngleDiff(VectorToAngles(P).y, VectorToAngles(v:GetForwardVector()).y)) < 90 then
			B = B + EOM_DAMAGE_FLAGS.Backstab
		end
	end
	local Q = 1 + self:GetSpecialValueFor("suriken_damage_multiplier") * 0.01
	local R = (E + y) * (z + I + J) * 0.01 * A * Q
	local S = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_fx_shouji_01.vpcf",
		PATTACH_ABSORIGIN,
		v
	)
	ParticleManager:SetParticleControl(S, 2, w)
	ParticleManager:ReleaseParticleIndex(S)
	v:AddNewModifier(s, self, "modifier_vespera_1_debuff", { duration = F })
	s:DealDamage(v, G, R, nil, B)
	if H and K and IsValid(v) and v:IsAlive() then
		if not IsValid(L) then
			L = v:AddNewModifier(s, self, "modifier_vespera_1_vulnerability", {})
		end
		if IsValid(L) then
			local N = self:GetSpecialValueFor("suiken_damage")
			local O = self:GetSpecialValueFor("suiken_damage_max")
			local T = N > 0 and math.ceil(O / N) or 0
			L:AddStackForPlayer(s:GetPlayerOwnerID(), self:GetSpecialValueFor("suiken_buff_dur"), T)
		end
	end
	local U = self:GetSpecialValueFor("poison")
	s:Poison(v, U)
end
function r.prototype.ThrowSuriken(self, V)
	local W = V
	local x = W.direction
	local X = W.isCircle
	local Y = W.isPrimary
	local Z = W.startPosition
	local _ = W.returnTarget
	local y = W.bonusDamage
	if y == nil then
		y = 0
	end
	local z = W.damagePct
	if z == nil then
		z = 100
	end
	local A = W.damageMultiplier
	if A == nil then
		A = 1
	end
	local a0 = W.delay
	if a0 == nil then
		a0 = 0
	end
	local a1 = W.widthScale
	if a1 == nil then
		a1 = 1
	end
	local a2 = W.useGiantParticle
	if a2 == nil then
		a2 = false
	end
	local a3 = W.uniqueID
	local C = W.sourceAbility
	local s = self:GetCaster()
	local a4 = self:config()
	local a5 = a4.distance
	local a6 = a4.width
	local a7 = a4.outDuration
	local a8 = a4.bounce
	local a9 = a4.damagePerDistance
	local aa = a6 * a1
	local ab = a5 / a7
	local ac = Z or s:GetAttachmentPosition("attach_hitloc")
	local ad = _ or s
	local ae = a2 and "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_giant_linear.vpcf"
		or "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_linear.vpcf"
	Bullet:CreateLinearBullet({
		ability = self,
		caster = s,
		spawnOrigin = ac,
		direction = x,
		moveSpeed = ab,
		distance = a5,
		radius = aa,
		bounce = a8,
		destroyOnBounce = false,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		OnBulletHit = function(v, w, af)
			local ag = CalcDistance(ac, w) * a9
			self:CreateHitEffect({
				target = v,
				location = w,
				direction = af.__velocity,
				bonusDamage = y,
				damagePct = z + ag,
				damageMultiplier = A,
				damageFlags = V.damageFlags,
				sourceAbility = C,
			})
		end,
		OnBulletBounceEnd = function(ah)
			ParticleManager:SetParticleControl(ah.__particleID, 1, ah.__velocity)
		end,
		ParticleCreator = function(ah)
			local S = ParticleManager:CreateParticle(ae, PATTACH_CUSTOMORIGIN, s)
			ParticleManager:SetParticleControlTransformForward(S, 0, ac, ah.__velocity:Normalized())
			ParticleManager:SetParticleControl(S, 1, ah.__velocity)
			ParticleManager:SetParticleControlEnt(S, 7, s.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
			ParticleManager:SetParticleControl(S, 60, Weapon:GetWeaponColor(s, Vector(99, 75, 255)))
			ParticleManager:SetParticleControl(S, 10, Vector(aa * self.bullet_particle_width, 0, 0))
			return S
		end,
		OnBulletDestroy = function(af)
			self:CreateReturningSuriken(
				af.__position,
				{
					isPrimary = Y,
					isCircle = X,
					bonusDamage = y,
					damagePct = z,
					damageMultiplier = A,
					delay = a0,
					start = ac,
					speed = ab,
					damageFlags = V.damageFlags or EOM_DAMAGE_FLAGS.NONE,
					widthScale = a1,
					useGiantParticle = a2,
					uniqueID = a3,
					sourceAbility = C,
					returnTarget = ad,
				}
			)
		end,
	})
end
function r.prototype.CreateReturningSuriken(self, ai, aj)
	local ak = aj
	local Y = ak.isPrimary
	local X = ak.isCircle
	local y = ak.bonusDamage
	local z = ak.damagePct
	local A = ak.damageMultiplier
	local a0 = ak.delay
	local ac = ak.start
	local ab = ak.speed
	local B = ak.damageFlags
	local a1 = ak.widthScale
	local a2 = ak.useGiantParticle
	local a3 = ak.uniqueID
	local _ = ak.returnTarget
	local C = ak.sourceAbility
	local s = self:GetCaster()
	local al = self:config()
	local a6 = al.width
	local am = al.returnDuration
	local a9 = al.damagePerDistance
	local aa = a6 * a1
	local an = a2 and "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_giant_static.vpcf"
		or "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_static.vpcf"
	local ao = a2 and "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_giant_track.vpcf"
		or "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_track.vpcf"
	local S = ParticleManager:CreateParticle(an, PATTACH_CUSTOMORIGIN, s)
	ParticleManager:SetParticleControl(S, 0, ai)
	ParticleManager:SetParticleControl(S, 1, Vector(a0, 0, 0))
	ParticleManager:SetParticleControlEnt(S, 7, s.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
	ParticleManager:SetParticleControl(S, 60, Weapon:GetWeaponColor(s, Vector(99, 75, 255)))
	ParticleManager:SetParticleControl(S, 10, Vector(aa * self.bullet_particle_width, 0, 0))
	if AbilityUpgrade:HasAbilityUpgrade(s, "vespera_upgrade_13") and X then
		local ap, aq = self.surikenHoverData, a3
		if ap[aq] == nil then
			ap[aq] = {}
		end
		local ar = self.surikenHoverData[a3]
		ar[#ar + 1] = { position = ai, radius = CalcDistance(ai, ac), angle = VectorAngles(CalcDirection2D(ai, ac)).y }
	end
	if s:HasAbilityUpgrade("vespera_upgrade_11_2") then
		local as = s:GetAbilityByTag(AbilityTag.Attack)
		as:CuttingStorm(ai, self:GetSpecialValueFor("aoe_static_factor"))
	end
	if AbilityUpgrade:HasAbilityUpgrade(s, "vespera_upgrade_18") and X and IsValid(C) then
		local at = C:GetSpecialValueFor("static_damage_interval")
		local au = C:GetSpecialValueFor("static_damage_pct")
		Bullet:CreateCustomBullet({
			spawnOrigin = ai,
			lifeTime = a0,
			interval = at,
			OnIntervalThink = function(ah)
				local av = FindEnemiesInRadius(s, ai, aa)
				for aw, v in ipairs(av) do
					local ag = CalcDistance(ac, ai) * a9
					self:CreateHitEffect({
						target = v,
						location = ai,
						bonusDamage = y,
						damagePct = (z + ag) * au * 0.01,
						damageMultiplier = A,
						damageFlags = B,
						sourceAbility = C,
					})
				end
			end,
		})
	end
	if AbilityUpgrade:HasAbilityUpgrade(s, "vespera_upgrade_13") and X then
		return
	end
	self:StartThink(a0, nil, function()
		Bullet:CreateTrackingBullet({
			ability = self,
			caster = s,
			spawnOrigin = ai,
			debug = true,
			effectName = ao,
			target = _,
			ignoreBlock = true,
			moveSpeed = math.max(ab, CalcDistance(ai, _:GetAbsOrigin()) / am),
			radius = aa,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			FuncUnitFinder = function(ax, ai, ay, az, ah)
				return Bullet:FindUnitInLine(
					ah.__teamNumber,
					ax,
					ah.__position,
					ay,
					az,
					ah.teamFilter,
					ah.typeFilter,
					ah.flagFilter
				)
			end,
			ParticleCreator = function(ah)
				local S = ParticleManager:CreateParticle(ao, PATTACH_CUSTOMORIGIN, s)
				ParticleManager:SetParticleControlTransformForward(S, 0, ai, ah.__velocity:Normalized())
				ParticleManager:SetParticleControlEnt(
					S,
					1,
					ah.target,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					ah.target:GetAbsOrigin(),
					false
				)
				ParticleManager:SetParticleControl(S, 2, Vector(ah.moveSpeed, 0, 0))
				ParticleManager:SetParticleControlEnt(S, 7, s.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
				ParticleManager:SetParticleControl(S, 10, Vector(aa * self.bullet_particle_width, 0, 0))
				ParticleManager:SetParticleControl(S, 60, Weapon:GetWeaponColor(s, Vector(99, 75, 255)))
				return S
			end,
			OnBulletHit = function(v, w, af)
				if v == _ then
					if Y and not X and AbilityUpgrade:HasAbilityUpgrade(s, "vespera_upgrade_14") then
						self:ReduceCooldown(self:GetSpecialValueFor("reduce_cd"))
					end
					if Y and not X and s:HasAbilityUpgrade("vespera_upgrade_11_4") then
						local as = s:GetAbilityByTag(AbilityTag.Attack)
						as:CuttingStorm(s, self:GetSpecialValueFor("aoe_return_factor"))
					end
					return
				end
				local ag = CalcDistance(ac, w) * a9
				self:CreateHitEffect({
					target = v,
					location = w,
					direction = af.__velocity,
					bonusDamage = y,
					damagePct = z + ag,
					damageMultiplier = A,
					damageFlags = B,
					sourceAbility = C,
				})
			end,
		})
		return -1
	end)
end
function r.prototype.SurikenToss(self, aA)
	local s = self:GetCaster()
	local ai = aA and aA.castPosition or self:GetCursorPosition()
	local aB = self:GetSpecialValueFor("suriken_count")
	local aC = s:HasAbilityUpgrade("vespera_upgrade_1_2_1")
	local aD = math.max(aB - 1, 0)
	local aE = aC and 1 + aD * self:GetSpecialValueFor("giant_scale_per_suriken") * 0.01 or 1
	local aF = aC and 1 + aD * self:GetSpecialValueFor("giant_damage_per_suriken") * 0.01 or 1
	local aG = aC and 1 or aB
	local aH = self:GetSpecialValueFor("angle_per_suriken")
	local aI = self:GetSpecialValueFor("damage_reduce")
	local a0 = self:GetSpecialValueFor("delay")
	local Z = aA and aA.startPosition or s:GetAttachmentPosition("attach_hitloc")
	local _ = aA and aA.returnTarget or s
	local aJ = CalcDirection2D(ai, Z)
	if AbilityUpgrade:HasAbilityUpgrade(s, "vespera_1_upgrade_6") then
		aI = 0
	end
	local aK = math.ceil((aG - 1) / 2)
	local aL = 0
	Bullet:SplitAction(aJ, aG, aH, function(aM, x)
		local Y = aL == aK
		self:ThrowSuriken({
			direction = x,
			isCircle = false,
			isPrimary = Y,
			startPosition = Z,
			returnTarget = _,
			delay = a0,
			damagePct = Y and 100 or 100 - aI,
			damageMultiplier = aF,
			damageFlags = aB > 1 and EOM_DAMAGE_FLAGS.SPLIT_DAMAGE or EOM_DAMAGE_FLAGS.NONE,
			widthScale = aE,
			useGiantParticle = aC,
			uniqueID = DoUniqueString("surikenHoverData"),
			sourceAbility = aA and aA.sourceAbility,
		})
		aL = aL + 1
	end)
	s:EmitSound("Hero_BountyHunter.Shuriken")
end
function r.prototype.OnSpellStart(self)
	self:SurikenToss()
end
function r.prototype.CircleSurikenToss(self, aB, aN, y, z, aO)
	local s = self:GetCaster()
	local aH = 360 / aB
	local aJ = s:GetForwardVector()
	local a3 = DoUniqueString("surikenHoverData")
	local C = s:GetAbilityByTag(AbilityTag.Ultimate)
	Bullet:SplitAction(aJ, aB, aH, function(aM, x)
		self:ThrowSuriken({
			direction = x,
			isCircle = true,
			isPrimary = true,
			damagePct = z,
			bonusDamage = y,
			delay = aO,
			damageFlags = EOM_DAMAGE_FLAGS.SPLIT_DAMAGE,
			uniqueID = a3,
			sourceAbility = C,
		})
	end)
	if AbilityUpgrade:HasAbilityUpgrade(s, "vespera_upgrade_13") then
		self:CreateShrinkingSurroundBullets(aB, aN, y, aO, a3, C)
	end
	s:EmitSound("Hero_BountyHunter.Shuriken")
end
function r.prototype.CreateShrinkingSurroundBullets(self, aP, aN, y, aO, a3, C)
	local s = self:GetCaster()
	local aQ = self:config()
	local a5 = aQ.distance
	local a6 = aQ.width
	local a7 = aQ.outDuration
	local a9 = aQ.damagePerDistance
	local ac = s:GetAbsOrigin()
	self:StartThink(aO + a7, nil, function()
		local aR = shallowcopy(self.surikenHoverData[a3])
		e(self.surikenHoverData, a3)
		local aS = 0
		local aT = GameRules:GetGameTime()
		local aU = Bullet:CreateTrackingBullet({
			spawnOrigin = ac,
			moveSpeed = CalcDistance(ac, s:GetAbsOrigin()) / aO,
			target = s,
			thinker = true,
			OnBulletThink = function(ai, ah)
				if IsValid(s) then
					local aV = GameRules:GetGameTime() - aT
					local aW = aO - aV
					if aW > 0 then
						ah.moveSpeed = CalcDistance(ai, s:GetAbsOrigin()) / aW
					end
				end
			end,
		})
		local aX = Bullet
		local aY = Bullet.CreateGroupSurroundBullet
		local aZ = aP
		local a_ = s
		local b0
		if aU ~= nil then
			b0 = Bullet:GetData(aU, "__thinker")
		else
			b0 = nil
		end
		aY(aX, aZ, {
			caster = a_,
			followEntity = b0,
			ability = self,
			group = DoUniqueString("vespera_upgrade_13"),
			circleRadius = a5,
			angularVelocity = aN,
			offset = 128,
			track = false,
			lifeTime = aO,
			radius = a6,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			OnBulletCreated = function(ah)
				local b1 = aR[aS + 1]
				if b1 ~= nil then
					ah.__position = b1.position
					ah.circleRadius = b1.radius
					ah.angle = b1.angle
					Bullet:SaveData(ah.__projIndex, "InitRadius", b1.radius)
				end
				aS = aS + 1
			end,
			OnBulletThink = function(ai, ah)
				ah.circleRadius = ah.circleRadius - Bullet:GetData(ah.__projIndex, "InitRadius", a5) / aO * FrameTime()
			end,
			ParticleCreator = function(ah)
				local S = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_linear.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControlEnt(
					S,
					0,
					ah.__thinker,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					ah.__thinker:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(S, 7, s.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
				ParticleManager:SetParticleControl(S, 60, Weapon:GetWeaponColor(s, Vector(99, 75, 255)))
				ParticleManager:SetParticleControl(S, 10, Vector(a6, 0, 0))
				return S
			end,
			OnBulletHit = function(v, w, af)
				if v == s then
					return
				end
				local ac = s:GetAttachmentPosition("attach_hitloc")
				local ag = CalcDistance(ac, w) * a9
				self:CreateHitEffect({
					target = v,
					location = w,
					bonusDamage = y,
					damagePct = 100 + ag,
					damageFlags = EOM_DAMAGE_FLAGS.RING_DAMAGE,
					sourceAbility = C,
				})
			end,
		})
		return -1
	end)
end
r = f(
	{
		q(nil, {
			searchBehavior = AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_LINE_TARGET,
			funcCondition = function(aM, as)
				return as:GetAutoCastState()
			end,
		}),
	},
	r
)
local b2 = c()
b2.name = "modifier_vespera_1_debuff"
d(b2, l)
function b2.prototype.OnCreated(self, aj)
	if IsServer() then
	else
		local b3 = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_debuff.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		self:AddParticle(b3, false, false, -1, false, false)
	end
end
function b2.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function b2.prototype.GetModifierMoveSpeedBonus_Constant(self)
	return -self:GetAbilitySpecialValueFor("reduce_move_speed")
end
b2 = f(
	{
		m(
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
	b2
)
local b4 = c()
b4.name = "modifier_vespera_1_vulnerability"
d(b4, l)
function b4.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.vulnerabilityData = {}
end
function b4.prototype.OnCreated(self, aj)
	if IsServer() then
		self:StartIntervalThink(0.2)
	end
end
function b4.prototype.AddStackForPlayer(self, b5, b6, T)
	if not IsServer() or b6 <= 0 or T <= 0 then
		return
	end
	local b7 = GameRules:GetGameTime()
	self:RemoveExpiredStacks(b5, b7)
	local b8, b9 = self.vulnerabilityData, b5
	if b8[b9] == nil then
		b8[b9] = { expireTimes = {} }
	end
	local ba = self.vulnerabilityData[b5]
	local bb = ba.expireTimes
	bb[#bb + 1] = b7 + b6
	g(ba.expireTimes, function(aM, bc, bd)
		return bc - bd
	end)
	while #ba.expireTimes > T do
		h(ba.expireTimes, 0, 1)
	end
	self:UpdateDisplayStackCount()
end
function b4.prototype.GetStackCountForPlayer(self, b5)
	if not IsServer() then
		return 0
	end
	self:RemoveExpiredStacks(b5, GameRules:GetGameTime())
	self:UpdateDisplayStackCount()
	local be = self.vulnerabilityData[b5]
	return be and #be.expireTimes or 0
end
function b4.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local b7 = GameRules:GetGameTime()
	for b5 in pairs(self.vulnerabilityData) do
		self:RemoveExpiredStacks(b5, b7)
	end
	self:UpdateDisplayStackCount()
	if #i(self.vulnerabilityData) <= 0 then
		self:Destroy()
	end
end
function b4.prototype.RemoveExpiredStacks(self, b5, b7)
	local ba = self.vulnerabilityData[b5]
	if ba == nil then
		return
	end
	do
		local aw = #ba.expireTimes - 1
		while aw >= 0 do
			if ba.expireTimes[aw + 1] <= b7 then
				h(ba.expireTimes, aw, 1)
			end
			aw = aw - 1
		end
	end
	if #ba.expireTimes <= 0 then
		e(self.vulnerabilityData, b5)
	end
end
function b4.prototype.UpdateDisplayStackCount(self)
	local bf = 0
	for bg, ba in pairs(self.vulnerabilityData) do
		bf = bf + #ba.expireTimes
	end
	self:SetStackCount(bf)
end
b4 = f(
	{
		m(
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
	b4
)
return j