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
local modifier_boss_night_006_shadow_shrink, modifier_boss_night_006_dash_fx
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local SEARCH_RANGE = 2400
local CAST_POINT = 0.65
local CAST_DURATION = 6.7
local PREPARE_BACKSTEP_DISTANCE = 560
local PREPARE_BACKSTEP_DURATION = 0.5
local PREPARE_SHRINK_DURATION = PREPARE_BACKSTEP_DURATION
local BLINK_DELAY = 0.12
local AMBUSH_REPEAT_COUNT = 5
local AMBUSH_BACK_DISTANCE = 520
local AMBUSH_WARNING_DURATION = 0.65
local AMBUSH_ROUND_GAP = 0.15
local DASH_DISTANCE = 1080
local DASH_DURATION = 0.32
local DASH_DAMAGE_RADIUS = 180
local DASH_WARNING_EXTRA_DISTANCE = 80
local DASH_DAMAGE_RATE = 25
local DASH_STUN_DURATION = 0.45
local BURST_DAMAGE_RADIUS = 320
local BURST_DAMAGE_RATE = 8
local PREPARE_PARTICLE = "particles/econ/events/diretide_2020/death_effect/death_dt20_post.vpcf"
local PREPARE_PARTICLE_THINKER_MODEL = "models/heroes/wisp/wisp.vmdl"
local BLINK_PARTICLE = "particles/nightstalker_crippling_fear_aura_burst.vpcf"
local DASH_HIT_PARTICLE = "particles/void_spirit_astral_step_impact_blue.vpcf"
local SLASH_PARTICLE = "particles/bb/aoe_dmg_blade_red.vpcf"
local BURST_PARTICLE = "particles/units/heroes/hero_night_stalker/nightstalker_crippling_fear_aura.vpcf"
local DASH_FX_PARTICLE = "particles/status_fx/status_effect_charge_of_darkness.vpcf"
--- 夜魔突袭：隐入黑暗后绕至目标身后，并向前扑击爪击。
____exports.boss_night_006 = __TS__Class()
local boss_night_006 = ____exports.boss_night_006
boss_night_006.name = "boss_night_006"
__TS__ClassExtends(boss_night_006, MonsterAbility_CS)
function boss_night_006.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.hitTargetIds = {}
	self.ambushToken = 0
end
function boss_night_006.prototype.Precache(self, context)
	PrecacheResource("particle", PREPARE_PARTICLE, context)
	PrecacheResource("model", PREPARE_PARTICLE_THINKER_MODEL, context)
	PrecacheResource("particle", BLINK_PARTICLE, context)
	PrecacheResource("particle", DASH_HIT_PARTICLE, context)
	PrecacheResource("particle", SLASH_PARTICLE, context)
	PrecacheResource("particle", BURST_PARTICLE, context)
	PrecacheResource("particle", DASH_FX_PARTICLE, context)
end
function boss_night_006.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		animationPlaybackRate = 0.9,
		isNotMove = true,
		OnPhaseStart = function()
			return self:PrepareAmbush()
		end,
		OnStart = function()
			return self:StartAmbush()
		end,
		OnFinish = function()
			return self:CleanupAmbush()
		end,
		OnInterrupt = function()
			return self:CleanupAmbush()
		end,
		castColor = Vector(80, 20, 120),
	}
end
function boss_night_006.prototype.PrepareAmbush(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
	local ____target_0
	if target then
		____target_0 = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	else
		____target_0 = caster:GetForwardVector()
	end
	local forward = ____target_0
	if target then
		caster:LockTargetForSpeed(target, CAST_POINT, 8)
	end
	caster:EmitSound("Hero_Nightstalker.Void")
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 0.9)
	modifier_boss_night_006_shadow_shrink:applys(
		caster,
		caster,
		self,
		{ duration = CAST_POINT + CAST_DURATION + 0.5, shrink_duration = PREPARE_SHRINK_DURATION }
	)
	local seeker = self:PlaySeekerParticle(PREPARE_PARTICLE, caster:GetAbsOrigin(), 0.8)
	caster:Mover(
		caster:GetAbsOrigin():__add(forward:__mul(-PREPARE_BACKSTEP_DISTANCE)),
		PREPARE_BACKSTEP_DURATION,
		function(____, position)
			if IsValidAlive(nil, seeker) then
				seeker:SetAbsOrigin(position)
			end
		end
	)
