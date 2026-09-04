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
local modifier_elite_102_heavenly_jump, modifier_elite_102_attack_buff, modifier_elite_102_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 0.1
local JUMP_DURATION = 0.3
local ABILITY_RANGE = 1100
local ENEMY_SEARCH_RANGE = 1000
local JUMP_TRIGGER_DISTANCE = 500
local JUMP_DISTANCE = 600
local JUMP_POINT_ATTEMPTS = 64
local JUMP_AWAY_ARC_DEGREES = 120
local JUMP_HEIGHT = 120
local MOVE_PATH_STEP = 80
local DAMAGE_RATE = 12
local SLOW_DURATION = 2.5
local SLOW_PCT = 60
local ATTACK_BUFF_DURATION = 3
local ATTACK_RANGE_BONUS = 500
local ATTACK_SPEED_BONUS = 100
local BODY_LIGHTNING_PARTICLE = "particles/units/heroes/hero_zuus/zuus_static_field.vpcf"
local HIT_LIGHTNING_PARTICLE = "particles/units/heroes/hero_zuus/zuus_static_field.vpcf"
local ZEUS_SOUND_EVENTS = "sounds/weapons/hero/zuus/static_field.vsnd"
local JUMP_CAST_SOUND = "Hero_Zuus.StaticField"
--- 精英怪宙斯技能：敌人贴近时向远离敌人的点位进行 Heavenly Jump，并用雷电伤害和减速周围敌人。
____exports.elite_102 = __TS__Class()
local elite_102 = ____exports.elite_102
elite_102.name = "elite_102"
__TS__ClassExtends(elite_102, MonsterAbility_CS)
function elite_102.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.targetEnemy = nil
end
function elite_102.prototype.Precache(self, context)
	PrecacheResource("particle", BODY_LIGHTNING_PARTICLE, context)
	PrecacheResource("particle", HIT_LIGHTNING_PARTICLE, context)
	PrecacheResource("soundfile", ZEUS_SOUND_EVENTS, context)
end
function elite_102.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = ABILITY_RANGE,
		castPoint = CAST_POINT,
		castDuration = JUMP_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		canCast = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return UF_FAIL_CUSTOM
			end
			local enemy = self:FindNearestEnemy(caster)
			if not IsValidAlive(nil, enemy) then
				return UF_FAIL_CUSTOM
			end
			local ____table_ShouldJumpAway_result_0
			if self:ShouldJumpAway(caster, enemy) then
				____table_ShouldJumpAway_result_0 = UF_SUCCESS
			else
				____table_ShouldJumpAway_result_0 = UF_FAIL_CUSTOM
			end
			return ____table_ShouldJumpAway_result_0
		end,
		castError = function()
			return "敌人距离还不够近"
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local enemy = self:FindNearestEnemy(caster)
			local ____temp_1
			if IsValidAlive(nil, enemy) and self:ShouldJumpAway(caster, enemy) then
				____temp_1 = enemy
			else
				____temp_1 = nil
			end
			self.targetEnemy = ____temp_1
			if self.targetEnemy then
				caster:LockTargetForSpeed(self.targetEnemy, CAST_POINT)
			end
		end,
		OnInterrupt = function()
			local caster = self:GetCaster()
			self.targetEnemy = nil
			if IsValid(nil, caster) and not caster:IsNull() then
				modifier_elite_102_heavenly_jump:remove(caster)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local enemy = self.targetEnemy or self:FindNearestEnemy(caster)
			self.targetEnemy = nil
			if not IsServer() or not IsValidAlive(nil, caster) or not IsValidAlive(nil, enemy) then
				return
			end
			if not self:ShouldJumpAway(caster, enemy) then
				return
			end
			local jumpPoint = self:FindJumpPoint(caster, enemy)
			if not jumpPoint then
				return
			end
			ProjectileManager:ProjectileDodge(caster)
			caster:SetForwardVector(GetDirection(nil, enemy:GetAbsOrigin(), caster:GetAbsOrigin()))
			EmitSoundOn(JUMP_CAST_SOUND, caster)
			self:ReleaseLightningPulse(caster)
			modifier_elite_102_attack_buff:applys(caster, caster, self, { duration = ATTACK_BUFF_DURATION })
			modifier_elite_102_heavenly_jump:remove(caster)
			modifier_elite_102_heavenly_jump:applys(
				caster,
				caster,
				self,
				{ duration = JUMP_DURATION, target_x = jumpPoint.x, target_y = jumpPoint.y, target_z = jumpPoint.z }
			)
		end,
	}
end
function elite_102.prototype.FindNearestEnemy(self, caster)
	return caster:GetMinDistanceUnit(ENEMY_SEARCH_RANGE)
end
function elite_102.prototype.ShouldJumpAway(self, caster, enemy)
	return GetDistance(nil, caster:GetAbsOrigin(), enemy:GetAbsOrigin()) <= JUMP_TRIGGER_DISTANCE
end
function elite_102.prototype.FindJumpPoint(self, caster, enemy)
	local casterOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local enemyOrigin = GetGroundPosition(enemy:GetAbsOrigin(), enemy)
	local awayDirection = GetDirection(nil, casterOrigin, enemyOrigin)
	local straightPoint = GetGroundPosition(casterOrigin:__add(awayDirection:__mul(JUMP_DISTANCE)), caster)
	if self:IsValidJumpPoint(casterOrigin, enemyOrigin, straightPoint) then
		return straightPoint
	end
	do
		local i = 0
		while i < JUMP_POINT_ATTEMPTS do
			local angle = RandomFloat(-JUMP_AWAY_ARC_DEGREES / 2, JUMP_AWAY_ARC_DEGREES / 2)
			local direction = RotateVector2D(nil, awayDirection, angle):Normalized()
			local distance = JUMP_DISTANCE
			local candidate = casterOrigin:__add(direction:__mul(distance))
			local groundedPoint = GetGroundPosition(candidate, caster)
			if self:IsValidJumpPoint(casterOrigin, enemyOrigin, groundedPoint) then
				return groundedPoint
			end
			i = i + 1
		end
	end
	return nil
