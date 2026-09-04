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
local BOSS_BEAST_CHARGE_FRAME_DISTANCE = 130
local BOSS_BEAST_CHARGE_PATH_SAMPLE_DISTANCE = 32
local BOSS_BEAST_CHARGE_FORWARD_PROBE_DISTANCE = 60
local function DebugBossBeast1(self, message) end
local boss_beast_1 = __TS__Class()
boss_beast_1.name = "boss_beast_1"
__TS__ClassExtends(boss_beast_1, MonsterAbility_CS)
function boss_beast_1.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 2.3,
		castDuration = BOSS_BEAST_CHARGE_DURATION * BOSS_BEAST_CHARGE_COUNT + BOSS_BEAST_SECOND_PREPARE_DURATION + 0.1,
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
				"modifier_boss_beast_1_pre",
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
			caster:AddNewModifier(caster, self, "modifier_boss_beast_1_move", { duration = BOSS_BEAST_CHARGE_DURATION })
		end,
	}
end
boss_beast_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_beast_1)
--- 蓄力阶段：后撤、索敌转向、预警线伸长、禁攻禁转身
local modifier_boss_beast_1_pre = __TS__Class()
modifier_boss_beast_1_pre.name = "modifier_boss_beast_1_pre"
__TS__ClassExtends(modifier_boss_beast_1_pre, BaseModifier_CS)
function modifier_boss_beast_1_pre.prototype.OnCreated(self, params)
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
function modifier_boss_beast_1_pre.prototype.OnIntervalThink(self)
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
function modifier_boss_beast_1_pre.prototype.OnDestroy(self)
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
function modifier_boss_beast_1_pre.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING, MODIFIER_PROPERTY_IGNORE_CAST_ANGLE }
end
function modifier_boss_beast_1_pre.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_boss_beast_1_pre.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_boss_beast_1_pre.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
modifier_boss_beast_1_pre = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_1_pre)
--- 冲刺阶段：逐帧位移、撞敌伤害击退、撞墙后撤；结束时驱动下一段蓄力/冲刺
local modifier_boss_beast_1_move = __TS__Class()
modifier_boss_beast_1_move.name = "modifier_boss_beast_1_move"
__TS__ClassExtends(modifier_boss_beast_1_move, BaseModifier_CS)
function modifier_boss_beast_1_move.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.caught_enemies = {}
	self.isBlocked = false
end
function modifier_boss_beast_1_move.prototype.OnCreated(self)
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
function modifier_boss_beast_1_move.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local forward = parent:GetForwardVector()
	local origin = parent:GetAbsOrigin()
	local plannedPos = origin:__add(forward:__mul(BOSS_BEAST_CHARGE_FRAME_DISTANCE))
	GridNav:DestroyTreesAroundPoint(plannedPos, 400, false)
	local newPos = self:GetSafeChargePosition(parent, origin, forward)
	if not newPos then
		self.isBlocked = true
		DebugBossBeast1(
			nil,
			(
				(
					(
						(
							(
								(("move blocked ent=" .. tostring(parent:entindex())) .. " pos=(")
								.. __TS__NumberToFixed(plannedPos.x, 0)
							) .. ", "
						) .. __TS__NumberToFixed(plannedPos.y, 0)
					) .. ", "
				) .. __TS__NumberToFixed(plannedPos.z, 0)
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
		if not __TS__ArrayIncludes(self.caught_enemies, unit) and unit ~= parent then
			if not IsValidAlive(nil, unit) then
				return
			end
			local impactPfx = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf"
			if not IsValidAlive(nil, parent) then
				return
			end
			local pfx = ParticleManager:CreateParticle(impactPfx, PATTACH_WORLDORIGIN, unit)
			ParticleManager:SetParticleControl(pfx, 0, unit:GetOrigin())
			ParticleManager:SetParticleControl(pfx, 1, Vector(100, 0, 0))
			ParticleManager:ReleaseParticleIndex(pfx)
			local ____self_caught_enemies_4 = self.caught_enemies
			____self_caught_enemies_4[#____self_caught_enemies_4 + 1] = unit
			unit:EmitSound("Hero_Spirit_Breaker.GreaterBash")
			parent:MonsterDamage({
				victim = unit,
				damage_rate = 35,
				ability = self:GetAbility(),
			})
			unit:KnockBack(parent, self:GetAbility(), {
				origin_pos = parent:GetOrigin(),
				duration = 0.25,
				stunDuration = 1,
				stun = true,
				distance = 150,
				height = 0,
			})
		end
	end)
end
function modifier_boss_beast_1_move.prototype.GetSafeChargePosition(self, parent, origin, forward)
	local steps = math.max(1, math.ceil(BOSS_BEAST_CHARGE_FRAME_DISTANCE / BOSS_BEAST_CHARGE_PATH_SAMPLE_DISTANCE))
	local lastSafePosition = origin
	do
		local index = 1
		while index <= steps do
			local distance = BOSS_BEAST_CHARGE_FRAME_DISTANCE * index / steps
			local candidate = origin:__add(forward:__mul(distance))
			local groundPoint = GetGroundPosition(candidate, parent)
			local forwardProbe = groundPoint:__add(forward:__mul(BOSS_BEAST_CHARGE_FORWARD_PROBE_DISTANCE))
			if not self:IsChargePointWalkable(groundPoint) or not self:IsChargePointWalkable(forwardProbe) then
				return nil
			end
			if not GridNav:CanFindPath(lastSafePosition, groundPoint) then
				return nil
			end
			if GridNav:FindPathLength(lastSafePosition, groundPoint) == -1 then
				return nil
			end
			lastSafePosition = groundPoint
			index = index + 1
		end
	end
	return lastSafePosition
end
function modifier_boss_beast_1_move.prototype.IsChargePointWalkable(self, point)
	return IsGridNavDisplacementWalkable(nil, point)
end
function modifier_boss_beast_1_move.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
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
			"modifier_boss_beast_1_pre",
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
				"modifier_boss_beast_1_move",
				{ duration = BOSS_BEAST_CHARGE_DURATION }
			)
			return nil
		end)
		return nil
	end)
end
function modifier_boss_beast_1_move.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_boss_beast_1_move.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
function modifier_boss_beast_1_move.prototype.GetOverrideAnimationRate(self)
	return 1.5
end
function modifier_boss_beast_1_move.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_boss_beast_1_move.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_boss_beast_1_move.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
modifier_boss_beast_1_move = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_1_move)
return ____exports