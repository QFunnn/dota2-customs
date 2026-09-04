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
local modifier_elite_047_prepare
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local BLINK_STOMP_COUNT = 1
local BLINK_TARGET_SEARCH_RANGE = 3000
local BLINK_RANDOM_OFFSET = 100
local BLINK_WARNING_RADIUS = 350
local STOMP_RADIUS = 350
local STOMP_DAMAGE_RATE = 20
local STOMP_STUN_DURATION = 1
local STOMP_WARNING_TIME = 0.35
local STOMP_BLINK_DELAY = 0.95
local STOMP_INTERVAL = 0.55
local WARNING_FOLLOW_SPEED = 350
local PARTICLE_PREVIEW_RING = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_preview.vpcf"
local PARTICLE_POOL = "particles/econ/items/spectre/spectre_arcana/spectre_arcana_blademail_v2.vpcf"
local PARTICLE_BLINK_START = "particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf"
local PARTICLE_BLINK_END = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_end.vpcf"
local PARTICLE_SCREAM_OWNER = "particles/units/heroes/hero_queenofpain/queen_scream_of_pain_owner.vpcf"
local PARTICLE_PREPARE = "particles/underlord_2021_immortal_portal_buildup_crimson_max.vpcf"
local SOUND_BLINK_START = "Hero_Spectre.DaggerCast"
local SOUND_BLINK_END = "Hero_Spectre.DaggerImpact"
local SOUND_STOMP = "Hero_Spectre.PreAttack"
____exports.elite_047 = __TS__Class()
local elite_047 = ____exports.elite_047
elite_047.name = "elite_047"
__TS__ClassExtends(elite_047, MonsterAbility_CS)
function elite_047.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_BLINK_START, context)
	PrecacheResource("particle", PARTICLE_BLINK_END, context)
	PrecacheResource("particle", PARTICLE_PREPARE, context)
	PrecacheResource("particle", PARTICLE_PREVIEW_RING, context)
	PrecacheResource("particle", PARTICLE_POOL, context)
end
function elite_047.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.03,
		castDuration = 1.25,
		castRange = 1000,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		isNotMove = true,
		OnStart = function()
			return self:startBlinkSequence()
		end,
	}
end
function elite_047.prototype.startBlinkSequence(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:turnToNearestTarget(caster)
	self:blinkToPoints(0)
end
function elite_047.prototype.blinkToPoints(self, index)
	if index >= BLINK_STOMP_COUNT then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local targetPos = self:getNextBlinkTargetPoint(caster)
	if not targetPos then
		return
	end
	if not self:isValidBlinkPoint(caster:GetAbsOrigin(), targetPos) then
		return
	end
	self:startBlinkMotion(targetPos, function()
		self:Timer(STOMP_INTERVAL, function()
			return self:blinkToPoints(index + 1)
		end)
	end)
end
function elite_047.prototype.startBlinkMotion(self, targetPos, callback)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:Timer(STOMP_WARNING_TIME, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local warningTracker = self:createWarningTargetTracker(caster, targetPos)
		caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
		self:playBlinkParticle("start")
		self:playPointParticle(PARTICLE_BLINK_END, targetPos, BLINK_WARNING_RADIUS)
		modifier_elite_047_prepare:applys(caster, caster, self, { duration = STOMP_WARNING_TIME })
		self:WarningRingEffect(targetPos, BLINK_WARNING_RADIUS, STOMP_BLINK_DELAY, {
			getCenter = function()
				return warningTracker:update()
			end,
		})
		caster:EmitSound(SOUND_STOMP)
		self:Timer(STOMP_BLINK_DELAY, function()
			modifier_elite_047_prepare:applys(caster, caster, self, { duration = 0.35 })
			if not IsValidAlive(nil, caster) then
				return
			end
			local finalTargetPos = warningTracker:update()
			caster:StartGesture(ACT_DOTA_ATTACK)
			FindClearSpaceForUnit(caster, finalTargetPos, true)
			self:playBlinkParticle("end")
			ScreenShake(finalTargetPos, 20, 20, 0.25, 3000, 0, true)
			Timers:CreateTimer(0.1, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:stompArea(finalTargetPos, STOMP_RADIUS, true)
			end)
			if callback ~= nil then
				callback(nil)
			end
		end)
	end)
end
function elite_047.prototype.createWarningTargetTracker(self, caster, initialPos)
	local currentPos = GetGroundPosition(initialPos, caster)
	local lastUpdateTime = GameRules:GetGameTime()
	return {
		update = function()
			if not IsValidAlive(nil, caster) then
				return currentPos
			end
			local now = GameRules:GetGameTime()
			local deltaTime = math.max(now - lastUpdateTime, 0)
			lastUpdateTime = now
			local target = caster:GetMinDistanceUnit(BLINK_TARGET_SEARCH_RANGE)
			if not IsValidAlive(nil, target) then
				return currentPos
			end
			local targetPos = GetGroundPosition(target:GetAbsOrigin(), caster)
			local delta = targetPos:__sub(currentPos)
			local distance = delta:Length2D()
			if distance <= 0.01 then
				currentPos = targetPos
				return currentPos
			end
			local moveDistance = math.min(WARNING_FOLLOW_SPEED * deltaTime, distance)
			local direction = Vector(delta.x / distance, delta.y / distance, 0)
			currentPos = GetGroundPosition(currentPos:__add(direction:__mul(moveDistance)), caster)
			return currentPos
		end,
	}
end
function elite_047.prototype.stompArea(self, pos, radius, isKnockback)
	local caster = self:GetCaster()
	local pfx = ParticleManager:CreateParticle(PARTICLE_POOL, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, radius, radius))
	ParticleManager:SetParticleControl(pfx, 2, Vector(radius, radius, radius))
	ParticleManager:DestroyParticle(pfx, false)
	ParticleManager:ReleaseParticleIndex(pfx)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue29
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = STOMP_DAMAGE_RATE, ability = self })
			enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = STOMP_STUN_DURATION })
			enemy:AddNewModifier(caster, self, "modifier_elite_047_slow", { duration = 3 })
			if isKnockback then
				enemy:KnockBack(caster, self, {
					origin_pos = pos,
					duration = 0.1,
					stunDuration = 0.1,
					stun = true,
					distance = 100,
					height = 0,
				})
			end
		end
		::__continue29::
	end