end
function boss_night_006.prototype.StartAmbush(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:ClearDebuffs()
	self.ambushToken = self.ambushToken + 1
	local token = self.ambushToken
	caster:EmitSound("Hero_Nightstalker.Darkness.Team")
	modifier_boss_night_006_shadow_shrink:remove(caster)
	caster:AddNoDraw()
	self:StartAmbushRound(1, token)
end
function boss_night_006.prototype.StartAmbushRound(self, round, token)
	local caster = self:GetCaster()
	if token ~= self.ambushToken or not IsValidAlive(nil, caster) then
		return
	end
	if round > AMBUSH_REPEAT_COUNT then
		caster:RemoveNoDraw()
		return
	end
	caster:AddNoDraw()
	local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
	local startPos = caster:GetAbsOrigin()
	self:PlayPointParticle(BLINK_PARTICLE, startPos, 0.8)
	if not target or not IsValidAlive(nil, target) then
		self:ScheduleHiddenWarningAndDash(startPos, caster:GetForwardVector(), token, round)
		return
	end
	local ambushPoint = self:ResolveAmbushPoint(caster, target)
	self:Timer(BLINK_DELAY, function()
		if token ~= self.ambushToken or not IsValidAlive(nil, caster) then
			return
		end
		FindClearSpaceForUnit(caster, ambushPoint, true)
		caster:AddNoDraw()
		self:PlayPointParticle(BLINK_PARTICLE, ambushPoint, 0.8)
		caster:EmitSound("Hero_Nightstalker.Void.Nihility")
		local ____IsValidAlive_result_1
		if IsValidAlive(nil, target) then
			____IsValidAlive_result_1 = GetDirection(nil, target:GetAbsOrigin(), ambushPoint)
		else
			____IsValidAlive_result_1 = caster:GetForwardVector()
		end
		local dashDirection = ____IsValidAlive_result_1
		caster:SetForwardVector(dashDirection)
		self:ScheduleHiddenWarningAndDash(caster:GetAbsOrigin(), dashDirection, token, round)
	end)
end
function boss_night_006.prototype.ScheduleHiddenWarningAndDash(self, dashStart, dashDirection, token, round)
	local caster = self:GetCaster()
	if token ~= self.ambushToken or not IsValidAlive(nil, caster) then
		return
	end
	local ____temp_2
	if dashDirection:Length2D() > 0.01 then
		____temp_2 = dashDirection:Normalized()
	else
		____temp_2 = caster:GetForwardVector()
	end
	local forward = ____temp_2
	local start = GetGroundPosition(dashStart, caster)
	local ____end = start:__add(forward:__mul(DASH_DISTANCE + DASH_WARNING_EXTRA_DISTANCE))
	self:PlayFixedLinearWarning(start, ____end, AMBUSH_WARNING_DURATION, DASH_DAMAGE_RADIUS, DASH_DAMAGE_RADIUS)
	self:Timer(AMBUSH_WARNING_DURATION, function()
		local caster = self:GetCaster()
		if token ~= self.ambushToken or not IsValidAlive(nil, caster) then
			return
		end
		caster:RemoveNoDraw()
		caster:SetForwardVector(forward)
		caster:SetAnimation("cast_void_nihility_anim")
		self.hitTargetIds = {}
		self:DashFromPoint(start, forward, false)
		self:ScheduleNextAmbushRound(round, token)
	end)
end
function boss_night_006.prototype.ScheduleNextAmbushRound(self, round, token)
	self:Timer(DASH_DURATION + AMBUSH_ROUND_GAP, function()
		local caster = self:GetCaster()
		if token ~= self.ambushToken or not IsValidAlive(nil, caster) then
			return
		end
		if round >= AMBUSH_REPEAT_COUNT then
			return
		end
		caster:AddNoDraw()
		self:StartAmbushRound(round + 1, token)
	end)
end
function boss_night_006.prototype.PlayFixedLinearWarning(self, start, ____end, duration, startWidth, endWidth)
	if duration <= 0 then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local thinker = CreateModifierThinker(
		caster,
		self,
		"modifier_dummy_thinker",
		{ duration = duration + 1 },
		start,
		caster:GetTeamNumber(),
		false
	)
	local effect = ParticleManager:CreateParticle("particles/range_finder_linear_1.vpcf", PATTACH_POINT, thinker)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	ParticleManager:SetParticleControl(effect, 0, start)
	ParticleManager:SetParticleControlEnt(
		effect,
		1,
		thinker,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		false
	)
	ParticleManager:SetParticleControl(effect, 2, Vector(duration, startWidth, endWidth))
	local direction = ____end:__sub(start)
	local distance = direction:Length()
	local ____temp_3
	if distance > 0.0001 then
		____temp_3 = direction:Normalized()
	else
		____temp_3 = Vector(1, 0, 0)
	end
	local forward = ____temp_3
	local elapsed = 0
	local interval = 0.03
	local function setEndPoint(____, progress)
		local currentEnd = start:__add(forward:__mul(distance * progress))
		if not IsValidAlive(nil, thinker) then
			return
		end
		local groundZ = GetGroundHeight(currentEnd, thinker)
		local ____thinker_SetAbsOrigin_7 = thinker.SetAbsOrigin
		local ____currentEnd_x_5 = currentEnd.x
		local ____currentEnd_y_6 = currentEnd.y
		local ____temp_4
		if groundZ ~= nil then
			____temp_4 = groundZ
		else
			____temp_4 = currentEnd.z
		end
		____thinker_SetAbsOrigin_7(thinker, Vector(____currentEnd_x_5, ____currentEnd_y_6, ____temp_4))
		ParticleManager:SetParticleControl(effect, 15, Vector(1, 1 - progress, 0))
	end
	setEndPoint(nil, 0)
	Timers:CreateTimer(0, function()
		local caster = self:GetCaster()
		if not IsValidAlive(nil, caster) then
			ParticleManager:DestroyParticle(effect, true)
			ParticleManager:ReleaseParticleIndex(effect)
			if IsValid(nil, thinker) and not thinker:IsNull() then
				thinker:RemoveSelf()
			end
			return
		end
		elapsed = elapsed + interval
		local progress = math.min(elapsed / duration, 1)
		setEndPoint(nil, progress)
		if progress >= 1 then
			ParticleManager:DestroyParticle(effect, true)
			ParticleManager:ReleaseParticleIndex(effect)
			if IsValid(nil, thinker) and not thinker:IsNull() then
				thinker:RemoveSelf()
			end
			return
		end
		return interval
	end)
end
function boss_night_006.prototype.ResolveAmbushPoint(self, caster, target)
	if not IsValidAlive(nil, target) then
		return GetGroundPosition(caster:GetAbsOrigin(), caster)
	end
	local targetOrigin = target:GetAbsOrigin()
	local targetForward = target:GetForwardVector()
	local preferred = targetOrigin:__sub(targetForward:__mul(AMBUSH_BACK_DISTANCE))
	local preferredGround = GetGroundPosition(preferred, caster)
	if IsGridNavDisplacementWalkable(nil, preferredGround) then
		return preferredGround
	end
	local fromCaster = GetDirection(nil, caster:GetAbsOrigin(), targetOrigin)
	do
		local i = 0
		while i < 8 do
			local dir = RotateVector2D(nil, fromCaster, i * 45)
			local point = targetOrigin:__add(dir:__mul(AMBUSH_BACK_DISTANCE))
			local groundPoint = GetGroundPosition(point, caster)
			if IsGridNavDisplacementWalkable(nil, groundPoint) then
				return groundPoint
			end
			i = i + 1
		end
	end
	return GetGroundPosition(caster:GetAbsOrigin(), caster)
end
function boss_night_006.prototype.DashFromPoint(self, origin, direction, playAttackGesture)
	if playAttackGesture == nil then
		playAttackGesture = true
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____temp_8
	if direction:Length2D() > 0.01 then
		____temp_8 = direction:Normalized()
	else
		____temp_8 = caster:GetForwardVector()
	end
	local forward = ____temp_8
	local endPoint = GetGroundPosition(origin:__add(forward:__mul(DASH_DISTANCE)), caster)
	if playAttackGesture then
		caster:SetAnimation("cast_void_nihility_anim")
	end
	caster:EmitSound("Hero_Nightstalker.Trickling_Fear")
	modifier_boss_night_006_dash_fx:applys(caster, caster, self, { duration = DASH_DURATION + 0.15 })
	self:PlaySlashEffect(caster:GetAbsOrigin(), forward)
	caster:Mover(endPoint, DASH_DURATION, function(____, pos)
		local damagePoint = pos:__add(forward:__mul(80))
		self:DamageDashArea(damagePoint)
	end)
	self:Timer(DASH_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local burstPoint = caster:GetAbsOrigin()
		self:DamageBurstArea(burstPoint)
	end)
end
function boss_night_006.prototype.DamageDashArea(self, origin)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		DASH_DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue51
			end
			local index = enemy:GetEntityIndex()
			if self.hitTargetIds[index] then
				goto __continue51
			end
			self.hitTargetIds[index] = true
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = DASH_DAMAGE_RATE,
				ability = self,
				effectName = DASH_HIT_PARTICLE,
			})
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = DASH_STUN_DURATION })
			enemy:KnockBack(caster, self, {
				origin_pos = caster:GetAbsOrigin(),
				duration = 0.12,
				stun = true,
				stunDuration = 0.12,
				distance = 120,
				height = 0,
			})
		end
		::__continue51::
	end
