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
local __TS__NumberToFixed = ____lualib.__TS__NumberToFixed
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local BOSS_BEAST_FIRST_PREPARE_DURATION = 2.1
local BOSS_BEAST_SECOND_PREPARE_DURATION = 2.4
local BOSS_BEAST_CHARGE_DURATION = 1
local BOSS_BEAST_CHARGE_COUNT = 2
local BOSS_BEAST_BLOCK_RECOVERY_DURATION = 0.3
local BOSS_BEAST_REAIM_RANGE = 3500
local BOSS_BEAST_SLAM_CYCLE_DURATION = 0.73
local BOSS_BEAST_SLAM_HOLD_DURATION = 0.33
local BOSS_BEAST_SLAM_LIFT_DURATION = 0.37
local BOSS_BEAST_SLAM_COUNT = 3
local BOSS_BEAST_SLAM_START_HEIGHT = 75
local BOSS_BEAST_SLAM_RAISE_ANGLE = 45
local BOSS_BEAST_SLAM_ARM_LENGTH = 250
local BOSS_BEAST_SLAM_MAX_HEIGHT = BOSS_BEAST_SLAM_START_HEIGHT
	+ BOSS_BEAST_SLAM_ARM_LENGTH * math.sin(BOSS_BEAST_SLAM_RAISE_ANGLE * math.pi / 180)
local BOSS_BEAST_SLAM_DAMAGE_RATE = 35
local BOSS_BEAST_SLAM_IMPACT_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf"
local BOSS_BEAST_SLAM_IMPACT_RADIUS = 500
local BOSS_BEAST_SLAM_STUN_DURATION = 1
local BOSS_BEAST_SLAM_ANIMATION_RELEASE_DELAY = 0.2
local BOSS_BEAST_SLAM_INERTIA_DURATION = 0.5
local BOSS_BEAST_SLAM_INERTIA_DISTANCE = 300
local function DebugBossBeast1(self, message) end
local boss_beast_5 = __TS__Class()
boss_beast_5.name = "boss_beast_5"
__TS__ClassExtends(boss_beast_5, MonsterAbility_CS)
function boss_beast_5.prototype.Precache(self, context)
	PrecacheResource("particle", BOSS_BEAST_SLAM_IMPACT_PARTICLE, context)
end
function boss_beast_5.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 2.3,
		castDuration = BOSS_BEAST_CHARGE_DURATION * BOSS_BEAST_CHARGE_COUNT
			+ BOSS_BEAST_SECOND_PREPARE_DURATION
			+ BOSS_BEAST_SLAM_CYCLE_DURATION * BOSS_BEAST_SLAM_COUNT
			+ 0.1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster.onslaught_count = 0
			caster.onslaught_max_count = BOSS_BEAST_CHARGE_COUNT
			DebugBossBeast1(
				nil,
				(
					((("OnPhaseStart caster=" .. caster:GetUnitName()) .. " ent=") .. tostring(caster:entindex()))
					.. " count=0 max="
				) .. tostring(BOSS_BEAST_CHARGE_COUNT)
			)
			caster:AddNewModifier(
				caster,
				self,
				"modifier_boss_beast_5_pre",
				{ duration = BOSS_BEAST_FIRST_PREPARE_DURATION }
			)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			DebugBossBeast1(
				nil,
				(
					((("OnStart caster=" .. caster:GetUnitName()) .. " ent=") .. tostring(caster:entindex()))
					.. " add move duration="
				) .. tostring(BOSS_BEAST_CHARGE_DURATION)
			)
			caster:AddNewModifier(caster, self, "modifier_boss_beast_5_move", { duration = BOSS_BEAST_CHARGE_DURATION })
		end,
	}
