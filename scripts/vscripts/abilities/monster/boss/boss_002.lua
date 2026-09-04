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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local BOSS_002_PROJECTILE_PARTICLE = "particles/boss/sky/drow_ti6_silence_wave.vpcf"
local BOSS_002_CAST_POINT = 1.8
local BOSS_002_PROJECTILE_DISTANCE = 1400
local BOSS_002_PROJECTILE_RANGE = 280
local BOSS_002_PROJECTILE_SPEED = 1400
local BOSS_002_DAMAGE_RATE = 15
local BOSS_002_EXECUTE_DAMAGE_RATE = 20
local BOSS_002_DASH_HIT_RADIUS = 300
local BOSS_002_CAST_SOUND = "Hero_SkywrathMage.ConcussiveShot.Cast"
local BOSS_002_IMPACT_SOUND = "Hero_SkywrathMage.ConcussiveShot.Target"
local BOSS_002_EXECUTE_SOUND = "Hero_SkywrathMage.AncientSeal.Target"
--- Boss技能2 - 读条后发射一条直线波动投射物
____exports.boss_002 = __TS__Class()
local boss_002 = ____exports.boss_002
boss_002.name = "boss_002"
__TS__ClassExtends(boss_002, MonsterAbility_CS)
function boss_002.prototype.Precache(self, context)
	PrecacheResource("particle", BOSS_002_PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", "particles/boss/skywrath_arcana_mystic_flare_ambient.vpcf", context)
	PrecacheResource("particle", "particles/boss/sky/skywrath_arcana_kill_target.vpcf", context)
end
function boss_002.prototype.GetCastRange(self, _location, _target)
	return BOSS_002_PROJECTILE_DISTANCE
end
function boss_002.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = BOSS_002_CAST_POINT,
		castDuration = 5,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(BOSS_002_PROJECTILE_DISTANCE)
			if not IsValidAlive(nil, target) then
				return
			end
			caster:LockTargetForSpeed(target, BOSS_002_CAST_POINT)
			local origin = caster:GetAbsOrigin()
			local castDirection = caster:GetForwardVector()
			local targetPos = origin:__add(castDirection:__mul(BOSS_002_PROJECTILE_DISTANCE))
			self:WarningEffect(origin, targetPos, BOSS_002_CAST_POINT, {
				startWidth = BOSS_002_PROJECTILE_RANGE,
				endWidth = BOSS_002_PROJECTILE_RANGE,
				getDirection = function()
					local ____IsValidAlive_result_0
					if IsValidAlive(nil, caster) then
						____IsValidAlive_result_0 = caster:GetForwardVector()
					else
						____IsValidAlive_result_0 = castDirection
					end
					return ____IsValidAlive_result_0
				end,
			})
		end,
		OnStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(BOSS_002_CAST_SOUND, caster)
			local origin = caster:GetAbsOrigin()
			local targetPos = origin:__add(caster:GetForwardVector():__mul(BOSS_002_PROJECTILE_DISTANCE))
			local speed = BOSS_002_PROJECTILE_SPEED
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				projectile_type = "linear",
				effect_name = BOSS_002_PROJECTILE_PARTICLE,
				projectile_speed = speed,
				target = targetPos,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				projectile_distance = BOSS_002_PROJECTILE_DISTANCE,
				projectile_range = BOSS_002_PROJECTILE_RANGE,
				on_hit = function(____, hitTarget)
					if not hitTarget or not IsValidAlive(nil, hitTarget) then
						return true
					end
					if not IsValidAlive(nil, caster) then
						return true
					end
					EmitSoundOn(BOSS_002_IMPACT_SOUND, hitTarget)
					caster:MonsterDamage({ victim = hitTarget, damage_rate = BOSS_002_DAMAGE_RATE, ability = self })
					return false
				end,
			})
			local recoilDir = Vector(-caster:GetForwardVector().x, -caster:GetForwardVector().y, 0)
			caster:Mover(caster:GetAbsOrigin():__add(recoilDir:__mul(300)), 0.2, nil, true)
			self:Timer(0.5, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local dashOrigin = caster:GetAbsOrigin()
				local forward = caster:GetForwardVector()
				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					dashOrigin,
					nil,
					2000,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				local nearest
				local nearestDist = 999999
				for ____, enemy in ipairs(enemies) do
					do
						if not IsValidAlive(nil, enemy) then
							goto __continue17
						end
						local to = enemy:GetAbsOrigin() - dashOrigin
						local dist = to:Length2D()
						if dist <= 0.01 then
							goto __continue17
						end
						local dir = to:Normalized()
						local dot = forward.x * dir.x + forward.y * dir.y + forward.z * dir.z
						local angleDeg = math.deg(math.acos(math.max(-1, math.min(1, dot))))
						if angleDeg > 60 then
							goto __continue17
						end
						if dist < nearestDist then
							nearestDist = dist
							nearest = enemy
						end
					end
					::__continue17::
				end
				if not IsValidAlive(nil, nearest) then
					self:DestroyDuration()
					return
				end
				local targetPos2D = nearest:GetAbsOrigin()
				local toTarget = targetPos2D - dashOrigin
				local dashDistance = toTarget:Length2D()
				if dashDistance <= 0.01 then
					return
				end
				local dashDuration = dashDistance / 2500
				self:WarningRingEffect(targetPos2D, BOSS_002_DASH_HIT_RADIUS, dashDuration)
				caster:AddNewModifier(caster, self, "modifier_boss_002_dash", { duration = dashDuration })
				caster:SetForwardVector(GetDirection(nil, targetPos2D, caster:GetAbsOrigin()))
				caster:Mover(targetPos2D, dashDuration)
				self:Timer(dashDuration + 0.03, function()
					if not IsValidAlive(nil, caster) then
						return
					end
					local hitUnits = FindUnitsInRadius(
						caster:GetTeamNumber(),
						targetPos2D,
						nil,
						BOSS_002_DASH_HIT_RADIUS,
						DOTA_UNIT_TARGET_TEAM_ENEMY,
						DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
						DOTA_UNIT_TARGET_FLAG_NONE,
						FIND_ANY_ORDER,
						false
					)
					local validHits = __TS__ArrayFilter(hitUnits, function(____, u)
						return IsValidAlive(nil, u)
					end)
					if #validHits ~= 1 then
						self:DestroyDuration()
						return
					end
					local victim = validHits[1]
					EmitSoundOn(BOSS_002_EXECUTE_SOUND, victim)
					self._caster:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 2)
					____exports.modifier_boss_002_dash_victim:applys(victim, caster, self, { duration = 3.5 })
					self:Timer(0.6, function()
						if not IsValidAlive(nil, caster) then
							return
						end
						____exports.modifier_boss_002_dash_self:applys(caster, caster, self, { duration = 3 })
					end)
				end)
			end)
		end,
	}