end
function elite_047.prototype.playBlinkParticle(self, ____type)
	local caster = self:GetCaster()
	local particleName = ____type == "start" and PARTICLE_BLINK_START or PARTICLE_BLINK_END
	local soundName = ____type == "start" and SOUND_BLINK_START or SOUND_BLINK_END
	caster:EmitSound(soundName)
	local pfx = ParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_047.prototype.playPointParticle(self, particleName, pos, radius)
	local caster = self:GetCaster()
	local pfx = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_047.prototype.getNextBlinkTargetPoint(self, caster)
	local target = caster:GetMinDistanceUnit(BLINK_TARGET_SEARCH_RANGE)
	if not IsValidAlive(nil, target) then
		return caster:GetAbsOrigin()
	end
	local targetOrigin = target:GetAbsOrigin()
	do
		local i = 0
		while i < 2 do
			local point = targetOrigin:__add(RandomVector(RandomFloat(0, BLINK_RANDOM_OFFSET)))
			local groundPoint = GetGroundPosition(point, caster)
			if self:isValidBlinkPoint(caster:GetAbsOrigin(), groundPoint) then
				return groundPoint
			end
			i = i + 1
		end
	end
	local targetGroundPoint = GetGroundPosition(targetOrigin, caster)
	if self:isValidBlinkPoint(caster:GetAbsOrigin(), targetGroundPoint) then
		return targetGroundPoint
	end
	return nil
end
function elite_047.prototype.isValidBlinkPoint(self, origin, point)
	if not GridNav:IsTraversable(origin) or GridNav:IsBlocked(origin) then
		return false
	end
	if not GridNav:IsTraversable(point) or GridNav:IsBlocked(point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	if GridNav:FindPathLength(origin, point) == -1 then
		return false
	end
	return true
end
function elite_047.prototype.turnToNearestTarget(self, caster)
	local target = caster:GetMinDistanceUnit(BLINK_TARGET_SEARCH_RANGE)
	if not IsValidAlive(nil, target) then
		return
	end
	local direction = target:GetAbsOrigin():__sub(caster:GetAbsOrigin()):Normalized()
	caster:SetForwardVector(direction)
end
elite_047 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_047)
____exports.elite_047 = elite_047
modifier_elite_047_prepare = __TS__Class()
modifier_elite_047_prepare.name = "modifier_elite_047_prepare"
__TS__ClassExtends(modifier_elite_047_prepare, BaseModifier_CS)
function modifier_elite_047_prepare.prototype.IsHidden(self)
	return true
end
function modifier_elite_047_prepare.prototype.GetEffectName(self)
	return PARTICLE_PREPARE
end
function modifier_elite_047_prepare.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_wraithking_ghosts.vpcf"
end
modifier_elite_047_prepare = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_047_prepare)
local modifier_elite_047_slow = __TS__Class()
modifier_elite_047_slow.name = "modifier_elite_047_slow"
__TS__ClassExtends(modifier_elite_047_slow, BaseModifier_CS)
function modifier_elite_047_slow.prototype.IsHidden(self)
	return false
end
function modifier_elite_047_slow.prototype.IsDebuff(self)
	return true
end
function modifier_elite_047_slow.prototype.IsPurgable(self)
	return true
end
function modifier_elite_047_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -50 }
end
modifier_elite_047_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_047_slow)
return ____exports