end
function elite_102.prototype.IsValidJumpPoint(self, casterOrigin, enemyOrigin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(casterOrigin, point) then
		return false
	end
	if GridNav:FindPathLength(casterOrigin, point) == -1 then
		return false
	end
	if GetDistance(nil, enemyOrigin, point) <= GetDistance(nil, enemyOrigin, casterOrigin) then
		return false
	end
	local delta = point:__sub(casterOrigin)
	local distance = delta:Length2D()
	if distance <= 1 then
		return true
	end
	local direction = delta:Normalized()
	local stepCount = math.ceil(distance / MOVE_PATH_STEP)
	do
		local i = 1
		while i <= stepCount do
			local stepDistance = math.min(i * MOVE_PATH_STEP, distance)
			local checkPos = GetGroundPosition(casterOrigin:__add(direction:__mul(stepDistance)), nil)
			if not IsGridNavDisplacementWalkable(nil, checkPos) then
				return false
			end
			i = i + 1
		end
	end
	return true
end
function elite_102.prototype.ReleaseLightningPulse(self, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		ABILITY_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue32
			end
			self:PlayLightningHit(enemy)
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			modifier_elite_102_slow:applys(enemy, caster, self, { duration = SLOW_DURATION })
		end
		::__continue32::
	end
end
function elite_102.prototype.PlayLightningHit(self, enemy)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(HIT_LIGHTNING_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		enemy,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		enemy:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
elite_102 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_102)
____exports.elite_102 = elite_102
modifier_elite_102_heavenly_jump = __TS__Class()
modifier_elite_102_heavenly_jump.name = "modifier_elite_102_heavenly_jump"
__TS__ClassExtends(modifier_elite_102_heavenly_jump, MonsterModifier_CS)
function modifier_elite_102_heavenly_jump.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.startPoint = Vector(0, 0, 0)
	self.targetPoint = Vector(0, 0, 0)
end
function modifier_elite_102_heavenly_jump.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.startPoint = GetGroundPosition(parent:GetAbsOrigin(), parent)
	self.targetPoint = GetGroundPosition(
		Vector(
			params.target_x or self.startPoint.x,
			params.target_y or self.startPoint.y,
			params.target_z or self.startPoint.z
		),
		parent
	)
	self:StartIntervalThink(FrameTime())
	self:OnIntervalThink()
end
function modifier_elite_102_heavenly_jump.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local duration = math.max(self:GetDuration(), FrameTime())
	local progress = math.min(self:GetElapsedTime() / duration, 1)
	local groundPoint = self:GetGroundPoint(parent, progress)
	local height = JUMP_HEIGHT * 4 * progress * (1 - progress)
	parent:SetAbsOrigin(Vector(groundPoint.x, groundPoint.y, groundPoint.z + height))
	local direction = self.targetPoint:__sub(self.startPoint)
	if direction:Length2D() > 0.01 then
		parent:SetForwardVector(Vector(direction.x, direction.y, 0):Normalized())
	end
	if progress >= 1 then
		self:Destroy()
	end
end
function modifier_elite_102_heavenly_jump.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self:StartIntervalThink(-1)
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	if IsValidAlive(nil, parent) then
		parent:SetAbsOrigin(self.targetPoint)
		FindClearSpaceForUnit(parent, self.targetPoint, true)
	end
	local ability = self:GetAbility()
	if ability and not ability:IsNull() then
		ability:DestroyDuration()
	end
end
function modifier_elite_102_heavenly_jump.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_COMMAND_RESTRICTED] = true }
end
function modifier_elite_102_heavenly_jump.prototype.GetEffectName(self)
	return BODY_LIGHTNING_PARTICLE
end
function modifier_elite_102_heavenly_jump.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_elite_102_heavenly_jump.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
function modifier_elite_102_heavenly_jump.prototype.GetGroundPoint(self, parent, progress)
	local delta = self.targetPoint:__sub(self.startPoint)
	local rawPoint = self.startPoint:__add(delta:__mul(progress))
	return GetGroundPosition(rawPoint, parent)
end
modifier_elite_102_heavenly_jump = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_102_heavenly_jump") },
	modifier_elite_102_heavenly_jump
)
modifier_elite_102_attack_buff = __TS__Class()
modifier_elite_102_attack_buff.name = "modifier_elite_102_attack_buff"
__TS__ClassExtends(modifier_elite_102_attack_buff, MonsterModifier_CS)
function modifier_elite_102_attack_buff.prototype.GetAttributeBonus(self)
	return { bonus_attack_range = ATTACK_RANGE_BONUS, attack_speed = ATTACK_SPEED_BONUS }
end
function modifier_elite_102_attack_buff.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = true }
end
function modifier_elite_102_attack_buff.prototype.GetTexture(self)
	return "zuus_heavenly_jump"
end
modifier_elite_102_attack_buff =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_102_attack_buff") }, modifier_elite_102_attack_buff)
modifier_elite_102_slow = __TS__Class()
modifier_elite_102_slow.name = "modifier_elite_102_slow"
__TS__ClassExtends(modifier_elite_102_slow, MonsterModifier_CS)
function modifier_elite_102_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -SLOW_PCT }
end
function modifier_elite_102_slow.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = true, isPurgable = true }
end
function modifier_elite_102_slow.prototype.GetTexture(self)
	return "zuus_heavenly_jump"
end
modifier_elite_102_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_102_slow") }, modifier_elite_102_slow)
return ____exports