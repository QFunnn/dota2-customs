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
local modifier_normal_007_blink_fx
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local TRIGGER_RANGE = 1000
local BACK_DODGE_TRIGGER_RANGE = 300
local DODGE_CHANCE_PCT = 30
local PROACTIVE_SIDE_DODGE_CHANCE_PCT = 20
local DODGE_DISTANCE_MIN = 200
local DODGE_DISTANCE_MAX = 450
local DODGE_DURATION = 0.2
local INTERNAL_COOLDOWN = 0.3
local PROACTIVE_CHECK_INTERVAL = 1
local BLINK_EFFECT = "particles/units/heroes/hero_faceless_void/faceless_void_time_walk.vpcf"
local BLINK_STATUS_EFFECT = "particles/status_fx/status_effect_faceless_timewalk.vpcf"
--- 普通技能7 - 被动：附近敌方英雄攻击开始时，有概率向侧方快速位移闪避
____exports.normal_007 = __TS__Class()
local normal_007 = ____exports.normal_007
normal_007.name = "normal_007"
__TS__ClassExtends(normal_007, MonsterAbility_CS)
function normal_007.prototype.Precache(self, context)
	PrecacheResource("particle", BLINK_EFFECT, context)
	PrecacheResource("particle", BLINK_STATUS_EFFECT, context)
end
function normal_007.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_007.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_007"
end
normal_007 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_007)
____exports.normal_007 = normal_007
local modifier_normal_007 = __TS__Class()
modifier_normal_007.name = "modifier_normal_007"
__TS__ClassExtends(modifier_normal_007, MonsterModifier_CS)
function modifier_normal_007.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.nextTriggerTime = 0
end
function modifier_normal_007.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(PROACTIVE_CHECK_INTERVAL)
end
function modifier_normal_007.prototype.DeclareEvents(self)
	return {
		{ event = BusinessEvents.ON_ATTACK_START, target = { scope = "global" } },
		{ event = BusinessEvents.ON_ABILITY_START, target = { scope = "global" } },
	}
end
function modifier_normal_007.prototype.OnAttackStart_CS(self, event)
	if not IsServer() then
		return
	end
	self:TryReactiveDodge(event.attacker)
end
function modifier_normal_007.prototype.OnAbilityStart_CS(self, event)
	if not IsServer() then
		return
	end
	local caster = EntIndexToHScript(event.caster)
	local sourceAbility = EntIndexToHScript(event.ability_index)
	if not caster or not sourceAbility or not IsValid(nil, caster) or not IsValid(nil, sourceAbility) then
		return
	end
	local ____opt_0 = sourceAbility.IsItem
	if ____opt_0 and ____opt_0(sourceAbility) then
		return
	end
	self:TryReactiveDodge(caster)
end
function modifier_normal_007.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local ____opt_2 = parent.GetAggroTarget
	local aggroTarget = ____opt_2 and ____opt_2(parent)
	if not aggroTarget or not IsValidAlive(nil, aggroTarget) then
		return
	end
	if RollPercentage(PROACTIVE_SIDE_DODGE_CHANCE_PCT) ~= true then
		return
	end
	self:TryDodge(aggroTarget, true, true)
end
function modifier_normal_007.prototype.TryReactiveDodge(self, attacker)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, attacker) then
		return
	end
	local distance = GetDistance(nil, parent:GetAbsOrigin(), attacker:GetAbsOrigin())
	local shouldBackDodge = distance <= BACK_DODGE_TRIGGER_RANGE
	self:TryDodge(attacker, shouldBackDodge, false)