end
boss_002 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_002)
____exports.boss_002 = boss_002
____exports.modifier_boss_002_dash = __TS__Class()
local modifier_boss_002_dash = ____exports.modifier_boss_002_dash
modifier_boss_002_dash.name = "modifier_boss_002_dash"
__TS__ClassExtends(modifier_boss_002_dash, MonsterModifier_CS)
function modifier_boss_002_dash.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_boss_002_dash.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_boss_002_dash.prototype.GetActivityTranslationModifiers(self)
	return "forcestaff_friendly"
end
function modifier_boss_002_dash.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_boss_002_dash.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_002_dash.prototype.IsHidden(self)
	return true
end
function modifier_boss_002_dash.prototype.IsPurgable(self)
	return false
end
modifier_boss_002_dash =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_002_dash") }, modifier_boss_002_dash)
____exports.modifier_boss_002_dash = modifier_boss_002_dash
____exports.modifier_boss_002_dash_self = __TS__Class()
local modifier_boss_002_dash_self = ____exports.modifier_boss_002_dash_self
modifier_boss_002_dash_self.name = "modifier_boss_002_dash_self"
__TS__ClassExtends(modifier_boss_002_dash_self, MonsterModifier_CS)
function modifier_boss_002_dash_self.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end
function modifier_boss_002_dash_self.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_boss_002_dash_self.prototype.GetActivityTranslationModifiers(self)
	return "fishing"
