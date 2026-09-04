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
local BOSS_001_CAST_DURATION = 2
local BOSS_001_FIRE_TIME = 0.4
local BOSS_001_WAVE_COUNT = 3
local BOSS_001_WAVE_INTERVAL = 0.6
--- 每一波（含 OnStart 立即那一波）的发射数量配置：第 0 个下标为 OnStart 那一波，其余按时间顺序依次使用，超出长度则沿用最后一个值
local BOSS_001_PROJECTILES_PER_WAVE = { 1, 1, 3, 6 }
local BOSS_001_CAST_SOUND = "Hero_SkywrathMage.MysticFlare.Target"
local BOSS_001_IMPACT_SOUND = "Hero_SkywrathMage.ArcaneBolt.Impact"
--- Boss技能1 - 待实现
____exports.boss_001 = __TS__Class()
local boss_001 = ____exports.boss_001
boss_001.name = "boss_001"
__TS__ClassExtends(boss_001, MonsterAbility_CS)
function boss_001.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/boss/boss_001.vpcf", context)
end
function boss_001.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.75,
		castDuration = BOSS_001_CAST_DURATION,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local effect_name = "particles/boss/boss_002.vpcf"
			local effect = ParticleManager:CreateParticle(effect_name, PATTACH_POINT, caster)
			ParticleManager:SetParticleControlEnt(
				effect,
				0,
				caster,
				PATTACH_POINT,
				"attach_weapon_tip_fx",
				caster:GetAbsOrigin(),
				true
			)
			local target = caster:GetMinDistanceUnit(2000)
			if target then
				caster:LockTargetForSpeed(target, 0.4 + BOSS_001_CAST_DURATION, 1)
				caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-250)), 0.2)
			end
			ParticleManager:ReleaseParticleIndex(effect)
		end,
		OnStart = function()
			self:FireProjectileWave(0)
			____exports.modifier_boss_001_buff:applys(
				self._caster,
				self._caster,
				self,
				{ duration = BOSS_001_CAST_DURATION }
			)
		end,
	}
end
function boss_001.prototype.FireProjectileWave(self, waveIndex)
	if waveIndex == nil then
		waveIndex = 0
	end
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local start_point = caster:GetAbsOrigin() + caster:GetForwardVector() * 150 + Vector(0, 0, 150)
	local base_dir = caster:GetForwardVector()
	local spread_deg = 15
	local distance = 2000
	ScreenShake(caster:GetAbsOrigin(), 5, 5, 0.5, 3000, 0, true)
	local recoilDir = Vector(-base_dir.x, -base_dir.y, 0)
	caster:Mover(caster:GetAbsOrigin():__add(recoilDir:__mul(100)), 0.2, nil, true)
	local idx = math.max(0, math.floor(waveIndex))
	local ____temp_0
	if #BOSS_001_PROJECTILES_PER_WAVE > 0 then
		____temp_0 = BOSS_001_PROJECTILES_PER_WAVE[math.min(idx, #BOSS_001_PROJECTILES_PER_WAVE - 1) + 1]
	else
		____temp_0 = 3
	end
	local countCfg = ____temp_0
	local count = math.max(1, countCfg)
	local startAngle = count == 1 and 0 or -spread_deg * (count - 1) / 2
	EmitSoundOn(BOSS_001_CAST_SOUND, caster)
	do
		local i = 0
		while i < count do
			local angle = startAngle + i * spread_deg
			local dir = RotateVector2D(nil, base_dir, angle)
			local end_point = start_point + dir * distance
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				effect_name = "particles/boss/boss_001.vpcf",
				target = end_point,
				start_point = start_point,
				projectile_type = "linear",
				projectile_speed = 1500,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				projectile_distance = distance,
				projectile_range = 60,
				on_hit = function(____, hitTarget)
					if not hitTarget or not IsValidAlive(nil, hitTarget) then
						return true
					end
					if not IsValidAlive(nil, caster) then
						return true
					end
					EmitSoundOn(BOSS_001_IMPACT_SOUND, hitTarget)
					caster:MonsterDamage({ victim = hitTarget, damage_rate = 15, ability = self })
					local pfx = ParticleManager:CreateParticle(
						"particles/boss/boss_001_endcap.vpcf",
						PATTACH_POINT_FOLLOW,
						hitTarget
					)
					ParticleManager:SetParticleControlEnt(
						pfx,
						3,
						hitTarget,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						Vector(0, 0, 0),
						true
					)
					ParticleManager:ReleaseParticleIndex(pfx)
					hitTarget:KnockBack(caster, self, { duration = 0.1, distance = 50, height = 0, stun = true })
					return false
				end,
			})
			i = i + 1
		end
	end
end
boss_001 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_001)
____exports.boss_001 = boss_001
____exports.modifier_boss_001_buff = __TS__Class()
local modifier_boss_001_buff = ____exports.modifier_boss_001_buff
modifier_boss_001_buff.name = "modifier_boss_001_buff"
__TS__ClassExtends(modifier_boss_001_buff, MonsterModifier_CS)
function modifier_boss_001_buff.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local ____temp_1
	if self:GetDuration() > 0 then
		____temp_1 = self:GetDuration()
	else
		____temp_1 = BOSS_001_CAST_DURATION
	end
	local totalDuration = ____temp_1
	local firstFireTime = BOSS_001_FIRE_TIME
	local waveCount = BOSS_001_WAVE_COUNT
	local ability = self:GetAbility()
	if not ability then
		return
	end
	do
		local i = 0
		while i < waveCount do
			local gestureTime = i * BOSS_001_WAVE_INTERVAL
			local fireTime = gestureTime + firstFireTime
			if gestureTime >= 0 and gestureTime <= totalDuration + 0.01 then
				self:Timer(gestureTime, function()
					local parent = self:GetParent()
					if not IsValidAlive(nil, parent) then
						return
					end
					parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
					return
				end)
			end
			if fireTime >= 0 and fireTime <= totalDuration + 0.01 then
				local waveIndex = i + 1
				self:Timer(fireTime, function()
					local caster = self:GetCaster()
					if not IsValidAlive(nil, caster) then
						return
					end
					local abilityRef = self:GetAbility()
					if not abilityRef then
						return
					end
					abilityRef:FireProjectileWave(waveIndex)
					return
				end)
			end
			i = i + 1
		end
	end
end
function modifier_boss_001_buff.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
modifier_boss_001_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_001_buff)
____exports.modifier_boss_001_buff = modifier_boss_001_buff
return ____exports