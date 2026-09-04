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
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local warningEffectRing = ____monster_base.warningEffectRing
local PROP_MODEL = "models/props_structures/rock_golem/tower_radiant_rock_golem.vmdl"
local PROP_IDLE_ANIMATION = "ACT_DOTA_CUSTOM_TOWER_IDLE"
local PROP_ATTACK_DURATION = 0.97
local PROP_ATTACK_INTERVAL = 5
local PROJECTILE_LAUNCH_DELAY = 0.67
local PROJECTILE_SPEED = 900
local PROJECTILE_FORWARD_OFFSET = 70
local PROJECTILE_HEIGHT_OFFSET = 150
local IMPACT_WARNING_RADIUS = 160
local PROP_DEATH_PARTICLE = "particles/econ/world/towers/rock_golem/radiant_rock_golem_destruction.vpcf"
local PROP_DEATH_DURATION = 3
local PROP_SCALE = 1
local ROCK_PROJECTILE_PARTICLE = "particles/econ/world/towers/rock_golem/radiant_rock_golem_attack.vpcf"
local ROCK_IMPACT_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
local ROCK_AMBIENT_PARTICLE = "particles/econ/world/towers/rock_golem/radiant_rock_golem_ambient.vpcf"
local ATTACK_SOUND = "GolemTower.Radiant.Attack"
local IMPACT_SOUND = "GolemTower.Radiant.ProjectileImpact"
--- 精英技能 74 - 岩石防御塔：每次普通攻击投掷一块追踪目标的石块。
____exports.elite_074 = __TS__Class()
local elite_074 = ____exports.elite_074
elite_074.name = "elite_074"
__TS__ClassExtends(elite_074, MonsterAbility_CS)
function elite_074.prototype.Precache(self, context)
	PrecacheResource("model", PROP_MODEL, context)
	PrecacheResource("particle", PROP_DEATH_PARTICLE, context)
	PrecacheResource("particle", ROCK_PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", ROCK_IMPACT_PARTICLE, context)
	PrecacheResource("particle", ROCK_AMBIENT_PARTICLE, context)
end
function elite_074.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_074_rock_tower"
end
function elite_074.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
elite_074 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_074)
____exports.elite_074 = elite_074
local modifier_elite_074_rock_tower = __TS__Class()
modifier_elite_074_rock_tower.name = "modifier_elite_074_rock_tower"
__TS__ClassExtends(modifier_elite_074_rock_tower, MonsterModifier_CS)
function modifier_elite_074_rock_tower.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:BindPropAnimation()
	local mapComponentEntity = self:ResolveMapComponentEntity(parent)
	if mapComponentEntity then
		local ambientParticleId =
			ParticleManager:CreateParticle(ROCK_AMBIENT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, mapComponentEntity)
		self:AddParticle(ambientParticleId, false, false, -1, false, false)
	end
	self:StartIntervalThink(PROP_ATTACK_INTERVAL)
	self:OnIntervalThink()
end
function modifier_elite_074_rock_tower.prototype.OnIntervalThink(self)
	if not IsServer() or self.propAnimationId == nil then
		return
	end
	local target = self:FindAimTarget()
	local parent = self:GetParent()
	if not target or not IsValidAlive(nil, parent) then
		return
	end
	local targetPoint = GetGroundPosition(target:GetAbsOrigin(), target)
	local direction = GetDirection(nil, targetPoint, parent:GetAbsOrigin())
	local forward = parent:GetForwardVector()
	local signedAim = self:GetAimPoseValue(forward, direction)
	local launchPoint = parent
		:GetAbsOrigin()
		:__add(direction:__mul(PROJECTILE_FORWARD_OFFSET))
		:__add(Vector(0, 0, PROJECTILE_HEIGHT_OFFSET))
	local flightDuration = targetPoint:__sub(launchPoint):Length2D() / PROJECTILE_SPEED
	local currentId = self.propAnimationId
	MyGamePropAnimation:SetSequence(currentId, "attack_multi")
	MyGamePropAnimation:SetPoseParameter(currentId, "aim", signedAim)
	parent:EmitSound(ATTACK_SOUND)
	warningEffectRing(
		nil,
		parent,
		targetPoint,
		IMPACT_WARNING_RADIUS,
		PROJECTILE_LAUNCH_DELAY + flightDuration,
		{ speed = 0 }
	)
	self:Timer(PROJECTILE_LAUNCH_DELAY, function()
		self:LaunchGroundProjectile(parent, launchPoint, targetPoint)
	end)
