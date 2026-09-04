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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local PRECAST_TIME = 1
local PROJECTILE_COUNT = 5
local SPAWN_RADIUS = 800
local MOVE_DISTANCE = 700
local MOVE_SPEED = 1500
local PROJECTILE_SPEED = 1500
local PROJECTILE_RANGE = 200
local DAMAGE_RATE = 8
local STUN_DURATION = 0.6
local IMPACT_RADIUS = 400
local PFX = "particles/units/monster/ember_spirit_fire_remnant_trail.vpcf"
local DASH_ACTIVE_PFX = "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test.vpcf"
local IMPACT_PFX = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
--- 生成背后均匀分布的阴影点
--
-- @param origin 施法者位置
-- @param forward 施法者朝向
-- @param count 需要的点数
-- @returns 均匀分布的起点数组
local function generateUniformBehindPoints(self, origin, forward, count)
	if count <= 0 then
		return {}
	end
	local points = {}
	local totalArc = 140
	local halfArc = totalArc / 2
	local zoneSize = totalArc / count
	do
		local i = 0
		while i < count do
			local zoneCenterAngle = -halfArc + zoneSize * (i + 0.5)
			local maxOffset = zoneSize * 0.4
			local randomOffset = RandomFloat(-maxOffset, maxOffset)
			local angle = zoneCenterAngle + randomOffset
			local backDir = RotateVector2D(nil, forward, 180 + angle)
			local distanceFactor = 1 - math.abs(angle) / halfArc * 0.4
			local dist = RandomFloat(200, SPAWN_RADIUS) * distanceFactor
			points[#points + 1] = origin:__add(backDir:__mul(dist))
			i = i + 1
		end
	end
	return points
end
local function createProjectileThinker(self, caster, ability, start, dir)
	if not IsServer() then
		return
	end
	local duration = MOVE_DISTANCE / PROJECTILE_SPEED
	local team = caster:GetTeamNumber()
	local thinker = CreateModifierThinker(
		caster,
		ability,
		"modifier_dummy_thinker",
		{ duration = duration + 3 },
		start,
		team,
		false
	)
	local pfx = ParticleManager:CreateParticle(DASH_ACTIVE_PFX, PATTACH_ABSORIGIN_FOLLOW, thinker)
	ParticleManager:SetParticleControl(pfx, 0, start)
	ParticleManager:SetParticleControlTransform(pfx, 0, thinker:GetAbsOrigin(), VectorToAngles(dir))
	local interval = FrameTime()
	local elapsed = 0
	Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, caster) or not IsValid(nil, thinker) or thinker:IsNull() then
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			if not IsValidAlive(nil, thinker) then
				return
			end
			if IsValid(nil, thinker) and not thinker:IsNull() then
				thinker:RemoveSelf()
			end
			return
		end
		elapsed = elapsed + interval
		local next = thinker:GetAbsOrigin():__add(dir:__mul(PROJECTILE_SPEED * interval))
		local groundZ = GetGroundHeight(next, thinker)
		local ____thinker_SetAbsOrigin_3 = thinker.SetAbsOrigin
		local ____next_x_1 = next.x
		local ____next_y_2 = next.y
		local ____temp_0
		if groundZ ~= nil then
			____temp_0 = groundZ
		else
			____temp_0 = next.z
		end
		____thinker_SetAbsOrigin_3(thinker, Vector(____next_x_1, ____next_y_2, ____temp_0))
		local pos = thinker:GetAbsOrigin()
		ParticleManager:SetParticleControl(pfx, 0, pos)
		thinker:SetForwardVector(dir)
		if elapsed >= duration then
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			return
		end
		return interval
	end)
end
--- 精英技能28 - 背后多点齐射 + 本体冲刺
____exports.elite_028 = __TS__Class()
local elite_028 = ____exports.elite_028
elite_028.name = "elite_028"
__TS__ClassExtends(elite_028, MonsterAbility_CS)
function elite_028.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self._points = {}
end
function elite_028.prototype.ApplyDamageAndStun(self, caster, target, position)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	caster:MonsterDamage({ victim = target, damage_rate = DAMAGE_RATE, ability = self })
	target:AddNewModifier(caster, self, "modifier_stunned", { duration = STUN_DURATION })
	local fow = caster:GetForwardVector()
	target:KnockBack(caster, self, {
		duration = 0.2,
		distance = 250,
		stun = true,
		stunDuration = 1,
		direction = fow,
	})
