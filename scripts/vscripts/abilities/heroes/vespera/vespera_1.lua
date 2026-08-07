--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
	local x = u.bonusDamage
	if x == nil then
		x = 0
	end
	local y = u.damagePct
	if y == nil then
		y = 100
	end
	local z = u.damageFlags
	if z == nil then
		z = EOM_DAMAGE_FLAGS.NO_OUTGOING_ADJUST
	end
	local A = u.sourceAbility
	local s = self:GetCaster()
	local B = self:config()
	local C = B.damage
	local D = B.reduceDuration
	local E = A ~= nil and A or self
	local F = E == self
	local G = 0
	self.hitCount = (self.hitCount + 1) % 5
	if s:HasAbilityUpgrade("vespera_1_upgrade_6") and self.hitCount == 0 then
		G = self:GetSpecialValueFor("fifth_damage")
	end
	local H = 0
	local I = s:HasAbilityUpgrade("vespera_1_upgrade_8")
	local J = v:FindModifierByName("modifier_vespera_1_vulnerability")
	if F and I and IsValid(J) then
		local K = J:GetStackCountForPlayer(s:GetPlayerOwnerID())
		local L = self:GetSpecialValueFor("suiken_damage")
		local M = self:GetSpecialValueFor("suiken_damage_max")
		H = math.min(K * L, M)
	end
	if s:HasAbilityUpgrade("vespera_upgrade_17") then
		if
			math.abs(AngleDiff(VectorToAngles(CalcDirection2D(v, w)).y, VectorToAngles(v:GetForwardVector()).y)) < 90
		then
			z = z + EOM_DAMAGE_FLAGS.Backstab
		end
	end
	local N = (C + x) * (y + G + H) * 0.01
	local O = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_fx_shouji_01.vpcf",
		PATTACH_ABSORIGIN,
		v
	)
	ParticleManager:SetParticleControl(O, 2, w)
	ParticleManager:ReleaseParticleIndex(O)
	v:AddNewModifier(s, self, "modifier_vespera_1_debuff", { duration = D })
	s:DealDamage(v, E, N, nil, z)
	if F and I and IsValid(v) and v:IsAlive() then
		if not IsValid(J) then
			J = v:AddNewModifier(s, self, "modifier_vespera_1_vulnerability", {})
		end
		if IsValid(J) then
			local L = self:GetSpecialValueFor("suiken_damage")
			local M = self:GetSpecialValueFor("suiken_damage_max")
			local P = L > 0 and math.ceil(M / L) or 0
			J:AddStackForPlayer(s:GetPlayerOwnerID(), self:GetSpecialValueFor("suiken_buff_dur"), P)
		end
	end
	local Q = self:GetSpecialValueFor("poison")
	s:Poison(v, Q)
end
function r.prototype.ThrowSuriken(self, R)
	local S = R
	local T = S.direction
	local U = S.isCircle
	local V = S.isPrimary
	local W = S.startPosition
	local X = S.returnTarget
	local x = S.bonusDamage
	if x == nil then
		x = 0
	end
	local y = S.damagePct
	if y == nil then
		y = 100
	end
	local Y = S.delay
	if Y == nil then
		Y = 0
	end
	local Z = S.uniqueID
	local A = S.sourceAbility
	local s = self:GetCaster()
	local _ = self:config()
	local a0 = _.distance
	local a1 = _.width
	local a2 = _.outDuration
	local a3 = _.bounce
	local a4 = _.damagePerDistance
	local a5 = a0 / a2
	local a6 = W or s:GetAttachmentPosition("attach_hitloc")
	local a7 = X or s
	Bullet:CreateLinearBullet({
		ability = self,
		caster = s,
		spawnOrigin = a6,
		direction = T,
		moveSpeed = a5,
		distance = a0,
		radius = a1,
		bounce = a3,
		destroyOnBounce = false,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		OnBulletHit = function(v, w, a8)
			local a9 = CalcDistance(a6, w) * a4
			self:CreateHitEffect({
				target = v,
				location = w,
				bonusDamage = x,
				damagePct = y + a9,
				damageFlags = R.damageFlags,
				sourceAbility = A,
			})
		end,
		OnBulletBounceEnd = function(aa)
			ParticleManager:SetParticleControl(aa.__particleID, 1, aa.__velocity)
		end,
		ParticleCreator = function(aa)
			local O = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_linear.vpcf",
				PATTACH_CUSTOMORIGIN,
				s
			)
			ParticleManager:SetParticleControlTransformForward(O, 0, a6, aa.__velocity:Normalized())
			ParticleManager:SetParticleControl(O, 1, aa.__velocity)
			ParticleManager:SetParticleControlEnt(O, 7, s.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
			ParticleManager:SetParticleControl(O, 60, Weapon:GetWeaponColor(s, Vector(99, 75, 255)))
			ParticleManager:SetParticleControl(O, 10, Vector(a1 * self.bullet_particle_width, 0, 0))
			return O
		end,
		OnBulletDestroy = function(a8)
			self:CreateReturningSuriken(
				a8.__position,
				{
					isPrimary = V,
					isCircle = U,
					bonusDamage = x,
					damagePct = y,
					delay = Y,
					start = a6,
					speed = a5,
					damageFlags = R.damageFlags or EOM_DAMAGE_FLAGS.NONE,
					uniqueID = Z,
					sourceAbility = A,
					returnTarget = a7,
				}
			)
		end,
	})
