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
local modifier_boss_night_007_wound, modifier_boss_night_007_dash_fx
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local SEARCH_RANGE = 1500
local CAST_POINT = 0.45
local CAST_DURATION = 0.75
local DASH_DURATION = 0.28
local DASH_OVERSHOOT_DISTANCE = 140
local BITE_RADIUS = 180
local BITE_DAMAGE_RATE = 22
local WOUND_DURATION = 4
local WOUND_NIGHT_DURATION = 8
local HEAL_REDUCTION_PCT = 45
local BITE_PREPARE_PARTICLE = "particles/nightstalker_crippling_fear_aura_burst.vpcf"
local BITE_HIT_PARTICLE = "particles/units/heroes/hero_night_stalker/nightstalker_void.vpcf"
local WOUND_PARTICLE = "particles/units/heroes/hero_night_stalker/nightstalker_crippling_fear_aura.vpcf"
local DASH_STATUS_PARTICLE = "particles/status_fx/status_effect_charge_of_darkness.vpcf"
--- 噬光撕咬：短突进咬击最近目标，并留下减疗伤口。
____exports.boss_night_007 = __TS__Class()
local boss_night_007 = ____exports.boss_night_007
boss_night_007.name = "boss_night_007"
__TS__ClassExtends(boss_night_007, MonsterAbility_CS)
function boss_night_007.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.lockedTarget = nil
	self.hasBitten = false
end
function boss_night_007.prototype.Precache(self, context)
	PrecacheResource("particle", BITE_PREPARE_PARTICLE, context)
	PrecacheResource("particle", BITE_HIT_PARTICLE, context)
	PrecacheResource("particle", WOUND_PARTICLE, context)
	PrecacheResource("particle", DASH_STATUS_PARTICLE, context)
end
function boss_night_007.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 1.25,
		isNotMove = true,
		castColor = Vector(45, 5, 85),
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, self:FindNearestEnemy(caster)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			return self:PrepareBite()
		end,
		OnInterrupt = function()
			return self:ClearState()
		end,
		OnStart = function()
			return self:StartBite()
		end,
	}
