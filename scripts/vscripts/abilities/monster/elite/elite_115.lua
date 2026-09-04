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
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_elite_115_static_link
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1000
local CAST_POINT = 1
local COOLDOWN = 44
local MANA_COST = 65
local LINK_DURATION = 10
local LINK_BREAK_DISTANCE = 850
local LINK_THINK_INTERVAL = 0.1
local LINK_DAMAGE_INTERVAL = 0.5
local LINK_DAMAGE_RATE = 15
local LINK_FACE_TARGET_RANGE = 2500
local PROJECTILE_DISTANCE = CAST_RANGE
local PROJECTILE_SPEED = 1600
local PROJECTILE_RADIUS = 70
local PROJECTILE_START_HEIGHT = 100
local PROJECTILE_DAMAGE_RATE = 15
local PROJECTILE_ANGLE_OFFSETS = { -20, 0, 20 }
local PROJECTILE_TRAVEL_DURATION = PROJECTILE_DISTANCE / PROJECTILE_SPEED
local PROJECTILE_THINK_INTERVAL = 0.03
local TARGET_VISION_RADIUS = 580
local TARGET_VISION_LINGER = 0.25
local STATIC_LINK_PARTICLE = "particles/razor_static_link.vpcf"
local LINK_DAMAGE_PARTICLE = "particles/dd/small_lightning_strike_hit_blue_cyan.vpcf"
local LINK_BREAK_RANGE_PARTICLE = "particles/monster/elite/elite_115_link_break_range.vpcf"
local LAUNCH_SHOCK_PARTICLE = "particles/econ/items/beastmaster/bm_shoulder_ti7/bm_shoulder_ti7_roar_warp.vpcf"
local RAZOR_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts"
local STATIC_LINK_START_SOUND = "Ability.static.start"
local STATIC_LINK_LOOP_SOUND = "Ability.static.loop"
local STATIC_LINK_END_SOUND = "Ability.static.end"
local STATIC_LINK_CASTER_ATTACHMENTS = { "attach_hand2", "attach_hand1", "attach_hitloc" }
local STATIC_LINK_CAST_GESTURE = ACT_DOTA_OVERRIDE_ABILITY_2
--- 精英技能115 - 静电连接：发射三道闪电，首个命中目标会受到伤害并被持续链接。
____exports.elite_115 = __TS__Class()
local elite_115 = ____exports.elite_115
elite_115.name = "elite_115"
__TS__ClassExtends(elite_115, MonsterAbility_CS)
function elite_115.prototype.Precache(self, context)
	PrecacheResource("particle", STATIC_LINK_PARTICLE, context)
	PrecacheResource("particle", LINK_DAMAGE_PARTICLE, context)
	PrecacheResource("particle", LINK_BREAK_RANGE_PARTICLE, context)
	PrecacheResource("particle", LAUNCH_SHOCK_PARTICLE, context)
	PrecacheResource("soundfile", RAZOR_SOUND_EVENTS, context)
end
function elite_115.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		castRange = CAST_RANGE * 0.9,
		castPoint = CAST_POINT,
		castDuration = PROJECTILE_TRAVEL_DURATION,
		cooldown = COOLDOWN,
		manaCost = MANA_COST,
		castProgressBarColor = "blue",
		thunderizedCounterBreak = true,
		thunderizedCounterBreakStunDuration = 1,
		thunderizedDamageImmune = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, self:GetMinDistanceUnit(CAST_RANGE)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		castError = function()
			return "附近没有可释放静电连接的目标"
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = self:GetMinDistanceUnit(LINK_FACE_TARGET_RANGE)
			if target then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			self:PlayProjectileWarnings(caster)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:SetAnimation("razor_static_link_damage")
			ScreenShake(caster:GetAbsOrigin(), 15, 15, 0.1, 3200, 0, true)
			self:PlayLaunchShockEffects(caster)
			self:FireLightningProjectiles(caster)
		end,
	}
end
function elite_115.prototype.PlayLaunchShockEffects(self, caster)
	local casterPosition = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local targetPosition =
		GetGroundPosition(casterPosition:__add(caster:GetForwardVector():__mul(PROJECTILE_DISTANCE)), caster)
	self:PlayLaunchShockEffect(caster, casterPosition, targetPosition)
end
function elite_115.prototype.PlayLaunchShockEffect(self, caster, startPosition, endPosition)
	local particle = ParticleManager:CreateParticle(LAUNCH_SHOCK_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, startPosition)
	ParticleManager:SetParticleControl(particle, 1, endPosition)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_115.prototype.FireLightningProjectiles(self, caster)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local startPoint = origin:__add(Vector(0, 0, PROJECTILE_START_HEIGHT))
	local volleyState = {
		hasEstablishedLink = false,
		particles = {},
		destroyedParticles = __TS__New(Map),
	}
	for ____, angleOffset in ipairs(PROJECTILE_ANGLE_OFFSETS) do
		local currentAngleOffset = angleOffset
		local currentDirection = RotateVector2D(nil, forward, currentAngleOffset):Normalized()
		self:LaunchLightningBeam(caster, startPoint, currentDirection, volleyState)
	end
