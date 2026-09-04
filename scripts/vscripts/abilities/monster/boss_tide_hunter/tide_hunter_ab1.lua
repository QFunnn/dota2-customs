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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- 预警特效
local WARNING_EFFECT = "particles/boss_tidehunter/boss_tidehunter_ab_1_effect_a.vpcf"
--- 触手特效
local TENTACLE_PARTICLE = "particles/boss_tidehunter/tidehunter_spell_ravage.vpcf"
--- 触手击中特效
local TENTACLE_HIT_PARTICLE = "particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage_hit.vpcf"
--- 触手生成范围（码）
local TENTACLE_SPAWN_RANGE = 1400
--- 警示圈持续时间（秒）
local WARNING_DURATION = 1
--- 触手作用半径（码）
local TENTACLE_DAMAGE_RADIUS = 150
--- 技能持续时间（秒）
local SKILL_DURATION = 5.5
--- 每波触手生成间隔（秒）
local SPAWN_INTERVAL = 2
--- 每波生成触手数量
local TENTACLE_COUNT_PER_WAVE = 20
--- 随机点最小间距（码）
local MIN_POINT_DISTANCE = 150
--- 触手柱体粒子保留时长（秒），用于 Destroy + Release
local TENTACLE_PFX_LIFETIME = 2.8
--- 受击粒子保留时长（秒）
local TENTACLE_HIT_PFX_LIFETIME = 1.5
--- 伤害系数
local DAMAGE_RATE = 20
--- 前摇时间（秒）
local CAST_POINT = 1.2
____exports.tide_hunter_ab1 = __TS__Class()
local tide_hunter_ab1 = ____exports.tide_hunter_ab1
tide_hunter_ab1.name = "tide_hunter_ab1"
__TS__ClassExtends(tide_hunter_ab1, MonsterAbility_CS)
function tide_hunter_ab1.prototype.Precache(self, context)
	PrecacheResource("particle", TENTACLE_PARTICLE, context)
	PrecacheResource("particle", TENTACLE_HIT_PARTICLE, context)
end
function tide_hunter_ab1.prototype.GetCooldown(self, level)
	return 8
end
function tide_hunter_ab1.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castPointDamageReduction = 0.5,
		castDuration = SKILL_DURATION + 0.5,
		castAnimation = ACT_DOTA_BRIDGE_THREAT,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:AddNewModifier(caster, self, "modifier_tide_hunter_ab1_tentacles", { duration = SKILL_DURATION })
		end,
	}
end
tide_hunter_ab1 = __TS__DecorateLegacy({ registerAbility(nil) }, tide_hunter_ab1)
____exports.tide_hunter_ab1 = tide_hunter_ab1
____exports.modifier_tide_hunter_ab1_tentacles = __TS__Class()
local modifier_tide_hunter_ab1_tentacles = ____exports.modifier_tide_hunter_ab1_tentacles
modifier_tide_hunter_ab1_tentacles.name = "modifier_tide_hunter_ab1_tentacles"
__TS__ClassExtends(modifier_tide_hunter_ab1_tentacles, MonsterModifier_CS)
function modifier_tide_hunter_ab1_tentacles.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SpawnTentacleWave()
	self:StartIntervalThink(SPAWN_INTERVAL)
end
function modifier_tide_hunter_ab1_tentacles.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:SpawnTentacleWave()
end
function modifier_tide_hunter_ab1_tentacles.prototype.SpawnTentacleWave(self)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		return
	end
	parent:StartGesture(ACT_DOTA_BRIDGE_DESTROY)
	local center = parent:GetAbsOrigin()
	local points =
		GetRandomPointsInCircle(nil, center, TENTACLE_SPAWN_RANGE, TENTACLE_COUNT_PER_WAVE, MIN_POINT_DISTANCE)
	local hitThisWave = __TS__New(Set)
	EmitSoundOnLocationWithCaster(center, "Ability.pre.Torrent", caster)
	for ____, point in ipairs(points) do
		local groundZ = GetGroundHeight(point, parent)
		local ____point_x_1 = point.x
		local ____point_y_2 = point.y
		local ____temp_0
		if groundZ ~= nil then
			____temp_0 = groundZ
		else
			____temp_0 = point.z
		end
		local pos = Vector(____point_x_1, ____point_y_2, ____temp_0)
		local effect = ParticleManager:CreateParticle(WARNING_EFFECT, PATTACH_WORLDORIGIN, caster)
		ParticleManager:SetParticleControl(effect, 0, pos)
		Timers:CreateTimer(WARNING_DURATION, function()
			ParticleManager:DestroyParticle(effect, false)
			ParticleManager:ReleaseParticleIndex(effect)
			if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
				return nil
			end
			local pfx = ParticleManager:CreateParticle(TENTACLE_PARTICLE, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(pfx, 0, pos)
			ParticleManager:SetParticleControl(pfx, 1, Vector(50, 0, 0))
			Timers:CreateTimer(TENTACLE_PFX_LIFETIME, function()
				ParticleManager:DestroyParticle(pfx, false)
				ParticleManager:ReleaseParticleIndex(pfx)
				return nil
			end)
			EmitSoundOnLocationWithCaster(center, "Ability.Ravage", caster)
			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				pos,
				nil,
				TENTACLE_DAMAGE_RADIUS,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			for ____, enemy in ipairs(enemies) do
				do
					if not IsValidAlive(nil, enemy) then
						goto __continue17
					end
					if hitThisWave:has(enemy:entindex()) then
						goto __continue17
					end
					hitThisWave:add(enemy:entindex())
					caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
					enemy:KnockBack(caster, self:GetAbility(), {
						origin_pos = pos,
						duration = 0.3,
						stunDuration = 1.2,
						stun = true,
						distance = 50,
						height = 200,
					})
					local hitPfx =
						ParticleManager:CreateParticle(TENTACLE_HIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, enemy)
					Timers:CreateTimer(TENTACLE_HIT_PFX_LIFETIME, function()
						ParticleManager:DestroyParticle(hitPfx, false)
						ParticleManager:ReleaseParticleIndex(hitPfx)
						return nil
					end)
				end
				::__continue17::
			end
			return nil
		end)
	end
end
function modifier_tide_hunter_ab1_tentacles.prototype.IsHidden(self)
	return false
end
function modifier_tide_hunter_ab1_tentacles.prototype.IsPurgable(self)
	return false
end
function modifier_tide_hunter_ab1_tentacles.prototype.IsDebuff(self)
	return false
end
modifier_tide_hunter_ab1_tentacles = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_tide_hunter_ab1_tentacles") },
	modifier_tide_hunter_ab1_tentacles
)
____exports.modifier_tide_hunter_ab1_tentacles = modifier_tide_hunter_ab1_tentacles
return ____exports