end
boss_beast_5 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_beast_5)
--- 蓄力阶段：后撤、索敌转向、预警线伸长、禁攻禁转身
local modifier_boss_beast_5_pre = __TS__Class()
modifier_boss_beast_5_pre.name = "modifier_boss_beast_5_pre"
__TS__ClassExtends(modifier_boss_beast_5_pre, BaseModifier_CS)
function modifier_boss_beast_5_pre.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	DebugBossBeast1(
		nil,
		(
			(
				(
					((("pre OnCreated caster=" .. caster:GetUnitName()) .. " ent=") .. tostring(caster:entindex()))
					.. " duration="
				) .. tostring(params.duration)
			) .. " abilityValid="
		) .. tostring(IsValid(nil, ability))
	)
	caster:AddNewModifier(caster, ability, "mo_mian_modfier", { duration = params.duration + 0.5 })
	caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-350)), 1)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.4)
	EmitSoundOn("Hero_PrimalBeast.Onslaught.Channel", caster)
	local pfxSoul = "particles/enigma_2_death_soul_c2.vpcf"
	local soulId = ParticleManager:CreateParticle(pfxSoul, PATTACH_ABSORIGIN_FOLLOW, caster)
	local soulDone = false
	local function tryReleaseSoul()
		if not IsServer() or soulDone then
			return
		end
		soulDone = true
		ParticleManager:ReleaseParticleIndex(soulId)
	end
	self.releaseSoulPfx = tryReleaseSoul
	Timers:CreateTimer(3, function()
		tryReleaseSoul(nil)
		return nil
	end)
	self:Timer(0.3, function()
		if not IsValidAlive(nil, caster) or self:IsNull() then
			return
		end
		self.dumy = CreateModifierThinker(
			caster,
			ability,
			"modifier_dummy_thinker",
			{ duration = 6 },
			caster:GetOrigin():__add(caster:GetForwardVector():__mul(80)),
			caster:GetTeamNumber(),
			false
		)
		if not IsValidAlive(nil, self.dumy) then
			self:Destroy()
			return
		end
		local pfxName = "particles/primal_beast_onslaught_range_finder_max.vpcf"
		self.pfx = ParticleManager:CreateParticleForTeam(pfxName, PATTACH_CENTER_FOLLOW, caster, DOTA_TEAM_GOODGUYS)
		ParticleManager:SetParticleControl(self.pfx, 4, Vector(255, 0, 0))
		ParticleManager:SetParticleControl(self.pfx, 0, caster:GetOrigin())
		ParticleManager:SetParticleControl(self.pfx, 1, self.dumy:GetOrigin())
		local ambientId =
			ParticleManager:CreateParticle("particles/phoenix_ambient_red.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		local ambientDone = false
		local function tryReleaseAmbient()
			if not IsServer() or ambientDone then
				return
			end
			ambientDone = true
			ParticleManager:DestroyParticle(ambientId, false)
			ParticleManager:ReleaseParticleIndex(ambientId)
		end
		self.releaseAmbientPfx = tryReleaseAmbient
		Timers:CreateTimer(3, function()
			tryReleaseAmbient(nil)
			return nil
		end)
		self:StartIntervalThink(0.03)
	end)
end
function modifier_boss_beast_5_pre.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, self.dumy) then
		self:Destroy()
		return
	end
	local target = caster:GetMinDistanceUnit(BOSS_BEAST_REAIM_RANGE)
	if target then
		caster:LockTargetForSpeed(target, 0.03, 3)
	end
	self:SetStackCount(self:GetStackCount() + 1)
	local dis = math.min(2500, self:GetStackCount() * 40)
	self.dumy:SetOrigin(caster:GetOrigin():__add(caster:GetForwardVector():__mul(dis)))
	if self.pfx then
		ParticleManager:SetParticleControl(self.pfx, 1, self.dumy:GetOrigin())
	end
end
function modifier_boss_beast_5_pre.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		DebugBossBeast1(
			nil,
			(("pre OnDestroy caster=" .. caster:GetUnitName()) .. " ent=") .. tostring(caster:entindex())
		)
	end
	local ____opt_0 = self.releaseSoulPfx
	if ____opt_0 ~= nil then
		____opt_0(self)
	end
	local ____opt_2 = self.releaseAmbientPfx
	if ____opt_2 ~= nil then
		____opt_2(self)
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, true)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
	if self.dumy and IsValid(nil, self.dumy) and not self.dumy:IsNull() then
		self.dumy:RemoveSelf()
	end
end
function modifier_boss_beast_5_pre.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING, MODIFIER_PROPERTY_IGNORE_CAST_ANGLE }
end
function modifier_boss_beast_5_pre.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_boss_beast_5_pre.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_boss_beast_5_pre.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
modifier_boss_beast_5_pre = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_5_pre)
--- 冲刺阶段：逐帧位移、撞敌伤害击退、撞墙后撤；结束时驱动下一段蓄力/冲刺
local modifier_boss_beast_5_move = __TS__Class()
modifier_boss_beast_5_move.name = "modifier_boss_beast_5_move"
__TS__ClassExtends(modifier_boss_beast_5_move, BaseModifier_CS)
function modifier_boss_beast_5_move.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.caught_enemies = {}
	self.isBlocked = false
	self.hasGrabbedTarget = false
