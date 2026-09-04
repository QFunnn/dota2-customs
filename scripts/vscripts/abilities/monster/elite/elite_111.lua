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
local modifier_elite_111_sleep
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1200
local CAST_POINT = 0.45
local CAST_DURATION = 0.6
local TRAP_COUNT = 6
local FIRST_TRAP_DISTANCE = 300
local TRAP_DISTANCE_STEP = 220
local TRAP_SIDE_OFFSET = 180
local TRAP_RADIUS = 145
local TRAP_DURATION = 9
local TRAP_ARM_DELAY = 1
local DETECT_INTERVAL = 0.1
local SLEEP_DURATION = 2.5
local SLEEP_DAMAGE_INTERVAL = 0.5
local SLEEP_DAMAGE_RATE = 5
local TRAP_HEAL_MAX_HEALTH_PCT = 12
local TRAP_PARTICLE = "particles/units/heroes/hero_bane/bane_nightmare.vpcf"
local SLEEP_PARTICLE = "particles/units/heroes/hero_bane/bane_nightmare.vpcf"
local CAST_SOUND = "Hero_Bane.Nightmare"
local TRIGGER_SOUND = "Hero_Bane.Nightmare"
local SLEEP_LOOP_SOUND = "Hero_Bane.Nightmare.Loop"
local SLEEP_END_SOUND = "Hero_Bane.Nightmare.End"
--- 精英技能111 - 梦游召唤：在目标前方左右交替布置梦魇陷阱，踩中后睡眠并持续受伤
____exports.elite_111 = __TS__Class()
local elite_111 = ____exports.elite_111
elite_111.name = "elite_111"
__TS__ClassExtends(elite_111, MonsterAbility_CS)
function elite_111.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.targetEnemy = nil
end
function elite_111.prototype.Precache(self, context)
	PrecacheResource("particle", TRAP_PARTICLE, context)
	PrecacheResource("particle", SLEEP_PARTICLE, context)
end
function elite_111.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
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
			self.targetEnemy = ____IsValidAlive_result_1
			if self.targetEnemy then
				caster:LockTargetForSpeed(self.targetEnemy, CAST_POINT)
			end
		end,
		OnInterrupt = function()
			self.targetEnemy = nil
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local target = self.targetEnemy or self:FindNearestEnemy(caster)
			self.targetEnemy = nil
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
				return
			end
			EmitSoundOn(CAST_SOUND, caster)
			self:CreateNightmareTraps(caster, target)
		end,
	}
end
function elite_111.prototype.FindNearestEnemy(self, caster)
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_111.prototype.CreateNightmareTraps(self, caster, target)
	local targetOrigin = GetGroundPosition(target:GetAbsOrigin(), caster)
	local forward = target:GetForwardVector()
	if forward:Length2D() <= 0.01 then
		forward = GetDirection(nil, targetOrigin, caster:GetAbsOrigin())
	end
	forward = Vector(forward.x, forward.y, 0):Normalized()
	local side = Vector(-forward.y, forward.x, 0)
	do
		local i = 0
		while i < TRAP_COUNT do
			local sideSign = i % 2 == 0 and -1 or 1
			local distance = FIRST_TRAP_DISTANCE + TRAP_DISTANCE_STEP * i
			local rawPoint = targetOrigin:__add(forward:__mul(distance)):__add(side:__mul(TRAP_SIDE_OFFSET * sideSign))
			local trapPoint = self:ResolveTrapPoint(rawPoint, targetOrigin, caster)
			CreateModifierThinker(
				caster,
				self,
				"modifier_elite_111_nightmare_trap",
				{ duration = TRAP_DURATION },
				trapPoint,
				caster:GetTeamNumber(),
				false
			)
			i = i + 1
		end
	end
end
function elite_111.prototype.ResolveTrapPoint(self, rawPoint, fallback, caster)
	local point = GetGroundPosition(rawPoint, caster)
	if IsGridNavDisplacementWalkable(nil, point) then
		return point
	end
	return fallback
