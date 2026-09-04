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
local modifier_elite_071_stationary_state
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local SEARCH_RADIUS = 5000
local MAX_TARGET_TELEPORT_DISTANCE = 1500
local SCAN_INTERVAL = 15
local PROJECTILE_SPEED = 1600
local NEAR_TARGET_DISTANCE = 700
local MIN_PROJECTILE_SPEED_DISTANCE = 350
local MIN_PROJECTILE_SPEED = 650
local ARM_DISTANCE = 80
local ARM_EXPLODE_DELAY = 1
local PROJECTILE_LIFETIME = 5
local LIFETIME_ARM_TIME = PROJECTILE_LIFETIME - ARM_EXPLODE_DELAY
local EXPLODE_RADIUS = 420
local DAMAGE_RATE = 25
local THINK_INTERVAL = 0.03
local CAST_ANIMATION = "sd_cc_2024_loadout_spawn_treasure_zoomedin"
local BOMB_HEIGHT_OFFSET = 75
local BOMB_INITIAL_HEIGHT_OFFSET = 300
local BOMB_INITIAL_DESCENT_DURATION = 1
local BOMB_PARTICLE = "particles/econ/items/shadow_demon/gate_of_hell/gate_of_hell_disruption.vpcf"
local WARNING_PARTICLE = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_release.vpcf"
local EXPLODE_PARTICLE = "particles/unit/shui_aoe_black.vpcf"
local HIT_PARTICLE = "particles/units/heroes/hero_shadow_demon/shadow_demon_loadout.vpcf"
local HIT_PARTICLE_RADIUS = 50
local HIT_KNOCKBACK_DISTANCE = 120
local HIT_KNOCKBACK_DURATION = 0.55
local HIT_KNOCKBACK_HEIGHT = 80
local SHADOW_DEMON_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_shadow_demon.vsndevts"
local CAST_SOUND = "Hero_ShadowDemon.Disruption"
local EXPLODE_SOUND = "Hero_ShadowDemon.ShadowPoison.Release"
local PROP_MODEL = "models/items/world/towers/dire_tower_crownfall/dire_tower_crownfall.vmdl"
local PROP_IDLE_ANIMATION = "dire_tower002_idle_showcase_copy"
local PROP_FACING_YAW_OFFSET = 270
local PROP_DEATH_PARTICLE =
	"particles/econ/world/towers/dire_tower_2024_crownfall/dire_tower_2024_crownfall_destruction.vpcf"
local PROP_DEATH_DURATION = 3
local PROP_SCALE = 0.84
--- 精英技能71 - 暗影大祭司：同房间远程锁定英雄，生成追踪炸弹延迟轰炸
____exports.elite_071 = __TS__Class()
local elite_071 = ____exports.elite_071
elite_071.name = "elite_071"
__TS__ClassExtends(elite_071, MonsterAbility_CS)
function elite_071.prototype.Precache(self, context)
	PrecacheResource("model", PROP_MODEL, context)
	PrecacheResource("particle", PROP_DEATH_PARTICLE, context)
	PrecacheResource("particle", BOMB_PARTICLE, context)
	PrecacheResource("particle", WARNING_PARTICLE, context)
	PrecacheResource("particle", EXPLODE_PARTICLE, context)
	PrecacheResource("particle", HIT_PARTICLE, context)
	PrecacheResource("soundfile", SHADOW_DEMON_SOUND_EVENTS, context)
end
function elite_071.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_071_shadow_barrage"
end
function elite_071.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castRange = SEARCH_RADIUS, castPoint = 0, castDuration = 0 }
end
elite_071 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_071)
____exports.elite_071 = elite_071
local modifier_elite_071_shadow_barrage = __TS__Class()
modifier_elite_071_shadow_barrage.name = "modifier_elite_071_shadow_barrage"
__TS__ClassExtends(modifier_elite_071_shadow_barrage, MonsterModifier_CS)
function modifier_elite_071_shadow_barrage.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	WarningPrint(
		(("[elite_071] 被动创建 caster=" .. caster:GetUnitName()) .. " index=") .. tostring(caster:entindex())
	)
	modifier_elite_071_stationary_state:applys(caster, caster, self:GetAbility())
	self:BindPropAnimation()
	self:StartIntervalThink(SCAN_INTERVAL)
	self:OnIntervalThink()
