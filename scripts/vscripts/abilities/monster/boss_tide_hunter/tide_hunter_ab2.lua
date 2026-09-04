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
--- 切割波浪特效
local WAVE_PARTICLE = "particles/boss_tidehunter/tidehunter_ab2/tidehunter_ab2_gush_upgrade.vpcf"
--- 前摇时间（秒）
local CAST_POINT = 1
--- 每轮预警持续时间（秒）
local DELAY_TIME = 0.8
--- 最后一波预警持续时间（秒）——8方向全覆盖，给玩家更多反应时间
local LAST_WAVE_DELAY_TIME = 1
--- 波浪碰撞 & 预警宽度（码）
local WIDTH = 180
--- 伤害系数
local DAMAGE_RATE = 20
--- 波浪投射物飞行距离（码）
local WAVE_DISTANCE = 1500
--- 波浪投射物速度
local WAVE_SPEED = 1200
--- 轮次之间的间隔（秒）
local WAVE_INTERVAL = 1.5
--- 总轮次
local TOTAL_WAVES = 3
--- Debuff 持续时间（秒）
local DEBUFF_DURATION = 4
--- 减速百分比
local SLOW_PCT = 40
--- 护甲降低量
local ARMOR_REDUCTION = -8
--- 技能总持续时间：最后一波用 LAST_WAVE_DELAY_TIME
local SKILL_DURATION = (TOTAL_WAVES - 1) * WAVE_INTERVAL + LAST_WAVE_DELAY_TIME + 0.5
____exports.tide_hunter_ab2 = __TS__Class()
local tide_hunter_ab2 = ____exports.tide_hunter_ab2
tide_hunter_ab2.name = "tide_hunter_ab2"
__TS__ClassExtends(tide_hunter_ab2, MonsterAbility_CS)
function tide_hunter_ab2.prototype.Precache(self, context)
	PrecacheResource("particle", WAVE_PARTICLE, context)
end
function tide_hunter_ab2.prototype.GetCooldown(self, level)
	return 8
end
function tide_hunter_ab2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = SKILL_DURATION,
		castAnimation = ACT_DOTA_BRIDGE_THREAT,
		castPointDamageReduction = 0.4,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:AddNewModifier(caster, self, "modifier_tide_hunter_ab2_gush", { duration = SKILL_DURATION })
		end,
	}
end
tide_hunter_ab2 = __TS__DecorateLegacy({ registerAbility(nil) }, tide_hunter_ab2)
____exports.tide_hunter_ab2 = tide_hunter_ab2
____exports.modifier_tide_hunter_ab2_gush = __TS__Class()
local modifier_tide_hunter_ab2_gush = ____exports.modifier_tide_hunter_ab2_gush
modifier_tide_hunter_ab2_gush.name = "modifier_tide_hunter_ab2_gush"
__TS__ClassExtends(modifier_tide_hunter_ab2_gush, MonsterModifier_CS)
function modifier_tide_hunter_ab2_gush.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.waveIndex = 0
end
function modifier_tide_hunter_ab2_gush.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		return
	end
	self.lockedOrigin = parent:GetAbsOrigin()
	self.lockedForward = parent:GetForwardVector()
	self.waveIndex = 0
	self:ShowWarningAndFireWave()
	self:StartIntervalThink(WAVE_INTERVAL)
end
function modifier_tide_hunter_ab2_gush.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self.waveIndex = self.waveIndex + 1
	if self.waveIndex >= TOTAL_WAVES then
		self:StartIntervalThink(-1)
		return
	end
	self:ShowWarningAndFireWave()
end
function modifier_tide_hunter_ab2_gush.prototype.GetWaveDirs(self)
	local f = self.lockedForward
	repeat
		local ____switch14 = self.waveIndex
		local ____cond14 = ____switch14 == 0
		if ____cond14 then
			return GetRotateVectors(nil, f, 4, 90)
		end
		____cond14 = ____cond14 or ____switch14 == 1
		if ____cond14 then
			return GetRotateVectors(nil, RotateVector2D(nil, f, 45), 4, 90)
		end
		____cond14 = ____cond14 or ____switch14 == 2
		do
			return GetRotateVectors(nil, f, 8, 45)
		end
	until true