end
function modifier_boss_beast_5_move.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local count = parent.onslaught_count or 0
	local maxCount = parent.onslaught_max_count or 1
	DebugBossBeast1(
		nil,
		(
			(
				(
					(
						(
							(
								(("move OnCreated parent=" .. parent:GetUnitName()) .. " ent=")
								.. tostring(parent:entindex())
							) .. " count="
						) .. tostring(count)
					) .. " max="
				) .. tostring(maxCount)
			) .. " duration="
		) .. tostring(self:GetDuration())
	)
	caster:EmitSound("Hero_PrimalBeast.Onslaught.Cast")
	local pfxName = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf"
	local pfx = ParticleManager:CreateParticle(pfxName, PATTACH_ABSORIGIN_FOLLOW, caster)
	self:AddParticle(pfx, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
	ScreenShake(caster:GetAbsOrigin(), 5, 2, 2, 4000, 0, true)
end
function modifier_boss_beast_5_move.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local forward = parent:GetForwardVector()
	local newPos = parent:GetOrigin() + forward * 130
	GridNav:DestroyTreesAroundPoint(newPos, 400, false)
	if GridNav:IsBlocked(newPos) or not GridNav:IsTraversable(newPos) then
		self.isBlocked = true
		DebugBossBeast1(
			nil,
			(
				(
					(
						(
							(
								(("move blocked ent=" .. tostring(parent:entindex())) .. " pos=(")
								.. __TS__NumberToFixed(newPos.x, 0)
							) .. ", "
						) .. __TS__NumberToFixed(newPos.y, 0)
					) .. ", "
				) .. __TS__NumberToFixed(newPos.z, 0)
			) .. ")"
		)
		self:Destroy()
		parent:AddNewModifier(parent, nil, "modifier_stunned", { duration = BOSS_BEAST_BLOCK_RECOVERY_DURATION })
		parent:Mover(parent:GetAbsOrigin() - forward * 250, BOSS_BEAST_BLOCK_RECOVERY_DURATION)
		return
	end
	parent:SetOrigin(newPos)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		280,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	__TS__ArrayForEach(enemies, function(____, unit)
		if not self.hasGrabbedTarget and not __TS__ArrayIncludes(self.caught_enemies, unit) and unit ~= parent then
			if not IsValidAlive(nil, parent) then
				return
			end
			if not IsValidAlive(nil, unit) then
				return
			end
			local ____self_caught_enemies_4 = self.caught_enemies
			____self_caught_enemies_4[#____self_caught_enemies_4 + 1] = unit
			self.hasGrabbedTarget = true
			parent.boss_beast_5_grabbed_target = unit
			unit:AddNewModifier(
				parent,
				self:GetAbility(),
				"modifier_boss_beast_5_slam",
				{ caster_entindex = parent:entindex() }
			)
			self:Destroy()
		end
	end)
end
function modifier_boss_beast_5_move.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) then
		return
	end
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
	if self.hasGrabbedTarget or parent.boss_beast_5_grabbed_target then
		parent.boss_beast_5_on_slam = false
		parent.onslaught_count = 0
		parent.onslaught_max_count = 1
		return
	end
	local count = parent.onslaught_count or 0
	local maxCount = parent.onslaught_max_count or 1
	count = count + 1
	parent.onslaught_count = count
	DebugBossBeast1(
		nil,
		(
			(
				(
					(
						(
							((("move OnDestroy ent=" .. tostring(parent:entindex())) .. " count=") .. tostring(count))
							.. " max="
						) .. tostring(maxCount)
					) .. " abilityValid="
				) .. tostring(IsValid(nil, ability))
			) .. " alive="
		) .. tostring(IsValidAlive(nil, parent))
	)
	if count >= maxCount then
		DebugBossBeast1(nil, ("move finished all charges ent=" .. tostring(parent:entindex())) .. " reset count")
		parent.onslaught_count = 0
		parent.onslaught_max_count = 1
		return
	end
	local ____table_isBlocked_5
	if self.isBlocked then
		____table_isBlocked_5 = BOSS_BEAST_BLOCK_RECOVERY_DURATION + FrameTime()
	else
		____table_isBlocked_5 = FrameTime()
	end
	local nextPrepareDelay = ____table_isBlocked_5
	DebugBossBeast1(
		nil,
		(
			(
				(("move schedule next prepare ent=" .. tostring(parent:entindex())) .. " delay=")
				.. tostring(nextPrepareDelay)
			) .. " blocked="
		) .. tostring(self.isBlocked)
	)
	Timers:CreateTimer(nextPrepareDelay, function()
		if not IsValidAlive(nil, parent) then
			return
		end
		DebugBossBeast1(
			nil,
			(
				(
					(("move next prepare timer fired ent=" .. tostring(parent:entindex())) .. " abilityValid=")
					.. tostring(IsValid(nil, ability))
				) .. " alive="
			) .. tostring(IsValidAlive(nil, parent))
		)
		if not IsValidAlive(nil, parent) or not IsValid(nil, ability) then
			DebugBossBeast1(nil, "move next prepare canceled ent=" .. tostring(parent:entindex()))
			return
		end
		DebugBossBeast1(
			nil,
			(("move add next prepare ent=" .. tostring(parent:entindex())) .. " duration=")
				.. tostring(BOSS_BEAST_SECOND_PREPARE_DURATION)
		)
		parent:AddNewModifier(
			parent,
			ability,
			"modifier_boss_beast_5_pre",
			{ duration = BOSS_BEAST_SECOND_PREPARE_DURATION - 0.1 }
		)
		parent:AddNewModifier(
			parent,
			ability,
			"modifier_monster_cast_pre_progress",
			{ time = BOSS_BEAST_SECOND_PREPARE_DURATION }
		)
		Timers:CreateTimer(BOSS_BEAST_SECOND_PREPARE_DURATION, function()
			if not IsValidAlive(nil, parent) then
				return
			end
			DebugBossBeast1(
				nil,
				(
					(
						(("move next charge timer fired ent=" .. tostring(parent:entindex())) .. " abilityValid=")
						.. tostring(IsValid(nil, ability))
					) .. " alive="
				) .. tostring(IsValidAlive(nil, parent))
			)
			if not IsValidAlive(nil, parent) or not IsValid(nil, ability) then
				DebugBossBeast1(nil, "move next charge canceled ent=" .. tostring(parent:entindex()))
				return
			end
			DebugBossBeast1(
				nil,
				(("move add next charge ent=" .. tostring(parent:entindex())) .. " duration=")
					.. tostring(BOSS_BEAST_CHARGE_DURATION)
			)
			parent:AddNewModifier(
				parent,
				ability,
				"modifier_boss_beast_5_move",
				{ duration = BOSS_BEAST_CHARGE_DURATION }
			)
			return nil
		end)
		return nil
	end)
end
function modifier_boss_beast_5_move.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_boss_beast_5_move.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
function modifier_boss_beast_5_move.prototype.GetOverrideAnimationRate(self)
	return 1.5
end
function modifier_boss_beast_5_move.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_boss_beast_5_move.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_boss_beast_5_move.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
modifier_boss_beast_5_move = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_5_move)
--- 摔砸状态：目标以施法者为圆心，沿固定手臂长度的圆弧抬升后落地。
-- 位置由服务端逐帧控制，避免强制动作的挂载点与客户端骨骼时间轴不同步。
local modifier_boss_beast_5_slam = __TS__Class()
modifier_boss_beast_5_slam.name = "modifier_boss_beast_5_slam"
__TS__ClassExtends(modifier_boss_beast_5_slam, BaseModifier_CS)
function modifier_boss_beast_5_slam.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.forward = Vector(1, 0, 0)
	self.groundZ = 0
	self.cycleIndex = 0
	self.cycleStartTime = 0
	self.initialTargetDistance = 0
