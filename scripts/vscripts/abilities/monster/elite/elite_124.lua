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
local CHARGE_STOP_DISTANCE = 80
local CHARGE_SPEED = 1800
local MIN_CHARGE_DURATION = 0.05
local MAX_CHARGE_DURATION = 0.35
local BLEED_DAMAGE_MULTIPLIER = 1
local BLEED_PARTICLE = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf"
--- 获取水平归一化方向，避免重叠或 Z 轴导致位移异常。
local function getFlatDirection(self, direction, fallback)
	if fallback == nil then
		fallback = Vector(1, 0, 0)
	end
	local flat = Vector(direction.x, direction.y, 0)
	local length = flat:Length2D()
	if length <= 0.001 then
		local fallbackFlat = Vector(fallback.x, fallback.y, 0)
		local fallbackLength = fallbackFlat:Length2D()
		local ____temp_0
		if fallbackLength <= 0.001 then
			____temp_0 = Vector(1, 0, 0)
		else
			____temp_0 = fallbackFlat:__mul(1 / fallbackLength)
		end
		return ____temp_0
	end
	return flat:__mul(1 / length)
end
--- 精英技能 124 - 血袭：普通攻击抬手时冲到目标身前，命中时附加基于自身攻击力的流血。
____exports.elite_124 = __TS__Class()
local elite_124 = ____exports.elite_124
elite_124.name = "elite_124"
__TS__ClassExtends(elite_124, MonsterAbility_CS)
function elite_124.prototype.Precache(self, context)
	PrecacheResource("particle", BLEED_PARTICLE, context)
	PrecacheResource("soundfile", "Creep_Good_Melee.Attack", context)
end
function elite_124.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function elite_124.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_elite_124.name
end
elite_124 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_124)
____exports.elite_124 = elite_124
____exports.modifier_elite_124 = __TS__Class()
local modifier_elite_124 = ____exports.modifier_elite_124
modifier_elite_124.name = "modifier_elite_124"
__TS__ClassExtends(modifier_elite_124, MonsterModifier_CS)
function modifier_elite_124.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_START, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_124.prototype.OnAttackStart_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local target = event.target
	if not self:CanTriggerAttackEffect(event, parent, target, ability) then
		return
	end
	self:ChargeToTargetFront(parent, target, ability)
end
function modifier_elite_124.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local target = event.target
	if not self:CanTriggerAttackEffect(event, parent, target, ability) then
		return
	end
	parent:EmitSound("Creep_Good_Melee.Attack")
	self:ApplyBleed(parent, target, ability)
end
function modifier_elite_124.prototype.CanTriggerAttackEffect(self, event, parent, target, ability)
	if not ability or ability:IsNull() then
		return false
	end
	if event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return false
	end
	if parent:PassivesDisabled() then
		return false
	end
	if not IsValidAlive(nil, target) or target:IsBuilding() or target:IsOther() then
		return false
	end
	return target:GetTeamNumber() ~= parent:GetTeamNumber()
end
function modifier_elite_124.prototype.ChargeToTargetFront(self, parent, target, ability)
	local parentOrigin = parent:GetAbsOrigin()
	local targetOrigin = target:GetAbsOrigin()
	local stopDirection = getFlatDirection(nil, parentOrigin:__sub(targetOrigin), parent:GetForwardVector())
	local ____end = GetGroundPosition(targetOrigin:__add(stopDirection:__mul(CHARGE_STOP_DISTANCE)), parent)
	local distance = GetDistance(nil, parentOrigin, ____end)
	if distance <= 1 then
		return
	end
	local duration = math.min(MAX_CHARGE_DURATION, math.max(MIN_CHARGE_DURATION, distance / CHARGE_SPEED))
	parent:SetForwardVector(getFlatDirection(nil, targetOrigin:__sub(parentOrigin), parent:GetForwardVector()))
	parent:Mover(____end, duration, nil, nil, true, true)
	Timers:CreateTimer(duration, function()
		if not IsValidAlive(nil, parent) then
			return
		end
		FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
		if IsValidAlive(nil, target) then
			parent:SetForwardVector(
				getFlatDirection(nil, target:GetAbsOrigin():__sub(parent:GetAbsOrigin()), parent:GetForwardVector())
			)
		end
	end)
end
function modifier_elite_124.prototype.ApplyBleed(self, parent, target, ability)
	local bleedDamage =
		math.max(0, (MyGameAttribute:GetAttribute(parent, "total_attack_damage") or 0) * BLEED_DAMAGE_MULTIPLIER)
	AddDeBuffStatus(
		nil,
		target,
		parent,
		ability,
		DebuffStatusType.BLEED,
		{ source_final_damage = bleedDamage, effect_name = BLEED_PARTICLE }
	)
end
function modifier_elite_124.prototype.IsHidden(self)
	return true
end
modifier_elite_124 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_124)
____exports.modifier_elite_124 = modifier_elite_124
return ____exports