end
function modifier_tide_hunter_ab2_gush.prototype.ShowWarningAndFireWave(self)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		return
	end
	local dirs = self:GetWaveDirs()
	local origin = self.lockedOrigin
	local isLastWave = self.waveIndex == TOTAL_WAVES - 1
	local delay = isLastWave and LAST_WAVE_DELAY_TIME or DELAY_TIME
	local playbackRate = isLastWave and 0.3 or 0.49
	parent:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0.1, 0.4, playbackRate)
	for ____, dir in ipairs(dirs) do
		local startPos = origin:__add(dir:__mul(100))
		local endPos = origin:__add(dir:__mul(WAVE_DISTANCE))
		ability:WarningEffect(startPos, endPos, delay, { startWidth = WIDTH, endWidth = WIDTH })
	end
	self:Timer(delay, function()
		if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
			return
		end
		EmitSoundOnLocationWithCaster(origin, "Ability.GushCast", caster)
		for ____, dir in ipairs(dirs) do
			local targetPos = origin:__add(dir:__mul(WAVE_DISTANCE))
			local startPoint = origin:__add(dir:__mul(50)):__add(Vector(0, 0, 80))
			CreateProjectile(nil, {
				ability = ability,
				caster = caster,
				effect_name = WAVE_PARTICLE,
				target = targetPos,
				start_point = startPoint,
				projectile_type = "linear",
				projectile_speed = WAVE_SPEED,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				projectile_distance = WAVE_DISTANCE,
				projectile_range = WIDTH,
				on_hit = function(____, hitTarget)
					if hitTarget and IsValidAlive(nil, hitTarget) then
						if not IsValidAlive(nil, caster) then
							return true
						end
						caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = ability })
						____exports.modifier_tide_hunter_ab2_debuff:applys(
							hitTarget,
							caster,
							ability,
							{ duration = DEBUFF_DURATION }
						)
						return false
					end
					return true
				end,
			})
		end
	end)
end
function modifier_tide_hunter_ab2_gush.prototype.IsHidden(self)
	return true
end
function modifier_tide_hunter_ab2_gush.prototype.IsPurgable(self)
	return false
end
function modifier_tide_hunter_ab2_gush.prototype.IsDebuff(self)
	return false
end
modifier_tide_hunter_ab2_gush =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_tide_hunter_ab2_gush") }, modifier_tide_hunter_ab2_gush)
____exports.modifier_tide_hunter_ab2_gush = modifier_tide_hunter_ab2_gush
____exports.modifier_tide_hunter_ab2_debuff = __TS__Class()
local modifier_tide_hunter_ab2_debuff = ____exports.modifier_tide_hunter_ab2_debuff
modifier_tide_hunter_ab2_debuff.name = "modifier_tide_hunter_ab2_debuff"
__TS__ClassExtends(modifier_tide_hunter_ab2_debuff, MonsterModifier_CS)
function modifier_tide_hunter_ab2_debuff.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_tidehunter/tidehunter_gush_slow.vpcf"
end
function modifier_tide_hunter_ab2_debuff.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -SLOW_PCT, bonus_armor = ARMOR_REDUCTION }
end
function modifier_tide_hunter_ab2_debuff.prototype.IsHidden(self)
	return false
end
function modifier_tide_hunter_ab2_debuff.prototype.IsPurgable(self)
	return true
end
function modifier_tide_hunter_ab2_debuff.prototype.IsDebuff(self)
	return true
end
modifier_tide_hunter_ab2_debuff =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_tide_hunter_ab2_debuff") }, modifier_tide_hunter_ab2_debuff)
____exports.modifier_tide_hunter_ab2_debuff = modifier_tide_hunter_ab2_debuff
return ____exports