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
local PROP_IDLE_ANIMATION = "ACT_DOTA_CUSTOM_TOWER_IDLE"
local PROP_ATTACK_ANIMATION = "attack_1_multi_aim"
local PROP_ATTACK_INTERVAL = 5
local PROJECTILE_LAUNCH_DELAY = 0.67
local PROJECTILE_SPEED = 900
local PROJECTILE_FORWARD_OFFSET = 70
local PROJECTILE_HEIGHT_OFFSET = 150
local IMPACT_WARNING_RADIUS = 160
local PROP_DEATH_DURATION = 3
local PROP_SCALE = 1
local IMPACT_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
local ATTACK_SOUND = "Tower.Bad.Attack"
local IMPACT_SOUND = "Tower.Bad.Impact"
--- 使用同一套转向、动作和投射物逻辑的天灾防御塔展示配置。
____exports.DIRE_TOWER_VISUAL_CONFIGS = {
	elite_075 = {
		model = "models/items/world/towers/dire_tower_2021/dire_tower_2021.vmdl",
		projectileParticle = "particles/econ/world/towers/dire_tower_2021/dire_tower_2021_attack.vpcf",
		ambientParticle = "particles/econ/world/towers/dire_tower_2021/dire_tower_2021_ambient.vpcf",
		deathParticle = "particles/econ/world/towers/dire_tower_2021/dire_tower_2021_destruction.vpcf",
	},
	elite_076 = {
		model = "models/items/world/towers/dire_tower_2022/dire_tower_2022.vmdl",
		projectileParticle = "particles/econ/world/towers/dire_tower_2022/dire_tower_2022_attack.vpcf",
		ambientParticle = "particles/econ/world/towers/dire_tower_2022/dire_tower_2022_ambient.vpcf",
		deathParticle = "particles/econ/world/towers/dire_tower_2022/dire_tower_2022_destruction.vpcf",
	},
	elite_077 = {
		model = "models/items/world/towers/ti10_dire_tower/ti10_dire_tower.vmdl",
		projectileParticle = "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_attack.vpcf",
		ambientParticle = "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_ambient.vpcf",
		deathParticle = "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_destruction.vpcf",
	},
}
function ____exports.PrecacheDireTowerVisual(self, context, abilityName)
	local config = ____exports.DIRE_TOWER_VISUAL_CONFIGS[abilityName]
	if not config then
		return
	end
	PrecacheResource("model", config.model, context)
	PrecacheResource("particle", config.deathParticle, context)
	PrecacheResource("particle", config.projectileParticle, context)
	PrecacheResource("particle", config.ambientParticle, context)
	PrecacheResource("particle", IMPACT_PARTICLE, context)
end
--- 精英技能 75 - 2021 天灾防御塔：使用塔模型动作和投射物进行攻击表现。
____exports.elite_075 = __TS__Class()
local elite_075 = ____exports.elite_075
elite_075.name = "elite_075"
__TS__ClassExtends(elite_075, MonsterAbility_CS)
function elite_075.prototype.Precache(self, context)
	____exports.PrecacheDireTowerVisual(nil, context, self:GetAbilityName())
end
function elite_075.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_075_dire_tower"
end
function elite_075.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
elite_075 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_075)
____exports.elite_075 = elite_075
local modifier_elite_075_dire_tower = __TS__Class()
modifier_elite_075_dire_tower.name = "modifier_elite_075_dire_tower"
__TS__ClassExtends(modifier_elite_075_dire_tower, MonsterModifier_CS)
function modifier_elite_075_dire_tower.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local config = self:GetTowerConfig()
	if not config then
		return
	end
	self:BindPropAnimation()
	local mapEntity = self:ResolveMapComponentEntity(parent)
	if mapEntity then
		local particleId = ParticleManager:CreateParticle(config.ambientParticle, PATTACH_ABSORIGIN_FOLLOW, mapEntity)
		self:AddParticle(particleId, false, false, -1, false, false)
	end
	self:StartIntervalThink(PROP_ATTACK_INTERVAL)
	self:OnIntervalThink()
