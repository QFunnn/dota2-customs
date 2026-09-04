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
local CAST_POINT = 1.3
local CAST_DURATION = 0.45
local PULL_RADIUS = 800
local PULL_SPEED = 200
local PULL_STOP_DISTANCE = 120
local TURN_SPEED = 6
local SLAM_PARTICLE = "particles/neutral_fx/ursa_thunderclap.vpcf"
local GROUND_PARTICLE = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
local PULL_PARTICLE = "particles/units/kez_003.vpcf"
local CAST_SOUND = "Roshan.Slam"
local HIT_SOUND = "Hero_Centaur.HoofStomp"
local DAMAGE_RATE = 50
____exports.roshan_001 = __TS__Class()
local roshan_001 = ____exports.roshan_001
roshan_001.name = "roshan_001"
__TS__ClassExtends(roshan_001, MonsterAbility_CS)
function roshan_001.prototype.Precache(self, context)
	PrecacheResource("particle", SLAM_PARTICLE, context)
	PrecacheResource("particle", GROUND_PARTICLE, context)
	PrecacheResource("particle", PULL_PARTICLE, context)
end
function roshan_001.prototype.GetCooldown(self, _level)
	return 6
end
function roshan_001.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = PULL_RADIUS,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		animationPlaybackRate = 0.5,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			____exports.modifier_roshan_001_pull:applys(caster, caster, self, { duration = CAST_POINT })
			local target = caster:GetMinDistanceUnit(1200)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, 0.3, TURN_SPEED)
			end
			self:Timer(0.4, function()
				self:WarningRingEffect(caster:GetAbsOrigin(), PULL_RADIUS, CAST_POINT - 0.4, {
					follow = true,
					getCenter = function()
						return caster:GetAbsOrigin()
					end,
				})
			end)
		end,
		OnStart = function()
			____exports.modifier_roshan_001_pull:remove(self:GetCaster())
			self:ReleaseImpact()
		end,
		OnInterrupt = function()
			return ____exports.modifier_roshan_001_pull:remove(self:GetCaster())
		end,
	}
end
function roshan_001.prototype.ReleaseImpact(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = GetGroundPosition(caster:GetAbsOrigin(), caster)
	EmitSoundOn(CAST_SOUND, caster)
	EmitSoundOnLocationWithCaster(center, HIT_SOUND, caster)
	ScreenShake(center, 14, 10, 0.35, 1200, 0, true)
	GridNav:DestroyTreesAroundPoint(center, 420, false)
	self:PlaySuctionEffect(center, caster)
	local casterPos = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		casterPos,
		nil,
		PULL_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue14
			end
			enemy:KnockBack(caster, self, {
				duration = 0.1,
				particleName = "",
				distance = 100,
				height = 0,
				stun = true,
				stunDuration = 1,
				origin_pos = caster:GetAbsOrigin(),
			})
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
		end
		::__continue14::
	end
end
function roshan_001.prototype.PlaySuctionEffect(self, center, caster)
	local stomp = ParticleManager:CreateParticle(GROUND_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(stomp, 0, center)
	ParticleManager:SetParticleControl(stomp, 1, Vector(PULL_RADIUS, PULL_RADIUS, 0))
	ParticleManager:ReleaseParticleIndex(stomp)
	local thunder = ParticleManager:CreateParticle(SLAM_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(thunder, 0, center)
	ParticleManager:SetParticleControl(thunder, 1, Vector(PULL_RADIUS, PULL_RADIUS, 0))
	ParticleManager:ReleaseParticleIndex(thunder)
end
roshan_001 = __TS__DecorateLegacy({ registerAbility(nil) }, roshan_001)
____exports.roshan_001 = roshan_001
____exports.modifier_roshan_001_pull = __TS__Class()
local modifier_roshan_001_pull = ____exports.modifier_roshan_001_pull
modifier_roshan_001_pull.name = "modifier_roshan_001_pull"
__TS__ClassExtends(modifier_roshan_001_pull, MonsterModifier_CS)
function modifier_roshan_001_pull.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local pullPfx = ParticleManager:CreateParticle(PULL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pullPfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(pullPfx, 1, Vector(PULL_RADIUS, PULL_RADIUS, PULL_RADIUS))
	self:AddParticle(pullPfx, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end
function modifier_roshan_001_pull.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local casterPos = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		casterPos,
		nil,
		PULL_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local step = PULL_SPEED * FrameTime()
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue23
			end
			local ____opt_0 = enemy.GetUnitType
			local unitType = ____opt_0 and ____opt_0(enemy)
			if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
				goto __continue23
			end
			local enemyPos = enemy:GetAbsOrigin()
			local toCaster = casterPos:__sub(enemyPos)
			local distance = toCaster:Length2D()
			if distance <= PULL_STOP_DISTANCE then
				goto __continue23
			end
			local moveDistance = math.min(step, distance - PULL_STOP_DISTANCE)
			local nextPos = enemyPos:__add(toCaster:Normalized():__mul(moveDistance))
			nextPos.z = GetGroundHeight(nextPos, enemy)
			if not IsGridNavDisplacementWalkable(nil, nextPos) then
				goto __continue23
			end
			enemy:SetAbsOrigin(nextPos)
			ResolveNPCPositions(nextPos, enemy:GetHullRadius())
		end
		::__continue23::
	end
end
function modifier_roshan_001_pull.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
modifier_roshan_001_pull = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_roshan_001_pull)
____exports.modifier_roshan_001_pull = modifier_roshan_001_pull
return ____exports