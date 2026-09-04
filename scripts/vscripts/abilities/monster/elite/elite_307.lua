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
local modifier_elite_307_clone_state, modifier_elite_307_line_clone, modifier_elite_307_hit_cooldown, modifier_elite_307_collision_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1100
local CAST_POINT = 0.45
local CLONE_UNIT_NAME = "monster_11303_mirror"
local CLONE_SUMMON_TAG = "monster_11303_mirror"
local CLONE_COUNT = 3
local CLONE_WAVE_COUNT = 4
local CLONE_WAVE_INTERVAL = 0.65
local CLONE_DASH_SPEED_MULTIPLIER = 0.7
local CLONE_DASH_DURATION = 2 / CLONE_DASH_SPEED_MULTIPLIER
local CLONE_START_INTERVAL = 0.18
local PATH_SIDE_RANDOM_RANGE = 920
local PATH_BACK_DISTANCE = 1500
local PATH_FRONT_DISTANCE = 2500
local HIT_RADIUS = 170
local CLONE_LIFETIME = (CLONE_COUNT - 1) * CLONE_START_INTERVAL + CLONE_DASH_DURATION + 0.25
local CLONE_TOTAL_DURATION = (CLONE_WAVE_COUNT - 1) * CLONE_WAVE_INTERVAL + CLONE_LIFETIME
local HIT_COOLDOWN = 0.2
local COLLISION_SLOW_DURATION = 0.5
local DAMAGE_RATE = 10
local PARTICLE = "particles/units/heroes/hero_weaver/weaver_shukuchi.vpcf"
local HIT_PARTICLE = "particles/units/heroes/hero_weaver/weaver_shukuchi_damage.vpcf"
local SCREEN_SHAKE_AMPLITUDE = 12
local SCREEN_SHAKE_FREQUENCY = 12
local SCREEN_SHAKE_DURATION = 0.2
local SCREEN_SHAKE_RADIUS = 1800
____exports.elite_307 = __TS__Class()
local elite_307 = ____exports.elite_307
elite_307.name = "elite_307"
__TS__ClassExtends(elite_307, MonsterAbility_CS)
function elite_307.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE, context)
	PrecacheResource("particle", HIT_PARTICLE, context)
	PrecacheUnitByNameSync(CLONE_UNIT_NAME, context)
end
function elite_307.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = 0,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 14,
		OnPhaseStart = function()
			return self:FaceNearestTarget()
		end,
		OnStart = function()
			return self:StartCloneState()
		end,
	}
end
function elite_307.prototype.FaceNearestTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 10)
	end
end
function elite_307.prototype.StartCloneState(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn("Hero_Weaver.Shukuchi", caster)
	local origin = caster:GetAbsOrigin()
	modifier_elite_307_clone_state:applys(caster, caster, self, {
		duration = CLONE_TOTAL_DURATION,
		origin_x = origin.x,
		origin_y = origin.y,
		origin_z = origin.z,
		forward_x = caster:GetForwardVector().x,
		forward_y = caster:GetForwardVector().y,
		forward_z = caster:GetForwardVector().z,
	})
end
function elite_307.prototype.SummonLineClones(self, waveIndex, origin, direction)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____opt_0 = caster.GetRoomId
	local roomId = ____opt_0 and ____opt_0(caster)
	do
		local index = 0
		while index < CLONE_COUNT do
			local currentIndex = index
			local delay = currentIndex * CLONE_START_INTERVAL
			local path = self:ResolveRandomPath(caster, origin, direction)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = CLONE_UNIT_NAME,
				summonTag = (CLONE_SUMMON_TAG .. "_") .. tostring(caster:entindex()),
				maxSummons = CLONE_COUNT * CLONE_WAVE_COUNT,
				position = path.start,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = false,
				onSpawn = function(____, clone)
					if not clone or not IsValidAlive(nil, clone) then
						return
					end
					if not IsValidAlive(nil, caster) then
						MyGameUnit:DestroyUnit(clone)
						return
					end
					clone:SetOwner(caster)
					clone:SetAbsOrigin(path.start)
					clone:SetForwardVector(GetDirection(nil, path["end"], path.start))
					self:PlayCloneScreenShake(path.start)
					modifier_elite_307_line_clone:applys(clone, caster, self, {
						duration = CLONE_LIFETIME,
						start_x = path.start.x,
						start_y = path.start.y,
						start_z = path.start.z,
						end_x = path["end"].x,
						end_y = path["end"].y,
						end_z = path["end"].z,
						delay = delay,
					})
				end,
			})
			index = index + 1
		end
	end