end
function modifier_elite_074_rock_tower.prototype.GetAimPoseValue(self, forward, direction)
	local cross = forward.x * direction.y - forward.y * direction.x
	local dot = forward.x * direction.x + forward.y * direction.y
	return math.max(-1, math.min(1, math.atan2(cross, dot) / math.pi))
end
function modifier_elite_074_rock_tower.prototype.LaunchGroundProjectile(self, parent, launchPoint, targetPoint)
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		return
	end
	CreateProjectile(nil, {
		ability = ability,
		caster = parent,
		projectile_type = "collideground",
		effect_name = ROCK_PROJECTILE_PARTICLE,
		projectile_speed = PROJECTILE_SPEED,
		start_point = launchPoint,
		target = targetPoint,
		on_hit = function(____, _hitTarget, location)
			if not IsValidAlive(nil, parent) then
				return true
			end
			local impactPoint = GetGroundPosition(location, parent)
			parent:EmitSound(IMPACT_SOUND)
			self:PlayGroundImpactEffect(parent, impactPoint)
			return true
		end,
	})
end
function modifier_elite_074_rock_tower.prototype.PlayGroundImpactEffect(self, parent, impactPoint)
	local particleId = ParticleManager:CreateParticle(ROCK_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(particleId, 0, impactPoint)
	ParticleManager:ReleaseParticleIndex(particleId)
end
function modifier_elite_074_rock_tower.prototype.FindAimTarget(self)
	local parent = self:GetParent()
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		1200,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	return __TS__ArrayFind(enemies, function(____, enemy)
		return IsValidAlive(nil, enemy)
	end)
end
function modifier_elite_074_rock_tower.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	if self.propAnimationId == nil or not IsValidAlive(nil, parent) then
		return
	end
	MyGamePropAnimation:Destroy(self.propAnimationId)
	self.propAnimationId = nil
end
function modifier_elite_074_rock_tower.prototype.BindPropAnimation(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if type(MyGamePropAnimation) == "nil" or not MyGamePropAnimation then
		WarningPrint(
			(("[elite_074] PROP 管理器未初始化，跳过模型绑定 unit=" .. parent:GetUnitName()) .. " index=")
				.. tostring(parent:entindex())
		)
		return
	end
	self.propAnimationId = MyGamePropAnimation:Create({
		bindUnit = parent,
		model = PROP_MODEL,
		idleAnimation = PROP_IDLE_ANIMATION,
		deathParticle = PROP_DEATH_PARTICLE,
		deathDuration = PROP_DEATH_DURATION,
		scale = PROP_SCALE,
	})
	if self.propAnimationId == nil then
		WarningPrint(
			(("[elite_074] 岩石防御塔 PROP 绑定失败 unit=" .. parent:GetUnitName()) .. " index=")
				.. tostring(parent:entindex())
		)
	end
end
function modifier_elite_074_rock_tower.prototype.ResolveMapComponentEntity(self, parent)
	local ____this_1
	____this_1 = parent
	local ____opt_0 = ____this_1.GetRoomId
	local roomId = ____opt_0 and ____opt_0(____this_1)
	if not roomId then
		return nil
	end
	local room = MyGameRoomManager:GetRoom(roomId)
	if not room then
		return nil
	end
	for ____, component in ipairs(room:GetComponents("Monster")) do
		do
			local ____opt_2 = component.GetSpawnedUnit
			if ____opt_2 ~= nil then
				____opt_2 = ____opt_2(component)
			end
			if ____opt_2 ~= parent then
				goto __continue31
			end
			local ____opt_4 = component.GetEntity
			if ____opt_4 ~= nil then
				____opt_4 = ____opt_4(component)
			end
			local entity = ____opt_4
			if entity and IsValid(nil, entity) and not entity:IsNull() then
				return entity
			end
		end
		::__continue31::
	end
	return nil
end
function modifier_elite_074_rock_tower.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
function modifier_elite_074_rock_tower.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING, MODIFIER_PROPERTY_IGNORE_CAST_ANGLE }
end
function modifier_elite_074_rock_tower.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_elite_074_rock_tower.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_elite_074_rock_tower.prototype.IsHidden(self)
	return true
end
function modifier_elite_074_rock_tower.prototype.IsPurgable(self)
	return false
end
modifier_elite_074_rock_tower =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_074_rock_tower") }, modifier_elite_074_rock_tower)
return ____exports