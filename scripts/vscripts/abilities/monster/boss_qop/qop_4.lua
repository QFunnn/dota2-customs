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
local __TS__ArrayEvery = ____lualib.__TS__ArrayEvery
local ____exports = {}
local modifier_qop_4_summon_rain, modifier_qop_4_summon_fx
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_phase_transition_ability = require("abilities.monster.boss.boss_phase_transition_ability")
local BossPhaseTransitionAbility_CS = ____boss_phase_transition_ability.BossPhaseTransitionAbility_CS
local WAVE_COUNT = 3
local WAVE_INTERVAL = 1.4
local IMPACT_DELAY = 0.6
local SPAWN_RANGE = 1500
local WARNING_RADIUS = 150
local CIRCLES_PER_WAVE = 3
local SUMMON_UNIT_NAME = "monster_13005"
local PARTICLE_PROJECTILE = "particles/qop/qop_proj1.vpcf"
local PARTICLE_WARNING = "particles/qop/qop_range.vpcf"
local PARTICLE_SUMMON_ATTACH = "particles/qop_arcana_msg_deny.vpcf"
____exports.qop_4 = __TS__Class()
local qop_4 = ____exports.qop_4
qop_4.name = "qop_4"
__TS__ClassExtends(qop_4, BossPhaseTransitionAbility_CS)
function qop_4.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_PROJECTILE, context)
	PrecacheResource("particle", PARTICLE_WARNING, context)
	PrecacheResource("particle", PARTICLE_SUMMON_ATTACH, context)
end
function qop_4.prototype.GetBossPhaseTransitionGesture(self)
	return ACT_DOTA_CAST_ABILITY_1
end
function qop_4.prototype.GetBossPhaseTransitionConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0,
		castDuration = self:GetBossPhaseTransitionReturnToSpawnDuration() + self:GetBossPhaseTransitionWindowDuration(),
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		isNotMove = true,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_Weaver.Swarm.Cast")
			modifier_qop_4_summon_rain:applys(
				caster,
				caster,
				self,
				{ duration = WAVE_COUNT * WAVE_INTERVAL + IMPACT_DELAY }
			)
		end,
	}
end
qop_4 = __TS__DecorateLegacy({ registerAbility(nil) }, qop_4)
____exports.qop_4 = qop_4
modifier_qop_4_summon_rain = __TS__Class()
modifier_qop_4_summon_rain.name = "modifier_qop_4_summon_rain"
__TS__ClassExtends(modifier_qop_4_summon_rain, MonsterModifier_CS)
function modifier_qop_4_summon_rain.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.wave = 0
end
function modifier_qop_4_summon_rain.prototype.IsHidden(self)
	return true
end
function modifier_qop_4_summon_rain.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:spawnWave()
	self:StartIntervalThink(WAVE_INTERVAL)
end
function modifier_qop_4_summon_rain.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if self.wave >= WAVE_COUNT then
		self:StartIntervalThink(-1)
		return
	end
	self:spawnWave()
end
function modifier_qop_4_summon_rain.prototype.spawnWave(self)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	self.wave = self.wave + 1
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	self:Timer(0.3, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local origin = caster:GetAbsOrigin()
		local circles = self:generateNonOverlappingCircles(origin.x, origin.y, SPAWN_RANGE, WARNING_RADIUS)
		for ____, circle in ipairs(circles) do
			do
				local pos = Vector(
					circle.x,
					circle.y,
					GetGroundHeight(Vector(circle.x, circle.y, origin.z), caster) or origin.z
				)
				if not self:isValidBlinkPoint(origin, pos) then
					goto __continue16
				end
				local distance = GetDistance(nil, origin, pos)
				self:playWarning(pos, distance / 1500 + 0.5)
			end
			::__continue16::
		end
	end)
end
function modifier_qop_4_summon_rain.prototype.playProjectile(self, pos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(PARTICLE_PROJECTILE, PATTACH_CUSTOMORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0, 0, 0), true)
	ParticleManager:SetParticleControl(pfx, 1, Vector(1500, 0, 0))
	ParticleManager:SetParticleControl(pfx, 5, pos)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_qop_4_summon_rain.prototype.playWarning(self, pos, delay)
	self:createSummon(pos)
end
function modifier_qop_4_summon_rain.prototype.isValidBlinkPoint(self, origin, point)
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
function modifier_qop_4_summon_rain.prototype.createSummon(self, pos)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	local summonPos = GetGroundPosition(pos, caster)
	local roomId = caster:GetRoomId()
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = SUMMON_UNIT_NAME,
		position = summonPos,
		roomId = roomId,
		team = caster:GetTeamNumber(),
		owner = caster,
		findClearSpace = true,
		onSpawn = function(____, unit)
			if not unit or not IsValid(nil, unit) or unit:IsNull() then
				return
			end
			modifier_qop_4_summon_fx:applys(unit, caster, ability)
			unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
			unit:AddNewModifier(unit, nil, "modifier_monster_born", { duration = 0.6 })
			unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, caster:GetAbsOrigin(), unit:GetAbsOrigin()))
		end,
	})
end
function modifier_qop_4_summon_rain.prototype.circlesOverlap(self, circle1, circle2)
	local dx = circle1.x - circle2.x
	local dy = circle1.y - circle2.y
	local distance = math.sqrt(dx * dx + dy * dy)
	return distance < circle1.radius + circle2.radius
end
function modifier_qop_4_summon_rain.prototype.generateRandomCoordinates(self, centerX, centerY, range)
	local angle = RandomFloat(0, 2 * math.pi)
	local radius = RandomFloat(0, range)
	return {
		centerX + math.cos(angle) * radius,
		centerY + math.sin(angle) * radius,
	}
end
function modifier_qop_4_summon_rain.prototype.generateNonOverlappingCircles(self, centerX, centerY, range, circleRadius)
	local circles = {}
	local attempts = 0
	while #circles < CIRCLES_PER_WAVE and attempts < 120 do
		attempts = attempts + 1
		local x, y = unpack(self:generateRandomCoordinates(centerX, centerY, range))
		local newCircle = { x = x, y = y, radius = circleRadius }
		if
			__TS__ArrayEvery(circles, function(____, circle)
				return not self:circlesOverlap(circle, newCircle)
			end)
		then
			circles[#circles + 1] = newCircle
		end
	end
	return circles
end
modifier_qop_4_summon_rain = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_qop_4_summon_rain)
modifier_qop_4_summon_fx = __TS__Class()
modifier_qop_4_summon_fx.name = "modifier_qop_4_summon_fx"
__TS__ClassExtends(modifier_qop_4_summon_fx, MonsterModifier_CS)
function modifier_qop_4_summon_fx.prototype.IsHidden(self)
	return true
end
function modifier_qop_4_summon_fx.prototype.GetEffectName(self)
	return PARTICLE_SUMMON_ATTACH
end
modifier_qop_4_summon_fx = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_qop_4_summon_fx)
return ____exports