end
function modifier_elite_075_dire_tower.prototype.OnIntervalThink(self)
	if not IsServer() or self.propAnimationId == nil then
		return
	end
	local parent = self:GetParent()
	local target = self:FindAimTarget()
	local config = self:GetTowerConfig()
	if not target or not IsValidAlive(nil, parent) or not config then
		return
	end
	local targetPoint = GetGroundPosition(target:GetAbsOrigin(), target)
	local direction = GetDirection(nil, targetPoint, parent:GetAbsOrigin())
	local signedAim = self:GetAimPoseValue(parent:GetForwardVector(), direction)
	local launchPoint = parent
		:GetAbsOrigin()
		:__add(direction:__mul(PROJECTILE_FORWARD_OFFSET))
		:__add(Vector(0, 0, PROJECTILE_HEIGHT_OFFSET))
	local flightDuration = targetPoint:__sub(launchPoint):Length2D() / PROJECTILE_SPEED
	local currentId = self.propAnimationId
	MyGamePropAnimation:SetSequence(currentId, PROP_ATTACK_ANIMATION)
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
		return self:LaunchProjectile(parent, launchPoint, targetPoint, config)
	end)
end
function modifier_elite_075_dire_tower.prototype.GetAimPoseValue(self, forward, direction)
	local cross = forward.x * direction.y - forward.y * direction.x
	local dot = forward.x * direction.x + forward.y * direction.y
	return math.max(-1, math.min(1, math.atan2(cross, dot) / math.pi))
end
function modifier_elite_075_dire_tower.prototype.LaunchProjectile(self, parent, launchPoint, targetPoint, config)
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		return
	end
	CreateProjectile(nil, {
		ability = ability,
		caster = parent,
		projectile_type = "collideground",
		effect_name = config.projectileParticle,
		projectile_speed = PROJECTILE_SPEED,
		start_point = launchPoint,
		target = targetPoint,
		on_hit = function(____, _hitTarget, location)
			if not IsValidAlive(nil, parent) then
				return true
			end
			local impactPoint = GetGroundPosition(location, parent)
			parent:EmitSound(IMPACT_SOUND)
			local particleId = ParticleManager:CreateParticle(IMPACT_PARTICLE, PATTACH_WORLDORIGIN, parent)
			ParticleManager:SetParticleControl(particleId, 0, impactPoint)
			ParticleManager:ReleaseParticleIndex(particleId)
			return true
		end,
	})
end
function modifier_elite_075_dire_tower.prototype.FindAimTarget(self)
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
function modifier_elite_075_dire_tower.prototype.BindPropAnimation(self)
	local parent = self:GetParent()
	local config = self:GetTowerConfig()
	if not IsValidAlive(nil, parent) or not config or type(MyGamePropAnimation) == "nil" or not MyGamePropAnimation then
		return
	end
	self.propAnimationId = MyGamePropAnimation:Create({
		bindUnit = parent,
		model = config.model,
		idleAnimation = PROP_IDLE_ANIMATION,
		deathParticle = config.deathParticle,
		deathDuration = PROP_DEATH_DURATION,
		scale = PROP_SCALE,
	})
end
function modifier_elite_075_dire_tower.prototype.GetTowerConfig(self)
	local ____opt_0 = self:GetAbility()
	return ____exports.DIRE_TOWER_VISUAL_CONFIGS[____opt_0 and ____opt_0:GetAbilityName() or ""]
end
function modifier_elite_075_dire_tower.prototype.ResolveMapComponentEntity(self, parent)
	local ____this_3
	____this_3 = parent
	local ____opt_2 = ____this_3.GetRoomId
	local roomId = ____opt_2 and ____opt_2(____this_3)
	if not roomId then
		return nil
	end
	local room = MyGameRoomManager:GetRoom(roomId)
	if not room then
		return nil
	end
	for ____, component in ipairs(room:GetComponents("Monster")) do
		do
			local ____opt_4 = component.GetSpawnedUnit
			if ____opt_4 ~= nil then
				____opt_4 = ____opt_4(component)
			end
			if ____opt_4 ~= parent then
				goto __continue29
			end
			local ____opt_6 = component.GetEntity
			if ____opt_6 ~= nil then
				____opt_6 = ____opt_6(component)
			end
			local entity = ____opt_6
			if entity and IsValid(nil, entity) and not entity:IsNull() then
				return entity
			end
		end
		::__continue29::
	end
	return nil
end
function modifier_elite_075_dire_tower.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	if self.propAnimationId ~= nil then
		MyGamePropAnimation:Destroy(self.propAnimationId)
		self.propAnimationId = nil
	end
end
function modifier_elite_075_dire_tower.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
function modifier_elite_075_dire_tower.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING, MODIFIER_PROPERTY_IGNORE_CAST_ANGLE }
end
function modifier_elite_075_dire_tower.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_elite_075_dire_tower.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_elite_075_dire_tower.prototype.IsHidden(self)
	return true
end
function modifier_elite_075_dire_tower.prototype.IsPurgable(self)
	return false
end
modifier_elite_075_dire_tower =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_075_dire_tower") }, modifier_elite_075_dire_tower)
return ____exports