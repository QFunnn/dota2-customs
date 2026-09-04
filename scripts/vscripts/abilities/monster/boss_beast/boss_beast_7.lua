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
--- 兽-咆哮 (boss_beast_7)
-- 旧版: imba_primal_beast_uproar
____exports.boss_beast_7 = __TS__Class()
local boss_beast_7 = ____exports.boss_beast_7
boss_beast_7.name = "boss_beast_7"
__TS__ClassExtends(boss_beast_7, MonsterAbility_CS)
function boss_beast_7.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.5,
		castDuration = 5,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = false,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_3, 1)
			caster:EmitSound("Hero_PrimalBeast.Uproar.Cast")
			local pxf_name = "particles/world_outpost_dire_ambient_shockwave.vpcf"
			local pfx = ParticleManager:CreateParticle(pxf_name, PATTACH_CUSTOMORIGIN, caster)
			ParticleManager:SetParticleControl(pfx, 1, caster:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(pfx)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			____exports.modifier_boss_beast_7_thinker:applys(caster, caster, self, { duration = 5 })
			caster:AddNewModifier(caster, self, "slow_gongsu_modfier", { duration = 5 })
		end,
	}
end
function boss_beast_7.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
	if target then
		local caster = self:GetCaster()
		if not IsValidAlive(nil, caster) then
			return true
		end
		caster:MonsterDamage({ victim = target, damage_rate = 20, ability = self })
	end
	return true
end
boss_beast_7 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_beast_7)
____exports.boss_beast_7 = boss_beast_7
____exports.modifier_boss_beast_7_thinker = __TS__Class()
local modifier_boss_beast_7_thinker = ____exports.modifier_boss_beast_7_thinker
modifier_boss_beast_7_thinker.name = "modifier_boss_beast_7_thinker"
__TS__ClassExtends(modifier_boss_beast_7_thinker, BaseModifier_CS)
function modifier_boss_beast_7_thinker.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1.2)
	local parent = self:GetParent()
	parent:SetRenderColor(255, 155, 0)
end
function modifier_boss_beast_7_thinker.prototype.OnIntervalThink(self)
	self:IncrementStackCount()
	self:StartPro(self:GetStackCount())
end
function modifier_boss_beast_7_thinker.prototype.GetEffectName(self)
	return "particles/mirana_3_light_red.vpcf"
end
function modifier_boss_beast_7_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:GetParent():SetRenderColor(255, 255, 255)
end
function modifier_boss_beast_7_thinker.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -60 }
end
function modifier_boss_beast_7_thinker.prototype.StartPro(self, n)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_3, 1.2)
	local fow = caster:GetForwardVector()
	local num = 6 + (n - 1) * 4
	local arr = GetRotateVectors(nil, fow, num, 360 / num)
	caster:EmitSound("Hero_PrimalBeast.Uproar.Cast")
	__TS__ArrayForEach(arr, function(____, item)
		local info = {
			vSpawnOrigin = caster:GetAbsOrigin(),
			vVelocity = item:__mul(1200),
			vAcceleration = Vector(0, 0, 0),
			fMaxSpeed = 1200,
			fDistance = 3300,
			fStartRadius = 80,
			fEndRadius = 80,
			fExpireTime = GameRules:GetGameTime() + 5,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			bIgnoreSource = true,
			bHasFrontalCone = true,
			bDrawsOnMinimap = false,
			bVisibleToEnemies = true,
			EffectName = "particles/magnataur_shockwave_red.vpcf",
			Ability = ability,
			Source = caster,
			bProvidesVision = false,
		}
		ProjectileManager:CreateLinearProjectile(info)
	end)
	self:PlayEffects()
end
function modifier_boss_beast_7_thinker.prototype.PlayEffects(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_roar_aoe.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_primal_beast/primal_beast_roar.vpcf"
	local sound_cast = "Hero_PrimalBeast.Onslaught.Channel"
	local radius = 300
	if not IsValidAlive(nil, caster) then
		return
	end
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, caster:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local effect_cast2 = ParticleManager:CreateParticle(particle_cast2, PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast2, 0, caster:GetOrigin())
	ParticleManager:SetParticleControlEnt(
		effect_cast2,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_loadout_roar",
		caster:GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast2)
	EmitSoundOn(sound_cast, caster)
end
modifier_boss_beast_7_thinker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_7_thinker)
____exports.modifier_boss_beast_7_thinker = modifier_boss_beast_7_thinker
return ____exports