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
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
local ATTACK_TARGET_SYNC_INTERVAL = 0.25
local ATTACK_TARGET_FALLBACK_RANGE = 3500
--- 怪物普攻目标同步：将原生自动攻击目标转为明确攻击目标命令
____exports.modifier_monster_attack_target_sync = __TS__Class()
local modifier_monster_attack_target_sync = ____exports.modifier_monster_attack_target_sync
modifier_monster_attack_target_sync.name = "modifier_monster_attack_target_sync"
__TS__ClassExtends(modifier_monster_attack_target_sync, BaseModifier)
function modifier_monster_attack_target_sync.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(ATTACK_TARGET_SYNC_INTERVAL)
end
function modifier_monster_attack_target_sync.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local ____temp_2 = parent:IsStunned() or parent:IsChanneling()
	if not ____temp_2 then
		local ____opt_0 = parent.IsMonsterCasting
		____temp_2 = ____opt_0 and ____opt_0(parent)
	end
	if ____temp_2 then
		return
	end
	local target = self:GetCurrentAttackTarget(parent)
	if not target then
		self.lastTargetIndex = nil
		return
	end
	local targetIndex = target:entindex()
	if self.lastTargetIndex == targetIndex then
		return
	end
	self.lastTargetIndex = targetIndex
	ExecuteOrderFromTable({
		UnitIndex = parent:entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		TargetIndex = targetIndex,
		Queue = false,
	})
end
function modifier_monster_attack_target_sync.prototype.GetCurrentAttackTarget(self, parent)
	local ____this_4
	____this_4 = parent
	local ____opt_3 = ____this_4.GetAttackTarget
	local ____temp_7 = ____opt_3 and ____opt_3(____this_4)
	if ____temp_7 == nil then
		local ____this_6
		____this_6 = parent
		local ____opt_5 = ____this_6.GetAggroTarget
		____temp_7 = ____opt_5 and ____opt_5(____this_6)
	end
	local target = ____temp_7
	if self:IsValidEnemyTarget(parent, target) then
		return target
	end
	return self:FindFallbackTarget(parent)
end
function modifier_monster_attack_target_sync.prototype.FindFallbackTarget(self, parent)
	local ____this_9
	____this_9 = parent
	local ____opt_8 = ____this_9.GetMinDistanceUnit
	local target = ____opt_8 and ____opt_8(____this_9, ATTACK_TARGET_FALLBACK_RANGE)
	local ____table_IsValidEnemyTarget_result_10
	if self:IsValidEnemyTarget(parent, target) then
		____table_IsValidEnemyTarget_result_10 = target
	else
		____table_IsValidEnemyTarget_result_10 = nil
	end
	return ____table_IsValidEnemyTarget_result_10
end
function modifier_monster_attack_target_sync.prototype.IsValidEnemyTarget(self, parent, target)
	if not IsValidAlive(nil, target) then
		return false
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return false
	end
	if target == parent then
		return false
	end
	return true
end
function modifier_monster_attack_target_sync.prototype.IsHidden(self)
	return true
end
function modifier_monster_attack_target_sync.prototype.IsPurgable(self)
	return false
end
function modifier_monster_attack_target_sync.prototype.RemoveOnDeath(self)
	return true
end
modifier_monster_attack_target_sync = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_monster_attack_target_sync") },
	modifier_monster_attack_target_sync
)
____exports.modifier_monster_attack_target_sync = modifier_monster_attack_target_sync
return ____exports