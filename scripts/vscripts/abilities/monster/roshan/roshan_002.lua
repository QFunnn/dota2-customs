--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local CAST_POINT = 0.9
local CAST_DURATION = 6
local MAX_THINK_COUNT = 4
local SEARCH_RANGE = 2500
local ROAR_RADIUS = 500
local ROAR_KNOCKBACK_DISTANCE = 400
local DAMAGE_RATE = 28
local IMPACT_RADIUS = 180
local STUN_DURATION = 1
local ROCK_SPEED = 1000
local ROAR_PARTICLE = "particles/units/heroes/hero_beastmaster/beastmaster_primal_roar.vpcf"
local ROCK_ARC_PARTICLE = "particles/primal_beast_rock_throw_arc.vpcf"
local ROCK_IMPACT_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
local ATTACK_LANDED_PARTICLE = "particles/sandking_epicenter.vpcf"
____exports.roshan_002 = __TS__Class()
local roshan_002 = ____exports.roshan_002
roshan_002.name = "roshan_002"
__TS__ClassExtends(roshan_002, MonsterAbility_CS)
function roshan_002.prototype.Precache(self, context)
	PrecacheResource("particle", ROAR_PARTICLE, context)
	PrecacheResource("particle", ROCK_ARC_PARTICLE, context)
	PrecacheResource("particle", ROCK_IMPACT_PARTICLE, context)
	PrecacheResource("particle", ATTACK_LANDED_PARTICLE, context)
end
function roshan_002.prototype.GetCooldown(self, _level)
	return 5
end
function roshan_002.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:AddNewModifier(caster, self, "mo_mian_modfier", { duration = CAST_DURATION + 0.5 })
			caster:AddNewModifier(caster, self, "modifier_roshan_002_slow_attack", { duration = CAST_DURATION })
		end,
		OnStart = function()
			local caster = self:GetCaster()
			self:PlayRoarEffect(caster)
			EmitSoundOn("Hero_PrimalBeast.Onslaught.Channel", caster)
			local pxf_name = "particles/units/heroes/hero_beastmaster/beastmaster_primal_roar.vpcf"
			local roarPfx = ParticleManager:CreateParticle(pxf_name, PATTACH_CENTER_FOLLOW, caster)
			ParticleManager:SetParticleControlEnt(
				roarPfx,
				0,
				caster,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				Vector(0, 0, 0),
				true
			)
			ParticleManager:SetParticleControl(roarPfx, 1, caster:GetOrigin())
			self:Timer(0.1, function()
				return self:KnockBackEnemies(caster)
			end)
			self:Timer(0.4, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:AddNewModifier(caster, self, "modifier_roshan_002_thinker", { duration = CAST_DURATION })
			end)
		end,
	}
end
function roshan_002.prototype.OnProjectileHit_ExtraData(self, target, _location, extraData)
	if not target or not extraData.dummy then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return true
	end
	local dummy = EntIndexToHScript(extraData.dummy)
	if not IsValid(nil, dummy) then
		return true
	end
	if not IsValidAlive(nil, dummy) then
		return true
	end
	local impactPosition = dummy:GetAbsOrigin()
	ScreenShake(impactPosition, 4, 2, 2, 3000, 0, true)
	GridNav:DestroyTreesAroundPoint(impactPosition, 300, false)
	dummy:EmitSound("Hero_PrimalBeast.RockThrow.Impact")
	local effect = ParticleManager:CreateParticle(ROCK_IMPACT_PARTICLE, PATTACH_CENTER_FOLLOW, caster)
	ParticleManager:SetParticleControl(effect, 3, impactPosition)
	ParticleManager:ReleaseParticleIndex(effect)
	local enemies = self:FindHeroesInRadius(IMPACT_RADIUS, impactPosition)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue16
			end
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
			enemy:EmitSound("Hero_PrimalBeast.RockThrow.Stun")
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
		end
		::__continue16::
	end
	dummy:RemoveSelf()
	return true
end
function roshan_002.prototype.PlayRoarEffect(self, caster)
	local roar = ParticleManager:CreateParticle(ROAR_PARTICLE, PATTACH_CENTER_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(roar, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
	ParticleManager:SetParticleControl(roar, 1, caster:GetOrigin())
	local released = false
	local function releaseRoar()
		if not IsServer() or released then
			return
		end
		released = true
		ParticleManager:DestroyParticle(roar, false)
		ParticleManager:ReleaseParticleIndex(roar)
	end
	self:Timer(2.5, function()
		return releaseRoar(nil)
	end)
end
function roshan_002.prototype.KnockBackEnemies(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		ROAR_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		FIND_ANY_ORDER,
		false
	)
	for ____, target in ipairs(enemies) do
		do
			if not IsValidAlive(nil, target) then
				goto __continue25
			end
			target:KnockBack(caster, self, {
				duration = 0.5,
				origin_pos = origin,
				stun = true,
				stunDuration = 0.8,
				distance = ROAR_KNOCKBACK_DISTANCE,
				height = 1,
			})
		end
		::__continue25::
	end
end
roshan_002 = __TS__DecorateLegacy({ registerAbility(nil) }, roshan_002)
____exports.roshan_002 = roshan_002
local modifier_roshan_002_thinker = __TS__Class()
modifier_roshan_002_thinker.name = "modifier_roshan_002_thinker"
__TS__ClassExtends(modifier_roshan_002_thinker, BaseModifier_CS)
function modifier_roshan_002_thinker.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.count = 0
end
function modifier_roshan_002_thinker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1.6)
	self:OnIntervalThink()
end
function modifier_roshan_002_thinker.prototype.OnIntervalThink(self)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	self.count = self.count + 1
	if self.count >= MAX_THINK_COUNT then
		self:StartIntervalThink(-1)
		return
	end
	local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, 1, 2)
	end
	self:StartRock(self.count)