end
function modifier_boss_002_dash_self.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_VICTORY_START
end
function modifier_boss_002_dash_self.prototype.IsHidden(self)
	return false
end
function modifier_boss_002_dash_self.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local fxId = ParticleManager:CreateParticle(
		"particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_kill_caster.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControlEnt(
		fxId,
		0,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		fxId,
		1,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		fxId,
		2,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleShouldCheckFoW(fxId, false)
	self:AddParticle(fxId, false, false, -1, false, false)
end
function modifier_boss_002_dash_self.prototype.IsPurgable(self)
	return false
end
modifier_boss_002_dash_self =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_002_dash_self") }, modifier_boss_002_dash_self)
____exports.modifier_boss_002_dash_self = modifier_boss_002_dash_self
____exports.modifier_boss_002_dash_victim = __TS__Class()
local modifier_boss_002_dash_victim = ____exports.modifier_boss_002_dash_victim
modifier_boss_002_dash_victim.name = "modifier_boss_002_dash_victim"
__TS__ClassExtends(modifier_boss_002_dash_victim, MonsterModifier_CS)
function modifier_boss_002_dash_victim.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.executeDamageRate = BOSS_002_EXECUTE_DAMAGE_RATE
end
function modifier_boss_002_dash_victim.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
function modifier_boss_002_dash_victim.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME,
	}
end
function modifier_boss_002_dash_victim.prototype.GetModifierModelScaleAnimateTime(self)
	return 0.5
end
function modifier_boss_002_dash_victim.prototype.GetModifierModelScale(self)
	return -50