end
function modifier_boss_beast_5_slam.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ____params_caster_entindex_6
	if params.caster_entindex then
		____params_caster_entindex_6 = EntIndexToHScript(params.caster_entindex)
	else
		____params_caster_entindex_6 = self:GetCaster()
	end
	self.caster = ____params_caster_entindex_6
	self.ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, self.caster) then
		self:Destroy()
		return
	end
	self.forward = self.caster:GetForwardVector()
	self.groundZ = parent:GetAbsOrigin().z
	local casterOrigin = self.caster:GetAbsOrigin()
	local targetOrigin = parent:GetAbsOrigin()
	self.initialTargetDistance = Vector(targetOrigin.x - casterOrigin.x, targetOrigin.y - casterOrigin.y, 0):Length2D()
	self.cycleStartTime = GameRules:GetGameTime()
	self.caster.boss_beast_5_slam_target = parent
	self.caster:AddNewModifier(
		self.caster,
		self.ability,
		"modifier_boss_beast_5_slam_animation",
		{
			duration = BOSS_BEAST_SLAM_CYCLE_DURATION * BOSS_BEAST_SLAM_COUNT
				+ BOSS_BEAST_SLAM_ANIMATION_RELEASE_DELAY
				+ FrameTime(),
		}
	)
	parent:EmitSound("Hero_PrimalBeast.Pulverize.Cast")
	self:ScheduleSlamImpact(BOSS_BEAST_SLAM_HOLD_DURATION + BOSS_BEAST_SLAM_LIFT_DURATION)
	self:ScheduleSlamImpact(
		BOSS_BEAST_SLAM_CYCLE_DURATION + BOSS_BEAST_SLAM_HOLD_DURATION + BOSS_BEAST_SLAM_LIFT_DURATION
	)
	self:ScheduleSlamImpact(
		BOSS_BEAST_SLAM_CYCLE_DURATION * 2 + BOSS_BEAST_SLAM_HOLD_DURATION + BOSS_BEAST_SLAM_LIFT_DURATION
	)
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_beast_5_slam.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self.caster
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local elapsed = GameRules:GetGameTime() - self.cycleStartTime
	if elapsed >= BOSS_BEAST_SLAM_CYCLE_DURATION then
		self.cycleIndex = self.cycleIndex + 1
		if self.cycleIndex >= BOSS_BEAST_SLAM_COUNT then
			self:Destroy()
			return
		end
		self.cycleStartTime = GameRules:GetGameTime()
	end
	local phase = GameRules:GetGameTime() - self.cycleStartTime
	local position = self:CalculateSlamPosition(caster, phase)
	parent:SetAbsOrigin(position)
