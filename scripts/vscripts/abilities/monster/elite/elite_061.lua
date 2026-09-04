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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_elite_063_no_heal
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1500
local CAST_POINT = 0.7
local PROJECTILE_TRAVEL_DURATION = 1
local WARNING_DURATION = 0
local ATTACK_WINDUP_DURATION = 0.3
local IMPACT_RADIUS = 400
local BLAST_COUNT = 3
local BLAST_INTERVAL = 0.7
local TARGET_RANDOM_OFFSET = 200
local DAMAGE_RATE = 28
local ICE_BLAST_PARTICLE =
	"particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_final_ti5.vpcf"
local ICE_BLAST_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts"
local ICE_BLAST_CAST_SOUND = "Hero_Ancient_Apparition.IceBlastRelease.Cast"
local ICE_BLAST_IMPACT_SOUND = "Hero_Ancient_Apparition.IceBlast.Tracker"
local LIFESTEAL_AMP_REDUCTION_PCT = 50
--- 精英技能61 - 寒霜爆破：随机锁定附近敌人位置，延迟造成大范围伤害
____exports.elite_061 = __TS__Class()
local elite_061 = ____exports.elite_061
elite_061.name = "elite_061"
__TS__ClassExtends(elite_061, MonsterAbility_CS)
function elite_061.prototype.Precache(self, context)
	PrecacheResource("particle", ICE_BLAST_PARTICLE, context)
	PrecacheResource("soundfile", ICE_BLAST_SOUND_EVENTS, context)
end
function elite_061.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = WARNING_DURATION
			+ ATTACK_WINDUP_DURATION
			+ PROJECTILE_TRAVEL_DURATION
			+ BLAST_INTERVAL * (BLAST_COUNT - 1),
		castAnimation = ACT_DOTA_CHILLING_TOUCH,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = self:FindRandomEnemy()
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
		end,
		OnStart = function()
			self:StartIceBlastSequence()
		end,
	}
end
function elite_061.prototype.FindRandomEnemy(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local enemies = __TS__ArrayFilter(
		FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, CAST_RANGE, 2, 1 + 18, 0, 0, false),
		function(____, enemy)
			return IsValidAlive(nil, enemy)
		end
	)
	if #enemies <= 0 then
		return nil
	end
	return enemies[RandomInt(0, #enemies - 1) + 1]
end
function elite_061.prototype.GetFallbackTargetPos(self, caster)
	local pos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(CAST_RANGE))
	return GetGroundPosition(pos, caster)
end
function elite_061.prototype.GetBlastTargetPos(self, caster)
	local target = self:FindRandomEnemy()
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, WARNING_DURATION)
		local randomPos = target:GetAbsOrigin():__add(RandomVector(TARGET_RANDOM_OFFSET))
		return GetGroundPosition(randomPos, target)
	end
	return self:GetFallbackTargetPos(caster)
end
function elite_061.prototype.StartIceBlast(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pos = self:GetBlastTargetPos(caster)
	local damagePos = self:ClonePosition(GetGroundPosition(pos, caster))
	self:WarningRingEffect(
		damagePos,
		IMPACT_RADIUS,
		WARNING_DURATION + ATTACK_WINDUP_DURATION + PROJECTILE_TRAVEL_DURATION
	)
	self:Timer(WARNING_DURATION, function()
		return self:StartAttackWindup(damagePos)
	end)
end
function elite_061.prototype.StartAttackWindup(self, damagePos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithFade(ACT_DOTA_ATTACK, 0.05, 0.25)
	self:Timer(ATTACK_WINDUP_DURATION, function()
		return self:LaunchIceBlast(damagePos)
	end)
end
function elite_061.prototype.LaunchIceBlast(self, damagePos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local startPos = self:ClonePosition(GetGroundPosition(caster:GetAbsOrigin(), caster):__add(Vector(0, 0, 96)))
	local endPos = self:ClonePosition(damagePos:__add(Vector(0, 0, 96)))
	EmitSoundOn(ICE_BLAST_CAST_SOUND, caster)
	local pfx = ParticleManager:CreateParticle(ICE_BLAST_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, startPos)
	ParticleManager:SetParticleControl(pfx, 1, GetDirection(nil, endPos, startPos) * GetDistance(nil, startPos, endPos))
	ParticleManager:SetParticleControl(pfx, 5, Vector(1, 1, 1))
	self:Timer(PROJECTILE_TRAVEL_DURATION, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
	self:Timer(PROJECTILE_TRAVEL_DURATION, function()
		return self:DamageAt(damagePos)
	end)
end
function elite_061.prototype.StartIceBlastSequence(self)
	do
		local i = 0
		while i < BLAST_COUNT do
			local delay = BLAST_INTERVAL * i
			self:Timer(delay, function()
				return self:StartIceBlast()
			end)
			i = i + 1
		end
	end
end
function elite_061.prototype.ClonePosition(self, pos)
	return Vector(pos.x, pos.y, pos.z)
end
function elite_061.prototype.DamageAt(self, pos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	ScreenShake(pos, 15, 15, 0.15, 2000, 0, true)
	EmitSoundOnLocationWithCaster(pos, ICE_BLAST_IMPACT_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue31
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			modifier_elite_063_no_heal:applys(enemy, caster, self, { duration = 6 })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.2 })
		end
		::__continue31::
	end
end
elite_061 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_061)
____exports.elite_061 = elite_061
modifier_elite_063_no_heal = __TS__Class()
modifier_elite_063_no_heal.name = "modifier_elite_063_no_heal"
__TS__ClassExtends(modifier_elite_063_no_heal, MonsterModifier_CS)
function modifier_elite_063_no_heal.GetLocalizationCN(self)
	return { name = "寒霜蚀血", description = "吸血效果降低50%。" }
end
function modifier_elite_063_no_heal.prototype.GetAttributeBonus(self)
	return { lifesteal_amp_pct = -LIFESTEAL_AMP_REDUCTION_PCT }
end
function modifier_elite_063_no_heal.prototype.IsDebuff(self)
	return true
end
function modifier_elite_063_no_heal.prototype.IsPurgable(self)
	return true
end
function modifier_elite_063_no_heal.prototype.GetTexture(self)
	return "ancient_apparition_chilling_touch"
end
modifier_elite_063_no_heal =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_063_no_heal") }, modifier_elite_063_no_heal)
return ____exports