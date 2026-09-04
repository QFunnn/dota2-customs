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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1200
local CAST_POINT = 1.13
local TOTAL_DURATION = 2
local DASH_END_TIME = 1.43
local DASH_DURATION = DASH_END_TIME - CAST_POINT
local CAST_DURATION = TOTAL_DURATION - CAST_POINT
local DASH_DISTANCE = 1200
local WARNING_WIDTH = 180
local HIT_RADIUS = 180
local DAMAGE_RATE = 16
local PLAYER_MAX_HEALTH_DAMAGE_PCT = 40
local KNOCKBACK_DISTANCE = 350
local KNOCKBACK_DURATION = 0.25
local STUN_DURATION = 2
local WARNING_EFFECT =
	"particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_dragon_iron_dragon.vpcf"
local DASH_EFFECT = "particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_iron_dragon.vpcf"
local HIT_EFFECT = "particles/econ/items/dragon_knight/dk_2022_immortal/dk_2022_immortal_dragon_tail_knight.vpcf"
local DASH_SOUND = "Hero_DragonKnight.BreathFire"
local HIT_SOUND = "Hero_DragonKnight.DragonTail.Target"
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
--- 黑暗守卫专属 - 铁龙冲撞：命中后额外清空玩家当前护盾。
____exports.normal_039_dark_guard = __TS__Class()
local normal_039_dark_guard = ____exports.normal_039_dark_guard
normal_039_dark_guard.name = "normal_039_dark_guard"
__TS__ClassExtends(normal_039_dark_guard, MonsterAbility_CS)
function normal_039_dark_guard.prototype.Precache(self, context)
	PrecacheResource("particle", WARNING_EFFECT, context)
	PrecacheResource("particle", DASH_EFFECT, context)
	PrecacheResource("particle", HIT_EFFECT, context)
end
function normal_039_dark_guard.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT - 0.2)
			end
			self:WarningEffect(caster:GetAbsOrigin(), self:GetWarningEnd(caster), CAST_POINT, {
				startWidth = WARNING_WIDTH,
				endWidth = WARNING_WIDTH,
				getDirection = function()
					local ____IsValidAlive_result_0
					if IsValidAlive(nil, caster) then
						____IsValidAlive_result_0 = caster:GetForwardVector()
					else
						____IsValidAlive_result_0 = Vector(1, 0, 0)
					end
					return ____IsValidAlive_result_0
				end,
			})
			self:StartWarningEffect(caster)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:ClearWarningEffect()
			self:StartDash(caster)
		end,
		OnFinish = function()
			return self:ClearAllEffects()
		end,
		OnInterrupt = function()
			return self:ClearAllEffects()
		end,
	}
end
function normal_039_dark_guard.prototype.StartWarningEffect(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	self:ClearWarningEffect()
	local pfx = ParticleManager:CreateParticle(WARNING_EFFECT, PATTACH_CENTER_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_CENTER_FOLLOW,
		"attach_attack2",
		caster:GetAbsOrigin(),
		true
	)
	self.warningPfx = pfx
	self:UpdateWarningForward(caster, 0)
end
function normal_039_dark_guard.prototype.UpdateWarningForward(self, caster, elapsed)
	if self.warningPfx == nil or not IsValidAlive(nil, caster) then
		return
	end
	ParticleManager:SetParticleControlForward(self.warningPfx, 0, caster:GetForwardVector())
	if elapsed >= CAST_POINT then
		return
	end
	return self:Timer(FrameTime(), function()
		return self:UpdateWarningForward(caster, elapsed + FrameTime())
	end)
end
function normal_039_dark_guard.prototype.StartDash(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local forward = caster:GetForwardVector()
	local start = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local ____end = getGroundPosition(nil, start:__add(forward:__mul(DASH_DISTANCE)), caster)
	local hitTargets = __TS__New(Set)
	caster:AddNewModifier(caster, self, "normal_039_dark_guard_pre", { duration = DASH_DURATION })
	self:StartDashEffect(caster)
	EmitSoundOn(DASH_SOUND, caster)
	self:HitDashEnemies(caster, start, forward, hitTargets)
	caster:Mover(____end, DASH_DURATION, function(____, position)
		if not IsValidAlive(nil, caster) then
			return true
		end
		self:HitDashEnemies(caster, position, forward, hitTargets)
	end)
	self:Timer(DASH_DURATION, function()
		return self:ClearDashEffect()
	end)
end
function normal_039_dark_guard.prototype.GetWarningEnd(self, caster)
	if not IsValidAlive(nil, caster) then
		return Vector(0, 0, 0)
	end
	local origin = caster:GetAbsOrigin()
	return origin:__add(caster:GetForwardVector():__mul(DASH_DISTANCE))
end
function normal_039_dark_guard.prototype.StartDashEffect(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	self:ClearDashEffect()
	local pfx = ParticleManager:CreateParticle(DASH_EFFECT, PATTACH_POINT_FOLLOW, caster)
	for ____, cp in ipairs({ 0, 2, 4, 5 }) do
		ParticleManager:SetParticleControlEnt(
			pfx,
			cp,
			caster,
			PATTACH_CENTER_FOLLOW,
			"attach_attack2",
			caster:GetAbsOrigin(),
			true
		)
	end
	self.dashPfx = pfx
end
function normal_039_dark_guard.prototype.HitDashEnemies(self, caster, position, forward, hitTargets)
	if not IsValidAlive(nil, caster) then
		return
	end
	local hitCenter = getGroundPosition(nil, position:__add(forward:__mul(80)), caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		hitCenter,
		nil,
		HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, caster) then
				return
			end
			if not IsValidAlive(nil, enemy) then
				goto __continue32
			end
			local idx = enemy:GetEntityIndex()
			if hitTargets:has(idx) then
				goto __continue32
			end
			hitTargets:add(idx)
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, enemy) then
				goto __continue32
			end
			self:ClearTargetShield(enemy)
			self:ApplyPlayerMaxHealthDamage(caster, enemy)
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, enemy) then
				goto __continue32
			end
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, enemy) then
				goto __continue32
			end
			enemy:KnockBack(caster, self, {
				duration = KNOCKBACK_DURATION,
				distance = KNOCKBACK_DISTANCE,
				height = 80,
				direction = forward,
				particleName = "",
			})
			self:PlayHitEffect(enemy, forward)
			EmitSoundOn(HIT_SOUND, enemy)
		end
		::__continue32::
	end
