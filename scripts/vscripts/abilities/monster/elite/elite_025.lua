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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_025_THINKER_DURATION = 3
local ELITE_025_THINKER_SPEED = 500
local ELITE_025_THINKER_RADIUS = 250
local ELITE_025_SPAWN_OFFSET = 80
local ELITE_025_PROJECTILE_INTERVAL = 0.3
local ELITE_025_DAMAGE_INTERVAL = 0.2
local ELITE_025_STUN_DURATION = 0.1
local ELITE_025_DAMAGE_RATE = 8
local ELITE_025_PARTICLE = "particles/units/heroes/hero_tiny/tiny_avalanche_lvl4.vpcf"
local ELITE_025_PROJECTILE_PARTICLE = "particles/units/heroes/hero_tiny/tiny_avalanche_projectile_lvl4.vpcf"
local ELITE_025_CAST_RANGE = 1200
--- 精英技能25 - 巨石崩塌：施法成功后面前生成缓慢前移的 avalanche thinker
____exports.elite_025 = __TS__Class()
local elite_025 = ____exports.elite_025
elite_025.name = "elite_025"
__TS__ClassExtends(elite_025, MonsterAbility_CS)
function elite_025.prototype.Precache(self, context)
	PrecacheResource("particle", ELITE_025_PARTICLE, context)
	PrecacheResource("particle", ELITE_025_PROJECTILE_PARTICLE, context)
end
function elite_025.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = ELITE_025_CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 1.6,
		castDuration = 0.6,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsServer() or not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local len = math.sqrt(forward.x * forward.x + forward.y * forward.y) or 1
			local dir = Vector(forward.x / len, forward.y / len, 0)
			local startPos = origin:__add(dir:__mul(ELITE_025_SPAWN_OFFSET))
			startPos.z = GetGroundPosition(startPos, caster).z
			local pathLen = ELITE_025_CAST_RANGE
			local endPos = startPos:__add(dir:__mul(pathLen))
			endPos.z = GetGroundPosition(endPos, caster).z
			local target = caster:GetMinDistanceUnit(2500)
			caster:LockTargetForSpeed(target, 1.5, 2)
			self:WarningEffect(startPos, endPos, 1.6, {
				startWidth = ELITE_025_THINKER_RADIUS,
				endWidth = ELITE_025_THINKER_RADIUS,
				getDirection = function()
					return caster:GetForwardVector()
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
			caster:EmitSound("Hero_EarthShaker.Fissure.Cast")
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local spawnPos = origin:__add(forward:__mul(ELITE_025_SPAWN_OFFSET))
			spawnPos.z = GetGroundPosition(spawnPos, caster).z
			CreateModifierThinker(
				caster,
				self,
				"modifier_elite_025_avalanche_thinker",
				{ duration = ELITE_025_THINKER_DURATION, dir_x = forward.x, dir_y = forward.y, dir_z = 0 },
				spawnPos,
				caster:GetTeamNumber(),
				false
			)
			ScreenShake(origin, 8, 8, 2.5, 3000, 0, true)
		end,
	}
end
elite_025 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_025)
____exports.elite_025 = elite_025
local modifier_elite_025_avalanche_thinker = __TS__Class()
modifier_elite_025_avalanche_thinker.name = "modifier_elite_025_avalanche_thinker"
__TS__ClassExtends(modifier_elite_025_avalanche_thinker, MonsterModifier_CS)
function modifier_elite_025_avalanche_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.speed = ELITE_025_THINKER_SPEED
	self._projectileTimer = 0
	self._damageTimer = 0
end
function modifier_elite_025_avalanche_thinker.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local dirX = params.dir_x or 1
	local dirY = params.dir_y or 0
	self.dir = Vector(dirX, dirY, 0)
	local len = self.dir:Length2D()
	if len > 0.001 then
		self.dir = self.dir:__mul(1 / len)
	else
		self.dir = Vector(1, 0, 0)
	end
	parent:SetForwardVector(self.dir)
	self.pfx = ParticleManager:CreateParticle(ELITE_025_PARTICLE, PATTACH_POINT_FOLLOW, parent)
	ParticleManager:SetParticleControl(self.pfx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(
		self.pfx,
		1,
		Vector(ELITE_025_THINKER_RADIUS, ELITE_025_THINKER_RADIUS, ELITE_025_THINKER_RADIUS)
	)
	ParticleManager:SetParticleControlTransformForward(self.pfx, 0, parent:GetAbsOrigin(), self.dir)
	self:AddParticle(self.pfx, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_025_avalanche_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	local remaining = self:GetRemainingTime()
	if remaining <= 0 then
		self:Destroy()
		return
	end
	local dt = FrameTime()
	local pos = parent:GetAbsOrigin()
	local move = self.dir:__mul(self.speed * dt)
	local newPos = pos:__add(move)
	newPos.z = GetGroundPosition(newPos, parent).z
	parent:SetAbsOrigin(newPos)
	self._projectileTimer = self._projectileTimer + dt
	if self._projectileTimer >= ELITE_025_PROJECTILE_INTERVAL then
		self._projectileTimer = self._projectileTimer - ELITE_025_PROJECTILE_INTERVAL
		local fxPos = parent:GetAbsOrigin()
		local proj = ParticleManager:CreateParticle(ELITE_025_PROJECTILE_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(proj, 0, fxPos)
		ParticleManager:SetParticleControl(proj, 1, self.dir:__mul(100))
		Timers:CreateTimer(ELITE_025_PROJECTILE_INTERVAL, function()
			ParticleManager:DestroyParticle(proj, false)
			ParticleManager:ReleaseParticleIndex(proj)
		end)
	end
	self._damageTimer = self._damageTimer + dt
	if self._damageTimer >= ELITE_025_DAMAGE_INTERVAL then
		self._damageTimer = self._damageTimer - ELITE_025_DAMAGE_INTERVAL
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		if not IsValidAlive(nil, caster) or not ability then
			return
		end
		local center = parent:GetAbsOrigin()
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			center,
			nil,
			ELITE_025_THINKER_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) then
					goto __continue23
				end
				enemy:AddNewModifier(caster, ability, "modifier_stunned", { duration = ELITE_025_STUN_DURATION })
				caster:MonsterDamage({ victim = enemy, damage_rate = ELITE_025_DAMAGE_RATE, ability = ability })
			end
			::__continue23::
		end
	end
end
function modifier_elite_025_avalanche_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.pfx ~= nil then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
end
modifier_elite_025_avalanche_thinker = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_025_avalanche_thinker") },
	modifier_elite_025_avalanche_thinker
)
return ____exports