end
function boss_night_006.prototype.DamageBurstArea(self, origin)
	local caster = self:GetCaster()
	self:PlayPointParticle(BURST_PARTICLE, origin, 1, Vector(BURST_DAMAGE_RADIUS, BURST_DAMAGE_RADIUS, 0))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		BURST_DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue56
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = BURST_DAMAGE_RATE, ability = self })
		end
		::__continue56::
	end
end
function boss_night_006.prototype.PlayPointParticle(self, name, point, duration, cp2)
	local pfx = ParticleManager:CreateParticle(name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point)
	if cp2 then
		ParticleManager:SetParticleControl(pfx, 2, cp2)
	end
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
function boss_night_006.prototype.PlaySeekerParticle(self, name, point, duration)
	local caster = self:GetCaster()
	local seeker = CreateModifierThinker(
		caster,
		self,
		"modifier_dummy_thinker",
		{ duration = duration + 0.5 },
		point,
		caster:GetTeamNumber(),
		false
	)
	Timers:CreateTimer(FrameTime(), function()
		if not IsValidAlive(nil, seeker) then
			return
		end
		seeker:SetOriginalModel(PREPARE_PARTICLE_THINKER_MODEL)
		seeker:SetModel(PREPARE_PARTICLE_THINKER_MODEL)
	end)
	Timers:CreateTimer(FrameTime() * 2, function()
		if not IsValidAlive(nil, seeker) then
			return
		end
		local pfx = ParticleManager:CreateParticle(name, PATTACH_ABSORIGIN_FOLLOW, seeker)
		ParticleManager:SetParticleControlEnt(pfx, 0, seeker, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", point, true)
		Timers:CreateTimer(duration, function()
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			if IsValid(nil, seeker) and not seeker:IsNull() then
				seeker:RemoveSelf()
			end
			return nil
		end)
	end)
	return seeker
end
function boss_night_006.prototype.PlaySlashEffect(self, origin, forward)
	local caster = self:GetCaster()
	local pfx = ParticleManager:CreateParticle(SLASH_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 6, origin:__add(forward:__mul(220)))
	ParticleManager:SetParticleControl(pfx, 11, Vector(120, 0, 0))
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
function boss_night_006.prototype.CleanupAmbush(self)
	local caster = self:GetCaster()
	self.ambushToken = self.ambushToken + 1
	if not caster or not IsValid(nil, caster) or caster:IsNull() then
		return
	end
	caster:RemoveNoDraw()
	modifier_boss_night_006_shadow_shrink:remove(caster)
end
boss_night_006 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_night_006)
____exports.boss_night_006 = boss_night_006
modifier_boss_night_006_shadow_shrink = __TS__Class()
modifier_boss_night_006_shadow_shrink.name = "modifier_boss_night_006_shadow_shrink"
__TS__ClassExtends(modifier_boss_night_006_shadow_shrink, MonsterModifier_CS)
function modifier_boss_night_006_shadow_shrink.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.shrinkDuration = PREPARE_SHRINK_DURATION
end
function modifier_boss_night_006_shadow_shrink.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.shrinkDuration = math.max(params and params.shrink_duration or PREPARE_SHRINK_DURATION, FrameTime())
	self:SetStackCount(0)
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_night_006_shadow_shrink.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local progress = math.min(self:GetElapsedTime() / self.shrinkDuration, 1)
	self:SetStackCount(math.floor(progress * 100))
	if progress >= 1 then
		self:StartIntervalThink(-1)
	end