end
function modifier_elite_071_shadow_barrage.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	local ____opt_0 = caster.GetRoomId
	local casterRoomId = ____opt_0 and ____opt_0(caster)
	if casterRoomId == nil then
		return
	end
	local targets = {}
	local playerCount = PlayerResource:GetPlayerCount()
	do
		local playerId = 0
		while playerId < playerCount do
			do
				local currentPlayerId = playerId
				if not PlayerResource:IsValidPlayerID(currentPlayerId) then
					goto __continue11
				end
				local hero = PlayerResource:GetSelectedHeroEntity(currentPlayerId)
				if not IsValidAlive(nil, hero) then
					goto __continue11
				end
				if hero:GetTeamNumber() == caster:GetTeamNumber() then
					goto __continue11
				end
				if self:GetHeroRoomId(hero) ~= casterRoomId then
					goto __continue11
				end
				targets[#targets + 1] = { target = hero, roomId = casterRoomId }
			end
			::__continue11::
			playerId = playerId + 1
		end
	end
	if #targets <= 0 then
		return
	end
	caster:SetAnimation(CAST_ANIMATION)
	for ____, ____value in ipairs(targets) do
		local target = ____value.target
		local roomId = ____value.roomId
		self:CreateBombThinker(caster, ability, target, roomId)
	end
end
function modifier_elite_071_shadow_barrage.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local caster = self:GetCaster()
	if self.propAnimationId ~= nil and IsValidAlive(nil, caster) then
		MyGamePropAnimation:Destroy(self.propAnimationId)
		self.propAnimationId = nil
	end
end
function modifier_elite_071_shadow_barrage.prototype.BindPropAnimation(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if type(MyGamePropAnimation) == "nil" or not MyGamePropAnimation then
		WarningPrint(
			(("[elite_071] PROP 管理器未初始化，跳过绑定 caster=" .. caster:GetUnitName()) .. " index=")
				.. tostring(caster:entindex())
		)
		return
	end
	WarningPrint(
		(
			(
				(("[elite_071] 请求绑定防御塔 PROP caster=" .. caster:GetUnitName()) .. " index=")
				.. tostring(caster:entindex())
			) .. " model="
		) .. PROP_MODEL
	)
	self.propAnimationId = MyGamePropAnimation:Create({
		bindUnit = caster,
		model = PROP_MODEL,
		idleAnimation = PROP_IDLE_ANIMATION,
		facingYawOffset = PROP_FACING_YAW_OFFSET,
		deathParticle = PROP_DEATH_PARTICLE,
		deathDuration = PROP_DEATH_DURATION,
		scale = PROP_SCALE,
		onCreated = function(____, id)
			WarningPrint(
				(("[elite_071] PROP 创建回调成功 id=" .. tostring(id)) .. " casterIndex=")
					.. tostring(caster:entindex())
			)
		end,
	})
	if self.propAnimationId == nil then
		WarningPrint(
			(("[elite_071] PROP 绑定失败 caster=" .. caster:GetUnitName()) .. " index=")
				.. tostring(caster:entindex())
		)
		return
	end
	WarningPrint(
		(("[elite_071] PROP 绑定完成 id=" .. tostring(self.propAnimationId)) .. " casterIndex=")
			.. tostring(caster:entindex())
	)
end
function modifier_elite_071_shadow_barrage.prototype.CreateBombThinker(self, caster, ability, target, roomId)
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	if not IsValidAlive(nil, target) then
		return
	end
	caster:EmitSound("Hero_ShadowDemon.ShadowPoison")
	local thinker = CreateModifierThinker(caster, ability, "modifier_elite_071_bomb_thinker", {
		duration = PROJECTILE_LIFETIME,
		target_entindex = target:entindex(),
		room_id = roomId,
	}, origin, caster:GetTeamNumber(), false)
	if roomId ~= nil and IsValid(nil, thinker) and not thinker:IsNull() then
		thinker.__room_id__ = roomId
	end
end
function modifier_elite_071_shadow_barrage.prototype.GetHeroRoomId(self, hero)
	if not IsValidAlive(nil, hero) then
		return
	end
	local ____this_3
	____this_3 = hero
	local ____opt_2 = ____this_3.GetPlayerOwnerID
	local playerId = ____opt_2 and ____opt_2(____this_3)
	if playerId == nil or playerId < 0 then
		return nil
	end
	local ____opt_4 = MyGameRoomManager:GetPlayerRoom(playerId)
	return ____opt_4 and ____opt_4:GetRoomId()
end
function modifier_elite_071_shadow_barrage.prototype.IsHidden(self)
	return true
end
function modifier_elite_071_shadow_barrage.prototype.IsPurgable(self)
	return false
end
modifier_elite_071_shadow_barrage = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_071_shadow_barrage") },
	modifier_elite_071_shadow_barrage
)
--- 防御塔展示单位的固定状态：保留技能逻辑，仅禁止移动与普通攻击。
modifier_elite_071_stationary_state = __TS__Class()
modifier_elite_071_stationary_state.name = "modifier_elite_071_stationary_state"
__TS__ClassExtends(modifier_elite_071_stationary_state, MonsterModifier_CS)
function modifier_elite_071_stationary_state.prototype.IsHidden(self)
	return true
end
function modifier_elite_071_stationary_state.prototype.IsPurgable(self)
	return false
end
function modifier_elite_071_stationary_state.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
modifier_elite_071_stationary_state = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_071_stationary_state") },
	modifier_elite_071_stationary_state
)
local modifier_elite_071_bomb_thinker = __TS__Class()
modifier_elite_071_bomb_thinker.name = "modifier_elite_071_bomb_thinker"
__TS__ClassExtends(modifier_elite_071_bomb_thinker, MonsterModifier_CS)
function modifier_elite_071_bomb_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.exploded = false
	self.cancelled = false
	self.armed = false
	self.armStartTime = 0