end
function elite_115.prototype.LaunchLightningBeam(self, caster, startPoint, direction, volleyState)
	local casterAttachment = self:GetCasterLinkAttachment(caster)
	local particle = ParticleManager:CreateParticle(STATIC_LINK_PARTICLE, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		casterAttachment,
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(particle, 1, startPoint)
	local ____volleyState_particles_1 = volleyState.particles
	____volleyState_particles_1[#____volleyState_particles_1 + 1] = particle
	local traveledDistance = 0
	local previousPoint = startPoint
	Timers:CreateTimer(0, function()
		return SafelyCall(nil, function()
			if not IsValidAlive(nil, caster) or volleyState.hasEstablishedLink then
				self:DestroyLightningBeam(particle, volleyState)
				return
			end
			local currentDistance =
				math.min(PROJECTILE_DISTANCE, traveledDistance + PROJECTILE_SPEED * PROJECTILE_THINK_INTERVAL)
			local currentPoint = startPoint:__add(direction:__mul(currentDistance))
			ParticleManager:SetParticleControl(particle, 1, currentPoint)
			local hitTarget = self:FindBeamHitTarget(caster, previousPoint, currentPoint)
			if IsValidAlive(nil, hitTarget) then
				volleyState.hasEstablishedLink = true
				self:DestroyLightningVolley(volleyState)
				caster:MonsterDamage({
					victim = hitTarget,
					damage_rate = PROJECTILE_DAMAGE_RATE,
					ability = self,
					effectName = LINK_DAMAGE_PARTICLE,
				})
				self:ApplyStaticLink(caster, hitTarget)
				return
			end
			traveledDistance = currentDistance
			previousPoint = currentPoint
			if traveledDistance >= PROJECTILE_DISTANCE then
				self:DestroyLightningBeam(particle, volleyState)
				return
			end
			return PROJECTILE_THINK_INTERVAL
		end)
	end)
end
function elite_115.prototype.FindBeamHitTarget(self, caster, previousPoint, currentPoint)
	local lineStart = GetGroundPosition(previousPoint, caster)
	local lineEnd = GetGroundPosition(currentPoint, caster)
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		lineStart,
		lineEnd,
		nil,
		PROJECTILE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	local closestTarget
	local closestDistance = math.huge
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue23
			end
			local distance = GetDistance(nil, lineStart, enemy:GetAbsOrigin())
			if distance >= closestDistance then
				goto __continue23
			end
			closestTarget = enemy
			closestDistance = distance
		end
		::__continue23::
	end
	return closestTarget
end
function elite_115.prototype.DestroyLightningVolley(self, volleyState)
	for ____, particle in ipairs(volleyState.particles) do
		self:DestroyLightningBeam(particle, volleyState)
	end
end
function elite_115.prototype.DestroyLightningBeam(self, particle, volleyState)
	if volleyState.destroyedParticles:get(particle) then
		return
	end
	volleyState.destroyedParticles:set(particle, true)
	ParticleManager:DestroyParticle(particle, false)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_115.prototype.GetCasterLinkAttachment(self, caster)
	for ____, attachmentName in ipairs(STATIC_LINK_CASTER_ATTACHMENTS) do
		if caster:ScriptLookupAttachment(attachmentName) > 0 then
			return attachmentName
		end
	end
	return "attach_hitloc"
end
function elite_115.prototype.ApplyStaticLink(self, caster, target)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	modifier_elite_115_static_link:remove(caster)
	modifier_elite_115_static_link:applys(caster, caster, self, {
		duration = LINK_DURATION,
		target_entindex = target:entindex(),
	})
end
function elite_115.prototype.PlayProjectileWarnings(self, caster)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	for ____, angleOffset in ipairs(PROJECTILE_ANGLE_OFFSETS) do
		local currentAngleOffset = angleOffset
		local currentDirection = RotateVector2D(nil, forward, currentAngleOffset)
		local currentEndPosition = origin:__add(currentDirection:__mul(PROJECTILE_DISTANCE))
		self:WarningEffect(origin, currentEndPosition, CAST_POINT, {
			startWidth = PROJECTILE_RADIUS,
			endWidth = PROJECTILE_RADIUS,
			follow = true,
			getStartPosition = function()
				local ____IsValidAlive_result_2
				if IsValidAlive(nil, caster) then
					____IsValidAlive_result_2 = caster:GetAbsOrigin()
				else
					____IsValidAlive_result_2 = nil
				end
				return ____IsValidAlive_result_2
			end,
			getDirection = function()
				local ____IsValidAlive_result_3
				if IsValidAlive(nil, caster) then
					____IsValidAlive_result_3 = RotateVector2D(nil, caster:GetForwardVector(), currentAngleOffset)
				else
					____IsValidAlive_result_3 = nil
				end
				return ____IsValidAlive_result_3
			end,
		})
	end
end
elite_115 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_115)
____exports.elite_115 = elite_115
modifier_elite_115_static_link = __TS__Class()
modifier_elite_115_static_link.name = "modifier_elite_115_static_link"
__TS__ClassExtends(modifier_elite_115_static_link, MonsterModifier_CS)
function modifier_elite_115_static_link.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.nextDamageTime = 0
end
function modifier_elite_115_static_link.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	self.targetEntIndex = params and params.target_entindex
	self.target = self:GetLinkedTarget()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, self.target) then
		self:Destroy()
		return
	end
	self.nextDamageTime = GameRules:GetGameTime() + LINK_DAMAGE_INTERVAL
	caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_2)
	self:CreateLinkEffects(caster, self.target)
	self:CreateLinkBreakRangeEffect(caster)
	self:StartIntervalThink(LINK_THINK_INTERVAL)
	self:OnIntervalThink()
