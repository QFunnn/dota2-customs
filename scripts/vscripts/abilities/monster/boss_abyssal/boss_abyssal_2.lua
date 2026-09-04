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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local warningEffectRing = ____monster_base.warningEffectRing
local BOSS_ABYSSAL_2_WARNING_DURATION = 0.7
local BOSS_ABYSSAL_2_FIRE_STORM_RADIUS = 400
local BOSS_ABYSSAL_2_FIRE_STORM_DAMAGE_RATE = 10
local BOSS_ABYSSAL_2_FIRE_STORM_WAVE_COUNT = 5
local BOSS_ABYSSAL_2_FIRE_STORM_WAVE_INTERVAL = 0.5
local BOSS_ABYSSAL_2_SPLIT_COUNT = 4
local BOSS_ABYSSAL_2_SPLIT_DISTANCE = 800
local BOSS_ABYSSAL_2_SPLIT_ANGLE_JITTER = 12
local BOSS_ABYSSAL_2_FIRE_STORM_PARTICLE = "particles/abyssal_underlord_firestorm_wave2.vpcf"
--- 深渊领主-裂变火雨 (boss_abyssal_2)
____exports.boss_abyssal_2 = __TS__Class()
local boss_abyssal_2 = ____exports.boss_abyssal_2
boss_abyssal_2.name = "boss_abyssal_2"
__TS__ClassExtends(boss_abyssal_2, MonsterAbility_CS)
function boss_abyssal_2.prototype.Precache(self, context)
	PrecacheResource("particle", BOSS_ABYSSAL_2_FIRE_STORM_PARTICLE, context)
end
function boss_abyssal_2.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.6,
		castDuration = 1.5,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local center = GetGroundPosition(caster:GetAbsOrigin(), caster)
			warningEffectRing(
				nil,
				caster,
				center,
				BOSS_ABYSSAL_2_FIRE_STORM_RADIUS,
				BOSS_ABYSSAL_2_WARNING_DURATION,
				{ speed = 0 }
			)
			self:Timer(BOSS_ABYSSAL_2_WARNING_DURATION, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
				self:StartFireStorm(caster, center)
				self:CreateSplitWarnings(caster, center)
			end)
		end,
	}
end
function boss_abyssal_2.prototype.CreateSplitWarnings(self, caster, center)
	local baseDirection = caster:GetForwardVector()
	local angleStep = 360 / BOSS_ABYSSAL_2_SPLIT_COUNT
	do
		local index = 0
		while index < BOSS_ABYSSAL_2_SPLIT_COUNT do
			local currentIndex = index
			local currentAngle = currentIndex * angleStep
				+ RandomFloat(-BOSS_ABYSSAL_2_SPLIT_ANGLE_JITTER, BOSS_ABYSSAL_2_SPLIT_ANGLE_JITTER)
			local currentDirection = RotateVector2D(nil, baseDirection, currentAngle):Normalized()
			local currentPosition =
				GetGroundPosition(center:__add(currentDirection:__mul(BOSS_ABYSSAL_2_SPLIT_DISTANCE)), caster)
			warningEffectRing(
				nil,
				caster,
				currentPosition,
				BOSS_ABYSSAL_2_FIRE_STORM_RADIUS,
				BOSS_ABYSSAL_2_WARNING_DURATION,
				{ speed = 0 }
			)
			self:Timer(BOSS_ABYSSAL_2_WARNING_DURATION, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:StartFireStorm(caster, currentPosition)
			end)
			index = index + 1
		end
	end
end
function boss_abyssal_2.prototype.StartFireStorm(self, caster, position)
	____exports.modifier_boss_abyssal_2_fire_storm:applys(
		caster,
		caster,
		self,
		{
			duration = BOSS_ABYSSAL_2_FIRE_STORM_WAVE_INTERVAL * BOSS_ABYSSAL_2_FIRE_STORM_WAVE_COUNT,
			origin_x = position.x,
			origin_y = position.y,
			origin_z = position.z,
		}
	)
end
boss_abyssal_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_abyssal_2)
____exports.boss_abyssal_2 = boss_abyssal_2
____exports.modifier_boss_abyssal_2_fire_storm = __TS__Class()
local modifier_boss_abyssal_2_fire_storm = ____exports.modifier_boss_abyssal_2_fire_storm
modifier_boss_abyssal_2_fire_storm.name = "modifier_boss_abyssal_2_fire_storm"
__TS__ClassExtends(modifier_boss_abyssal_2_fire_storm, BaseModifier_CS)
function modifier_boss_abyssal_2_fire_storm.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.count = 0
end
function modifier_boss_abyssal_2_fire_storm.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_boss_abyssal_2_fire_storm.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local fallbackPosition = caster:GetAbsOrigin()
	self.stormPosition = Vector(
		params and params.origin_x or fallbackPosition.x,
		params and params.origin_y or fallbackPosition.y,
		params and params.origin_z or fallbackPosition.z
	)
	self:OnIntervalThink()
	self:StartIntervalThink(BOSS_ABYSSAL_2_FIRE_STORM_WAVE_INTERVAL)
end
function modifier_boss_abyssal_2_fire_storm.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local stormPosition = self.stormPosition
	if not IsValidAlive(nil, caster) or not ability or not IsValid(nil, ability) or ability:IsNull() then
		self:Destroy()
		return
	end
	if self.count == 0 then
		EmitSoundOnLocationWithCaster(stormPosition, "Hero_AbyssalUnderlord.Firestorm", caster)
	end
	ScreenShake(stormPosition, 10, 10, 0.2, 2500, 0, true)
	local pfx = ParticleManager:CreateParticle(BOSS_ABYSSAL_2_FIRE_STORM_PARTICLE, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, stormPosition)
	ParticleManager:SetParticleControl(pfx, 4, Vector(BOSS_ABYSSAL_2_FIRE_STORM_RADIUS, 1, 1))
	ParticleManager:ReleaseParticleIndex(pfx)
	self:Timer(0.1, function()
		if not IsValidAlive(nil, caster) or not IsValid(nil, ability) or ability:IsNull() then
			return
		end
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			stormPosition,
			nil,
			BOSS_ABYSSAL_2_FIRE_STORM_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		__TS__ArrayForEach(enemies, function(____, enemy)
			if not IsValidAlive(nil, enemy) then
				return
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = BOSS_ABYSSAL_2_FIRE_STORM_DAMAGE_RATE,
				ability = ability,
			})
		end)
	end)
	self.count = self.count + 1
	if self.count >= BOSS_ABYSSAL_2_FIRE_STORM_WAVE_COUNT then
		self:Destroy()
	end
end
modifier_boss_abyssal_2_fire_storm = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_abyssal_2_fire_storm)
____exports.modifier_boss_abyssal_2_fire_storm = modifier_boss_abyssal_2_fire_storm
return ____exports