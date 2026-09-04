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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local CAST_RANGE = 1400
local CAST_POINT = 0.5
local TOTAL_DURATION = 2.3
local FIRE_TIME = 1.4
local FIRE_DELAY_AFTER_START = FIRE_TIME - CAST_POINT
local CAST_DURATION = TOTAL_DURATION - CAST_POINT
local PROJECTILE_DISTANCE = 1600
local PROJECTILE_RADIUS = 100
local PROJECTILE_SPEED = 3000
local PROJECTILE_SPAWN_FORWARD = 80
local PROJECTILE_SPAWN_HEIGHT = 110
local DAMAGE_RATE = 14
local STUN_DURATION = 1.5
local CURRENT_HEALTH_DAMAGE_PCT = 30
local CURRENT_SHIELD_DAMAGE_PCT = 30
local CHANNEL_EFFECT =
	"particles/econ/items/windrunner/windranger_arcana/windranger_arcana_powershot_channel_combo.vpcf"
local PROJECTILE_EFFECT = "particles/econ/items/windrunner/windranger_arcana/windranger_arcana_spell_powershot.vpcf"
local CHANNEL_SOUND = "Ability.PowershotPull.Mh_bow.layer"
local FIRE_SOUND = "Ability.Powershot.Alt"
local DAMAGE_SOUND = "Hero_Windrunner.PowershotDamage"
--- 普通技能38 - 堕落强弓：持续瞄准最近敌人，蓄力后发射穿透箭矢
____exports.normal_038 = __TS__Class()
local normal_038 = ____exports.normal_038
normal_038.name = "normal_038"
__TS__ClassExtends(normal_038, MonsterAbility_CS)
function normal_038.prototype.Precache(self, context)
	PrecacheResource("particle", CHANNEL_EFFECT, context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
end
function normal_038.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 7,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:LockAndWarn(caster)
			self:StartChannelEffect(caster)
			EmitSoundOn(CHANNEL_SOUND, caster)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:Timer(FIRE_DELAY_AFTER_START, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:FireArrow(caster)
			end)
		end,
		OnFinish = function()
			return self:ClearChannelEffect()
		end,
		OnInterrupt = function()
			return self:ClearChannelEffect()
		end,
	}
end
function normal_038.prototype.LockAndWarn(self, caster)
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		self.lockedTargetIndex = target:entindex()
		caster:LockTargetForSpeed(target, FIRE_TIME - 0.1)
	end
	local start = self:GetProjectileStart(caster)
	local ____end = start:__add(caster:GetForwardVector():__mul(PROJECTILE_DISTANCE))
	self:WarningEffect(start, ____end, FIRE_TIME + 0.15, {
		startWidth = PROJECTILE_RADIUS + 20,
		endWidth = PROJECTILE_RADIUS + 20,
		getDirection = function()
			return caster:GetForwardVector()
		end,
		type = 1,
		follow = true,
	})
end
function normal_038.prototype.StartChannelEffect(self, caster)
	self:ClearChannelParticle()
	local pfx = ParticleManager:CreateParticle(CHANNEL_EFFECT, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin() + caster:GetForwardVector() * 100,
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		caster,
		PATTACH_CENTER_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin() + caster:GetForwardVector() * 100,
		false
	)
	self.channelPfx = pfx
	self:UpdateChannelForward(caster, 0)
end
function normal_038.prototype.UpdateChannelForward(self, caster, elapsed)
	if self.channelPfx == nil or not IsValidAlive(nil, caster) then
		return
	end
	local forward = caster:GetForwardVector()
	ParticleManager:SetParticleControlForward(self.channelPfx, 0, forward)
	ParticleManager:SetParticleControlForward(self.channelPfx, 1, forward)
	if elapsed >= FIRE_TIME then
		return
	end
	return self:Timer(FrameTime(), function()
		return self:UpdateChannelForward(caster, elapsed + FrameTime())
	end)
end
function normal_038.prototype.FireArrow(self, caster)
	self:ClearChannelParticle()
	EmitSoundOn(FIRE_SOUND, caster)
	local start = self:GetProjectileStart(caster)
	local target = start:__add(caster:GetForwardVector():__mul(PROJECTILE_DISTANCE))
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PROJECTILE_EFFECT,
		target = target,
		start_point = start,
		projectile_type = "linear",
		projectile_speed = PROJECTILE_SPEED,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = PROJECTILE_RADIUS,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				local bonusDamage = self:GetCurrentHealthAndShieldDamage(hitTarget)
				if not IsValidAlive(nil, caster) then
					return
				end
				EmitSoundOn(DAMAGE_SOUND, hitTarget)
				caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
				self:ApplyBonusDamage(caster, hitTarget, bonusDamage)
				hitTarget:KnockBack(caster, self, {
					origin_pos = caster:GetAbsOrigin(),
					duration = 0.1,
					stunDuration = STUN_DURATION,
					stun = true,
					distance = 100,
				})
				AddDeBuffStatus(nil, hitTarget, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
				return false
			end
			return true
		end,
	})
	self.lockedTargetIndex = nil
end
function normal_038.prototype.GetCurrentHealthAndShieldDamage(self, target)
	if not IsValidAlive(nil, target) then
		return 0
	end
	local currentHealth = math.max(0, target:GetHealth())
	local ____math_max_2 = math.max
	local ____this_1
	____this_1 = target
	local ____opt_0 = ____this_1.GetCurrentEnergyShield
	local currentShield = ____math_max_2(0, ____opt_0 and ____opt_0(____this_1) or 0)
	return math.floor((currentHealth * CURRENT_HEALTH_DAMAGE_PCT + currentShield * CURRENT_SHIELD_DAMAGE_PCT) / 100)
end
function normal_038.prototype.ApplyBonusDamage(self, caster, target, damage)
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = damage,
		damage_type = 2,
		ability = self,
	})
end
function normal_038.prototype.GetProjectileStart(self, caster)
	return caster
		:GetAbsOrigin()
		:__add(caster:GetForwardVector():__mul(PROJECTILE_SPAWN_FORWARD))
		:__add(Vector(0, 0, PROJECTILE_SPAWN_HEIGHT))
end
function normal_038.prototype.ClearChannelEffect(self)
	self:ClearChannelParticle()
	self.lockedTargetIndex = nil
end
function normal_038.prototype.ClearChannelParticle(self)
	if self.channelPfx ~= nil then
		ParticleManager:DestroyParticle(self.channelPfx, false)
		ParticleManager:ReleaseParticleIndex(self.channelPfx)
		self.channelPfx = nil
	end
end
normal_038 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_038)
____exports.normal_038 = normal_038
return ____exports