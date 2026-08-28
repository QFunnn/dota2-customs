--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
--- 复仇：挂在复仇者身上，仅对标记目标增伤；标记目标头顶特效。
-- 客户端头像依赖 CustomTransmitter 同步 texture_name（OnCreated 参数仅服务端有）。
____exports.sl_modifier_rnd_event_1023 = __TS__Class()
local sl_modifier_rnd_event_1023 = ____exports.sl_modifier_rnd_event_1023
sl_modifier_rnd_event_1023.name = "sl_modifier_rnd_event_1023"
__TS__ClassExtends(sl_modifier_rnd_event_1023, sl_modifier_transmitter_data)
function sl_modifier_rnd_event_1023.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_rnd_event_1023.prototype.IsHidden(self)
	return false
end
function sl_modifier_rnd_event_1023.prototype.GetTexture(self)
	local ____table__params_texture_name_0 = self._params
	if ____table__params_texture_name_0 ~= nil then
		____table__params_texture_name_0 = ____table__params_texture_name_0.texture_name
	end
	local ____table__params_texture_name_0_2 = ____table__params_texture_name_0
	if ____table__params_texture_name_0_2 == nil then
		____table__params_texture_name_0_2 = "buff/rnd_event_1023"
	end
	return ____table__params_texture_name_0_2
end
function sl_modifier_rnd_event_1023.prototype.IsPermanent(self)
	return true
end
function sl_modifier_rnd_event_1023.prototype.RemoveOnDeath(self)
	return false
end
function sl_modifier_rnd_event_1023.prototype.OnCreated(self, params)
	sl_modifier_transmitter_data.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:_CreateMarkParticle()
end
function sl_modifier_rnd_event_1023.prototype.OnRefresh(self, params)
	sl_modifier_transmitter_data.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_DestroyMarkParticle()
	self:_CreateMarkParticle()
end
function sl_modifier_rnd_event_1023.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:_DestroyMarkParticle()
end
function sl_modifier_rnd_event_1023.prototype._CreateMarkParticle(self)
	local target = self:GetMarkedTarget()
	if not IsValid(target) then
		return
	end
	local viewer = self:GetParent():GetFixedPlayerOwner()
	if not IsValid(viewer) then
		return
	end
	self._overhead_pid = SParticleManager:CreateGenericParticleForPlayer(
		GENERIC_PARTICLES.rnd_event_1023_mark_overhead,
		PATTACH_OVERHEAD_FOLLOW,
		target,
		viewer
	)
end
function sl_modifier_rnd_event_1023.prototype._DestroyMarkParticle(self)
	if self._overhead_pid == nil then
		return
	end
	SParticleManager:DestroyParticle(self._overhead_pid, false)
	self._overhead_pid = nil
end
function sl_modifier_rnd_event_1023.prototype.GetMarkedTarget(self)
	local ____table__params_marked_target_3 = self._params
	if ____table__params_marked_target_3 ~= nil then
		____table__params_marked_target_3 = ____table__params_marked_target_3.marked_target
	end
	local marked_target = ____table__params_marked_target_3
	if marked_target == nil or marked_target == nil then
		return nil
	end
	local target = EntIndexToHScript(marked_target)
	if not IsValid(target) then
		return nil
	end
	return target
end
function sl_modifier_rnd_event_1023.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_rnd_event_1023.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_5 = event
	local attacker = ____event_5.attacker
	local target = ____event_5.target
	local parent = self:GetParent()
	if attacker ~= parent then
		return
	end
	if not IsValid(target) then
		return
	end
	local ____temp_8 = target:GetEntityIndex()
	local ____table__params_marked_target_6 = self._params
	if ____table__params_marked_target_6 ~= nil then
		____table__params_marked_target_6 = ____table__params_marked_target_6.marked_target
	end
	if ____temp_8 ~= ____table__params_marked_target_6 then
		return
	end
	local ____table__params_damage_pct_9 = self._params
	if ____table__params_damage_pct_9 ~= nil then
		____table__params_damage_pct_9 = ____table__params_damage_pct_9.damage_pct
	end
	local ____table__params_damage_pct_9_11 = ____table__params_damage_pct_9
	if ____table__params_damage_pct_9_11 == nil then
		____table__params_damage_pct_9_11 = 0
	end
	return ____table__params_damage_pct_9_11
end
sl_modifier_rnd_event_1023 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/random_event_modifiers/sl_modifier_rnd_event_1023") },
	sl_modifier_rnd_event_1023
)
____exports.sl_modifier_rnd_event_1023 = sl_modifier_rnd_event_1023
return ____exports