end
function elite_028.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = PRECAST_TIME,
		castRange = 1000,
		castDuration = MOVE_DISTANCE / MOVE_SPEED,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn("Hero_PrimalBeast.Onslaught.Cast", caster)
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local dashEnd = origin:__add(forward:__mul(MOVE_DISTANCE))
			self._dashEnd = dashEnd
			caster:Mover(origin:__add(forward:__mul(-250)), 0.25)
			self:WarningEffect(
				origin:__add(forward:__mul(-250)),
				dashEnd,
				PRECAST_TIME,
				{ startWidth = PROJECTILE_RANGE, endWidth = PROJECTILE_RANGE }
			)
			self._points = generateUniformBehindPoints(nil, origin, forward, PROJECTILE_COUNT)
			for ____, p in ipairs(self._points) do
				local ____end = p:__add(forward:__mul(MOVE_DISTANCE))
				self:WarningEffect(
					p,
					____end,
					PRECAST_TIME,
					{ startWidth = PROJECTILE_RANGE, endWidth = PROJECTILE_RANGE, type = 2 }
				)
			end
			self:Timer(0.8, function()
				caster:StartGesture(ACT_DOTA_CENTAUR_STAMPEDE)
			end)
		end,
		OnStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local forward = caster:GetForwardVector()
			local origin = caster:GetAbsOrigin()
			local dashEnd = self._dashEnd or origin:__add(forward:__mul(MOVE_DISTANCE))
			local ____table__points_length_4
			if #self._points then
				____table__points_length_4 = self._points
			else
				____table__points_length_4 = generateUniformBehindPoints(nil, origin, forward, PROJECTILE_COUNT)
			end
			local points = ____table__points_length_4
			for ____, start_point in ipairs(points) do
				local target = start_point:__add(forward:__mul(MOVE_DISTANCE))
				createProjectileThinker(nil, caster, self, start_point, forward)
				CreateProjectile(nil, {
					ability = self,
					caster = caster,
					effect_name = PFX,
					target = target,
					start_point = start_point,
					projectile_type = "linear",
					projectile_speed = PROJECTILE_SPEED,
					projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
					projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
					projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
					projectile_distance = MOVE_DISTANCE,
					projectile_range = PROJECTILE_RANGE,
					on_hit = function(____, hitTarget, position)
						if not IsValidAlive(nil, hitTarget) then
							return
						end
						if not hitTarget or not hitTarget:IsAlive() then
							return true
						end
						self:ApplyDamageAndStun(caster, hitTarget, position)
						return true
					end,
				})
			end
			local duration = MOVE_DISTANCE / MOVE_SPEED
			caster:AddNewModifier(caster, self, "modifier_elite_028_dash_anim", { duration = duration })
			caster:AddNewModifier(caster, self, "modifier_elite_028_speed_buff", { duration = duration + 1 })
			local dashPfx = ParticleManager:CreateParticle(DASH_ACTIVE_PFX, PATTACH_ABSORIGIN_FOLLOW, caster)
			ParticleManager:SetParticleControlEnt(
				dashPfx,
				0,
				caster,
				PATTACH_ABSORIGIN_FOLLOW,
				"attach_hitloc",
				Vector(0, 0, 0),
				true
			)
			Timers:CreateTimer(duration, function()
				ParticleManager:DestroyParticle(dashPfx, false)
				ParticleManager:ReleaseParticleIndex(dashPfx)
			end)
			local hit = __TS__New(Set)
			caster:Mover(dashEnd, duration, function(____, position)
				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					position,
					nil,
					PROJECTILE_RANGE,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				for ____, enemy in ipairs(enemies) do
					do
						if not IsValidAlive(nil, enemy) then
							goto __continue31
						end
						local key = tostring(enemy:entindex())
						if hit:has(key) then
							goto __continue31
						end
						hit:add(key)
						self:ApplyDamageAndStun(caster, enemy, position)
					end
					::__continue31::
				end
			end)
		end,
	}
end
elite_028 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_028)
____exports.elite_028 = elite_028
local modifier_elite_028_dash_anim = __TS__Class()
modifier_elite_028_dash_anim.name = "modifier_elite_028_dash_anim"
__TS__ClassExtends(modifier_elite_028_dash_anim, MonsterModifier_CS)
function modifier_elite_028_dash_anim.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_elite_028_dash_anim.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_elite_028_dash_anim.prototype.GetActivityTranslationModifiers(self)
	return "forcestaff_friendly"
end
function modifier_elite_028_dash_anim.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_elite_028_dash_anim.prototype.CheckState(self)
	return { [MODIFIER_STATE_COMMAND_RESTRICTED] = true }
end
function modifier_elite_028_dash_anim.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	Timers:CreateTimer(0.65, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local origin = caster:GetAbsOrigin()
		local pfx = ParticleManager:CreateParticle(IMPACT_PFX, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(pfx, 0, origin)
		ParticleManager:SetParticleControl(pfx, 1, Vector(IMPACT_RADIUS * 1.25, 2, IMPACT_RADIUS * 3))
		ParticleManager:SetParticleControl(pfx, 2, origin)
		ParticleManager:ReleaseParticleIndex(pfx)
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			origin,
			nil,
			IMPACT_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		ScreenShake(origin, 5, 5, 0.3, 1000, 0, true)
		EmitSoundOn("Hero_PrimalBeast.Onslaught", caster)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) then
					goto __continue45
				end
				AddDeBuffStatus(nil, enemy, caster, ability, DebuffStatusType.STUN, { duration = STUN_DURATION * 2 })
				caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE * 2, ability = ability })
			end
			::__continue45::
		end
	end)
end
function modifier_elite_028_dash_anim.prototype.IsHidden(self)
	return true
end
modifier_elite_028_dash_anim = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_028_dash_anim)
local modifier_elite_028_speed_buff = __TS__Class()
modifier_elite_028_speed_buff.name = "modifier_elite_028_speed_buff"
__TS__ClassExtends(modifier_elite_028_speed_buff, MonsterModifier_CS)
function modifier_elite_028_speed_buff.prototype.CheckState(self)
	return { [MODIFIER_STATE_COMMAND_RESTRICTED] = true }
end
function modifier_elite_028_speed_buff.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = 150 }
end
modifier_elite_028_speed_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_028_speed_buff)
return ____exports