end
function normal_039_dark_guard.prototype.ClearTargetShield(self, target)
	if not IsValidAlive(nil, target) then
		return
	end
	local ____this_2
	____this_2 = target
	local ____opt_1 = ____this_2.IsRealHero
	if not (____opt_1 and ____opt_1(____this_2)) then
		return
	end
	local ____this_4
	____this_4 = target
	local ____opt_3 = ____this_4.SetCurrentEnergyShield
	if ____opt_3 ~= nil then
		____opt_3(____this_4, 0)
	end
end
function normal_039_dark_guard.prototype.ApplyPlayerMaxHealthDamage(self, caster, target)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	local ____this_6
	____this_6 = target
	local ____opt_5 = ____this_6.IsRealHero
	if not (____opt_5 and ____opt_5(____this_6)) then
		return
	end
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = 0,
		damage_type = 2,
		ability = self,
		expected_damage_health_pct = PLAYER_MAX_HEALTH_DAMAGE_PCT,
	})
end
function normal_039_dark_guard.prototype.PlayHitEffect(self, target, forward)
	if not IsValidAlive(nil, target) then
		return
	end
	local origin = target:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle(HIT_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 2, origin)
	ParticleManager:SetParticleControl(pfx, 3, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 4, origin)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function normal_039_dark_guard.prototype.ClearDashEffect(self)
	if self.dashPfx ~= nil then
		ParticleManager:DestroyParticle(self.dashPfx, false)
		ParticleManager:ReleaseParticleIndex(self.dashPfx)
		self.dashPfx = nil
	end
end
function normal_039_dark_guard.prototype.ClearWarningEffect(self)
	if self.warningPfx ~= nil then
		ParticleManager:DestroyParticle(self.warningPfx, false)
		ParticleManager:ReleaseParticleIndex(self.warningPfx)
		self.warningPfx = nil
	end
end
function normal_039_dark_guard.prototype.ClearAllEffects(self)
	self:ClearWarningEffect()
	self:ClearDashEffect()
end
normal_039_dark_guard = __TS__DecorateLegacy({ registerAbility(nil) }, normal_039_dark_guard)
____exports.normal_039_dark_guard = normal_039_dark_guard
____exports.normal_039_dark_guard_pre = __TS__Class()
local normal_039_dark_guard_pre = ____exports.normal_039_dark_guard_pre
normal_039_dark_guard_pre.name = "normal_039_dark_guard_pre"
__TS__ClassExtends(normal_039_dark_guard_pre, MonsterModifier_CS)
function normal_039_dark_guard_pre.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test2.vpcf"
end
normal_039_dark_guard_pre = __TS__DecorateLegacy({ registerModifier(nil) }, normal_039_dark_guard_pre)
____exports.normal_039_dark_guard_pre = normal_039_dark_guard_pre
return ____exports