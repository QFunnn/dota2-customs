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
local modifier_normal_022_dash
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local TRIGGER_DISTANCE = 230
local STOP_DISTANCE = 100
local MAX_DASH_DISTANCE = 600
local DASH_SPEED = 1500
local DASH_MIN_DURATION = 0.12
local DASH_MAX_DURATION = 0.45
local CHECK_INTERVAL = 1
local COOLDOWN = 5
local DASH_SOUND = "Hero_PhantomAssassin.Strike.Start"
local HIT_SOUND = "Hero_PhantomAssassin.Strike.End"
--- 普通技能22 - 被动：目标距离超过 300 时冲到身边并攻击一次
____exports.normal_022 = __TS__Class()
local normal_022 = ____exports.normal_022
normal_022.name = "normal_022"
__TS__ClassExtends(normal_022, MonsterAbility_CS)
function normal_022.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0, cooldown = COOLDOWN }
end
function normal_022.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_022"
end
normal_022 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_022)
____exports.normal_022 = normal_022
local modifier_normal_022 = __TS__Class()
modifier_normal_022.name = "modifier_normal_022"
__TS__ClassExtends(modifier_normal_022, MonsterModifier_CS)
function modifier_normal_022.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.isDashing = false
end
function modifier_normal_022.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(CHECK_INTERVAL)
end
function modifier_normal_022.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if self.isDashing then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	if parent:IsStunned() or parent:IsChanneling() or parent:IsSilenced() then
		return
	end
	local ____opt_0 = parent.IsMonsterCasting
	if ____opt_0 and ____opt_0(parent) then
		return
	end
	local target = self:FindDashTarget(parent)
	if not IsValidAlive(nil, target) then
		return
	end
	if not target then
		return
	end
	local distance = GetDistance(nil, parent:GetAbsOrigin(), target:GetAbsOrigin())
	if distance <= TRIGGER_DISTANCE then
		return
	end
	local cooldown = ability:GetCooldown(ability:GetLevel())
	local ____ability_StartCooldown_3 = ability.StartCooldown
	local ____temp_2
	if cooldown > 0 then
		____temp_2 = cooldown
	else
		____temp_2 = COOLDOWN
	end
	____ability_StartCooldown_3(ability, ____temp_2)
	self:DashAndAttack(parent, target)
end
function modifier_normal_022.prototype.FindDashTarget(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	local ____this_5
	____this_5 = parent
	local ____opt_4 = ____this_5.GetAttackTarget
	local attackTarget = ____opt_4 and ____opt_4(____this_5)
	if self:IsValidEnemyTarget(parent, attackTarget) then
		return attackTarget
	end
	local ____this_7
	____this_7 = parent
	local ____opt_6 = ____this_7.GetAggroTarget
	local aggroTarget = ____opt_6 and ____opt_6(____this_7)
	if self:IsValidEnemyTarget(parent, aggroTarget) then
		return aggroTarget
	end
	return nil
end
function modifier_normal_022.prototype.IsValidEnemyTarget(self, parent, target)
	if not target or not IsValidAlive(nil, target) then
		return false
	end
	if not IsValidAlive(nil, parent) then
		return false
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return false
	end
	local ____this_9
	____this_9 = target
	local ____opt_8 = ____this_9.GetUnitType
	local unitType = ____opt_8 and ____opt_8(____this_9)
	if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
		return false
	end
	return true
end
function modifier_normal_022.prototype.DashAndAttack(self, parent, target)
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	if not IsValidAlive(nil, target) then
		return
	end
	local targetOrigin = target:GetAbsOrigin()
	local direction = GetDirection(nil, targetOrigin, origin)
	local desiredDashEnd = targetOrigin:__sub(direction:__mul(STOP_DISTANCE))
	local desiredDashDistance = GetDistance(nil, origin, desiredDashEnd)
	local dashDistance = math.min(desiredDashDistance, MAX_DASH_DISTANCE)
	local dashEnd = origin:__add(direction:__mul(dashDistance))
	dashEnd.z = GetGroundHeight(dashEnd, parent) or dashEnd.z
	local duration = math.min(DASH_MAX_DURATION, math.max(DASH_MIN_DURATION, dashDistance / DASH_SPEED))
	self.isDashing = true
	parent:SetForwardVector(direction)
	EmitSoundOn(DASH_SOUND, parent)
	parent:Mover(dashEnd, duration, nil, false, true)
	Timers:CreateTimer(duration + 0.03, function()
		self.isDashing = false
		if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) then
			return
		end
		FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
		parent:SetForwardVector(GetDirection(nil, target:GetAbsOrigin(), parent:GetAbsOrigin()))
		modifier_normal_022_dash:applys(parent, parent, ability, { duration = duration })
		EmitSoundOn(HIT_SOUND, target)
	end)
end
function modifier_normal_022.prototype.IsHidden(self)
	return true
end
function modifier_normal_022.prototype.IsPurgable(self)
	return false
end
modifier_normal_022 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_022") }, modifier_normal_022)
modifier_normal_022_dash = __TS__Class()
modifier_normal_022_dash.name = "modifier_normal_022_dash"
__TS__ClassExtends(modifier_normal_022_dash, MonsterModifier_CS)
function modifier_normal_022_dash.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_normal_022_dash.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CAST_ABILITY_1
end
function modifier_normal_022_dash.prototype.GetOverrideAnimationRate(self)
	return 2.5
end
function modifier_normal_022_dash.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_normal_022_dash.prototype.IsHidden(self)
	return true
end
function modifier_normal_022_dash.prototype.IsPurgable(self)
	return false
end
modifier_normal_022_dash =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_022_dash") }, modifier_normal_022_dash)
return ____exports