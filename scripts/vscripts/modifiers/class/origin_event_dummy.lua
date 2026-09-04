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
local registerModifier = ____dota_ts_adapter.registerModifier
local BaseModifier = ____dota_ts_adapter.BaseModifier
local ____Debug = require("modules.Debug")
local Debug = ____Debug.Debug
____exports.OriginEventDummy = __TS__Class()
local OriginEventDummy = ____exports.OriginEventDummy
OriginEventDummy.name = "OriginEventDummy"
__TS__ClassExtends(OriginEventDummy, BaseModifier)
function OriginEventDummy.prototype.IsHidden(self)
	return true
end
function OriginEventDummy.prototype.IsDebuff(self)
	return false
end
function OriginEventDummy.prototype.RemoveOnDeath(self)
	return false
end
function OriginEventDummy.prototype.IsPurgable(self)
	return false
end
function OriginEventDummy.prototype.IsPurgeException(self)
	return false
end
function OriginEventDummy.prototype.IsPermanent(self)
	return true
end
function OriginEventDummy.prototype.DeclareFunctions(self)
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_EVENT_ON_ABILITY_START,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
end
function OriginEventDummy.prototype.OnAbilityStart(self, event)
	if not IsServer() then
		return
	end
	if not event.ability or not event.unit or not IsValid(nil, event.unit) then
		return
	end
	local ____MyGameEvent_6 = MyGameEvent
	local ____MyGameEvent_FireEvent_7 = MyGameEvent.FireEvent
	local ____BusinessEvents_ON_ABILITY_START_5 = BusinessEvents.ON_ABILITY_START
	local ____temp_2 = event.ability:GetEntityIndex()
	local ____temp_3 = event.ability:GetAbilityName()
	local ____temp_4 = event.unit:GetEntityIndex()
	local ____opt_0 = event.target
	____MyGameEvent_FireEvent_7(____MyGameEvent_6, ____BusinessEvents_ON_ABILITY_START_5, {
		ability_index = ____temp_2,
		ability_name = ____temp_3,
		caster = ____temp_4,
		target = ____opt_0 and ____opt_0:GetEntityIndex(),
		pos = event.unit:GetCursorPosition(),
	}, { scope = "entity", entity = event.unit })
end
function OriginEventDummy.prototype.OnAbilityFullyCast(self, event)
	if not IsServer() then
		return
	end
	if not event.ability or not event.unit or not IsValid(nil, event.unit) then
		return
	end
	local ____MyGameEvent_14 = MyGameEvent
	local ____MyGameEvent_FireEvent_15 = MyGameEvent.FireEvent
	local ____BusinessEvents_ON_AFTER_ABILITY_FULLY_CAST_13 = BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST
	local ____temp_10 = event.ability:GetEntityIndex()
	local ____temp_11 = event.ability:GetAbilityName()
	local ____temp_12 = event.unit:GetEntityIndex()
	local ____opt_8 = event.target
	____MyGameEvent_FireEvent_15(____MyGameEvent_14, ____BusinessEvents_ON_AFTER_ABILITY_FULLY_CAST_13, {
		ability_index = ____temp_10,
		ability_name = ____temp_11,
		caster = ____temp_12,
		target = ____opt_8 and ____opt_8:GetEntityIndex(),
		pos = event.unit:GetCursorPosition(),
	}, { scope = "entity", entity = event.unit })
	if Debug:IsWTFEnabled() then
		event.ability:EndCooldown()
	end
end
function OriginEventDummy.prototype.OnAttackRecord(self, event)
	if not IsServer() then
		return
	end
	if not MyGameAttribute:HasAttributes(event.attacker) then
		return
	end
	local ____temp_20 = not MyGameAttribute:HasAttributes(event.target)
	if ____temp_20 then
		local ____opt_18 = event.target
		local ____opt_16 = ____opt_18 and ____opt_18.GetUnitType
		____temp_20 = (____opt_16 and ____opt_16(____opt_18)) ~= UnitType.DESTRUCTIBLE
	end
	if ____temp_20 then
		return
	end
	if not IsValid(nil, event.attacker) or not IsValid(nil, event.target) then
		return
	end
	local attacker = event.attacker
	local target = event.target
	local attack_damage = MyGameAttribute:GetAttribute(attacker, "total_attack_damage") or 0
	local hasAttackRecordStart = event.record ~= nil
	if hasAttackRecordStart then
		MyGameAttack:RegisterAttackRecordStart(attacker, event.record)
	end
	local ev = {
		attacker = attacker,
		target = target,
		ability = nil,
		record = event.record,
		attack_damage = attack_damage,
		disable_celled = false,
		never_miss = false,
		use_effect = true,
		use_projectile = attacker:IsRangedAttacker(),
		has_attack_record_start = hasAttackRecordStart,
	}
	MyGameEvent:FireEvent(BusinessEvents.ON_ATTACK_START, ev, { scope = "entity", entity = attacker })
	MyGameEvent:FireEvent(BusinessEvents.ON_TAKE_ATTACK_START, ev, { scope = "entity", entity = target })
end
function OriginEventDummy.prototype.OnAttack(self, event)
	if not IsServer() then
		return
	end
	if not MyGameAttribute:HasAttributes(event.attacker) then
		return
	end
	local ____temp_25 = not MyGameAttribute:HasAttributes(event.target)
	if ____temp_25 then
		local ____opt_23 = event.target
		local ____opt_21 = ____opt_23 and ____opt_23.GetUnitType
		____temp_25 = (____opt_21 and ____opt_21(____opt_23)) ~= UnitType.DESTRUCTIBLE
	end
	if ____temp_25 then
		return
	end
	local attacker = event.attacker
	local target = event.target
	if
		not attacker
		or not target
		or not IsValid(nil, attacker)
		or not IsValid(nil, target)
		or not target:IsBaseNPC()
	then
		return
	end
	local attackDamage = MyGameAttribute:GetAttribute(attacker, "total_attack_damage")
	local baseParams = {
		attack_damage = attackDamage,
		disable_celled = false,
		never_miss = false,
		use_effect = true,
		use_projectile = attacker:IsRangedAttacker(),
		record = event.record,
	}
	MyGameAttack:PerformAttack(attacker, target, baseParams, event.record)
end
OriginEventDummy = __TS__DecorateLegacy({ registerModifier(nil) }, OriginEventDummy)
____exports.OriginEventDummy = OriginEventDummy
return ____exports