end
function modifier_boss_beast_5_slam.prototype.ScheduleSlamImpact(self, delay)
	self:Timer(delay, function()
		if not IsServer() or self:IsNull() then
			return
		end
		local parent = self:GetParent()
		local caster = self.caster
		if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
			return
		end
		self:ApplySlamImpact(parent, caster)
	end)
end
function modifier_boss_beast_5_slam.prototype.CalculateSlamPosition(self, caster, phase)
	local casterOrigin = caster:GetAbsOrigin()
	local clampedPhase = math.min(BOSS_BEAST_SLAM_CYCLE_DURATION, math.max(0, phase))
	if clampedPhase >= BOSS_BEAST_SLAM_HOLD_DURATION + BOSS_BEAST_SLAM_LIFT_DURATION then
		local horizontalAtImpact = BOSS_BEAST_SLAM_ARM_LENGTH * math.cos(BOSS_BEAST_SLAM_RAISE_ANGLE * math.pi / 180)
		local impactOrigin = casterOrigin:__add(self.forward:__mul(horizontalAtImpact))
		return Vector(impactOrigin.x, impactOrigin.y, self.groundZ)
	end
	local angle = 0
	if clampedPhase > BOSS_BEAST_SLAM_HOLD_DURATION then
		local liftProgress = math.min(1, (clampedPhase - BOSS_BEAST_SLAM_HOLD_DURATION) / BOSS_BEAST_SLAM_LIFT_DURATION)
		angle = BOSS_BEAST_SLAM_RAISE_ANGLE * liftProgress
	end
	local radians = angle * math.pi / 180
	local horizontal = BOSS_BEAST_SLAM_ARM_LENGTH * math.cos(radians)
	local maxRaiseRadians = BOSS_BEAST_SLAM_RAISE_ANGLE * math.pi / 180
	local height = BOSS_BEAST_SLAM_START_HEIGHT
		+ (BOSS_BEAST_SLAM_MAX_HEIGHT - BOSS_BEAST_SLAM_START_HEIGHT)
			* math.sin(radians)
			/ math.sin(maxRaiseRadians)
	return casterOrigin:__add(self.forward:__mul(horizontal)):__add(Vector(0, 0, height))