end
function modifier_elite_071_bomb_thinker.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_PROVIDES_VISION] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
function modifier_elite_071_bomb_thinker.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.roomId = params.room_id
	local parent = self:GetParent()
	if self.roomId ~= nil then
		parent.__room_id__ = self.roomId
	end
	EmitSoundOn(CAST_SOUND, parent)
	if params.target_entindex ~= nil then
		local target = EntIndexToHScript(params.target_entindex)
		if IsValidAlive(nil, target) then
			self.target = target
		end
	end
	if not self.target then
		self:Destroy()
		return
	end
	local initialTargetPosition = self.target:GetAbsOrigin()
	self.previousTargetPosition = Vector(initialTargetPosition.x, initialTargetPosition.y, initialTargetPosition.z)
	self.exploded = false
	self.cancelled = false
	self.armed = false
	self.armStartTime = 0
	self:SetThinkerGroundPosition(parent, parent:GetAbsOrigin())
	self:CreateBombParticle(parent)
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_elite_071_bomb_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self.target
	local parent = self:GetParent()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) or not self:IsTargetTrackingValid(target) then
		self:CancelAndDestroy()
		return
	end
	local currentTargetPosition = target:GetAbsOrigin()
	self.previousTargetPosition = Vector(currentTargetPosition.x, currentTargetPosition.y, currentTargetPosition.z)
	local elapsed = self:GetElapsedTime()
	if self.armed then
		self:SetThinkerGroundPosition(parent, parent:GetAbsOrigin())
		if elapsed - self.armStartTime >= ARM_EXPLODE_DELAY then
			self:Explode(parent:GetAbsOrigin())
			self:Destroy()
		end
		return
	end
	if elapsed >= LIFETIME_ARM_TIME then
		self:ArmBomb(parent)
		return
	end
	self:MoveTowardTarget(parent, target)