end
function elite_307.prototype.ResolveRandomPath(self, caster, origin, direction)
	local forward = direction:Normalized()
	local sideOffset = RandomFloat(-PATH_SIDE_RANDOM_RANGE, PATH_SIDE_RANDOM_RANGE)
	local side = Vector(-forward.y, forward.x, 0):Normalized()
	local center = origin:__add(side:__mul(sideOffset))
	return {
		start = GetGroundPosition(center:__sub(forward:__mul(PATH_BACK_DISTANCE)), caster),
		["end"] = GetGroundPosition(center:__add(forward:__mul(PATH_FRONT_DISTANCE)), caster),
	}
end
function elite_307.prototype.PlayCloneScreenShake(self, point)
	ScreenShake(
		point,
		SCREEN_SHAKE_AMPLITUDE,
		SCREEN_SHAKE_FREQUENCY,
		SCREEN_SHAKE_DURATION,
		SCREEN_SHAKE_RADIUS,
		0,
		true
	)
end
elite_307 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_307)
____exports.elite_307 = elite_307
modifier_elite_307_clone_state = __TS__Class()
modifier_elite_307_clone_state.name = "modifier_elite_307_clone_state"
__TS__ClassExtends(modifier_elite_307_clone_state, MonsterModifier_CS)
function modifier_elite_307_clone_state.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.nextWaveIndex = 0
	self.origin = Vector(0, 0, 0)
	self.direction = Vector(1, 0, 0)
end
function modifier_elite_307_clone_state.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.nextWaveIndex = 0
	self.origin =
		Vector(params and params.origin_x or 0, params and params.origin_y or 0, params and params.origin_z or 0)
	self.direction = Vector(
		params and params.forward_x or 1,
		params and params.forward_y or 0,
		params and params.forward_z or 0
	):Normalized()
	self:StartIntervalThink(0)
end
function modifier_elite_307_clone_state.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability or ability:IsNull() then
		self:Destroy()
		return
	end
	if self.nextWaveIndex >= CLONE_WAVE_COUNT then
		self:StartIntervalThink(-1)
		return
	end
	local currentWaveIndex = self.nextWaveIndex
	ability:SummonLineClones(currentWaveIndex, self.origin, self.direction)
	self.nextWaveIndex = currentWaveIndex + 1
	self:StartIntervalThink(CLONE_WAVE_INTERVAL)
end
function modifier_elite_307_clone_state.prototype.IsHidden(self)
	return true
end
function modifier_elite_307_clone_state.prototype.IsPurgable(self)
	return false
end
modifier_elite_307_clone_state =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_307_clone_state") }, modifier_elite_307_clone_state)
modifier_elite_307_line_clone = __TS__Class()
modifier_elite_307_line_clone.name = "modifier_elite_307_line_clone"
__TS__ClassExtends(modifier_elite_307_line_clone, MonsterModifier_CS)
function modifier_elite_307_line_clone.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.startPoint = Vector(0, 0, 0)
	self.endPoint = Vector(0, 0, 0)
	self.pathForward = Vector(1, 0, 0)
	self.delay = 0
end
function modifier_elite_307_line_clone.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.startPoint =
		Vector(params and params.start_x or 0, params and params.start_y or 0, params and params.start_z or 0)
	self.endPoint = Vector(params and params.end_x or 0, params and params.end_y or 0, params and params.end_z or 0)
	self.pathForward = GetDirection(nil, self.endPoint, self.startPoint)
	self.delay = params and params.delay or 0
	self:StartShukuchiEffect()
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_307_line_clone.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local clone = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, clone) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local elapsed = self:GetElapsedTime() - self.delay
	if elapsed < 0 then
		clone:SetForwardVector(self.pathForward)
		clone:SetAbsOrigin(self.startPoint)
		return
	end
	local progress = math.min(elapsed / CLONE_DASH_DURATION, 1)
	local nextPosition = self:ResolveLinePosition(caster, progress)
	clone:SetForwardVector(self.pathForward)
	clone:SetAbsOrigin(nextPosition)
	self:DamageCollidedEnemies(caster, clone, nextPosition)
	if progress >= 1 then
		self:Destroy()
	end
