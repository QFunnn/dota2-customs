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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local px2 = "particles/void_spirit_astral_step_impact_blue.vpcf"
local PHANTOME_AB1_CHARGE_DURATION = 0.9
local PHANTOME_AB1_TARGET_SEARCH_RANGE = 3500
local PHANTOME_AB1_REPOSITION_DISTANCE = 500
local PHANTOME_AB1_REPOSITION_MIN_MOVE_DISTANCE = 500
local PHANTOME_AB1_REPOSITION_MAX_MOVE_DISTANCE = 800
local PHANTOME_AB1_REPOSITION_FINISH_DISTANCE = 64
local PHANTOME_AB1_REPOSITION_MIN_SPEED = 900
local phantome_ab1_1 = __TS__Class()
phantome_ab1_1.name = "phantome_ab1_1"
__TS__ClassExtends(phantome_ab1_1, MonsterAbility_CS)
function phantome_ab1_1.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = PHANTOME_AB1_CHARGE_DURATION,
		castDuration = 6.2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnPrePhaseMove = function(____, done)
			return self:StartPrePhaseMove(done)
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:RemoveGesture(ACT_DOTA_RUN)
			caster:AddNewModifier(
				caster,
				self,
				"phantome_ab1_1_modifier_pre",
				{ duration = PHANTOME_AB1_CHARGE_DURATION }
			)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:AddNewModifier(caster, self, "phantome_ab1_1_modifier_start", { duration = 4.5 })
			self:Timer(4, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:AddNewModifier(caster, self, "phantome_ab3_pre2", { duration = 0.16 })
				caster:SetCustomValue("绝影斩击", 3)
			end)
		end,
		OnInterrupt = function()
			local caster = self:GetCaster()
			caster:RemoveGesture(ACT_DOTA_RUN)
			caster:Stop()
		end,
	}
end
function phantome_ab1_1.prototype.StartPrePhaseMove(self, done)
	if not IsServer() then
		done(nil)
		return
	end
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(PHANTOME_AB1_TARGET_SEARCH_RANGE)
	local rawMovePoint = self:ResolveRepositionPoint(caster, target)
	local movePoint = self:ResolveRepositionPointByMoveDistanceRange(caster, rawMovePoint)
	local moveDistance = movePoint:__sub(caster:GetAbsOrigin()):Length2D()
	if moveDistance <= PHANTOME_AB1_REPOSITION_FINISH_DISTANCE then
		done(nil)
		return
	end
	local moveDirection = GetDirection(nil, movePoint, caster:GetAbsOrigin())
	local moveDuration = self:GetRepositionMoveDuration(caster, moveDistance)
	local finished = false
	local function finishMove()
		if finished then
			return
		end
		finished = true
		if IsValidAlive(nil, caster) then
			caster:RemoveGesture(ACT_DOTA_RUN)
			caster:Stop()
		end
		done(nil)
	end
	caster:SetForwardVector(moveDirection)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_RUN, 1.35)
	caster:Mover(movePoint, moveDuration, function(____, position)
		if position:__sub(movePoint):Length2D() > PHANTOME_AB1_REPOSITION_FINISH_DISTANCE then
			return
		end
		finishMove(nil)
		return true
	end, false, true)
	self:Timer(moveDuration + FrameTime(), finishMove)
end
function phantome_ab1_1.prototype.GetRepositionMoveDuration(self, caster, distance)
	local speed = math.max(caster:GetIdealSpeed(), PHANTOME_AB1_REPOSITION_MIN_SPEED)
	return math.max(distance / speed, FrameTime())
end
function phantome_ab1_1.prototype.ResolveRepositionPoint(self, caster, target)
	local ____GetGroundPosition_1 = GetGroundPosition
	local ____target_0
	if target then
		____target_0 = target:GetAbsOrigin()
	else
		____target_0 = caster:GetAbsOrigin()
	end
	local targetPoint = ____GetGroundPosition_1(____target_0, target or caster)
	local ____GetGroundPosition_4 = GetGroundPosition
	local ____this_3
	____this_3 = caster
	local ____opt_2 = ____this_3.GetSpawnPoint
	local centerPoint = ____GetGroundPosition_4(____opt_2 and ____opt_2(____this_3) or caster:GetAbsOrigin(), caster)
	local baseDirection = self:ResolveAwayFromCenterDirection(caster, targetPoint, centerPoint)
	local angles = {
		0,
		45,
		-45,
		90,
		-90,
		135,
		-135,
		180,
	}
	local bestPoint =
		GetGroundPosition(targetPoint:__add(baseDirection:__mul(PHANTOME_AB1_REPOSITION_DISTANCE)), caster)
	local bestScore = -1
	for ____, angle in ipairs(angles) do
		do
			local direction = RotateVector2D(nil, baseDirection, angle)
			local candidate =
				GetGroundPosition(targetPoint:__add(direction:__mul(PHANTOME_AB1_REPOSITION_DISTANCE)), caster)
			if not self:IsValidRepositionPoint(caster, targetPoint, candidate) then
				goto __continue19
			end
			local centerDistance = candidate:__sub(centerPoint):Length2D()
			if centerDistance > bestScore then
				bestScore = centerDistance
				bestPoint = candidate
			end
		end
		::__continue19::
	end
	return bestPoint
