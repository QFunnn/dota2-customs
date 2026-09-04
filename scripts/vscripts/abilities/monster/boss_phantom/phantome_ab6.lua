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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local px2 = "particles/void_spirit_astral_step_impact_blue.vpcf"
local PHANTOME_AB6_PRE_MOVE_FINISH_DISTANCE = 64
local PHANTOME_AB6_PRE_MOVE_MIN_SPEED = 900
local PHANTOME_AB6_ROUND_COUNT = 6
local PHANTOME_AB6_INITIAL_PROJECTILE_COUNT = 6
local PHANTOME_AB6_PROJECTILE_COUNT_INCREMENT = 2
local PHANTOME_AB6_ROUND_INTERVAL = 1
local PHANTOME_AB6_CAST_DURATION = PHANTOME_AB6_ROUND_INTERVAL * (PHANTOME_AB6_ROUND_COUNT - 1) + 1
local PHANTOME_AB6_PROJECTILE_DISTANCE = 3600
local PHANTOME_AB6_PROJECTILE_SPEED = 1000
local PHANTOME_AB6_PROJECTILE_RANGE = 50
local PHANTOME_AB6_ANIMATION_POOL = { "c4_fan_of_knives", "attack_swing" }
local phantome_ab6 = __TS__Class()
phantome_ab6.name = "phantome_ab6"
__TS__ClassExtends(phantome_ab6, MonsterAbility_CS)
function phantome_ab6.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.8,
		castDuration = PHANTOME_AB6_CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnPrePhaseMove = function(____, done)
			return self:StartPrePhaseMove(done)
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:RemoveGesture(ACT_DOTA_RUN)
			caster:SetAnimation("attack_swing")
			caster:SetAbsOrigin(self:ResolveSpawnPoint(caster))
			local pfx_name =
				"particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_event_glitch_load.vpcf"
			local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
			ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
			self:armParticleLifetime(pfx, 0.65)
		end,
		OnStart = function()
			self:StartBarrage()
		end,
		OnInterrupt = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:RemoveGesture(ACT_DOTA_RUN)
			caster:Stop()
		end,
	}
end
function phantome_ab6.prototype.StartPrePhaseMove(self, done)
	if not IsServer() then
		done(nil)
		return
	end
	local caster = self:GetCaster()
	local spawnPoint = self:ResolveSpawnPoint(caster)
	local moveDistance = spawnPoint:__sub(caster:GetAbsOrigin()):Length2D()
	if moveDistance <= PHANTOME_AB6_PRE_MOVE_FINISH_DISTANCE then
		done(nil)
		return
	end
	local moveDirection = GetDirection(nil, spawnPoint, caster:GetAbsOrigin())
	local moveDuration = self:GetPreMoveDuration(caster, moveDistance)
	local finished = false
	local function finishMove()
		if finished then
			return
		end
		finished = true
		if IsValidAlive(nil, caster) then
			caster:RemoveGesture(ACT_DOTA_RUN)
		end
		done(nil)
	end
	caster:SetForwardVector(moveDirection)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_RUN, 1.35)
	caster:Mover(spawnPoint, moveDuration, function(____, position)
		if position:__sub(spawnPoint):Length2D() > PHANTOME_AB6_PRE_MOVE_FINISH_DISTANCE then
			return
		end
		finishMove(nil)
		return true
	end, false, true)
	self:Timer(moveDuration + FrameTime(), finishMove)
end
function phantome_ab6.prototype.ResolveSpawnPoint(self, caster)
	local ____this_1
	____this_1 = caster
	local ____opt_0 = ____this_1.GetSpawnPoint
	local spawnPoint = ____opt_0 and ____opt_0(____this_1) or caster:GetAbsOrigin()
	return GetGroundPosition(spawnPoint, caster)
end
function phantome_ab6.prototype.GetPreMoveDuration(self, caster, distance)
	local speed = math.max(caster:GetIdealSpeed(), PHANTOME_AB6_PRE_MOVE_MIN_SPEED)
	return math.max(distance / speed, FrameTime())
end
function phantome_ab6.prototype.armParticleLifetime(self, pid, lifeSec)
	if not IsServer() then
		return
	end
	local done = false
	Timers:CreateTimer(lifeSec, function()
		if done then
			return nil
		end
		done = true
		ParticleManager:DestroyParticle(pid, false)
		ParticleManager:ReleaseParticleIndex(pid)
		return nil
	end)
end
function phantome_ab6.prototype.StartBarrage(self)
	local caster = self:GetCaster()
	caster:SetAnimation(PHANTOME_AB6_ANIMATION_POOL[math.random(0, #PHANTOME_AB6_ANIMATION_POOL - 1) + 1])
	do
		local roundIndex = 0
		while roundIndex < PHANTOME_AB6_ROUND_COUNT do
			local currentRoundIndex = roundIndex
			local projectileCount = PHANTOME_AB6_INITIAL_PROJECTILE_COUNT
				+ currentRoundIndex * PHANTOME_AB6_PROJECTILE_COUNT_INCREMENT
			local angleStep = 360 / projectileCount
			local angleOffset = currentRoundIndex * (angleStep / 2)
			local delay = currentRoundIndex * PHANTOME_AB6_ROUND_INTERVAL
			self:Timer(delay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:SetAnimation(PHANTOME_AB6_ANIMATION_POOL[math.random(0, #PHANTOME_AB6_ANIMATION_POOL - 1) + 1])
				local rate = math.random(0, 30)
				self:Timer(0.35, function()
					self:createDaggerProjectiles(projectileCount, angleOffset + rate)
					self:Timer(0.25, function()
						self:createDaggerProjectiles(projectileCount, angleOffset + 180 / projectileCount + rate)
					end)
					if currentRoundIndex == PHANTOME_AB6_ROUND_COUNT - 1 then
						self:Timer(0.35, function()
							self:createDaggerProjectiles(projectileCount, angleOffset + rate)
						end)
					end
				end)
			end)
			roundIndex = roundIndex + 1
		end
	end
end
function phantome_ab6.prototype.createDaggerProjectiles(self, projectileCount, angleOffset)
	local caster = self:GetCaster()
	local ability = self
	local origin = caster:GetAbsOrigin()
	local baseForward = RotateVector2D(nil, caster:GetForwardVector(), angleOffset)
	local dirs = GetRotateVectors(nil, baseForward, projectileCount, 360 / projectileCount)
	caster:EmitSound("Hero_PhantomAssassin.Dagger.Cast")
	__TS__ArrayForEach(dirs, function(____, dir)
		CreateProjectile(nil, {
			ability = ability,
			caster = caster,
			effect_name = "particles/boss/pa_persona_stifling_dagger.vpcf",
			target = origin:__add(dir:__mul(PHANTOME_AB6_PROJECTILE_DISTANCE)):__add(Vector(0, 0, 150)),
			start_point = origin:__add(dir:__mul(100)):__add(Vector(0, 0, 60)),
			projectile_type = "linear",
			projectile_speed = PHANTOME_AB6_PROJECTILE_SPEED,
			projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			projectile_target_flags = DOTA_UNIT_TARGET_FLAG_RESPECT_OBSTRUCTIONS,
			projectile_distance = PHANTOME_AB6_PROJECTILE_DISTANCE,
			projectile_range = PHANTOME_AB6_PROJECTILE_RANGE,
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
				caster:MonsterDamage({ victim = hitTarget, damage_rate = 15, ability = ability, effectName = px2 })
				return true
			end,
		})
	end)
end
phantome_ab6 = __TS__DecorateLegacy({ registerAbility(nil) }, phantome_ab6)
return ____exports