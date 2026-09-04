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
local modifier_normal_044_berserk
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local NORMAL_044_IMPACT_TIME = 1.2
local NORMAL_044_CAST_DURATION = 0.5
local NORMAL_044_WAVE_LENGTH = 600
local NORMAL_044_WAVE_HALF_ANGLE_DEG = 50
local NORMAL_044_WAVE_DAMAGE_RATE = 15
local NORMAL_044_WAVE_STUN_DURATION = 1.4
local NORMAL_044_WAVE_PARTICLE = "particles/unit/elite_032_1.vpcf"
local NORMAL_044_WAVE_CAST_SOUND = "Hero_Mars.Shield.Cast"
local NORMAL_044_WAVE_FLY_SOUND = "Hero_Mars.Shield.Cast"
local BERSERK_DURATION = 5
local BERSERK_MOVESPEED_PCT = 50
local BERSERK_ATTACK_SPEED_PCT = 50
local BERSERK_PARTICLE = "particles/econ/items/lycan/ti9_immortal/lycan_ti9_immortal_howl_buff_fire.vpcf"
local BERSERK_SOUND = "Hero_LifeStealer.Rage"
--- 普通怪物技能44：向前打出扇形波，随后短时间提升移速与攻速
____exports.normal_044 = __TS__Class()
local normal_044 = ____exports.normal_044
normal_044.name = "normal_044"
__TS__ClassExtends(normal_044, MonsterAbility_CS)
function normal_044.prototype.Precache(self, context)
	PrecacheResource("particle", NORMAL_044_WAVE_PARTICLE, context)
	PrecacheResource("particle", BERSERK_PARTICLE, context)
end
function normal_044.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 500,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = NORMAL_044_IMPACT_TIME,
		castDuration = NORMAL_044_CAST_DURATION,
		animationPlaybackRate = 0.9,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local endPos = origin:__add(caster:GetForwardVector():__mul(450))
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, 1, 2)
			self:WarningEffect(origin, endPos, NORMAL_044_IMPACT_TIME, {
				startWidth = 80,
				endWidth = 320,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			return self:OnStart()
		end,
	}
end
function normal_044.prototype.OnStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	EmitSoundOn(NORMAL_044_WAVE_CAST_SOUND, caster)
	EmitSoundOn(NORMAL_044_WAVE_FLY_SOUND, caster)
	self:PlayWaveEffect(origin + forward * 50, forward)
	self:DamageAndStunWave(caster, origin, forward)
	ScreenShake(origin, 20, 20, 0.3, 2500, 0, true)
	modifier_normal_044_berserk:applys(caster, caster, self, { duration = BERSERK_DURATION })
	EmitSoundOn(BERSERK_SOUND, caster)
end
function normal_044.prototype.PlayWaveEffect(self, origin, forward)
	local pfx = ParticleManager:CreateParticle(NORMAL_044_WAVE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(pfx, 0, origin, forward)
	ParticleManager:SetParticleControl(pfx, 11, Vector(NORMAL_044_WAVE_LENGTH, 0, 0))
	Timers:CreateTimer(2, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function normal_044.prototype.DamageAndStunWave(self, caster, origin, forward)
	local minDot = math.cos(math.rad(NORMAL_044_WAVE_HALF_ANGLE_DEG))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		NORMAL_044_WAVE_LENGTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue13
			end
			local delta = enemy:GetAbsOrigin():__sub(origin)
			local distance = delta:Length2D()
			if distance <= 0.01 or distance > NORMAL_044_WAVE_LENGTH then
				goto __continue13
			end
			local direction = Vector(delta.x / distance, delta.y / distance, 0)
			local dot = forward.x * direction.x + forward.y * direction.y
			if dot < minDot then
				goto __continue13
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = NORMAL_044_WAVE_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.STUN,
				{ duration = NORMAL_044_WAVE_STUN_DURATION }
			)
		end
		::__continue13::
	end
end
normal_044 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_044)
____exports.normal_044 = normal_044
modifier_normal_044_berserk = __TS__Class()
modifier_normal_044_berserk.name = "modifier_normal_044_berserk"
__TS__ClassExtends(modifier_normal_044_berserk, MonsterModifier_CS)
function modifier_normal_044_berserk.GetLocalizationCN(self)
	return { name = "狂暴", description = "移动速度提升50%，攻击速度提升50。" }
end
function modifier_normal_044_berserk.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = BERSERK_MOVESPEED_PCT, attack_speed_pct = BERSERK_ATTACK_SPEED_PCT }
end
function modifier_normal_044_berserk.prototype.IsHidden(self)
	return false
end
function modifier_normal_044_berserk.prototype.IsPurgable(self)
	return false
end
function modifier_normal_044_berserk.prototype.GetTexture(self)
	return "night_stalker_void"
end
function modifier_normal_044_berserk.prototype.GetEffectName(self)
	return BERSERK_PARTICLE
end
function modifier_normal_044_berserk.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_normal_044_berserk =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_044_berserk") }, modifier_normal_044_berserk)
return ____exports