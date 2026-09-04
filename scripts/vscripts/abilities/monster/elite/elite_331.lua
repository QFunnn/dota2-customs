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
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 2500
local CAST_POINT = 0.5
local CAST_DURATION = 0.3
local TORNADO_SPAWN_FORWARD_OFFSET = 170
local TORNADO_DURATION = 10
local TORNADO_RADIUS = 250
local TORNADO_MOVE_SPEED = 150
local TORNADO_THINK_INTERVAL = 0.03
local TORNADO_HIT_INTERVAL = 0.5
local TORNADO_DAMAGE_RATE = 20
local TORNADO_KNOCKBACK_DISTANCE = 150
local TORNADO_KNOCKBACK_DURATION = 0.2
local TORNADO_CORE_PARTICLE = "particles/bb/axe_abilityjg_juggernaut_blade_fury_abyssal.vpcf"
local TORNADO_AOE_PARTICLE = "particles/dd/tornado_aoe.vpcf"
local TORNADO_BLADE_FURY_PARTICLE = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal.vpcf"
____exports.elite_331 = __TS__Class()
local elite_331 = ____exports.elite_331
elite_331.name = "elite_331"
__TS__ClassExtends(elite_331, MonsterAbility_CS)
function elite_331.prototype.Precache(self, context)
	PrecacheResource("particle", TORNADO_CORE_PARTICLE, context)
	PrecacheResource("particle", TORNADO_AOE_PARTICLE, context)
	PrecacheResource("particle", TORNADO_BLADE_FURY_PARTICLE, context)
end
function elite_331.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_ATTACK,
		cooldown = 6,
		isNotMove = true,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:FindTarget()) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			return self:FaceTarget()
		end,
		OnStart = function()
			return self:CreateTornado()
		end,
	}
end
function elite_331.prototype.FaceTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindTarget()
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 8)
	end
