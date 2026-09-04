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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local PREPARE_DURATION = 1.2
local CHARGE_DURATION = 0.75
local CHARGE_STEP_DISTANCE = 35
local CHARGE_WARNING_DISTANCE = 900
local CHARGE_HIT_RADIUS = 220
local CHARGE_DAMAGE_RATE = 15
local KNOCKBACK_DISTANCE = 140
local KNOCKBACK_DURATION = 0.2
local REAIM_RANGE = 2500
--- 残角冲锋兽的教学版突：保留首领预警线，只冲锋一次。
____exports.elite_162 = __TS__Class()
local elite_162 = ____exports.elite_162
elite_162.name = "elite_162"
__TS__ClassExtends(elite_162, MonsterAbility_CS)
function elite_162.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = PREPARE_DURATION,
		castDuration = CHARGE_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:AddNewModifier(caster, self, "modifier_elite_162_pre", { duration = PREPARE_DURATION })
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:AddNewModifier(caster, self, "modifier_elite_162_move", { duration = CHARGE_DURATION })
		end,
	}
end
elite_162 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_162)
____exports.elite_162 = elite_162
--- 蓄力阶段：持续瞄准最近目标并显示与首领一致的直线预警。
local modifier_elite_162_pre = __TS__Class()
modifier_elite_162_pre.name = "modifier_elite_162_pre"
__TS__ClassExtends(modifier_elite_162_pre, BaseModifier_CS)
function modifier_elite_162_pre.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability then
		self:Destroy()
		return
	end
	self:Timer(FrameTime(), function()
		if not self:IsNull() and IsValidAlive(nil, caster) then
			caster:SetAnimation("dragonspawn_a_flail")
		end
	end)
	self.warningTarget = CreateModifierThinker(
		caster,
		ability,
		"modifier_dummy_thinker",
		{ duration = PREPARE_DURATION + 0.2 },
		caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(100)),
		caster:GetTeamNumber(),
		false
	)
	if not IsValidAlive(nil, self.warningTarget) then
		self:Destroy()
		return
	end
	EmitSoundOn("Hero_PrimalBeast.Onslaught.Channel", caster)
	self.warningParticle = ParticleManager:CreateParticleForTeam(
		"particles/primal_beast_onslaught_range_finder_max.vpcf",
		PATTACH_CENTER_FOLLOW,
		caster,
		DOTA_TEAM_GOODGUYS
	)
	ParticleManager:SetParticleControl(self.warningParticle, 4, Vector(255, 0, 0))
	ParticleManager:SetParticleControl(self.warningParticle, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.warningParticle, 1, self.warningTarget:GetAbsOrigin())
	self:StartIntervalThink(0.03)
end
function modifier_elite_162_pre.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	if not IsValidAlive(nil, self.warningTarget) then
		self:Destroy()
		return
	end
	local target = caster:GetMinDistanceUnit(REAIM_RANGE)
	if target then
		caster:LockTargetForSpeed(target, 0.03, 3)
	end
	self:SetStackCount(self:GetStackCount() + 1)
	local distance = math.min(CHARGE_WARNING_DISTANCE, 100 + self:GetStackCount() * 25)
	self.warningTarget:SetOrigin(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(distance)))
	if self.warningParticle then
		ParticleManager:SetParticleControl(self.warningParticle, 1, self.warningTarget:GetAbsOrigin())
	end
end
function modifier_elite_162_pre.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		caster:SetAnimation("dragonspawn_a_idle")
	end
	if self.warningParticle then
		ParticleManager:DestroyParticle(self.warningParticle, true)
		ParticleManager:ReleaseParticleIndex(self.warningParticle)
	end
	if self.warningTarget and IsValid(nil, self.warningTarget) and not self.warningTarget:IsNull() then
		self.warningTarget:RemoveSelf()
	end
end
function modifier_elite_162_pre.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING, MODIFIER_PROPERTY_IGNORE_CAST_ANGLE }
end
function modifier_elite_162_pre.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_elite_162_pre.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_elite_162_pre.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
modifier_elite_162_pre = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_162_pre)
--- 冲锋阶段：命中首个敌人或遇到阻挡后立刻结束。
local modifier_elite_162_move = __TS__Class()
modifier_elite_162_move.name = "modifier_elite_162_move"
__TS__ClassExtends(modifier_elite_162_move, BaseModifier_CS)
function modifier_elite_162_move.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.hasHit = false
end
function modifier_elite_162_move.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:EmitSound("Hero_PrimalBeast.Onslaught.Cast")
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	self:AddParticle(particle, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_162_move.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local nextPosition = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(CHARGE_STEP_DISTANCE))
	if GridNav:IsBlocked(nextPosition) or not GridNav:IsTraversable(nextPosition) then
		self:Destroy()
		return
	end
	caster:SetOrigin(nextPosition)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		CHARGE_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local hitTarget = enemies[1]
	if not hitTarget or not IsValidAlive(nil, hitTarget) or self.hasHit then
		return
	end
	self.hasHit = true
	EmitSoundOn("Hero_Spirit_Breaker.GreaterBash", hitTarget)
	caster:MonsterDamage({
		victim = hitTarget,
		damage_rate = CHARGE_DAMAGE_RATE,
		ability = self:GetAbility(),
	})
	hitTarget:KnockBack(caster, self:GetAbility(), {
		direction = caster:GetForwardVector(),
		distance = KNOCKBACK_DISTANCE,
		duration = KNOCKBACK_DURATION,
		height = 0,
		block = true,
		blockUntraversable = true,
	})
	self:Destroy()
end
function modifier_elite_162_move.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
	end
end
function modifier_elite_162_move.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_elite_162_move.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
function modifier_elite_162_move.prototype.GetOverrideAnimationRate(self)
	return 1.5
end
function modifier_elite_162_move.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_elite_162_move.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_elite_162_move.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
modifier_elite_162_move = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_162_move)
return ____exports