end
function modifier_boss_night_006_shadow_shrink.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME }
end
function modifier_boss_night_006_shadow_shrink.prototype.GetModifierModelScaleAnimateTime(self)
	return FrameTime()
end
function modifier_boss_night_006_shadow_shrink.prototype.GetModifierModelScale(self)
	return -self:GetStackCount()
end
function modifier_boss_night_006_shadow_shrink.prototype.IsHidden(self)
	return true
end
function modifier_boss_night_006_shadow_shrink.prototype.IsPurgable(self)
	return false
end
modifier_boss_night_006_shadow_shrink =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_006_shadow_shrink)
modifier_boss_night_006_dash_fx = __TS__Class()
modifier_boss_night_006_dash_fx.name = "modifier_boss_night_006_dash_fx"
__TS__ClassExtends(modifier_boss_night_006_dash_fx, MonsterModifier_CS)
function modifier_boss_night_006_dash_fx.prototype.GetEffectName(self)
	return DASH_FX_PARTICLE
end
function modifier_boss_night_006_dash_fx.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_charge_of_darkness.vpcf"
end
function modifier_boss_night_006_dash_fx.prototype.IsHidden(self)
	return true
end
function modifier_boss_night_006_dash_fx.prototype.IsPurgable(self)
	return false
end
modifier_boss_night_006_dash_fx = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_006_dash_fx)
return ____exports