end
function elite_331.prototype.CreateTornado(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local forward = self:ResolveSpawnDirection(caster)
	local casterOrigin = caster:GetAbsOrigin()
	local preferredPoint = GetGroundPosition(casterOrigin:__add(forward:__mul(TORNADO_SPAWN_FORWARD_OFFSET)), caster)
	local spawnPoint = self:ResolveSafeTornadoPoint(casterOrigin, preferredPoint, caster)
	CreateModifierThinker(
		caster,
		self,
		"modifier_elite_331_tornado_thinker",
		{ duration = TORNADO_DURATION },
		spawnPoint,
		caster:GetTeamNumber(),
		false
	)
end
function elite_331.prototype.ResolveSpawnDirection(self, caster)
	local target = self:FindTarget()
	if IsValidAlive(nil, target) then
		return GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	end
	local forward = caster:GetForwardVector()
	local ____temp_1
	if forward:Length2D() > 0.01 then
		____temp_1 = forward:Normalized()
	else
		____temp_1 = Vector(1, 0, 0)
	end
	return ____temp_1
end
function elite_331.prototype.ResolveSafeTornadoPoint(self, origin, preferredPoint, caster)
	if self:IsTornadoMovePointValid(origin, preferredPoint) then
		return preferredPoint
	end
	return GetGroundPosition(origin, caster)
end
function elite_331.prototype.IsTornadoMovePointValid(self, origin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if IsGridNavDisplacementWalkable(nil, origin) and not GridNav:CanFindPath(origin, point) then
		return false
	end
	return true
end
function elite_331.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
elite_331 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_331)
____exports.elite_331 = elite_331
local modifier_elite_331_tornado_thinker = __TS__Class()
modifier_elite_331_tornado_thinker.name = "modifier_elite_331_tornado_thinker"
__TS__ClassExtends(modifier_elite_331_tornado_thinker, MonsterModifier_CS)
function modifier_elite_331_tornado_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.hitCooldownUntilByEntity = __TS__New(Map)
end
function modifier_elite_331_tornado_thinker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	self:CreateTornadoParticles(parent)
	self:StartIntervalThink(TORNADO_THINK_INTERVAL)
end
function modifier_elite_331_tornado_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	self:MoveTowardNearestEnemy(parent, caster)
	self:UpdateTornadoParticles(parent)
	self:HitEnemies(parent, caster, ability)
end
function modifier_elite_331_tornado_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyTornadoParticles()
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_331_tornado_thinker.prototype.CreateTornadoParticles(self, parent)
	local origin = parent:GetAbsOrigin()
	local radiusVector = Vector(TORNADO_RADIUS, TORNADO_RADIUS, TORNADO_RADIUS)
	local bladeFuryRadiusVector = Vector(TORNADO_RADIUS, 1, 1)
	self.coreParticle = ParticleManager:CreateParticle(TORNADO_CORE_PARTICLE, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(self.coreParticle, 0, origin)
	ParticleManager:SetParticleControl(self.coreParticle, 1, radiusVector)
	ParticleManager:SetParticleShouldCheckFoW(self.coreParticle, false)
	self.aoeParticle = ParticleManager:CreateParticle(TORNADO_AOE_PARTICLE, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(self.aoeParticle, 0, origin)
	ParticleManager:SetParticleControl(self.aoeParticle, 1, radiusVector)
	ParticleManager:SetParticleShouldCheckFoW(self.aoeParticle, false)
	self.bladeFuryParticle = ParticleManager:CreateParticle(TORNADO_BLADE_FURY_PARTICLE, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(self.bladeFuryParticle, 0, origin)
	ParticleManager:SetParticleControl(self.bladeFuryParticle, 5, bladeFuryRadiusVector)
	ParticleManager:SetParticleShouldCheckFoW(self.bladeFuryParticle, false)
end
function modifier_elite_331_tornado_thinker.prototype.UpdateTornadoParticles(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	if self.coreParticle ~= nil then
		ParticleManager:SetParticleControl(self.coreParticle, 0, origin)
	end
	if self.aoeParticle ~= nil then
		ParticleManager:SetParticleControl(self.aoeParticle, 0, origin)
	end
	if self.bladeFuryParticle ~= nil then
		ParticleManager:SetParticleControl(self.bladeFuryParticle, 0, origin)
	end
end
function modifier_elite_331_tornado_thinker.prototype.DestroyTornadoParticles(self)
	if self.coreParticle ~= nil then
		ParticleManager:DestroyParticle(self.coreParticle, false)
		ParticleManager:ReleaseParticleIndex(self.coreParticle)
		self.coreParticle = nil
	end
	if self.aoeParticle ~= nil then
		ParticleManager:DestroyParticle(self.aoeParticle, false)
		ParticleManager:ReleaseParticleIndex(self.aoeParticle)
		self.aoeParticle = nil
	end
	if self.bladeFuryParticle ~= nil then
		ParticleManager:DestroyParticle(self.bladeFuryParticle, false)
		ParticleManager:ReleaseParticleIndex(self.bladeFuryParticle)
		self.bladeFuryParticle = nil
	end
end
function modifier_elite_331_tornado_thinker.prototype.MoveTowardNearestEnemy(self, parent, caster)
	if not IsValidAlive(nil, parent) then
		return
	end
	local target = parent:GetMinDistanceUnit(CAST_RANGE)
	if not IsValidAlive(nil, target) then
		return
	end
	local origin = parent:GetAbsOrigin()
	local direction = GetDirection(nil, target:GetAbsOrigin(), origin)
	local moveDistance = TORNADO_MOVE_SPEED * TORNADO_THINK_INTERVAL
	local nextPoint = GetGroundPosition(origin:__add(direction:__mul(moveDistance)), caster)
	if not self:IsMovePointValid(origin, nextPoint) then
		return
	end
	parent:SetAbsOrigin(nextPoint)
end
function modifier_elite_331_tornado_thinker.prototype.IsMovePointValid(self, origin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if IsGridNavDisplacementWalkable(nil, origin) and not GridNav:CanFindPath(origin, point) then
		return false
	end
	return true
end
function modifier_elite_331_tornado_thinker.prototype.HitEnemies(self, parent, caster, ability)
	local now = GameRules:GetGameTime()
	if not IsValidAlive(nil, caster) then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		TORNADO_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue50
			end
			local entityIndex = enemy:GetEntityIndex()
			local cooldownUntil = self.hitCooldownUntilByEntity:get(entityIndex) or 0
			if now < cooldownUntil then
				goto __continue50
			end
			self.hitCooldownUntilByEntity:set(entityIndex, now + TORNADO_HIT_INTERVAL)
			caster:MonsterDamage({ victim = enemy, damage_rate = TORNADO_DAMAGE_RATE, ability = ability })
			enemy:KnockBack(caster, ability, {
				duration = TORNADO_KNOCKBACK_DURATION,
				distance = TORNADO_KNOCKBACK_DISTANCE,
				height = 0,
				direction = GetDirection(nil, enemy:GetAbsOrigin(), parent:GetAbsOrigin()),
			})
		end
		::__continue50::
	end
end
function modifier_elite_331_tornado_thinker.prototype.IsHidden(self)
	return true
end
function modifier_elite_331_tornado_thinker.prototype.IsPurgable(self)
	return false
end
modifier_elite_331_tornado_thinker = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_331_tornado_thinker") },
	modifier_elite_331_tornado_thinker
)
return ____exports