end
function modifier_elite_071_bomb_thinker.prototype.CancelAndDestroy(self)
	self.cancelled = true
	self:Destroy()
end
function modifier_elite_071_bomb_thinker.prototype.IsTargetTrackingValid(self, target)
	if not IsValidAlive(nil, target) then
		return false
	end
	if self.roomId == nil or self:GetHeroRoomId(target) ~= self.roomId then
		return false
	end
	if not self.previousTargetPosition then
		return true
	end
	local displacement = (target:GetAbsOrigin() - self.previousTargetPosition):Length2D()
	return displacement <= MAX_TARGET_TELEPORT_DISTANCE
end
function modifier_elite_071_bomb_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	if
		not self.cancelled
		and not self.exploded
		and self:GetElapsedTime() >= PROJECTILE_LIFETIME
		and IsValid(nil, parent)
		and not parent:IsNull()
		and self:IsTargetTrackingValid(self.target)
	then
		self:Explode(parent:GetAbsOrigin())
	end
	if self.particleId ~= nil then
		ParticleManager:DestroyParticle(self.particleId, false)
		ParticleManager:ReleaseParticleIndex(self.particleId)
		self.particleId = nil
	end
	if self.warningParticleId ~= nil then
		ParticleManager:DestroyParticle(self.warningParticleId, false)
		ParticleManager:ReleaseParticleIndex(self.warningParticleId)
		self.warningParticleId = nil
	end
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_071_bomb_thinker.prototype.MoveTowardTarget(self, parent, target)
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	if not IsValidAlive(nil, target) then
		return
	end
	local targetPos = target:GetAbsOrigin()
	local delta = Vector(targetPos.x - origin.x, targetPos.y - origin.y, 0)
	local distance = delta:Length2D()
	if distance <= ARM_DISTANCE then
		self:ArmBomb(parent)
		return
	end
	local direction = delta:Normalized()
	local speed = self:GetMoveSpeedByDistance(distance)
	local step = math.min(speed * THINK_INTERVAL, distance)
	local nextPos = origin:__add(direction:__mul(step))
	self:SetThinkerGroundPosition(parent, nextPos)
	parent:SetForwardVector(direction)
end
function modifier_elite_071_bomb_thinker.prototype.ArmBomb(self, parent)
	if self.armed then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	self.armed = true
	self.armStartTime = self:GetElapsedTime()
	local ability = self:GetAbility()
	if ability ~= nil then
		ability:WarningRingEffect(parent:GetAbsOrigin(), EXPLODE_RADIUS, ARM_EXPLODE_DELAY)
	end
	self:PlayWarningParticle(parent:GetAbsOrigin())
end
function modifier_elite_071_bomb_thinker.prototype.GetMoveSpeedByDistance(self, distance)
	if distance >= NEAR_TARGET_DISTANCE then
		return PROJECTILE_SPEED
	end
	if distance <= MIN_PROJECTILE_SPEED_DISTANCE then
		return MIN_PROJECTILE_SPEED
	end
	local progress = (distance - MIN_PROJECTILE_SPEED_DISTANCE) / (NEAR_TARGET_DISTANCE - MIN_PROJECTILE_SPEED_DISTANCE)
	return MIN_PROJECTILE_SPEED + (PROJECTILE_SPEED - MIN_PROJECTILE_SPEED) * progress
end
function modifier_elite_071_bomb_thinker.prototype.SetThinkerGroundPosition(self, parent, origin, groundOwner)
	if groundOwner == nil then
		groundOwner = parent
	end
	local groundPos = GetGroundPosition(origin, groundOwner)
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetAbsOrigin(Vector(groundPos.x, groundPos.y, groundPos.z + self:GetBombHeightOffset()))
end
function modifier_elite_071_bomb_thinker.prototype.GetBombHeightOffset(self)
	local descentProgress = math.min(math.max(self:GetElapsedTime() / BOMB_INITIAL_DESCENT_DURATION, 0), 1)
	return BOMB_INITIAL_HEIGHT_OFFSET + (BOMB_HEIGHT_OFFSET - BOMB_INITIAL_HEIGHT_OFFSET) * descentProgress
