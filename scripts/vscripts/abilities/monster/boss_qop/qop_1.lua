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
local modifier_qop_1_prepare
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local BLINK_STOMP_COUNT = 1
local BLINK_TARGET_SEARCH_RANGE = 3000
local BLINK_RANDOM_OFFSET = 260
local BLINK_WARNING_RADIUS = 420
local STOMP_RADIUS = 500
local STOMP_DAMAGE_RATE = 20
local STOMP_KNOCKBACK_DISTANCE = 360
local STOMP_WARNING_TIME = 0.35
local STOMP_BLINK_DELAY = 0.35
local STOMP_INTERVAL = 0.55
local PARTICLE_BLINK_START = "particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf"
local PARTICLE_BLINK_END = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_end.vpcf"
local PARTICLE_SCREAM_OWNER = "particles/units/heroes/hero_queenofpain/queen_scream_of_pain_owner.vpcf"
local PARTICLE_PREPARE = "particles/underlord_2021_immortal_portal_buildup_crimson_max.vpcf"
local PARTICLE_PREVIEW_RING = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_preview.vpcf"
local PARTICLE_POOL = "particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf"
____exports.qop_1 = __TS__Class()
local qop_1 = ____exports.qop_1
qop_1.name = "qop_1"
__TS__ClassExtends(qop_1, MonsterAbility_CS)
function qop_1.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_BLINK_START, context)
	PrecacheResource("particle", PARTICLE_BLINK_END, context)
	PrecacheResource("particle", PARTICLE_SCREAM_OWNER, context)
	PrecacheResource("particle", PARTICLE_PREPARE, context)
	PrecacheResource("particle", PARTICLE_PREVIEW_RING, context)
end
function qop_1.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.35,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
		end,
		OnStart = function()
			return self:startBlinkSequence()
		end,
	}
end
function qop_1.prototype.startBlinkSequence(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:turnToNearestTarget(caster)
	self:blinkToPoints(0)
end
function qop_1.prototype.blinkToPoints(self, index)
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
function qop_1.prototype.startBlinkMotion(self, targetPos, callback)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:Timer(STOMP_WARNING_TIME, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
		self:playBlinkParticle("start")
		self:playBlinkParticle("end")
		modifier_qop_1_prepare:applys(caster, caster, self, { duration = STOMP_WARNING_TIME })
		self:WarningRingEffect(targetPos, BLINK_WARNING_RADIUS, STOMP_BLINK_DELAY)
		caster:EmitSound("Hero_QueenOfPain.ScreamOfPain")
		self:Timer(STOMP_BLINK_DELAY, function()
			caster:AddNewModifier(caster, self, "qop_3_pre2", { duration = 0.35 })
			if not IsValidAlive(nil, caster) then
				return
			end
			self:stompArea(caster:GetAbsOrigin(), STOMP_RADIUS * 0.7, true)
			FindClearSpaceForUnit(caster, targetPos, true)
			ScreenShake(targetPos, 20, 20, 0.25, 3000, 0, true)
			Timers:CreateTimer(0.1, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:stompArea(targetPos, STOMP_RADIUS * 0.9, true)
			end)
			if callback ~= nil then
				callback(nil)
			end
		end)
	end)
end
function qop_1.prototype.stompArea(self, pos, radius, isKnockback)
	local caster = self:GetCaster()
	local pfx = ParticleManager:CreateParticle(PARTICLE_POOL, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, radius, radius))
	ParticleManager:SetParticleControl(pfx, 2, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(pfx)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		radius * 0.9,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue24
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = STOMP_DAMAGE_RATE, ability = self })
			enemy:AddNewModifier(caster, self, "modifier_qop_1_slow", { duration = 2 })
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
		::__continue24::
	end
end
function qop_1.prototype.playBlinkParticle(self, ____type)
	local caster = self:GetCaster()
	local particleName = ____type == "start" and PARTICLE_BLINK_START or PARTICLE_BLINK_END
	local soundName = ____type == "start" and "Hero_QueenOfPain.Blink_in.Layer" or "Hero_QueenOfPain.Blink_out.Arcana"
	caster:EmitSound(soundName)
	local pfx = ParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(pfx)
end
function qop_1.prototype.getNextBlinkTargetPoint(self, caster)
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
function qop_1.prototype.isValidBlinkPoint(self, origin, point)
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
function qop_1.prototype.turnToNearestTarget(self, caster)
	local target = caster:GetMinDistanceUnit(BLINK_TARGET_SEARCH_RANGE)
	if not IsValidAlive(nil, target) then
		return
	end
	local direction = target:GetAbsOrigin():__sub(caster:GetAbsOrigin()):Normalized()
	caster:SetForwardVector(direction)
end
qop_1 = __TS__DecorateLegacy({ registerAbility(nil) }, qop_1)
____exports.qop_1 = qop_1
modifier_qop_1_prepare = __TS__Class()
modifier_qop_1_prepare.name = "modifier_qop_1_prepare"
__TS__ClassExtends(modifier_qop_1_prepare, BaseModifier_CS)
function modifier_qop_1_prepare.prototype.IsHidden(self)
	return true
end
function modifier_qop_1_prepare.prototype.GetEffectName(self)
	return PARTICLE_PREPARE
end
function modifier_qop_1_prepare.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_wraithking_ghosts.vpcf"
end
modifier_qop_1_prepare = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_qop_1_prepare)
local modifier_qop_1_slow = __TS__Class()
modifier_qop_1_slow.name = "modifier_qop_1_slow"
__TS__ClassExtends(modifier_qop_1_slow, BaseModifier_CS)
function modifier_qop_1_slow.prototype.IsHidden(self)
	return false
end
function modifier_qop_1_slow.prototype.IsDebuff(self)
	return true
end
function modifier_qop_1_slow.prototype.IsPurgable(self)
	return true
end
function modifier_qop_1_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -50 }
end
modifier_qop_1_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_qop_1_slow)
return ____exports