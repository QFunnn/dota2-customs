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
local KNOCKBACK_DISTANCE = 350
local KNOCKBACK_DURATION = 0.25
local STUN_DURATION = 2
local WARNING_EFFECT = "particles/dragon_knight_dragon_tail_dragon_iron_dragon_p.vpcf"
local DASH_EFFECT = "particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_iron_dragon.vpcf"
local HIT_EFFECT = "particles/econ/items/dragon_knight/dk_2022_immortal/dk_2022_immortal_dragon_tail_knight.vpcf"
local DASH_SOUND = "Hero_DragonKnight.BreathFire"
local HIT_SOUND = "Hero_DragonKnight.DragonTail.Target"
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
____exports.boss_pangolier_1 = __TS__Class()
local boss_pangolier_1 = ____exports.boss_pangolier_1
boss_pangolier_1.name = "boss_pangolier_1"
__TS__ClassExtends(boss_pangolier_1, MonsterAbility_CS)
function boss_pangolier_1.prototype.Precache(self, context)
	PrecacheResource("particle", WARNING_EFFECT, context)
	PrecacheResource("particle", DASH_EFFECT, context)
	PrecacheResource("particle", HIT_EFFECT, context)
end
function boss_pangolier_1.prototype.GetMosnterAbilityConfig(self)
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
					return caster:GetForwardVector()
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
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1_END, 1)
		end,
		OnFinish = function()
			return self:ClearAllEffects()
		end,
		OnInterrupt = function()
			return self:ClearAllEffects()
		end,
	}
end
function boss_pangolier_1.prototype.StartWarningEffect(self, caster)
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
function boss_pangolier_1.prototype.UpdateWarningForward(self, caster, elapsed)
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
function boss_pangolier_1.prototype.StartDash(self, caster)
	local forward = caster:GetForwardVector()
	local start = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local ____end = getGroundPosition(nil, start:__add(forward:__mul(DASH_DISTANCE)), caster)
	local hitTargets = __TS__New(Set)
	caster:AddNewModifier(caster, self, "boss_pangolier_1_pre", { duration = DASH_DURATION })
	self:StartDashEffect(caster)
	EmitSoundOn(DASH_SOUND, caster)
	self:HitDashEnemies(caster, start, forward, hitTargets)
	caster:Mover(____end, DASH_DURATION, function(____, position)
		self:HitDashEnemies(caster, position, forward, hitTargets)
	end)
	self:Timer(DASH_DURATION, function()
		return self:ClearDashEffect()
	end)
end
function boss_pangolier_1.prototype.GetWarningEnd(self, caster)
	local origin = caster:GetAbsOrigin()
	return origin:__add(caster:GetForwardVector():__mul(DASH_DISTANCE))
end
function boss_pangolier_1.prototype.StartDashEffect(self, caster)
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
function boss_pangolier_1.prototype.HitDashEnemies(self, caster, position, forward, hitTargets)
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
			if not IsValidAlive(nil, enemy) then
				goto __continue27
			end
			local idx = enemy:GetEntityIndex()
			if hitTargets:has(idx) then
				goto __continue27
			end
			hitTargets:add(idx)
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
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
		::__continue27::
	end
end
function boss_pangolier_1.prototype.PlayHitEffect(self, target, forward)
	local origin = target:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle(HIT_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 2, origin)
	ParticleManager:SetParticleControl(pfx, 3, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 4, origin)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function boss_pangolier_1.prototype.ClearDashEffect(self)
	if self.dashPfx ~= nil then
		ParticleManager:DestroyParticle(self.dashPfx, false)
		ParticleManager:ReleaseParticleIndex(self.dashPfx)
		self.dashPfx = nil
	end
end
function boss_pangolier_1.prototype.ClearWarningEffect(self)
	if self.warningPfx ~= nil then
		ParticleManager:DestroyParticle(self.warningPfx, false)
		ParticleManager:ReleaseParticleIndex(self.warningPfx)
		self.warningPfx = nil
	end
end
function boss_pangolier_1.prototype.ClearAllEffects(self)
	self:ClearWarningEffect()
	self:ClearDashEffect()
end
boss_pangolier_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_pangolier_1)
____exports.boss_pangolier_1 = boss_pangolier_1
____exports.boss_pangolier_1_pre = __TS__Class()
local boss_pangolier_1_pre = ____exports.boss_pangolier_1_pre
boss_pangolier_1_pre.name = "boss_pangolier_1_pre"
__TS__ClassExtends(boss_pangolier_1_pre, MonsterModifier_CS)
function boss_pangolier_1_pre.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test2.vpcf"
end
boss_pangolier_1_pre = __TS__DecorateLegacy({ registerModifier(nil) }, boss_pangolier_1_pre)
____exports.boss_pangolier_1_pre = boss_pangolier_1_pre
return ____exports