end
function modifier_elite_071_bomb_thinker.prototype.CreateBombParticle(self, parent)
	self.particleId = ParticleManager:CreateParticle(BOMB_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleShouldCheckFoW(self.particleId, false)
	ParticleManager:SetParticleControlEnt(
		self.particleId,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_origin",
		parent:GetAbsOrigin(),
		true
	)
end
function modifier_elite_071_bomb_thinker.prototype.PlayWarningParticle(self, origin)
	if self.warningParticleId ~= nil then
		return
	end
	self.warningParticleId = ParticleManager:CreateParticle(WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.warningParticleId, false)
	ParticleManager:SetParticleControl(self.warningParticleId, 0, origin)
	ParticleManager:SetParticleControl(self.warningParticleId, 2, origin)
	ParticleManager:SetParticleControl(self.warningParticleId, 3, Vector(400, 0, 0))
end
function modifier_elite_071_bomb_thinker.prototype.Explode(self, origin)
	if self.exploded then
		return
	end
	self.exploded = true
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	EmitSoundOn("Hero_ShadowDemon.DemonicPurge.Damage", self._parent)
	EmitSoundOn("Ability.Torrent", self._parent)
	self:PlayExplodeParticle(origin)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		EXPLODE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue82
			end
			if self.roomId ~= nil and self:GetHeroRoomId(enemy) ~= self.roomId then
				goto __continue82
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
			self:PlayHitEffects(enemy)
			self:KnockBackEnemy(caster, ability, enemy, origin)
		end
		::__continue82::
	end
end
function modifier_elite_071_bomb_thinker.prototype.PlayHitEffects(self, enemy)
	if not IsValidAlive(nil, enemy) then
		return
	end
	local origin = enemy:GetAbsOrigin()
	ScreenShake(origin, 10, 10, 0.15, 1200, 0, true)
	local pfx = ParticleManager:CreateParticle(HIT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 2, origin)
	ParticleManager:SetParticleControl(pfx, 3, Vector(HIT_PARTICLE_RADIUS, HIT_PARTICLE_RADIUS, HIT_PARTICLE_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_elite_071_bomb_thinker.prototype.KnockBackEnemy(self, caster, ability, enemy, origin)
	if not IsValidAlive(nil, enemy) then
		return
	end
	local direction = GetDirection(nil, enemy:GetAbsOrigin(), origin)
	enemy:KnockBack(caster, ability, {
		duration = HIT_KNOCKBACK_DURATION,
		distance = HIT_KNOCKBACK_DISTANCE,
		height = HIT_KNOCKBACK_HEIGHT,
		direction = direction,
		stun = true,
		stunDuration = HIT_KNOCKBACK_DURATION,
	})
end
function modifier_elite_071_bomb_thinker.prototype.PlayExplodeParticle(self, origin)
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		EmitSoundOnLocationWithCaster(origin, EXPLODE_SOUND, caster)
	end
	local pfx = ParticleManager:CreateParticle(EXPLODE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(EXPLODE_RADIUS, EXPLODE_RADIUS, EXPLODE_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_elite_071_bomb_thinker.prototype.GetHeroRoomId(self, hero)
	if not IsValidAlive(nil, hero) then
		return
	end
	local ____this_9
	____this_9 = hero
	local ____opt_8 = ____this_9.GetPlayerOwnerID
	local playerId = ____opt_8 and ____opt_8(____this_9)
	if playerId == nil or playerId < 0 then
		return nil
	end
	local ____opt_10 = MyGameRoomManager:GetPlayerRoom(playerId)
	return ____opt_10 and ____opt_10:GetRoomId()
end
function modifier_elite_071_bomb_thinker.prototype.IsHidden(self)
	return true
end
function modifier_elite_071_bomb_thinker.prototype.IsPurgable(self)
	return false
end
modifier_elite_071_bomb_thinker =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_071_bomb_thinker") }, modifier_elite_071_bomb_thinker)
return ____exports