end
function r.prototype.CreateReturningSuriken(self, ab, ac)
	local ad = ac
	local V = ad.isPrimary
	local U = ad.isCircle
	local x = ad.bonusDamage
	local y = ad.damagePct
	local Y = ad.delay
	local a6 = ad.start
	local a5 = ad.speed
	local z = ad.damageFlags
	local Z = ad.uniqueID
	local X = ad.returnTarget
	local A = ad.sourceAbility
	local s = self:GetCaster()
	local ae = self:config()
	local a1 = ae.width
	local af = ae.returnDuration
	local a4 = ae.damagePerDistance
	local O = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_static.vpcf",
		PATTACH_CUSTOMORIGIN,
		s
	)
	ParticleManager:SetParticleControl(O, 0, ab)
	ParticleManager:SetParticleControl(O, 1, Vector(Y, 0, 0))
	ParticleManager:SetParticleControlEnt(O, 7, s.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
	ParticleManager:SetParticleControl(O, 60, Weapon:GetWeaponColor(s, Vector(99, 75, 255)))
	ParticleManager:SetParticleControl(O, 10, Vector(a1 * self.bullet_particle_width, 0, 0))
	if AbilityUpgrade:HasAbilityUpgrade(s, "vespera_upgrade_13") and U then
		local ag, ah = self.surikenHoverData, Z
		if ag[ah] == nil then
			ag[ah] = {}
		end
		local ai = self.surikenHoverData[Z]
		ai[#ai + 1] = { position = ab, radius = CalcDistance(ab, a6), angle = VectorAngles(CalcDirection2D(ab, a6)).y }
	end
	if s:HasAbilityUpgrade("vespera_upgrade_11_2") then
		local aj = s:GetAbilityByTag(AbilityTag.Attack)
		aj:CuttingStorm(ab, self:GetSpecialValueFor("aoe_static_factor"))
	end
	if AbilityUpgrade:HasAbilityUpgrade(s, "vespera_upgrade_18") and U and IsValid(A) then
		local ak = A:GetSpecialValueFor("static_damage_interval")
		local al = A:GetSpecialValueFor("static_damage_pct")
		Bullet:CreateCustomBullet({
			spawnOrigin = ab,
			lifeTime = Y,
			interval = ak,
			OnIntervalThink = function(aa)
				local am = FindEnemiesInRadius(s, ab, a1)
				for an, v in ipairs(am) do
					local a9 = CalcDistance(a6, ab) * a4
					self:CreateHitEffect({
						target = v,
						location = ab,
						bonusDamage = x,
						damagePct = (y + a9) * al * 0.01,
						damageFlags = z,
						sourceAbility = A,
					})
				end
			end,
		})
	end
	if AbilityUpgrade:HasAbilityUpgrade(s, "vespera_upgrade_13") and U then
		return
	end
	self:StartThink(Y, nil, function()
		Bullet:CreateTrackingBullet({
			ability = self,
			caster = s,
			spawnOrigin = ab,
			debug = true,
			effectName = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_track.vpcf",
			target = X,
			ignoreBlock = true,
			moveSpeed = math.max(a5, CalcDistance(ab, X:GetAbsOrigin()) / af),
			radius = a1,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			FuncUnitFinder = function(ao, ab, ap, aq, aa)
				return Bullet:FindUnitInLine(
					aa.__teamNumber,
					ao,
					aa.__position,
					ap,
					aq,
					aa.teamFilter,
					aa.typeFilter,
					aa.flagFilter
				)
			end,
			ParticleCreator = function(aa)
				local O = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_track.vpcf",
					PATTACH_CUSTOMORIGIN,
					s
				)
				ParticleManager:SetParticleControlTransformForward(O, 0, ab, aa.__velocity:Normalized())
				ParticleManager:SetParticleControlEnt(
					O,
					1,
					aa.target,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					aa.target:GetAbsOrigin(),
					false
				)
				ParticleManager:SetParticleControl(O, 2, Vector(aa.moveSpeed, 0, 0))
				ParticleManager:SetParticleControlEnt(O, 7, s.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
				ParticleManager:SetParticleControl(O, 10, Vector(a1 * self.bullet_particle_width, 0, 0))
				ParticleManager:SetParticleControl(O, 60, Weapon:GetWeaponColor(s, Vector(99, 75, 255)))
				return O
			end,
			OnBulletHit = function(v, w, a8)
				if v == X then
					if V and not U and AbilityUpgrade:HasAbilityUpgrade(s, "vespera_upgrade_14") then
						self:ReduceCooldown(self:GetSpecialValueFor("reduce_cd"))
					end
					if V and not U and s:HasAbilityUpgrade("vespera_upgrade_11_4") then
						local aj = s:GetAbilityByTag(AbilityTag.Attack)
						aj:CuttingStorm(s, self:GetSpecialValueFor("aoe_return_factor"))
					end
					return
				end
				local a9 = CalcDistance(a6, w) * a4
				self:CreateHitEffect({ target = v, location = w, bonusDamage = x, damagePct = y + a9, damageFlags = z, sourceAbility = A })
			end,
		})
		return -1
	end)
end
function r.prototype.SurikenToss(self, ar)
	local s = self:GetCaster()
	local ab = ar and ar.castPosition or self:GetCursorPosition()
	local as = self:GetSpecialValueFor("suriken_count")
	local at = self:GetSpecialValueFor("angle_per_suriken")
	local au = self:GetSpecialValueFor("damage_reduce")
	local Y = self:GetSpecialValueFor("delay")
	local W = ar and ar.startPosition or s:GetAttachmentPosition("attach_hitloc")
	local X = ar and ar.returnTarget or s
	local av = CalcDirection2D(ab, W)
	if AbilityUpgrade:HasAbilityUpgrade(s, "vespera_1_upgrade_6") then
		au = 0
	end
	local aw = math.ceil((as - 1) / 2)
	local ax = 0
	Bullet:SplitAction(av, as, at, function(ay, T)
		local V = ax == aw
		self:ThrowSuriken({
			direction = T,
			isCircle = false,
			isPrimary = V,
			startPosition = W,
			returnTarget = X,
			delay = Y,
			damagePct = V and 100 or 100 - au,
			damageFlags = as > 1 and EOM_DAMAGE_FLAGS.SPLIT_DAMAGE or EOM_DAMAGE_FLAGS.NONE,
			uniqueID = DoUniqueString("surikenHoverData"),
			sourceAbility = ar and ar.sourceAbility,
		})
		ax = ax + 1
	end)
	s:EmitSound("Hero_BountyHunter.Shuriken")
end
function r.prototype.OnSpellStart(self)
	self:SurikenToss()
end
function r.prototype.CircleSurikenToss(self, as, az, x, y, aA)
	local s = self:GetCaster()
	local at = 360 / as
	local av = s:GetForwardVector()
	local Z = DoUniqueString("surikenHoverData")
	local A = s:GetAbilityByTag(AbilityTag.Ultimate)
	Bullet:SplitAction(av, as, at, function(ay, T)
		self:ThrowSuriken({
			direction = T,
			isCircle = true,
			isPrimary = true,
			damagePct = y,
			bonusDamage = x,
			delay = aA,
			damageFlags = EOM_DAMAGE_FLAGS.SPLIT_DAMAGE,
			uniqueID = Z,
			sourceAbility = A,
		})
	end)
	if AbilityUpgrade:HasAbilityUpgrade(s, "vespera_upgrade_13") then
		self:CreateShrinkingSurroundBullets(as, az, x, aA, Z, A)
	end
	s:EmitSound("Hero_BountyHunter.Shuriken")
end
function r.prototype.CreateShrinkingSurroundBullets(self, aB, az, x, aA, Z, A)
	local s = self:GetCaster()
	local aC = self:config()
	local a0 = aC.distance
	local a1 = aC.width
	local a2 = aC.outDuration
	local a4 = aC.damagePerDistance
	local a6 = s:GetAbsOrigin()
	self:StartThink(aA + a2, nil, function()
		local aD = shallowcopy(self.surikenHoverData[Z])
		e(self.surikenHoverData, Z)
		local aE = 0
		local aF = GameRules:GetGameTime()
		local aG = Bullet:CreateTrackingBullet({
			spawnOrigin = a6,
			moveSpeed = CalcDistance(a6, s:GetAbsOrigin()) / aA,
			target = s,
			thinker = true,
			OnBulletThink = function(ab, aa)
				if IsValid(s) then
					local aH = GameRules:GetGameTime() - aF
					local aI = aA - aH
					if aI > 0 then
						aa.moveSpeed = CalcDistance(ab, s:GetAbsOrigin()) / aI
					end
				end
			end,
		})
		local aJ = Bullet
		local aK = Bullet.CreateGroupSurroundBullet
		local aL = aB
		local aM = s
		local aN
		if aG ~= nil then
			aN = Bullet:GetData(aG, "__thinker")
		else
			aN = nil
		end
		aK(aJ, aL, {
			caster = aM,
			followEntity = aN,
			ability = self,
			group = DoUniqueString("vespera_upgrade_13"),
			circleRadius = a0,
			angularVelocity = az,
			offset = 128,
			track = false,
			lifeTime = aA,
			radius = a1,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			OnBulletCreated = function(aa)
				local aO = aD[aE + 1]
				if aO ~= nil then
					aa.__position = aO.position
					aa.circleRadius = aO.radius
					aa.angle = aO.angle
					Bullet:SaveData(aa.__projIndex, "InitRadius", aO.radius)
				end
				aE = aE + 1
			end,
			OnBulletThink = function(ab, aa)
				aa.circleRadius = aa.circleRadius - Bullet:GetData(aa.__projIndex, "InitRadius", a0) / aA * FrameTime()
			end,
			ParticleCreator = function(aa)
				local O = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_linear.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControlEnt(
					O,
					0,
					aa.__thinker,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					aa.__thinker:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(O, 7, s.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
				ParticleManager:SetParticleControl(O, 60, Weapon:GetWeaponColor(s, Vector(99, 75, 255)))
				ParticleManager:SetParticleControl(O, 10, Vector(a1, 0, 0))
				return O
			end,
			OnBulletHit = function(v, w, a8)
				if v == s then
					return
				end
				local a6 = s:GetAttachmentPosition("attach_hitloc")
				local a9 = CalcDistance(a6, w) * a4
				self:CreateHitEffect({
					target = v,
					location = w,
					bonusDamage = x,
					damagePct = 100 + a9,
					damageFlags = EOM_DAMAGE_FLAGS.RING_DAMAGE,
					sourceAbility = A,
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
			funcCondition = function(ay, aj)
				return aj:GetAutoCastState()
			end,
		}),
	},
	r
)
local aP = c()
aP.name = "modifier_vespera_1_debuff"
d(aP, l)
function aP.prototype.OnCreated(self, ac)
	if IsServer() then
	else
		local aQ = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_debuff.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		self:AddParticle(aQ, false, false, -1, false, false)
	end
end
function aP.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function aP.prototype.GetModifierMoveSpeedBonus_Constant(self)
	return -self:GetAbilitySpecialValueFor("reduce_move_speed")
end
aP = f(
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
	aP
)
local aR = c()
aR.name = "modifier_vespera_1_vulnerability"
d(aR, l)
function aR.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.vulnerabilityData = {}
end
function aR.prototype.OnCreated(self, ac)
	if IsServer() then
		self:StartIntervalThink(0.2)
	end
end
function aR.prototype.AddStackForPlayer(self, aS, aT, P)
	if not IsServer() or aT <= 0 or P <= 0 then
		return
	end
	local aU = GameRules:GetGameTime()
	self:RemoveExpiredStacks(aS, aU)
	local aV, aW = self.vulnerabilityData, aS
	if aV[aW] == nil then
		aV[aW] = { expireTimes = {} }
	end
	local aX = self.vulnerabilityData[aS]
	local aY = aX.expireTimes
	aY[#aY + 1] = aU + aT
	g(aX.expireTimes, function(ay, aZ, a_)
		return aZ - a_
	end)
	while #aX.expireTimes > P do
		h(aX.expireTimes, 0, 1)
	end
	self:UpdateDisplayStackCount()
end
function aR.prototype.GetStackCountForPlayer(self, aS)
	if not IsServer() then
		return 0
	end
	self:RemoveExpiredStacks(aS, GameRules:GetGameTime())
	self:UpdateDisplayStackCount()
	local b0 = self.vulnerabilityData[aS]
	return b0 and #b0.expireTimes or 0
end
function aR.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local aU = GameRules:GetGameTime()
	for aS in pairs(self.vulnerabilityData) do
		self:RemoveExpiredStacks(aS, aU)
	end
	self:UpdateDisplayStackCount()
	if #i(self.vulnerabilityData) <= 0 then
		self:Destroy()
	end
end
function aR.prototype.RemoveExpiredStacks(self, aS, aU)
	local aX = self.vulnerabilityData[aS]
	if aX == nil then
		return
	end
	do
		local an = #aX.expireTimes - 1
		while an >= 0 do
			if aX.expireTimes[an + 1] <= aU then
				h(aX.expireTimes, an, 1)
			end
			an = an - 1
		end
	end
	if #aX.expireTimes <= 0 then
		e(self.vulnerabilityData, aS)
	end
end
function aR.prototype.UpdateDisplayStackCount(self)
	local b1 = 0
	for b2, aX in pairs(self.vulnerabilityData) do
		b1 = b1 + #aX.expireTimes
	end
	self:SetStackCount(b1)
end
aR = f(
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
	aR
)
return j