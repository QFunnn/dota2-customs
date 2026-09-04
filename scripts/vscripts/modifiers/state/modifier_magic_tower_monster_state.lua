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
local ____magic_tower_monster_combat = require("shared.magic_tower_monster_combat")
local MagicTowerMonsterState = ____magic_tower_monster_combat.MagicTowerMonsterState
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 魔塔怪物统一战斗资格状态；固定怪激活后原地作战，动态成员激活后恢复移动。
____exports.modifier_magic_tower_monster_state = __TS__Class()
local modifier_magic_tower_monster_state = ____exports.modifier_magic_tower_monster_state
modifier_magic_tower_monster_state.name = "modifier_magic_tower_monster_state"
__TS__ClassExtends(modifier_magic_tower_monster_state, BaseModifier_CS)
function modifier_magic_tower_monster_state.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.stationaryWhenActive = true
end
function modifier_magic_tower_monster_state.prototype.IsHidden(self)
	return true
end
function modifier_magic_tower_monster_state.prototype.IsPurgable(self)
	return false
end
function modifier_magic_tower_monster_state.prototype.RemoveOnDeath(self)
	return true
end
function modifier_magic_tower_monster_state.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.stationaryWhenActive = tonumber(params and params.stationaryWhenActive or 1) == 1
	self:SetStackCount(MagicTowerMonsterState.SEALED)
end
function modifier_magic_tower_monster_state.prototype.SetMagicTowerState(self, state, stationaryWhenActive)
	if stationaryWhenActive == nil then
		stationaryWhenActive = self.stationaryWhenActive
	end
	if not IsServer() then
		return
	end
	self.stationaryWhenActive = stationaryWhenActive
	self:SetStackCount(state)
end
function modifier_magic_tower_monster_state.prototype.CheckState(self)
	local state = self:GetStackCount()
	if state == MagicTowerMonsterState.SEALED then
		return {
			[MODIFIER_STATE_OUT_OF_GAME] = true,
			[MODIFIER_STATE_INVULNERABLE] = true,
			[MODIFIER_STATE_UNSELECTABLE] = true,
			[MODIFIER_STATE_NO_HEALTH_BAR] = true,
			[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
			[MODIFIER_STATE_ROOTED] = true,
			[MODIFIER_STATE_DISARMED] = true,
			[MODIFIER_STATE_SILENCED] = true,
		}
	end
	if state == MagicTowerMonsterState.READY then
		return {
			[MODIFIER_STATE_NO_HEALTH_BAR] = true,
			[MODIFIER_STATE_ROOTED] = true,
			[MODIFIER_STATE_DISARMED] = true,
			[MODIFIER_STATE_SILENCED] = true,
		}
	end
	local ____table_stationaryWhenActive_2
	if self.stationaryWhenActive then
		____table_stationaryWhenActive_2 = { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_SILENCED] = true }
	else
		____table_stationaryWhenActive_2 = {}
	end
	return ____table_stationaryWhenActive_2
end
modifier_magic_tower_monster_state = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_magic_tower_monster_state)
____exports.modifier_magic_tower_monster_state = modifier_magic_tower_monster_state
return ____exports