end
function modifier_elite_307_line_clone.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local clone = self:GetParent()
	self:StartIntervalThink(-1)
	self:StopShukuchiEffect()
	if not IsValid(nil, clone) or clone:IsNull() then
		return
	end
	clone:AddNoDraw()
	if clone:IsAlive() then
		clone:ForceKill(false)
	else
		clone:RemoveSelf()
	end
end
function modifier_elite_307_line_clone.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL, MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_elite_307_line_clone.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
function modifier_elite_307_line_clone.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_elite_307_line_clone.prototype.GetModifierInvisibilityLevel(self)
	return 0.45
end
function modifier_elite_307_line_clone.prototype.IsHidden(self)
	return true
end
function modifier_elite_307_line_clone.prototype.IsPurgable(self)
	return false
end
function modifier_elite_307_line_clone.prototype.ResolveLinePosition(self, caster, progress)
	local offset = self.endPoint:__sub(self.startPoint)
	return GetGroundPosition(self.startPoint:__add(offset:__mul(progress)), caster)
end
function modifier_elite_307_line_clone.prototype.DamageCollidedEnemies(self, caster, clone, point)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue48
			end
			if modifier_elite_307_hit_cooldown:find_on(enemy) then
				goto __continue48
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = DAMAGE_RATE,
				ability = self:GetAbility(),
				effectName = HIT_PARTICLE,
			})
			modifier_elite_307_hit_cooldown:applys(enemy, caster, self:GetAbility(), { duration = HIT_COOLDOWN })
			modifier_elite_307_collision_slow:applys(
				enemy,
				caster,
				self:GetAbility(),
				{ duration = COLLISION_SLOW_DURATION }
			)
			ScreenShake(
				enemy:GetAbsOrigin(),
				SCREEN_SHAKE_AMPLITUDE,
				SCREEN_SHAKE_FREQUENCY,
				SCREEN_SHAKE_DURATION,
				SCREEN_SHAKE_RADIUS,
				0,
				true
			)
			EmitSoundOn("Hero_Weaver.ShukuchiDamage", enemy)
		end
		::__continue48::
	end
end
function modifier_elite_307_line_clone.prototype.StartShukuchiEffect(self)
	local clone = self:GetParent()
	self:StopShukuchiEffect()
	self.shukuchiParticle = ParticleManager:CreateParticle(PARTICLE, PATTACH_ABSORIGIN_FOLLOW, clone)
	ParticleManager:SetParticleControlEnt(
		self.shukuchiParticle,
		0,
		clone,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		clone:GetAbsOrigin(),
		true
	)
end
function modifier_elite_307_line_clone.prototype.StopShukuchiEffect(self)
	if self.shukuchiParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.shukuchiParticle, false)
	ParticleManager:ReleaseParticleIndex(self.shukuchiParticle)
	self.shukuchiParticle = nil
end
modifier_elite_307_line_clone =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_307_line_clone") }, modifier_elite_307_line_clone)
modifier_elite_307_hit_cooldown = __TS__Class()
modifier_elite_307_hit_cooldown.name = "modifier_elite_307_hit_cooldown"
__TS__ClassExtends(modifier_elite_307_hit_cooldown, MonsterModifier_CS)
function modifier_elite_307_hit_cooldown.prototype.IsHidden(self)
	return true
end
function modifier_elite_307_hit_cooldown.prototype.IsPurgable(self)
	return false
end
modifier_elite_307_hit_cooldown =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_307_hit_cooldown") }, modifier_elite_307_hit_cooldown)
modifier_elite_307_collision_slow = __TS__Class()
modifier_elite_307_collision_slow.name = "modifier_elite_307_collision_slow"
__TS__ClassExtends(modifier_elite_307_collision_slow, MonsterModifier_CS)
function modifier_elite_307_collision_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -80 }
end
function modifier_elite_307_collision_slow.prototype.IsHidden(self)
	return false
end
function modifier_elite_307_collision_slow.prototype.IsDebuff(self)
	return true
end
function modifier_elite_307_collision_slow.prototype.IsPurgable(self)
	return true
end
function modifier_elite_307_collision_slow.prototype.GetTexture(self)
	return "weaver_shukuchi"
end
function modifier_elite_307_collision_slow.GetLocalizationCN(self)
	return { name = "缩地冲撞", description = "被时隙分身擦过，移动速度短暂降低至最低。" }
end
modifier_elite_307_collision_slow = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_307_collision_slow") },
	modifier_elite_307_collision_slow
)
return ____exports