end
function modifier_normal_007.prototype.TryDodge(self, attacker, preferBackward, ignoreReactiveChance)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or not IsValidAlive(nil, attacker) then
		return
	end
	if not attacker:IsHero() then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if attacker == parent then
		return
	end
	if parent:IsStunned() or parent:IsChanneling() or parent:IsSilenced() then
		return
	end
	local ____opt_4 = parent.IsMonsterCasting
	if ____opt_4 and ____opt_4(parent) then
		return
	end
	if GameRules:GetGameTime() < self.nextTriggerTime then
		return
	end
	if GetDistance(nil, parent:GetAbsOrigin(), attacker:GetAbsOrigin()) > TRIGGER_RANGE then
		return
	end
	if not ignoreReactiveChance and RollPercentage(DODGE_CHANCE_PCT) ~= true then
		return
	end
	local origin = parent:GetAbsOrigin()
	local dodgeDistance = RandomFloat(DODGE_DISTANCE_MIN, DODGE_DISTANCE_MAX)
	local dodgeDirBase = GetDirection(nil, attacker:GetAbsOrigin(), origin)
	local ____preferBackward_6
	if preferBackward then
		____preferBackward_6 = self:FindBackwardDodgeTarget(parent, origin, dodgeDirBase, dodgeDistance)
	else
		____preferBackward_6 = self:FindSideDodgeTarget(parent, origin, dodgeDirBase, dodgeDistance)
	end
	local dodgeTarget = ____preferBackward_6
	if not dodgeTarget then
		return
	end
	parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 2)
	modifier_normal_007_blink_fx:applys(parent, parent, ability, { duration = DODGE_DURATION })
	self.nextTriggerTime = GameRules:GetGameTime() + DODGE_DURATION + INTERNAL_COOLDOWN
	parent:Mover(dodgeTarget, DODGE_DURATION)
end
function modifier_normal_007.prototype.FindBackwardDodgeTarget(self, parent, origin, backwardDir, distance)
	local backwardTarget = origin:__add(backwardDir:__mul(distance))
	if not IsGridNavDisplacementWalkable(nil, backwardTarget) then
		return nil
	end
	return GetGroundPosition(backwardTarget, parent)
end
function modifier_normal_007.prototype.FindSideDodgeTarget(self, parent, origin, dodgeDirBase, distance)
	local leftDir = RotateVector2D(nil, dodgeDirBase, 90)
	local rightDir = RotateVector2D(nil, dodgeDirBase, -90)
	local tryLeftFirst = RandomInt(0, 1) == 1
	local ____tryLeftFirst_7
	if tryLeftFirst then
		____tryLeftFirst_7 = leftDir
	else
		____tryLeftFirst_7 = rightDir
	end
	local firstDir = ____tryLeftFirst_7
	local ____tryLeftFirst_8
	if tryLeftFirst then
		____tryLeftFirst_8 = rightDir
	else
		____tryLeftFirst_8 = leftDir
	end
	local secondDir = ____tryLeftFirst_8
	local firstTarget = origin:__add(firstDir:__mul(distance))
	if IsGridNavDisplacementWalkable(nil, firstTarget) then
		return GetGroundPosition(firstTarget, parent)
	end
	local secondTarget = origin:__add(secondDir:__mul(distance))
	if IsGridNavDisplacementWalkable(nil, secondTarget) then
		return GetGroundPosition(secondTarget, parent)
	end
	return nil
end
function modifier_normal_007.prototype.IsHidden(self)
	return true
end
function modifier_normal_007.prototype.IsPurgable(self)
	return false
end
modifier_normal_007 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_007") }, modifier_normal_007)
modifier_normal_007_blink_fx = __TS__Class()
modifier_normal_007_blink_fx.name = "modifier_normal_007_blink_fx"
__TS__ClassExtends(modifier_normal_007_blink_fx, MonsterModifier_CS)
function modifier_normal_007_blink_fx.prototype.IsHidden(self)
	return true
end
function modifier_normal_007_blink_fx.prototype.IsPurgable(self)
	return false
end
function modifier_normal_007_blink_fx.prototype.GetEffectName(self)
	return BLINK_EFFECT
end
function modifier_normal_007_blink_fx.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_normal_007_blink_fx.prototype.GetStatusEffectName(self)
	return BLINK_STATUS_EFFECT
end
function modifier_normal_007_blink_fx.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:EmitSound("Hero_Riki.Blink_Strike")
end
function modifier_normal_007_blink_fx.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_HIGH
end
function modifier_normal_007_blink_fx.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local enemies = self:FindHeroesInRadius(80, parent:GetAbsOrigin())
	for ____, enemy in ipairs(enemies) do
		parent:PerformAttack(enemy, true, true, true, false, true, false, true)
		if math.random(0, 100) < 50 then
			AddDeBuffStatus(nil, enemy, parent, self:GetAbility(), DebuffStatusType.STUN, { duration = 0.1 })
		end
		return
	end
end
modifier_normal_007_blink_fx =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_007_blink_fx") }, modifier_normal_007_blink_fx)
return ____exports