end
function phantome_ab1_1.prototype.ResolveRepositionPointByMoveDistanceRange(self, caster, point)
	local casterPoint = caster:GetAbsOrigin()
	local offset = point:__sub(casterPoint)
	local distance = offset:Length2D()
	if self:IsMoveDistanceInRange(caster, point) then
		return point
	end
	local direction = Vector(offset.x, offset.y, 0)
	if direction:Length2D() <= 0.01 then
		local forward = caster:GetForwardVector()
		direction = Vector(forward.x, forward.y, 0)
	end
	if direction:Length2D() <= 0.01 then
		return casterPoint
	end
	local normalized = direction:Normalized()
	local ____temp_5
	if distance < PHANTOME_AB1_REPOSITION_MIN_MOVE_DISTANCE then
		____temp_5 = { PHANTOME_AB1_REPOSITION_MIN_MOVE_DISTANCE, 600, 700, PHANTOME_AB1_REPOSITION_MAX_MOVE_DISTANCE }
	else
		____temp_5 = { PHANTOME_AB1_REPOSITION_MAX_MOVE_DISTANCE, 700, 600, PHANTOME_AB1_REPOSITION_MIN_MOVE_DISTANCE }
	end
	local distances = ____temp_5
	local angles = {
		0,
		30,
		-30,
		60,
		-60,
		90,
		-90,
		180,
	}
	for ____, candidateDistance in ipairs(distances) do
		for ____, angle in ipairs(angles) do
			do
				local candidateDirection = RotateVector2D(nil, normalized, angle)
				local candidate =
					GetGroundPosition(casterPoint:__add(candidateDirection:__mul(candidateDistance)), caster)
				if not self:IsMoveDistanceInRange(caster, candidate) then
					goto __continue28
				end
				if self:IsValidMoveTarget(caster, candidate) then
					return candidate
				end
			end
			::__continue28::
		end
	end
	return casterPoint
end
function phantome_ab1_1.prototype.ResolveAwayFromCenterDirection(self, caster, targetPoint, centerPoint)
	local fromCenter = Vector(targetPoint.x - centerPoint.x, targetPoint.y - centerPoint.y, 0)
	if fromCenter:Length2D() > 0.01 then
		return fromCenter:Normalized()
	end
	local fromTargetToCaster =
		Vector(caster:GetAbsOrigin().x - targetPoint.x, caster:GetAbsOrigin().y - targetPoint.y, 0)
	if fromTargetToCaster:Length2D() > 0.01 then
		return fromTargetToCaster:Normalized()
	end
	local forward = Vector(caster:GetForwardVector().x, caster:GetForwardVector().y, 0)
	if forward:Length2D() > 0.01 then
		return forward:Normalized()
	end
	return Vector(1, 0, 0)
end
function phantome_ab1_1.prototype.IsValidRepositionPoint(self, caster, targetPoint, point)
	if not self:IsMoveDistanceInRange(caster, point) then
		return false
	end
	if not self:IsValidMoveTarget(caster, point) then
		return false
	end
	if not GridNav:CanFindPath(targetPoint, point) then
		return false
	end
	return true
end
function phantome_ab1_1.prototype.IsMoveDistanceInRange(self, caster, point)
	local distance = point:__sub(caster:GetAbsOrigin()):Length2D()
	if distance < PHANTOME_AB1_REPOSITION_MIN_MOVE_DISTANCE then
		return false
	end
	if distance > PHANTOME_AB1_REPOSITION_MAX_MOVE_DISTANCE then
		return false
	end
	return true
end
function phantome_ab1_1.prototype.IsValidMoveTarget(self, caster, point)
	if not GridNav:IsTraversable(point) or GridNav:IsBlocked(point) then
		return false
	end
	if not GridNav:CanFindPath(caster:GetAbsOrigin(), point) then
		return false
	end
	return true
end
phantome_ab1_1 = __TS__DecorateLegacy({ registerAbility(nil) }, phantome_ab1_1)
local phantome_ab1_1_modifier_pre = __TS__Class()
phantome_ab1_1_modifier_pre.name = "phantome_ab1_1_modifier_pre"
__TS__ClassExtends(phantome_ab1_1_modifier_pre, BaseModifier_CS)
function phantome_ab1_1_modifier_pre.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.num = 0
	self.chargeStarted = false
end
function phantome_ab1_1_modifier_pre.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(PHANTOME_AB1_TARGET_SEARCH_RANGE)
	self:StartChargeWarning(caster, target)