end
function modifier_roshan_002_thinker.prototype.StartRock(self, round)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
	self:Timer(0.95, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local forward = caster:GetForwardVector()
		local nearestEnemy = caster:GetMinDistanceUnit(SEARCH_RANGE)
		local ____math_max_1 = math.max
		local ____IsValidAlive_result_0
		if IsValidAlive(nil, nearestEnemy) then
			____IsValidAlive_result_0 = nearestEnemy:GetAbsOrigin():__sub(caster:GetAbsOrigin()):Length2D()
		else
			____IsValidAlive_result_0 = 800
		end
		local distance = ____math_max_1(700, ____IsValidAlive_result_0)
		local centerPos = caster:GetOrigin():__add(forward:__mul(distance))
		local impactPositions = GetRandomPointsInCircle(nil, centerPos, 600, 3, 200)
		local dummies = {}
		for ____, impactPosition in ipairs(impactPositions) do
			local targetPos = impactPosition
			local travelDuration = targetPos:__sub(caster:GetOrigin()):Length2D() / ROCK_SPEED
			local dummy = CreateModifierThinker(
				caster,
				ability,
				"modifier_roshan_002_rock_preview",
				{ duration = travelDuration },
				targetPos,
				caster:GetTeamNumber(),
				false
			)
			if IsValidAlive(nil, dummy) then
				dummy:SetOrigin(dummy:GetOrigin():__add(Vector(0, 0, 90)))
				dummies[#dummies + 1] = dummy
			end
		end
		for ____, dummy in ipairs(dummies) do
			do
				local currentDummy = dummy
				if not IsValidAlive(nil, currentDummy) then
					goto __continue41
				end
				ProjectileManager:CreateTrackingProjectile({
					Target = currentDummy,
					Source = caster,
					Ability = ability,
					EffectName = ROCK_ARC_PARTICLE,
					iMoveSpeed = ROCK_SPEED,
					bDodgeable = false,
					bVisibleToEnemies = true,
					ExtraData = { dummy = currentDummy:entindex() },
				})
			end
			::__continue41::
		end
	end)
	self:Timer(1.05, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-50)), 0.3)
		local forward = caster:GetForwardVector()
		local nearestEnemy = caster:GetMinDistanceUnit(SEARCH_RANGE)
		local ____math_max_3 = math.max
		local ____IsValidAlive_result_2
		if IsValidAlive(nil, nearestEnemy) then
			____IsValidAlive_result_2 = nearestEnemy:GetAbsOrigin():__sub(caster:GetAbsOrigin()):Length2D()
		else
			____IsValidAlive_result_2 = 800
		end
		local distance = ____math_max_3(700, ____IsValidAlive_result_2)
		local centerPos = caster:GetOrigin():__add(forward:__mul(distance))
		local impactPositions = GetRandomPointsInCircle(nil, centerPos, 600, 3, 200)
		local dummies = {}
		for ____, impactPosition in ipairs(impactPositions) do
			local targetPos = impactPosition
			local travelDuration = targetPos:__sub(caster:GetOrigin()):Length2D() / ROCK_SPEED
			local dummy = CreateModifierThinker(
				caster,
				ability,
				"modifier_roshan_002_rock_preview",
				{ duration = travelDuration },
				targetPos,
				caster:GetTeamNumber(),
				false
			)
			if IsValidAlive(nil, dummy) then
				dummy:SetOrigin(dummy:GetOrigin():__add(Vector(0, 0, 90)))
				dummies[#dummies + 1] = dummy
			end
		end
		for ____, dummy in ipairs(dummies) do
			do
				local currentDummy = dummy
				if not IsValidAlive(nil, currentDummy) then
					goto __continue49
				end
				ProjectileManager:CreateTrackingProjectile({
					Target = currentDummy,
					Source = caster,
					Ability = ability,
					EffectName = ROCK_ARC_PARTICLE,
					iMoveSpeed = ROCK_SPEED,
					bDodgeable = false,
					bVisibleToEnemies = true,
					ExtraData = { dummy = currentDummy:entindex() },
				})
			end
			::__continue49::
		end
	end)
end
modifier_roshan_002_thinker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_roshan_002_thinker)
local modifier_roshan_002_rock_preview = __TS__Class()
modifier_roshan_002_rock_preview.name = "modifier_roshan_002_rock_preview"
__TS__ClassExtends(modifier_roshan_002_rock_preview, BaseModifier_CS)
function modifier_roshan_002_rock_preview.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	WarningRing(nil, caster, parent:GetOrigin(), 300, params.duration)
end
modifier_roshan_002_rock_preview = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_roshan_002_rock_preview)
local modifier_roshan_002_slow_attack = __TS__Class()
modifier_roshan_002_slow_attack.name = "modifier_roshan_002_slow_attack"
__TS__ClassExtends(modifier_roshan_002_slow_attack, BaseModifier_CS)
function modifier_roshan_002_slow_attack.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_EVENT_ON_ATTACK_LANDED }
end
function modifier_roshan_002_slow_attack.prototype.OnAttackLanded(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local effect = ParticleManager:CreateParticle(ATTACK_LANDED_PARTICLE, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 1, Vector(1000, 1, 1))
	ParticleManager:ReleaseParticleIndex(effect)
end
function modifier_roshan_002_slow_attack.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return -70
end
function modifier_roshan_002_slow_attack.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:Mover(parent:GetAbsOrigin():__add(parent:GetForwardVector():__mul(100)), 0.1)
end
modifier_roshan_002_slow_attack = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_roshan_002_slow_attack)
return ____exports