end
function boss_night_007.prototype.PrepareBite(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindNearestEnemy(caster)
	local ____IsValidAlive_result_1
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_1 = target
	else
		____IsValidAlive_result_1 = nil
	end
	self.lockedTarget = ____IsValidAlive_result_1
	self.hasBitten = false
	if not self.lockedTarget then
		return
	end
	caster:LockTargetForSpeed(self.lockedTarget, 0.4, 10)
	self:WarningEffect(caster:GetAbsOrigin(), self.lockedTarget:GetAbsOrigin(), CAST_POINT, {
		startWidth = BITE_RADIUS,
		endWidth = BITE_RADIUS,
		getDirection = function()
			return self:GetCaster():GetForwardVector()
		end,
		follow = true,
	})
	caster:Mover(caster:GetAbsOrigin():__sub(caster:GetForwardVector():__mul(150)), 0.2)
	self:PlayPointParticle(BITE_PREPARE_PARTICLE, caster:GetAbsOrigin(), 0.7)
	EmitSoundOn("Hero_Nightstalker.Void", caster)
end
function boss_night_007.prototype.StartBite(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____IsValidAlive_result_2
	if IsValidAlive(nil, self.lockedTarget) then
		____IsValidAlive_result_2 = self.lockedTarget
	else
		____IsValidAlive_result_2 = self:FindNearestEnemy(caster)
	end
	local target = ____IsValidAlive_result_2
	if not IsValidAlive(nil, target) then
		self:ClearState()
		return
	end
	local direction = caster:GetForwardVector()
	local endPoint = GetGroundPosition(target:GetAbsOrigin():__add(direction:__mul(DASH_OVERSHOOT_DISTANCE)), caster)
	caster:SetForwardVector(direction)
	caster:SetAnimation("cast_void_nihility_anim")
	modifier_boss_night_007_dash_fx:applys(caster, caster, self, { duration = DASH_DURATION + 0.15 })
	EmitSoundOn("Hero_Nightstalker.Trickling_Fear", caster)
	caster:Mover(endPoint, DASH_DURATION, function(____, pos)
		return self:TryBiteAtPoint(caster, pos)
	end)
	self:Timer(DASH_DURATION + 0.03, function()
		if not self.hasBitten and IsValidAlive(nil, target) then
			self:BiteTarget(caster, target)
		end
		self:ClearState()
	end)
end
function boss_night_007.prototype.TryBiteAtPoint(self, caster, point)
	if self.hasBitten then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		BITE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue20
			end
			self:BiteTarget(caster, enemy)
			return
		end
		::__continue20::
	end
end
function boss_night_007.prototype.BiteTarget(self, caster, target)
	if self.hasBitten or not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	self.hasBitten = true
	caster:MonsterDamage({ victim = target, damage_rate = BITE_DAMAGE_RATE, ability = self })
	modifier_boss_night_007_wound:applys(target, caster, self, { duration = self:ResolveWoundDuration(caster) })
	ScreenShake(target:GetAbsOrigin(), 12, 12, 0.18, 900, 0, true)
	EmitSoundOn("Hero_Nightstalker.Void.Nihility", target)
	self:PlayPointParticle(BITE_HIT_PARTICLE, target:GetAbsOrigin(), 0.6)
end
function boss_night_007.prototype.ResolveWoundDuration(self, caster)
	return (caster:HasModifier("modifier_boss_night_005_buff") or caster:HasModifier("modifier_env_monster_darkness"))
			and WOUND_NIGHT_DURATION
		or WOUND_DURATION
end
function boss_night_007.prototype.FindNearestEnemy(self, caster)
	return caster:GetMinDistanceUnit(SEARCH_RANGE)
end
function boss_night_007.prototype.ClearState(self)
	self.lockedTarget = nil
	self.hasBitten = false
end
function boss_night_007.prototype.PlayPointParticle(self, name, point, duration)
	local pfx = ParticleManager:CreateParticle(name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point)
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
boss_night_007 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_night_007)
____exports.boss_night_007 = boss_night_007
modifier_boss_night_007_wound = __TS__Class()
modifier_boss_night_007_wound.name = "modifier_boss_night_007_wound"
__TS__ClassExtends(modifier_boss_night_007_wound, MonsterModifier_CS)
function modifier_boss_night_007_wound.prototype.GetAttributeBonus(self)
	return { regen_amp_pct = -HEAL_REDUCTION_PCT }
end
function modifier_boss_night_007_wound.prototype.GetEffectName(self)
	return WOUND_PARTICLE
end
function modifier_boss_night_007_wound.prototype.IsHidden(self)
	return false
end
function modifier_boss_night_007_wound.prototype.IsDebuff(self)
	return true
end
function modifier_boss_night_007_wound.prototype.IsPurgable(self)
	return true
end
function modifier_boss_night_007_wound.prototype.GetTexture(self)
	return "night_stalker_void"
end
function modifier_boss_night_007_wound.GetLocalizationCN(self)
	return {
		name = "噬光伤口",
		description = ("受到的治疗降低" .. tostring(HEAL_REDUCTION_PCT))
			.. "%%；夜幕中伤口持续更久。",
	}
end
modifier_boss_night_007_wound = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_007_wound)
modifier_boss_night_007_dash_fx = __TS__Class()
modifier_boss_night_007_dash_fx.name = "modifier_boss_night_007_dash_fx"
__TS__ClassExtends(modifier_boss_night_007_dash_fx, MonsterModifier_CS)
function modifier_boss_night_007_dash_fx.prototype.GetStatusEffectName(self)
	return DASH_STATUS_PARTICLE
end
function modifier_boss_night_007_dash_fx.prototype.IsHidden(self)
	return true
end
function modifier_boss_night_007_dash_fx.prototype.IsPurgable(self)
	return false
end
modifier_boss_night_007_dash_fx = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_007_dash_fx)
return ____exports