end
function phantome_ab1_1_modifier_pre.prototype.StartChargeWarning(self, caster, lockedTarget)
	if self.chargeStarted then
		return
	end
	self.chargeStarted = true
	self.num = 0
	caster:SetAnimation("attack_spin_effigy")
	local ____IsValidAlive_result_6
	if IsValidAlive(nil, lockedTarget) then
		____IsValidAlive_result_6 = lockedTarget
	else
		____IsValidAlive_result_6 = caster:GetMinDistanceUnit(PHANTOME_AB1_TARGET_SEARCH_RANGE)
	end
	local target = ____IsValidAlive_result_6
	if target then
		caster:SetForwardVector(GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin()))
		caster:LockTargetForSpeed(target, PHANTOME_AB1_CHARGE_DURATION, 4)
	end
	local fow = caster:GetForwardVector()
	self.pfx = ParticleManager:CreateParticle(
		"particles/ui_mouseactions/range_finder_linear.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(self.pfx, 0, caster:GetAbsOrigin():__add(Vector(0, 0, 200)))
	ParticleManager:SetParticleControl(
		self.pfx,
		1,
		caster:GetAbsOrigin():__add(fow:__mul(100)):__add(Vector(0, 0, 200))
	)
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(300, 200, 800))
	ParticleManager:SetParticleControl(self.pfx, 4, fow)
	ParticleManager:SetParticleControl(self.pfx, 15, Vector(1, 0, 0))
	ParticleManager:SetParticleControlForward(self.pfx, 1, fow)
	self:StartIntervalThink(FrameTime())
end
function phantome_ab1_1_modifier_pre.prototype.OnIntervalThink(self)
	if not self.pfx then
		return
	end
	if not IsValidAlive(nil, self:GetCaster()) then
		return
	end
	local fow = self:GetCaster():GetForwardVector()
	self.num = self.num + 1
	ParticleManager:SetParticleControl(
		self.pfx,
		1,
		self:GetCaster():GetAbsOrigin():__add(fow:__mul(math.min(50, self.num) * 14)):__add(Vector(0, 0, 200))
	)
	ParticleManager:SetParticleControlForward(self.pfx, 1, fow)
end
function phantome_ab1_1_modifier_pre.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if IsValid(nil, caster) then
		caster:RemoveGesture(ACT_DOTA_RUN)
	end
	if self.pfx ~= nil then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
end
phantome_ab1_1_modifier_pre = __TS__DecorateLegacy({ registerModifier(nil) }, phantome_ab1_1_modifier_pre)
local phantome_ab1_1_modifier_start = __TS__Class()
phantome_ab1_1_modifier_start.name = "phantome_ab1_1_modifier_start"
__TS__ClassExtends(phantome_ab1_1_modifier_start, BaseModifier_CS)
function phantome_ab1_1_modifier_start.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.num = 0
end
function phantome_ab1_1_modifier_start.prototype.createDaggerProjectiles(self, dirs, getPosition, effectName)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	caster:EmitSound("Hero_PhantomAssassin.Dagger.Cast")
	__TS__ArrayForEach(dirs, function(____, dir)
		CreateProjectile(nil, {
			ability = ability,
			caster = caster,
			effect_name = effectName,
			target = getPosition(nil, dir),
			start_point = caster:GetAbsOrigin():__add(Vector(0, 0, 120)):__add(dir:__mul(100)),
			projectile_type = "linear",
			projectile_speed = 1400,
			projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS + DOTA_UNIT_TARGET_TREE,
			projectile_target_flags = DOTA_UNIT_TARGET_FLAG_RESPECT_OBSTRUCTIONS,
			projectile_distance = 3600,
			projectile_range = 50,
			on_hit = function(____, hitTarget, location)
				if not IsValidAlive(nil, hitTarget) then
					return true
				end
				if not hitTarget or not hitTarget:IsAlive() then
					return true
				end
				if not IsValidAlive(nil, caster) then
					return true
				end
				caster:MonsterDamage({ victim = hitTarget, damage_rate = 20, ability = ability, effectName = px2 })
				return true
			end,
		})
	end)
end
function phantome_ab1_1_modifier_start.prototype.OnCreated(self, params)
	local caster = self:GetCaster()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.1)
	local n = 0
	self:Timer(0, function()
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.3)
		local target = self:GetCaster():GetMinDistanceUnit(3500)
		local ____ = target and caster:LockTargetForSpeed(target, 0.32, 3.5)
		self:Timer(0.2, function()
			local fow = caster:GetForwardVector()
			local num = math.random(3, 5)
			local angle = math.random(18, 28)
			local arr = GetRotateVectors(nil, fow, num, angle)
			self:createDaggerProjectiles(arr, function(____, dir)
				return caster:GetOrigin():__add(dir:__mul(3600)):__add(Vector(0, 0, 150))
			end, "particles/boss/pa_persona_stifling_dagger.vpcf")
			self:Timer(0.15, function()
				local forward = caster:GetForwardVector()
				local nextArr = GetRotateVectors(nil, forward, num + 1, angle)
				self:createDaggerProjectiles(nextArr, function(____, dir)
					return caster:GetOrigin():__add(dir:__mul(math.random(2400, 3600)))
				end, "particles/boss/pa_persona_stifling_dagger.vpcf")
			end)
		end)
		n = n + 1
		if n >= 6 then
			return
		end
		return 0.7
	end)
end
phantome_ab1_1_modifier_start = __TS__DecorateLegacy({ registerModifier(nil) }, phantome_ab1_1_modifier_start)
return ____exports