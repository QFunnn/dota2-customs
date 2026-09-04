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
--- 饰品实体专用的状态特效 Modifier。
-- 仅承载并同步状态特效路径，不改变单位属性或状态。
____exports.modifier_wearable_status_effect = __TS__Class()
local modifier_wearable_status_effect = ____exports.modifier_wearable_status_effect
modifier_wearable_status_effect.name = "modifier_wearable_status_effect"
__TS__ClassExtends(modifier_wearable_status_effect, BaseModifier)
function modifier_wearable_status_effect.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.statusEffectName = params.status_effect_name or ""
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function modifier_wearable_status_effect.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.statusEffectName = params.status_effect_name or ""
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function modifier_wearable_status_effect.prototype.AddCustomTransmitterData(self)
	return { statusEffectName = self.statusEffectName }
end
function modifier_wearable_status_effect.prototype.HandleCustomTransmitterData(self, data)
	self.statusEffectName = data.statusEffectName or ""
end
function modifier_wearable_status_effect.prototype.IsHidden(self)
	return true
end
function modifier_wearable_status_effect.prototype.IsPurgable(self)
	return false
end
function modifier_wearable_status_effect.prototype.GetStatusEffectName(self)
	print("modifier_wearable_status_effect", IsServer(), self.statusEffectName)
	return self.statusEffectName
end
modifier_wearable_status_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_wearable_status_effect)
____exports.modifier_wearable_status_effect = modifier_wearable_status_effect
return ____exports