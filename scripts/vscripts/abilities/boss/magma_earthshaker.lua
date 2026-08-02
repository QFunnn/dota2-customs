--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/magma_earthshaker"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__ArraySome
local h = b.__TS__ArrayFind
local i = {}
local j = require("modifiers.eom_modifier.eom_modifier")
local k = j.EOMModifier
local l = j.EOMModifierMotionHorizontal
local m = j.registerEOMModifier
local n = require("abilities.eom_ability")
local o = n.AbilityValue
local p = n.EOMAbility
local q = n.registerEOMAbility
local r = c()
r.name = "magma_earthshaker_1"
d(r, p)
function r.prototype.OnSpellStart(self)
	local s = self:GetCaster()
	local t = self:GetCursorPosition()
	local u = CalcDirection(t, s:GetAbsOrigin())
	local v = CalcDistance(t, s:GetAbsOrigin())
	local w = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, s)
	ParticleManager:SetParticleControl(w, 0, t)
	ParticleManager:SetParticleControl(w, 1, t)
	ParticleManager:SetParticleControl(w, 2, Vector(self.radius, 1.1, 0))
	s:StartGesture(ACT_SCRIPT_CUSTOM_5)
	s:Dash(u, v, 400, 1.06, function()
		ParticleManager:DestroyParticle(w, true)
		if not IsValid(s) or not s:IsAlive() then
			return
		end
		s:EmitSound("Hero_EarthShaker.Totem")
		local x = ParticleManager:CreateParticle(
			"particles/econ/items/earthshaker/deep_magma/deep_magma_default/deep_magma_default_aftershock.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(x, 0, t)
		ParticleManager:SetParticleControl(x, 1, Vector(self.radius, self.radius, self.radius))
		ParticleManager:ReleaseParticleIndex(x)
		self:DelayShock(t)
	end)
	s:SimulateCast({ duration = 1.51 })
end
function r.prototype.DelayShock(self, t)
	local s = self:GetCaster()
	local y = self:GetSpecialValueFor("damage")
	local z = self:GetSpecialValueFor("stun_duration")
	local A = FindEnemiesInRadius(s, t, self.radius)
	for B, C in ipairs(A) do
		s:DealDamage(C, self, y)
		C:Stun(s, self, z)
	end
	self:CreateTotem(t)
end
function r.prototype.CreateTotem(self, t)
	local s = self:GetCaster()
	local D = s:FindModifierByName(self:GetIntrinsicModifierName())
	if D ~= nil then
		D:CreateTotem(t + s:GetForwardVector() * 150)
	end
end
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_magma_earthshaker_1"
end
e({ o(nil) }, r.prototype, "radius", nil)
r = e({ q(nil, {}) }, r)
local E = c()
E.name = "modifier_magma_earthshaker_1"
d(E, k)
function E.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.totemList = {}
	self.treeList = {}
	self.isDestroyingTotems = false
end
function E.prototype.CreateTotem(self, t)
	local F = self:GetParent()
	local G = self:GetAbility()
	local H = F:SummonUnit("enemy_earthshaker_2_1", t)
	if IsValid(H) then
		H:AddNewModifier(
			F,
			G,
			"modifier_magma_earthshaker_1_thinker",
			{ duration = self:GetAbilitySpecialValueFor("totem_duration") }
		)
		H:SetAbsAngles(180, VectorToAngles(F:GetForwardVector()).y, 0)
		H:EmitSound("Hero_EarthSpirit.StoneRemnant.Impact")
		local I = self.totemList
		I[#I + 1] = H
	end
end
function E.prototype.RemoveTotem(self, J)
	if self.isDestroyingTotems then
		return
	end
	ArrayRemove(self.totemList, J)
	self:GetParent():EmitSound("Hero_EarthSpirit.StoneRemnant.Destroy", J:GetAbsOrigin())
	if IsValid(J) then
		J:SafeRemoveUnit()
	end
end
function E.prototype.IsValidTotemPosition(self, t)
	if not GridNav:IsTraversable(t) or GridNav:IsBlocked(t) then
		return false
	end
	do
		local B = 0
		while B < #self.totemList do
			local J = self.totemList[B + 1]
			if IsValid(J) and CalcDistance(J, t) < 100 then
				return false
			end
			B = B + 1
		end
	end
	return true
end
function E.prototype.TryKnockBackTotem(self, K, L, s, G, M)
	if not K:IsFriendly(s) or K:GetUnitName() ~= "enemy_earthshaker_2_1" or f(L, K) then
		return false
	end
	L[#L + 1] = K
	local N = K:GetAbsOrigin()
	local O = RandomVector(1)
	local v = RandomInt(100, 200)
	local P = N + O * v
	K:KnockBack(O, v, 500, M.delay)
	local w = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(w, 0, P)
	ParticleManager:SetParticleControl(w, 1, P)
	ParticleManager:SetParticleControl(w, 2, Vector(M.radius, M.delay, 0))
	K:GameTimer(M.delay, function()
		local Q = ParticleManager:CreateParticle(
			"particles/econ/items/earthshaker/deep_magma/deep_magma_10th/deep_magma_10th_aftershock.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(Q, 0, P)
		ParticleManager:SetParticleControl(Q, 1, Vector(M.radius, 0, 0))
		local A = FindEnemiesInRadius(s, P, M.radius)
		for B, C in ipairs(A) do
			s:DealDamage(C, G, M.damage)
		end
		s:EmitSound("Hero_EarthShaker.Totem.Attack", P)
		self:RemoveTotem(K)
	end)
	return true
end
function E.prototype.WarningFissureLine(self, N, P, R)
	local S = self:GetAbility()
	if S ~= nil then
		S:LineWarning(N, P, self:GetAbilitySpecialValueFor("fissure_width"), R)
	end
end
function E.prototype.ApplyFissureLine(self, s, G, N, P, L)
	local T = self:GetAbilitySpecialValueFor("fissure_width")
	local U = self:GetAbilitySpecialValueFor("fissure_damage")
	local V = self:GetAbilitySpecialValueFor("fissure_totem_delay")
	local W = self:GetAbilitySpecialValueFor("fissure_totem_radius")
	local X = self:GetAbilitySpecialValueFor("fissure_totem_damage")
	local Y = self:GetAbilitySpecialValueFor("fissure_limit_totem")
	local w = ParticleManager:CreateParticle(
		"particles/econ/items/earthshaker/deep_magma/deep_magma_10th/deep_magma_10th_fissure.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(w, 0, N)
	ParticleManager:SetParticleControl(w, 1, P)
	ParticleManager:SetParticleControl(w, 2, Vector(1, 0, 0))
	local Z = N + CalcDirection2D(P, N) * T
	local A = FindUnitsInLine(
		s:GetTeamNumber(),
		Z,
		P,
		nil,
		T,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE
	)
	for _, K in ipairs(A) do
		if K:IsFriendly(s) then
			self:TryKnockBackTotem(K, L, s, G, { delay = V, radius = W, damage = X, limitTotem = Y })
		else
			s:DealDamage(K, G, U)
			K:KnockBack(vec3_zero, 0, 150, 0.5)
		end
	end
end
function E.prototype.OnDestroy(self)
	if IsServer() then
		self.isDestroyingTotems = true
		local a0 = self.totemList
		self.totemList = {}
		for B, J in ipairs(a0) do
			if IsValid(J) then
				J:SafeRemoveUnit()
			end
		end
		for B, a1 in ipairs(self.treeList) do
			if IsValid(a1) then
				a1:RemoveSelf()
			end
		end
		self.treeList = {}
		self.isDestroyingTotems = false
	end
end
function E.prototype.EachBlock(self, a2)
	for B, a1 in ipairs(self.treeList) do
		if IsValid(a1) then
			a2(nil, a1:GetAbsOrigin())
		end
	end
end
E = e(
	{
		m(
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
	E
)
local a3 = c()
a3.name = "modifier_magma_earthshaker_1_thinker"
d(a3, k)
function a3.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function a3.prototype.OnCreated(self, a4)
	if not IsServer() then
		return
	end
	local F = self:GetParent()
	local w = ParticleManager:CreateParticle(
		"particles/units/boss/boss_earth_shaker/stoneremnant.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		F
	)
	ParticleManager:SetParticleControlEnt(w, 1, F, PATTACH_ABSORIGIN_FOLLOW, nil, F:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(w, 2, F, PATTACH_ABSORIGIN_FOLLOW, nil, F:GetAbsOrigin(), true)
	self:AddParticle(w, false, false, -1, false, false)
end
function a3.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local s = self:GetCaster()
	if not IsValid(s) then
		return
	end
	local a5 = s:FindModifierByName("modifier_magma_earthshaker_1")
	local F = self:GetParent()
	if IsValid(a5) then
		a5:RemoveTotem(F)
	end
end
function a3.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function a3.prototype.DeclareFunctions(self)
	return {}
end
function a3.prototype.GetVisualZDelta(self)
	return 100
end
a3 = e(
	{
		m(
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
	a3
)
local a6 = c()
a6.name = "magma_earthshaker_2"
d(a6, p)
function a6.prototype.____constructor(self, ...)
	p.prototype.____constructor(self, ...)
	self.direction = vec3_bottom
end
function a6.prototype.GetLinearStartWidth(self)
	return self.width or 0
end
function a6.prototype.OnAbilityPhaseStart(self)
	self.left = false
	local s = self:GetCaster()
	local a7 = self:GetCursorPosition()
	if a7 == nil then
		return false
	end
	local a8 = self:GetCastRange(vec3_invalid, nil)
	local A = FindEnemiesInRadius(s, a7, a8)
	local C = GetRandomElement(A)
	if C == nil then
		return false
	end
	local a9 = s:GetAbsOrigin()
	local aa = CalcDirection2D(C, a9)
	if self.modifier_magma_earthshaker_1 == nil then
		self.modifier_magma_earthshaker_1 = s:FindModifierByName("modifier_magma_earthshaker_1")
		if self.modifier_magma_earthshaker_1 == nil then
			return false
		end
	end
	local a0 = self.modifier_magma_earthshaker_1.totemList or {}
	local ab = g(a0, function(_, ac)
		local ad = ac:GetAbsOrigin()
		if CalcDistance(ac, a9) > 500 then
			return false
		end
		if ac:IsCurrentlyVerticalMotionControlled() or ac:IsCurrentlyHorizontalMotionControlled() then
			return false
		end
		local ae = ad - a9
		ae.z = 0
		local af = AngleDiff(VectorToAngles(aa).y, VectorToAngles(ae).y)
		if math.abs(af) > 150 then
			return false
		end
		if af < 0 then
			self.left = true
		end
		self.totem = ac
		local ag = self.totem:FindModifierByName("modifier_magma_earthshaker_1_thinker")
		if ag ~= nil then
			ag:SetDuration(2, true)
		end
		return true
	end)
	if not ab then
		return false
	end
	if self.totem == nil then
		return false
	end
	local v = self:GetCastRange(vec3_zero, nil)
	local u = CalcDirection2D(C, self.totem)
	local ah = self:GetSpecialValueFor("width")
	self:LineWarning(self.totem:GetAbsOrigin(), self.totem:GetAbsOrigin() + u * v, ah, self:GetCastPoint())
	self.direction = u
	self:GetCaster():ClearActivityModifiers()
	print(self.left)
	if self.left then
		s:AddActivityModifier_Engine("left")
	else
		s:AddActivityModifier_Engine("right")
	end
	return true
end
function a6.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles(true)
end
function a6.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local s = self:GetCaster()
	local v = self:GetCastRange(vec3_zero, nil)
	local ai = self:GetSpecialValueFor("move_duration")
	if IsValid(self.totem) then
		self.totem:AddNewModifier(
			s,
			self,
			"magma_earthshaker_2_totem_motion",
			{ direction = VectorToString(self.direction), speed = v / ai, duration = ai }
		)
	end
	s:EmitSound("Hero_EarthShaker.Totem.Attack")
end
e({ o(nil) }, a6.prototype, "width", nil)
a6 = e({ q(nil, {}) }, a6)
i.magma_earthshaker_2_totem_motion = c()
local aj = i.magma_earthshaker_2_totem_motion
aj.name = "magma_earthshaker_2_totem_motion"
d(aj, l)
function aj.prototype.GetAbilitySpecialValue(self)
	self.width = self:GetAbilitySpecialValueFor("width")
	self.bounce = self:GetAbilitySpecialValueFor("bounce")
end
function aj.prototype.OnCreated(self, a4)
	local F = self:GetParent()
	if IsServer() then
		self.speed = a4.speed
		self.direction = StringToVector(a4.direction)
		local ak = self.caster
		self.modifier = ak and ak:FindModifierByName("modifier_magma_earthshaker_1")
		if not IsValid(self.modifier) then
			self:Destroy()
			return
		end
		local G = self:GetAbility()
		local y = self:GetAbilitySpecialValueFor("damage")
		self:ApplyHorizontalMotionController()
		self.bulletID = Bullet:CreateCustomBullet({
			caster = F,
			radius = self.width,
			ability = G,
			spawnOrigin = F:GetAbsOrigin(),
			PathFunction = function(t, al)
				return F:GetAbsOrigin()
			end,
			FuncUnitFinder = function(am, t, an, al)
				return Bullet:FindUnitInLine(
					al.__teamNumber,
					am,
					t,
					an,
					an,
					al.teamFilter,
					al.typeFilter,
					al.flagFilter
				)
			end,
			OnBulletHit = function(K, t, al)
				if IsValid(F) then
					F:DealDamage(K, G, y)
				end
			end,
		})
	else
		local w = ParticleManager:CreateParticle(
			"particles/econ/items/earthshaker/deep_magma/deep_magma_10th/deep_magma_10th_fissure_embers.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(w, false, false, -1, false, false)
	end
end
function aj.prototype.OnDestroy(self)
	if IsServer() then
		local F = self:GetParent()
		F:RemoveHorizontalMotionController(self)
		if self.bulletID ~= nil then
			Bullet:DestroyBulletByID(self.bulletID)
		end
		if IsValid(self.modifier) then
			self.modifier:RemoveTotem(F)
		end
	end
end
function aj.prototype.IsValidPosition(self, t)
	local J = h(self.modifier.totemList, function(_, ac)
		return ac ~= self.parent and CalcDistance(ac, t) < 100
	end)
	return GridNav:IsTraversable(t) and not GridNav:IsBlocked(t) and J == nil
end
function aj.prototype.GetReflection(self, ao)
	local ap = self:GetNormal(ao)
	return (self.direction - 2 * self.direction:Dot(-ap:Normalized()) * -ap:Normalized()):Normalized()
end
function aj.prototype.GetBlockPosition(self, aq)
	local ao = aq.vPosition
	while (ao - aq.vPrevious):Length2D() > 10 do
		ao = ao - self.direction * 10
		if self:IsValidPosition(ao) then
			break
		end
	end
	return ao
end
function aj.prototype.GetNormal(self, ao)
	local ap = vec3_zero
	local ar = 8
	local as = 32
	do
		local B = 1
		while B <= ar do
			local at = 360 / ar * B
			local au = ao + RotatePosition(vec3_zero, QAngle(0, at, 0), Vector(0, as, 0))
			if self:IsValidPosition(au) then
				ap = ap + RotatePosition(vec3_zero, QAngle(0, at, 0), Vector(0, as, 0))
				DebugDrawCircle(au, Vector(0, 155, 0), 50, as, true, 3)
			else
				DebugDrawCircle(au, Vector(155, 0, 0), 50, as, true, 3)
			end
			B = B + 1
		end
	end
	return ap:Normalized()
end
function aj.prototype.UpdateHorizontalMotion(self, F, av)
	if not IsServer() or not IsValid(F) then
		return
	end
	local aw = F:GetAbsOrigin() + self.direction * self.speed * av
	if not GridNav:IsValidPosition(aw) then
		self:Destroy()
	end
	F:SetAbsOrigin(aw)
end
function aj.prototype.OnHorizontalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
aj = e(
	{
		m(
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
	aj
)
i.magma_earthshaker_2_totem_motion = aj
local ax = c()
ax.name = "magma_earthshaker_3"
d(ax, p)
function ax.prototype.____constructor(self, ...)
	p.prototype.____constructor(self, ...)
	self.positionList = {}
end
function ax.prototype.GetLinearStartWidth(self)
	return self.fissure_width
end
function ax.prototype.OnAbilityPhaseStart(self)
	local s = self:GetCaster()
	local N = s:GetAbsOrigin()
	local v = self:GetCastRange(vec3_zero, nil)
	local af = 360 / self.count
	local ay = CalcDirection2D(self:GetCursorPosition(), N)
	self.positionList = {}
	do
		local B = 1
		while B <= self.count do
			local at = af * B + (B == 1 and 0 or RandomInt(-20, 20))
			local u = RotatePosition(vec3_zero, QAngle(0, at, 0), ay)
			local P = N + u * v
			local az = self.positionList
			az[#az + 1] = P
			self:LineWarning(N, P, self.fissure_width, self:GetCastPoint())
			B = B + 1
		end
	end
	return true
end
function ax.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles(true)
end
function ax.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local s = self:GetCaster()
	local N = s:GetAbsOrigin()
	local a5 = s:FindModifierByName("modifier_magma_earthshaker_1")
	if not IsValid(a5) then
		return
	end
	local a0 = a5.totemList
	local L = {}
	for B, P in ipairs(self.positionList) do
		a5:ApplyFissureLine(s, self, N, P, L)
	end
	local aA = a5:GetAbilitySpecialValueFor("fissure_limit_totem")
	for B, P in ipairs(self.positionList) do
		if #a0 < aA then
			a5:CreateTotem(VectorLerp(RandomFloat(0.2, 0.8), N, P))
		end
	end
	s:SimulateCast({ duration = 3 })
	s:EmitSound("Hero_EarthShaker.Fissure.Cast")
end
e({ o(nil) }, ax.prototype, "fissure_width", nil)
e({ o(nil) }, ax.prototype, "count", nil)
ax = e({ q(nil, {}) }, ax)
local aB = c()
aB.name = "magma_earthshaker_4"
d(aB, p)
function aB.prototype.OnSpellStart(self)
	self:StartThink(1, "channel", function()
		local s = self:GetCaster()
		local a9 = s:GetAbsOrigin()
		local an = self:GetSpecialValueFor("radius")
		local y = self:GetSpecialValueFor("damage")
		local aC = {}
		Bullet:SplitAction(RandomVector(1), 6, 360 / 6, function(_, u, aD)
			local t = a9 + u * RandomInt(200, 1200)
			aC[#aC + 1] = t
			self:CircleWarning(t, an, 1)
			local w = ParticleManager:CreateParticle(
				"particles/units/boss/boss_earth_shaker/meteor.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(w, 0, t + Vector(0, 0, 2000))
			ParticleManager:SetParticleControl(w, 1, t)
			ParticleManager:SetParticleControl(w, 2, Vector(1, 0, 0))
			ParticleManager:ReleaseParticleIndex(w)
		end)
		self:StartThink(1, DoUniqueString("1"), function()
			for _, t in ipairs(aC) do
				local A = FindEnemiesInRadius(s, t, an)
				for _, C in ipairs(A) do
					s:DealDamage(C, nil, y)
				end
			end
			s:EmitSound("DOTA_Item.MeteorHammer.Impact")
			return -1
		end)
		return 0.5
	end)
end
function aB.prototype.OnChannelFinish(self, aE)
	self:StartThink(-1, "channel")
end
aB = e({ q(nil, {}) }, aB)
local aF = c()
aF.name = "magma_earthshaker_5"
d(aF, p)
function aF.prototype.OnAbilityPhaseStart(self)
	local s = self:GetCaster()
	local w = ParticleManager:CreateParticle(
		"particles/econ/items/earth_spirit/earth_spirit_ti6_boulder/espirit_ti6_rollingboulder.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		s
	)
	self:AddWarningParticle(w)
	s:EmitSound("Hero_EarthSpirit.RollingBoulder.Cast")
	return true
end
function aF.prototype.OnSpellStart(self)
	local s = self:GetCaster()
	local C = self:GetCursorTarget()
	if IsValid(C) then
		s:SimulateCast({ duration = 1.7 })
		s:AddNewModifier(s, self, "magma_magma_earthshaker_5_motion", { duration = 1.7, entIndex = C:entindex() })
	end
end
aF = e({ q(nil, {}) }, aF)
i.magma_magma_earthshaker_5_motion = c()
local aG = i.magma_magma_earthshaker_5_motion
aG.name = "magma_magma_earthshaker_5_motion"
d(aG, l)
function aG.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.stun = false
end
function aG.prototype.OnCreated(self, a4)
	local F = self:GetParent()
	if IsServer() then
		EmitSoundOn("Hero_EarthSpirit.RollingBoulder.Loop", F)
		local C = EntIndexToHScript(a4.entIndex)
		local G = self:GetAbility()
		local y = self:GetAbilitySpecialValueFor("damage")
		if not self:ApplyHorizontalMotionController() then
			self:Destroy()
			return
		end
		self.bulletID = Bullet:CreateGuidedBullet({
			spawnOrigin = F:GetAbsOrigin(),
			moveSpeed = 100,
			target = C,
			caster = F,
			direction = F:GetForwardVector(),
			bounce = 100,
			bounceOnHole = true,
			debug = true,
			radius = 150,
			lifeTime = self:GetDuration(),
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			angularVelocity = 60,
			OnBulletThink = function(t, al)
				al.moveSpeed = al.moveSpeed + 50
			end,
			OnBulletHit = function(K, t, al)
				if IsValid(K) and al.moveSpeed >= 350 then
					F:DealDamage(K, G, y)
				end
			end,
			OnBulletBounceEnd = function(al)
				if al.moveSpeed > 2000 then
					self.stun = true
					self:Destroy()
					F:AddNewModifier(F, G, "modifier_stunned", { duration = 3 })
					F:SimulateCast({ duration = 3 })
				end
			end,
		})
	end
end
function aG.prototype.OnDestroy(self)
	if IsServer() then
		local F = self:GetParent()
		F:StopSound("Hero_EarthSpirit.RollingBoulder.Loop")
		F:RemoveHorizontalMotionController(self)
		if self.bulletID ~= nil then
			Bullet:DestroyBulletByID(self.bulletID)
		end
		F:EmitSound("Hero_ErthSpirit.RollingBoulder.Destroy", F:GetAbsOrigin())
		if not self.stun then
			local aH = F:GetForwardVector()
			F:Dash(aH, 200, 0, 0.6)
		end
		local aI = self:GetAbility()
		if aI ~= nil then
			aI:DestroyWarningParticles()
		end
	end
end
function aG.prototype.UpdateHorizontalMotion(self, F, av)
	if not IsServer() or not IsValid(F) then
		return
	end
	if self.bulletID ~= nil then
		local al = Bullet:GetBulletData(self.bulletID)
		if al ~= nil and al.__position ~= nil then
			F:SetAbsOrigin(al.__position)
			F:SetLocalAngles(0, VectorToAngles(al.__velocity:Normalized()).y, 0)
		end
	end
end
function aG.prototype.OnHorizontalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
aG = e(
	{
		m(
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
	aG
)
i.magma_magma_earthshaker_5_motion = aG
local aJ = c()
aJ.name = "magma_earthshaker_6"
d(aJ, p)
function aJ.prototype.GetCastRange(self, aK, C)
	return self:GetCaster():Script_GetAttackRange()
end
function aJ.prototype.OnAbilityPhaseStart(self)
	local s = self:GetCaster()
	local t = self:GetCursorPosition()
	local u = CalcDirection2D(t, s)
	self:SectorWarning(s:GetAbsOrigin(), u, s:Script_GetAttackRange(), 120, self:GetCastPoint())
	return true
end
function aJ.prototype.OnSpellStart(self)
	local s = self:GetCaster()
	local N = s:GetAbsOrigin()
	local t = self:GetCursorPosition()
	local u = CalcDirection2D(t, s)
	local y = self:GetSpecialValueFor("damage")
	local A = FindEnemiesInSector(s, N, s:Script_GetAttackRange(), u, 120)
	s:Dash(u, 100, 0, 0.06, function(t)
		s:PushOff(t)
	end)
	s:DealDamage(A, nil, y)
	s:SimulateCast({
		castPoint = 0.4,
		castAnimation = ACT_SCRIPT_CUSTOM_11,
		OnFinish = function()
			s:FadeGesture(ACT_SCRIPT_CUSTOM_11)
			self:AttackCombo2()
		end,
	})
	s:EmitSound("Hero_EarthShaker.Totem.Attack")
end
function aJ.prototype.AttackCombo2(self)
	local s = self:GetCaster()
	local N = s:GetAbsOrigin()
	local y = self:GetSpecialValueFor("damage")
	local u = s:GetForwardVector()
	self:SectorWarning(s:GetAbsOrigin(), u, s:Script_GetAttackRange(), 120, 0.47)
	s:SimulateCast({
		castPoint = 0.4,
		castAnimation = ACT_SCRIPT_CUSTOM_2,
		duration = 0.8,
		OnSpellStart = function()
			s:Dash(u, 100, 0, 0.06, function(t)
				s:PushOff(t)
			end)
			local A = FindEnemiesInSector(s, N, s:Script_GetAttackRange(), u, 120)
			s:DealDamage(A, nil, y)
			s:EmitSound("Hero_EarthShaker.Totem.Attack")
		end,
		OnFinish = function()
			self:AttackCombo3()
		end,
	})
end
function aJ.prototype.AttackCombo3(self)
	local s = self:GetCaster()
	local u = s:GetForwardVector()
	local N = s:GetAbsOrigin()
	local v = s:Script_GetAttackRange() * 2
	local P = N + u * v
	local a5 = s:FindModifierByName("modifier_magma_earthshaker_1")
	if not IsValid(a5) then
		return
	end
	local ah = a5:GetAbilitySpecialValueFor("fissure_width")
	local A = FindEnemiesInRadius(s, N, v, FIND_CLOSEST)
	local C = A[1]
	if IsValid(C) then
		self:LockFacingTarget(C, 60, 0.6)
		local H = self:FacingSupport(P, C, 60, v, 0.6)
		self:LineWarning(N, H, ah, 0.6)
	else
		self:LineWarning(N, P, ah, 0.6)
	end
	s:SimulateCast({
		castPoint = 0.6,
		duration = 1.6,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationRate = 1.2,
		OnSpellStart = function()
			local L = {}
			local u = AnglesToVector(s:GetLocalAngles())
			local aL = N + u * v
			a5:ApplyFissureLine(s, self, N, aL, L)
			s:EmitSound("Hero_EarthShaker.Fissure.Cast")
		end,
	})
end
aJ = e({ q(nil, {}) }, aJ)
local aM = c()
aM.name = "magma_earthshaker_7"
d(aM, p)
function aM.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.modifier_magma_earthshaker_1 = self:GetCaster():FindModifierByName("modifier_magma_earthshaker_1")
end
function aM.prototype.OnSpellStart(self)
	local s = self:GetCaster()
	if not IsValid(self.modifier_magma_earthshaker_1) then
		self.modifier_magma_earthshaker_1 = s:FindModifierByName("modifier_magma_earthshaker_1")
	end
	if not IsValid(self.modifier_magma_earthshaker_1) then
		return
	end
	local aN = self.modifier_magma_earthshaker_1:GetAbilitySpecialValueFor("fissure_limit_totem")
	local aO = aN - #self.modifier_magma_earthshaker_1.totemList
	do
		local B = 0
		while B < aO do
			local t = s:GetAbsOrigin() + RandomVector(RandomInt(100, 900))
			self.modifier_magma_earthshaker_1:CreateTotem(t)
			B = B + 1
		end
	end
	s:EmitSound("Hero_EarthSpirit.StoneRemnant.Impact")
end
aM = e(
	{
		q(nil, {
			funcCondition = function(_, G)
				local a5 = G:GetCaster():FindModifierByName("modifier_magma_earthshaker_1")
				if not IsValid(a5) then
					return false
				end
				return #a5.totemList < a5:GetAbilitySpecialValueFor("fissure_limit_totem")
			end,
		}),
	},
	aM
)
return i