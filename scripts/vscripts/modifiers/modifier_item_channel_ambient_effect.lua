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
--- 物品使用时的通用周身特效 modifier
-- - 仅供播放特效，不改变单位属性或状态
-- - 由 ItemUseManager 在 channel 与 slow 两种使用方式下共用
-- - 生命周期与读条 duration 一致
____exports.modifier_item_channel_ambient_effect = __TS__Class()
local modifier_item_channel_ambient_effect = ____exports.modifier_item_channel_ambient_effect
modifier_item_channel_ambient_effect.name = "modifier_item_channel_ambient_effect"
__TS__ClassExtends(modifier_item_channel_ambient_effect, BaseModifier)
function modifier_item_channel_ambient_effect.prototype.IsHidden(self)
	return true
end
function modifier_item_channel_ambient_effect.prototype.IsPurgable(self)
	return false
end
function modifier_item_channel_ambient_effect.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._ambient_effect = params and params.ambient_effect or ""
	if self._ambient_effect ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_item_channel_ambient_effect.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self._ambient_effect = params and params.ambient_effect or ""
	if self._ambient_effect ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_item_channel_ambient_effect.prototype.AddCustomTransmitterData(self)
	return { ambientEffect = self._ambient_effect }
end
function modifier_item_channel_ambient_effect.prototype.HandleCustomTransmitterData(self, data)
	self._ambient_effect = data.ambientEffect or ""
end
function modifier_item_channel_ambient_effect.prototype.GetEffectName(self)
	return self._ambient_effect or ""
end
modifier_item_channel_ambient_effect =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_channel_ambient_effect)
____exports.modifier_item_channel_ambient_effect = modifier_item_channel_ambient_effect
return ____exports