end
function modifier_boss_002_dash_victim.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_DISABLED
end
function modifier_boss_002_dash_victim.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.executeDamageRate = params and params.execute_damage_rate or BOSS_002_EXECUTE_DAMAGE_RATE
	local parent = self:GetParent()
	local boss = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, boss) then
		self:Destroy()
		return
	end
	self:Timer(0.5, function()
		if not IsValidAlive(nil, boss) then
			return
		end
		if not IsValidAlive(nil, parent) then
			return
		end
		local captureFx = ParticleManager:CreateParticle(
			"particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_ancient_seal_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			parent
		)
		ParticleManager:SetParticleControl(captureFx, 0, parent:GetAbsOrigin())
		ParticleManager:SetParticleControlEnt(
			captureFx,
			1,
			parent,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleShouldCheckFoW(captureFx, false)
		self:AddParticle(captureFx, true, false, -1, false, false)
		local bossOrigin = boss:GetAbsOrigin()
		local forward = boss:GetForwardVector()
		local groundPos = GetGroundPosition(bossOrigin:__add(forward:__mul(250)), boss)
		local targetPos = Vector(groundPos.x, groundPos.y, groundPos.z + 175)
		parent:Mover(targetPos, 0.5, nil, true)
		local fxId = ParticleManager:CreateParticle(
			"particles/boss/skywrath_arcana_mystic_flare_ambientb.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			parent
		)
		ParticleManager:SetParticleControl(fxId, 0, targetPos)
		ParticleManager:SetParticleControl(fxId, 1, Vector(200, 200, 200))
		ParticleManager:SetParticleShouldCheckFoW(fxId, false)
		self:AddParticle(fxId, true, false, -1, false, false)
		local fxId4 = ParticleManager:CreateParticle(
			"particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_rod_of_atos.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(fxId4, 0, targetPos)
		ParticleManager:SetParticleControl(fxId4, 1, Vector(200, 200, 200))
		ParticleManager:SetParticleShouldCheckFoW(fxId4, false)
		self:AddParticle(fxId4, false, false, -1, false, false)
	end)
	self:StartIntervalThink(1.5)
end
function modifier_boss_002_dash_victim.prototype.OnIntervalThink(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, self._caster) then
		return
	end
	local bossOrigin = self._caster:GetAbsOrigin()
	local forward = self._caster:GetForwardVector()
	local groundPos = GetGroundPosition(bossOrigin:__add(forward:__mul(250)), self._caster)
	local targetPos = Vector(groundPos.x, groundPos.y, groundPos.z + 175)
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetAbsOrigin(targetPos)
	local fxId = ParticleManager:CreateParticle(
		"particles/boss/skywrath_arcana_mystic_flare_ambient.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(fxId, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(fxId, 1, Vector(200, 200, 200))
	ParticleManager:SetParticleShouldCheckFoW(fxId, false)
	self:AddParticle(fxId, false, false, -1, false, false)
	local fxId2 = ParticleManager:CreateParticle(
		"particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_death.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControlEnt(
		fxId2,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		fxId2,
		1,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleShouldCheckFoW(fxId2, false)
	self:AddParticle(fxId2, false, false, -1, false, false)
	self:StartIntervalThink(-1)
	self:Timer(0, function()
		if not IsValidAlive(nil, parent) then
			return
		end
		local fxId3 = ParticleManager:CreateParticle(
			"particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_mystic_flare_hit_ambient.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(fxId3, 0, parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(fxId3, 1, Vector(200, 200, 200))
		ParticleManager:SetParticleShouldCheckFoW(fxId3, false)
		ParticleManager:DestroyParticle(fxId3, false)
		ParticleManager:ReleaseParticleIndex(fxId3)
		ScreenShake(parent:GetAbsOrigin(), 10, 10, 0.1, 2500, 0, true)
		self._caster:MonsterDamage({
			victim = parent,
			damage_rate = self.executeDamageRate,
			ability = self:GetAbility(),
		})
		EmitSoundOnLocationWithCaster(parent:GetAbsOrigin(), "Hero_SkywrathMage.MysticFlare.Target", self._caster)
		return IsValid(nil, self) and 0.1 or nil
	end)
end
function modifier_boss_002_dash_victim.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local boss = self:GetCaster()
	ScreenShake(parent:GetAbsOrigin(), 10, 10, 0.3, 2500, 0, true)
	if IsValidAlive(nil, parent) then
		local fx = ParticleManager:CreateParticle(
			"particles/boss/sky/skywrath_arcana_kill_target.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			parent
		)
		ParticleManager:SetParticleControlEnt(
			fx,
			0,
			parent,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleShouldCheckFoW(fx, false)
		ParticleManager:ReleaseParticleIndex(fx)
	end
	if IsValidAlive(nil, parent) and IsValidAlive(nil, boss) then
		local from = boss:GetAbsOrigin()
		local to = parent:GetAbsOrigin()
		local v = to - from
		local len = v:Length2D() or 1
		local dir = Vector(v.x / len, v.y / len, 0)
		parent:KnockBack(boss, self:GetAbility(), {
			duration = 0.5,
			distance = 400,
			height = 80,
			direction = dir,
			heightType = "parabola",
			destroyTreesType = "onDestroy",
			removeOnDeath = true,
		})
	end
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), false)
end
function modifier_boss_002_dash_victim.prototype.IsHidden(self)
	return false
end
function modifier_boss_002_dash_victim.prototype.IsPurgable(self)
	return false
end
modifier_boss_002_dash_victim =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_002_dash_victim") }, modifier_boss_002_dash_victim)
____exports.modifier_boss_002_dash_victim = modifier_boss_002_dash_victim
return ____exports