end
elite_111 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_111)
____exports.elite_111 = elite_111
local modifier_elite_111_nightmare_trap = __TS__Class()
modifier_elite_111_nightmare_trap.name = "modifier_elite_111_nightmare_trap"
__TS__ClassExtends(modifier_elite_111_nightmare_trap, MonsterModifier_CS)
function modifier_elite_111_nightmare_trap.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.origin = Vector(0, 0, 0)
	self.elapsed = 0
	self.armed = false
	self.triggered = false
end
function modifier_elite_111_nightmare_trap.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_PROVIDES_VISION] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
function modifier_elite_111_nightmare_trap.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	self.origin = GetGroundPosition(parent:GetAbsOrigin(), caster)
	parent:SetAbsOrigin(self.origin)
	self:WarningRingEffect(self.origin, TRAP_RADIUS, TRAP_ARM_DELAY)
	self:StartIntervalThink(DETECT_INTERVAL)
end
function modifier_elite_111_nightmare_trap.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	self.elapsed = self.elapsed + DETECT_INTERVAL
	if not self.armed and self.elapsed >= TRAP_ARM_DELAY then
		self.armed = true
		self:CreateTrapParticle()
	end
	if not self.armed or self.triggered then
		return
	end
	if caster:GetAbsOrigin():__sub(self.origin):Length2D() <= TRAP_RADIUS then
		self.triggered = true
		EmitSoundOn(TRIGGER_SOUND, caster)
		local healAmount = caster:GetMaxHealth() * (TRAP_HEAL_MAX_HEALTH_PCT / 100)
		caster:CustomHeal(healAmount, { ability = ability, source = "spell" })
		self:Destroy()
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		self.origin,
		nil,
		TRAP_RADIUS,
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
			self.triggered = true
			EmitSoundOn(TRIGGER_SOUND, enemy)
			modifier_elite_111_sleep:applys(enemy, caster, ability, { duration = SLEEP_DURATION })
			self:Destroy()
			return
		end
		::__continue27::
	end
end
function modifier_elite_111_nightmare_trap.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	if self.particleId ~= nil then
		ParticleManager:DestroyParticle(self.particleId, false)
		ParticleManager:ReleaseParticleIndex(self.particleId)
		self.particleId = nil
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_111_nightmare_trap.prototype.IsHidden(self)
	return true
end
function modifier_elite_111_nightmare_trap.prototype.IsPurgable(self)
	return false
end
function modifier_elite_111_nightmare_trap.prototype.CreateTrapParticle(self)
	if self.particleId ~= nil then
		return
	end
	self.particleId = ParticleManager:CreateParticle(TRAP_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.particleId, 0, self.origin)
end
modifier_elite_111_nightmare_trap = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_111_nightmare_trap") },
	modifier_elite_111_nightmare_trap
)
modifier_elite_111_sleep = __TS__Class()
modifier_elite_111_sleep.name = "modifier_elite_111_sleep"
__TS__ClassExtends(modifier_elite_111_sleep, MonsterModifier_CS)
function modifier_elite_111_sleep.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	EmitSoundOn(SLEEP_LOOP_SOUND, parent)
	local pfx = ParticleManager:CreateParticle(SLEEP_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:AddParticle(pfx, false, false, -1, false, false)
	self:StartIntervalThink(SLEEP_DAMAGE_INTERVAL)
end
function modifier_elite_111_sleep.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) or not ability then
		self:Destroy()
		return
	end
	caster:MonsterDamage({ victim = parent, damage_rate = SLEEP_DAMAGE_RATE, ability = ability })
end
function modifier_elite_111_sleep.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	StopSoundOn(SLEEP_LOOP_SOUND, parent)
	EmitSoundOn(SLEEP_END_SOUND, parent)
	self:StartIntervalThink(-1)
end
function modifier_elite_111_sleep.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
function modifier_elite_111_sleep.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_elite_111_sleep.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_DISABLED
end
function modifier_elite_111_sleep.prototype.IsHidden(self)
	return false
end
function modifier_elite_111_sleep.prototype.IsDebuff(self)
	return true
end
function modifier_elite_111_sleep.prototype.IsPurgable(self)
	return true
end
function modifier_elite_111_sleep.GetLocalizationCN(self)
	return { name = "梦游", description = "陷入梦魇睡眠，无法行动并持续受到伤害。" }
end
modifier_elite_111_sleep =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_111_sleep") }, modifier_elite_111_sleep)
return ____exports