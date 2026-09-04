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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 混沌-激光波 (boss_chaos_2)
local px = "particles/blue/phoenix_sunray_beam.vpcf"
local px1 = "particles/blue/io_calavera_relocate_channel_sparks.vpcf"
local px2 = "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_attack_hit_flash.vpcf"
local LASER_PREP_SOUND = "Hero_Phoenix.SunRay.Cast"
local LASER_LOOP_SOUND = "Hero_Phoenix.SunRay.Loop"
local LASER_BEAM_START_SOUND = "Hero_Phoenix.SunRay.Beam"
local LASER_END_SOUND = "Hero_Phoenix.SunRay.Stop"
____exports.boss_chaos_2 = __TS__Class()
local boss_chaos_2 = ____exports.boss_chaos_2
boss_chaos_2.name = "boss_chaos_2"
__TS__ClassExtends(boss_chaos_2, MonsterAbility_CS)
function boss_chaos_2.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.range = 2500
	self.speed = 1.2
	self.damage = 1.5
end
function boss_chaos_2.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.1,
		castDuration = 11.5 / 1.2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_Tinker.GridEffect")
			caster:EmitSound(LASER_PREP_SOUND)
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0.8 * self.speed)
			____exports.modifier_boss_chaos_2_laser:applys(
				caster,
				caster,
				self,
				{ duration = 8.3 / self.speed, range = self.range, speed = self.speed, damage = self.damage }
			)
		end,
	}
end
boss_chaos_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_chaos_2)
____exports.boss_chaos_2 = boss_chaos_2
____exports.modifier_boss_chaos_2_laser = __TS__Class()
local modifier_boss_chaos_2_laser = ____exports.modifier_boss_chaos_2_laser
modifier_boss_chaos_2_laser.name = "modifier_boss_chaos_2_laser"
__TS__ClassExtends(modifier_boss_chaos_2_laser, BaseModifier_CS)
function modifier_boss_chaos_2_laser.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.range = 2500
	self.speed = 1.2
	self.damage = 1
	self.elapsed = 0
	self.loopStarted = false
	self.beamStarted = false
end
function modifier_boss_chaos_2_laser.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.range = params.range or self.range
	self.speed = params.speed or self.speed
	self.damage = params.damage or self.damage
	self:StartIntervalThink(0.03)
end
function modifier_boss_chaos_2_laser.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	self.elapsed = self.elapsed + 0.03
	if not self.loopStarted and self.elapsed >= 1.7 / self.speed then
		self.loopStarted = true
		caster:EmitSound(LASER_LOOP_SOUND)
		self.pfxHead = ParticleManager:CreateParticle(px1, PATTACH_WORLDORIGIN, nil)
	end
	if not self.beamStarted and self.elapsed >= 3.9 / self.speed then
		self.beamStarted = true
		caster:SetRenderColor(0, 0, 0)
		caster:EmitSound(LASER_BEAM_START_SOUND)
		self.pfxBeam = ParticleManager:CreateParticle(px, PATTACH_WORLDORIGIN, nil)
	end
	if not self.loopStarted then
		return
	end
	local target = caster:GetMinDistanceUnit(self.range)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, 0.03, 0.8)
	end
	local beamStart = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(160)):__add(Vector(0, 0, 170))
	local beamEnd = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(self.range))
	if self.pfxHead then
		ParticleManager:SetParticleControl(self.pfxHead, 3, beamStart)
	end
	if not self.pfxBeam then
		return
	end
	ParticleManager:SetParticleControl(self.pfxBeam, 0, beamStart)
	ParticleManager:SetParticleControl(self.pfxBeam, 3, beamEnd:__add(Vector(0, 0, 100)))
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		beamEnd,
		nil,
		100,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:MonsterDamage({
			victim = enemy,
			damage_rate = 1.5 * self.damage,
			ability = self:GetAbility(),
			effectName = px2,
		})
	end)
end
function modifier_boss_chaos_2_laser.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if self.pfxBeam ~= nil then
		ParticleManager:DestroyParticle(self.pfxBeam, false)
		ParticleManager:ReleaseParticleIndex(self.pfxBeam)
		self.pfxBeam = nil
	end
	if self.pfxHead ~= nil then
		ParticleManager:DestroyParticle(self.pfxHead, false)
		ParticleManager:ReleaseParticleIndex(self.pfxHead)
		self.pfxHead = nil
	end
	if IsValidAlive(nil, caster) then
		caster:StopSound(LASER_LOOP_SOUND)
		caster:EmitSound(LASER_END_SOUND)
		caster:SetRenderColor(255, 255, 255)
	end
end
modifier_boss_chaos_2_laser = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_chaos_2_laser)
____exports.modifier_boss_chaos_2_laser = modifier_boss_chaos_2_laser
return ____exports