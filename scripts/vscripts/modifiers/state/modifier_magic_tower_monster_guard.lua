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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 魔塔怪物的警卫约束；状态切换由房间级调度器统一驱动。
____exports.modifier_magic_tower_monster_guard = __TS__Class()
local modifier_magic_tower_monster_guard = ____exports.modifier_magic_tower_monster_guard
modifier_magic_tower_monster_guard.name = "modifier_magic_tower_monster_guard"
__TS__ClassExtends(modifier_magic_tower_monster_guard, BaseModifier_CS)
function modifier_magic_tower_monster_guard.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.stationaryWhenEngaged = false
end
function modifier_magic_tower_monster_guard.prototype.IsHidden(self)
	return true
end
function modifier_magic_tower_monster_guard.prototype.IsPurgable(self)
	return false
end
function modifier_magic_tower_monster_guard.prototype.RemoveOnDeath(self)
	return true
end
function modifier_magic_tower_monster_guard.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.stationaryWhenEngaged = tonumber(params and params.stationaryWhenEngaged) == 1
	self:SetStackCount(0)
end
function modifier_magic_tower_monster_guard.prototype.SetGuardState(self, state, stationaryWhenEngaged)
	if not IsServer() then
		return
	end
	self.stationaryWhenEngaged = stationaryWhenEngaged
	self:SetStackCount(state)
end
function modifier_magic_tower_monster_guard.prototype.CheckState(self)
	local state = self:GetStackCount()
	if state == 0 then
		return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_SILENCED] = true }
	end
	if state == 2 then
		return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_SILENCED] = true }
	end
	local ____table_stationaryWhenEngaged_2
	if self.stationaryWhenEngaged then
		____table_stationaryWhenEngaged_2 = { [MODIFIER_STATE_ROOTED] = true }
	else
		____table_stationaryWhenEngaged_2 = {}
	end
	return ____table_stationaryWhenEngaged_2
end
modifier_magic_tower_monster_guard = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_magic_tower_monster_guard)
____exports.modifier_magic_tower_monster_guard = modifier_magic_tower_monster_guard
return ____exports