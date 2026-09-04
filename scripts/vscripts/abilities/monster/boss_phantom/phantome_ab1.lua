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
local PHANTOME_AB1_CHARGE_DURATION = 0.7
local PHANTOME_AB1_TARGET_SEARCH_RANGE = 3500
local PHANTOME_AB1_AWAY_MOVE_DISTANCE = 500
local PHANTOME_AB1_MAX_TARGET_DISTANCE = 1200
local PHANTOME_AB1_AWAY_MOVE_FINISH_DISTANCE = 64
local PHANTOME_AB1_AWAY_MOVE_MIN_SPEED = 900
local phantome_ab1 = __TS__Class()
phantome_ab1.name = "phantome_ab1"
__TS__ClassExtends(phantome_ab1, MonsterAbility_CS)
function phantome_ab1.prototype.GetMosnterAbilityConfig(self)
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
				"phantome_ab1_modifier_pre",
				{ duration = PHANTOME_AB1_CHARGE_DURATION }
			)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:AddNewModifier(caster, self, "phantome_ab1_modifier_start", { duration = 4.5 })
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
function phantome_ab1.prototype.StartPrePhaseMove(self, done)
	if not IsServer() then
		done(nil)
		return
	end
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(PHANTOME_AB1_TARGET_SEARCH_RANGE)
	if not target then
		done(nil)
		return
	end
	local movePoint = self:ResolveAwayFromTargetMovePoint(caster, target)
	local moveDistance = movePoint:__sub(caster:GetAbsOrigin()):Length2D()
	if moveDistance <= PHANTOME_AB1_AWAY_MOVE_FINISH_DISTANCE then
		done(nil)
		return
	end
	local moveDirection = GetDirection(nil, movePoint, caster:GetAbsOrigin())
	local moveDuration = self:GetAwayMoveDuration(caster, moveDistance)
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
		if position:__sub(movePoint):Length2D() > PHANTOME_AB1_AWAY_MOVE_FINISH_DISTANCE then
			return
		end
		finishMove(nil)
		return true
	end, false, true)
	self:Timer(moveDuration + FrameTime(), finishMove)
end
function phantome_ab1.prototype.GetAwayMoveDuration(self, caster, distance)
	local speed = math.max(caster:GetIdealSpeed(), PHANTOME_AB1_AWAY_MOVE_MIN_SPEED)
	return math.max(distance / speed, FrameTime())
end
function phantome_ab1.prototype.ResolveAwayFromTargetMovePoint(self, caster, target)
	local casterPoint = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local targetPoint = GetGroundPosition(target:GetAbsOrigin(), target)
	local currentTargetDistance = casterPoint:__sub(targetPoint):Length2D()
	local distanceBudget = PHANTOME_AB1_MAX_TARGET_DISTANCE - currentTargetDistance
	if distanceBudget <= PHANTOME_AB1_AWAY_MOVE_FINISH_DISTANCE then
		return casterPoint
	end
	local awayDirection = self:ResolveAwayFromTargetDirection(caster, casterPoint, targetPoint)
	local moveDistance = math.min(PHANTOME_AB1_AWAY_MOVE_DISTANCE, distanceBudget)
	local moveDistances = { moveDistance, moveDistance * 0.8, moveDistance * 0.6, moveDistance * 0.4 }
	local angles = {
		0,
		20,
		-20,
		40,
		-40,
		60,
		-60,
		80,
		-80,
		90,
		-90,
	}
	for ____, candidateDistance in ipairs(moveDistances) do
		for ____, angle in ipairs(angles) do
			local direction = RotateVector2D(nil, awayDirection, angle)
			local candidate = GetGroundPosition(casterPoint:__add(direction:__mul(candidateDistance)), caster)
			if self:IsValidAwayMovePoint(caster, targetPoint, currentTargetDistance, candidate) then
				return candidate
			end
		end
	end
	return casterPoint
end
function phantome_ab1.prototype.ResolveAwayFromTargetDirection(self, caster, casterPoint, targetPoint)
	local fromTargetToCaster = Vector(casterPoint.x - targetPoint.x, casterPoint.y - targetPoint.y, 0)
	if fromTargetToCaster:Length2D() > 0.01 then
		return fromTargetToCaster:Normalized()
	end
	local forward = Vector(caster:GetForwardVector().x, caster:GetForwardVector().y, 0)
	if forward:Length2D() > 0.01 then
		return forward:Normalized()
	end
	return Vector(1, 0, 0)
end
function phantome_ab1.prototype.IsValidAwayMovePoint(self, caster, targetPoint, currentTargetDistance, point)
	local casterPoint = caster:GetAbsOrigin()
	local moveDistance = point:__sub(casterPoint):Length2D()
	if moveDistance <= PHANTOME_AB1_AWAY_MOVE_FINISH_DISTANCE then
		return false
	end
	local targetDistance = point:__sub(targetPoint):Length2D()
	if targetDistance <= currentTargetDistance + 1 then
		return false
	end
	if targetDistance > PHANTOME_AB1_MAX_TARGET_DISTANCE then
		return false
	end
	if not GridNav:IsTraversable(point) or GridNav:IsBlocked(point) then
		return false
	end
	if not GridNav:CanFindPath(casterPoint, point) then
		return false
	end
	return true
end
phantome_ab1 = __TS__DecorateLegacy({ registerAbility(nil) }, phantome_ab1)
local phantome_ab1_modifier_pre = __TS__Class()
phantome_ab1_modifier_pre.name = "phantome_ab1_modifier_pre"
__TS__ClassExtends(phantome_ab1_modifier_pre, BaseModifier_CS)
function phantome_ab1_modifier_pre.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.num = 0
end
function phantome_ab1_modifier_pre.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self:GetCaster():SetAnimation("attack_spin_effigy")
	local target = self:GetCaster():GetMinDistanceUnit(PHANTOME_AB1_TARGET_SEARCH_RANGE)
	local ____target_0
	if target then
		____target_0 = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	else
		____target_0 = caster:GetForwardVector()
	end
	local forward = ____target_0
	if target then
		caster:LockTargetForSpeed(target, 0.5, 4)
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
function phantome_ab1_modifier_pre.prototype.OnIntervalThink(self)
	if self.pfx then
		if not IsValidAlive(nil, self:GetCaster()) then
			return
		end
		local fow = self:GetCaster():GetForwardVector()
		self.num = self.num + 1
		ParticleManager:SetParticleControl(
			self.pfx,
			1,
			self:GetCaster():GetAbsOrigin():__add(fow:__mul(math.min(50, self.num) * 17)):__add(Vector(0, 0, 200))
		)
		ParticleManager:SetParticleControlForward(self.pfx, 1, fow)
	end
end
function phantome_ab1_modifier_pre.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	ParticleManager:DestroyParticle(self.pfx, false)
	ParticleManager:ReleaseParticleIndex(self.pfx)
end
phantome_ab1_modifier_pre = __TS__DecorateLegacy({ registerModifier(nil) }, phantome_ab1_modifier_pre)
local phantome_ab1_modifier_start = __TS__Class()
phantome_ab1_modifier_start.name = "phantome_ab1_modifier_start"
__TS__ClassExtends(phantome_ab1_modifier_start, BaseModifier_CS)
function phantome_ab1_modifier_start.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.num = 0
end
function phantome_ab1_modifier_start.prototype.createDaggerProjectiles(self, dirs, getPosition, effectName)
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
function phantome_ab1_modifier_start.prototype.OnCreated(self, params)
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
phantome_ab1_modifier_start = __TS__DecorateLegacy({ registerModifier(nil) }, phantome_ab1_modifier_start)
return ____exports