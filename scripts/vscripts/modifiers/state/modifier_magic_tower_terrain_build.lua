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
--- 魔能秘塔地形构建期间的玩家隐藏与操作保护。
____exports.modifier_magic_tower_terrain_build = __TS__Class()
local modifier_magic_tower_terrain_build = ____exports.modifier_magic_tower_terrain_build
modifier_magic_tower_terrain_build.name = "modifier_magic_tower_terrain_build"
__TS__ClassExtends(modifier_magic_tower_terrain_build, BaseModifier_CS)
function modifier_magic_tower_terrain_build.prototype.IsHidden(self)
	return true
end
function modifier_magic_tower_terrain_build.prototype.IsPurgable(self)
	return false
end
function modifier_magic_tower_terrain_build.prototype.RemoveOnDeath(self)
	return false
end
function modifier_magic_tower_terrain_build.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
	}
end
function modifier_magic_tower_terrain_build.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():AddNoDrawWithWearables()
end
function modifier_magic_tower_terrain_build.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveNoDrawWithWearables()
end
modifier_magic_tower_terrain_build = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_magic_tower_terrain_build)
____exports.modifier_magic_tower_terrain_build = modifier_magic_tower_terrain_build
return ____exports