end
function modifier_boss_beast_5_slam.prototype.ApplySlamImpact(self, parent, caster)
	local casterOrigin = caster:GetAbsOrigin()
	local impactPosition = GetGroundPosition(casterOrigin:__add(self.forward:__mul(self.initialTargetDistance)), caster)
	local pfx = ParticleManager:CreateParticle(BOSS_BEAST_SLAM_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, impactPosition)
	ParticleManager:SetParticleControl(
		pfx,
		1,
		Vector(BOSS_BEAST_SLAM_IMPACT_RADIUS, BOSS_BEAST_SLAM_IMPACT_RADIUS, BOSS_BEAST_SLAM_IMPACT_RADIUS)
	)
	ParticleManager:SetParticleControl(
		pfx,
		3,
		Vector(BOSS_BEAST_SLAM_IMPACT_RADIUS, BOSS_BEAST_SLAM_IMPACT_RADIUS, BOSS_BEAST_SLAM_IMPACT_RADIUS)
	)
	ParticleManager:ReleaseParticleIndex(pfx)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		impactPosition,
		nil,
		BOSS_BEAST_SLAM_IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	if not __TS__ArrayIncludes(enemies, parent) then
		enemies[#enemies + 1] = parent
	end
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue76
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = BOSS_BEAST_SLAM_DAMAGE_RATE, ability = self.ability })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self.ability,
				DebuffStatusType.STUN,
				{ duration = BOSS_BEAST_SLAM_STUN_DURATION }
			)
		end
		::__continue76::
	end
	EmitSoundOnLocationWithCaster(impactPosition, "Hero_PrimalBeast.Pulverize.Stun", caster)
end
function modifier_boss_beast_5_slam.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self.caster
	if IsValidAlive(nil, parent) then
		FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
	end
	if caster and caster.boss_beast_5_slam_target == parent then
		caster.boss_beast_5_slam_target = nil
	end
	if caster and caster.boss_beast_5_grabbed_target == parent then
		caster.boss_beast_5_grabbed_target = nil
	end
	if caster then
		Timers:CreateTimer(BOSS_BEAST_SLAM_ANIMATION_RELEASE_DELAY, function()
			if not IsValidAlive(nil, caster) or caster:IsNull() then
				return
			end
			local activeTarget = caster.boss_beast_5_slam_target
			if activeTarget and activeTarget ~= parent then
				return
			end
			caster:RemoveModifierByName("modifier_boss_beast_5_slam_animation")
			if self.ability and not self.ability:IsNull() then
				self.ability:DestroyDuration()
			end
		end)
	end
end
function modifier_boss_beast_5_slam.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_boss_beast_5_slam.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_boss_beast_5_slam.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_boss_beast_5_slam.prototype.GetOverrideAnimationRate(self)
	return 1
end
modifier_boss_beast_5_slam = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_5_slam)
--- 施法者侧持续播放 Ability 5 的通道动作。
local modifier_boss_beast_5_slam_animation = __TS__Class()
modifier_boss_beast_5_slam_animation.name = "modifier_boss_beast_5_slam_animation"
__TS__ClassExtends(modifier_boss_beast_5_slam_animation, BaseModifier_CS)
function modifier_boss_beast_5_slam_animation.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.inertiaOrigin = Vector(0, 0, 0)
	self.inertiaForward = Vector(1, 0, 0)
	self.inertiaStartTime = 0
end
function modifier_boss_beast_5_slam_animation.prototype.IsHidden(self)
	return true
end
function modifier_boss_beast_5_slam_animation.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.inertiaOrigin = parent:GetAbsOrigin()
	self.inertiaForward = parent:GetForwardVector()
	self.inertiaStartTime = GameRules:GetGameTime()
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_beast_5_slam_animation.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local progress =
		math.min(1, math.max(0, (GameRules:GetGameTime() - self.inertiaStartTime) / BOSS_BEAST_SLAM_INERTIA_DURATION))
	if progress >= 1 then
		return
	end
	local easedProgress = 1 - (1 - progress) * (1 - progress)
	local nextPos = GetGroundPosition(
		self.inertiaOrigin:__add(self.inertiaForward:__mul(BOSS_BEAST_SLAM_INERTIA_DISTANCE * easedProgress)),
		parent
	)
	if not GridNav:IsTraversable(nextPos) or GridNav:IsBlocked(nextPos) then
		return
	end
	parent:SetAbsOrigin(nextPos)
end
function modifier_boss_beast_5_slam_animation.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
	}
end
function modifier_boss_beast_5_slam_animation.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CHANNEL_ABILITY_5
end
function modifier_boss_beast_5_slam_animation.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_boss_beast_5_slam_animation.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_boss_beast_5_slam_animation.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_boss_beast_5_slam_animation.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end
modifier_boss_beast_5_slam_animation =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_5_slam_animation)
return ____exports