end
function modifier_elite_115_static_link.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	local target = self:GetLinkedTarget()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) or not ability or ability:IsNull() then
		self:Destroy()
		return
	end
	if GetDistance(nil, caster:GetAbsOrigin(), target:GetAbsOrigin()) > LINK_BREAK_DISTANCE then
		self:Destroy()
		return
	end
	AddFOWViewer(caster:GetTeamNumber(), target:GetAbsOrigin(), TARGET_VISION_RADIUS, TARGET_VISION_LINGER, false)
	if GameRules:GetGameTime() < self.nextDamageTime then
		return
	end
	self.nextDamageTime = self.nextDamageTime + LINK_DAMAGE_INTERVAL
	self:ApplyLinkDamage(caster, target, ability)
end
function modifier_elite_115_static_link.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local caster = self:GetParent()
	if IsValid(nil, caster) and not caster:IsNull() then
		StopSoundOn(STATIC_LINK_LOOP_SOUND, caster)
		EmitSoundOn(STATIC_LINK_END_SOUND, caster)
		caster:RemoveGesture(STATIC_LINK_CAST_GESTURE)
	end
	self:DestroyLinkParticle()
	self:DestroyLinkBreakRangeParticle()
end
function modifier_elite_115_static_link.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_elite_115_static_link.prototype.GetOverrideAnimation(self)
	return STATIC_LINK_CAST_GESTURE
end
function modifier_elite_115_static_link.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_elite_115_static_link.prototype.IsHidden(self)
	return true
end
function modifier_elite_115_static_link.prototype.IsPurgable(self)
	return false
end
function modifier_elite_115_static_link.prototype.GetLinkedTarget(self)
	if self.target and IsValidAlive(nil, self.target) then
		return self.target
	end
	if self.targetEntIndex == nil then
		return nil
	end
	local target = EntIndexToHScript(self.targetEntIndex)
	local ____IsValidAlive_result_6
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_6 = target
	else
		____IsValidAlive_result_6 = nil
	end
	self.target = ____IsValidAlive_result_6
	return self.target
end
function modifier_elite_115_static_link.prototype.ApplyLinkDamage(self, caster, target, ability)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:MonsterDamage({
		victim = target,
		damage_rate = LINK_DAMAGE_RATE,
		ability = ability,
		effectName = LINK_DAMAGE_PARTICLE,
	})
end
function modifier_elite_115_static_link.prototype.CreateLinkEffects(self, caster, target)
	EmitSoundOn(STATIC_LINK_START_SOUND, caster)
	EmitSoundOn(STATIC_LINK_LOOP_SOUND, caster)
	local casterAttach = self:GetCasterLinkAttachment(caster)
	self.linkPfx = ParticleManager:CreateParticle(STATIC_LINK_PARTICLE, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		self.linkPfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		casterAttach,
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.linkPfx,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
end
function modifier_elite_115_static_link.prototype.CreateLinkBreakRangeEffect(self, caster)
	self.linkBreakRangePfx = ParticleManager:CreateParticle(LINK_BREAK_RANGE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(self.linkBreakRangePfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.linkBreakRangePfx, 1, Vector(LINK_BREAK_DISTANCE, 0, 0))
end
function modifier_elite_115_static_link.prototype.GetCasterLinkAttachment(self, caster)
	for ____, attachmentName in ipairs(STATIC_LINK_CASTER_ATTACHMENTS) do
		if caster:ScriptLookupAttachment(attachmentName) > 0 then
			return attachmentName
		end
	end
	return "attach_hitloc"
end
function modifier_elite_115_static_link.prototype.DestroyLinkParticle(self)
	if self.linkPfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self.linkPfx, false)
	ParticleManager:ReleaseParticleIndex(self.linkPfx)
	self.linkPfx = nil
end
function modifier_elite_115_static_link.prototype.DestroyLinkBreakRangeParticle(self)
	if self.linkBreakRangePfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self.linkBreakRangePfx, false)
	ParticleManager:ReleaseParticleIndex(self.linkBreakRangePfx)
	self.linkBreakRangePfx = nil
end
modifier_elite_115_static_link =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_115_static_link") }, modifier_elite_115_static_link)
return ____exports