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
--- 通用眩晕（可自定义前端特效），默认用于被打断后的眩晕
____exports.modifier_generic_stunned = __TS__Class()
local modifier_generic_stunned = ____exports.modifier_generic_stunned
modifier_generic_stunned.name = "modifier_generic_stunned"
__TS__ClassExtends(modifier_generic_stunned, BaseModifier_CS)
function modifier_generic_stunned.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.effectName = params.effect_name
	self.statusEffectName = params.status_effect_name
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_generic_stunned.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.effectName = params.effect_name
	self.statusEffectName = params.status_effect_name
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_generic_stunned.prototype.AddCustomTransmitterData(self)
	return { effectName = self.effectName, statusEffectName = self.statusEffectName }
end
function modifier_generic_stunned.prototype.HandleCustomTransmitterData(self, data)
	self.effectName = data.effectName
	self.statusEffectName = data.statusEffectName
end
function modifier_generic_stunned.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_generic_stunned.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_DISABLED
end
function modifier_generic_stunned.prototype.IsHidden(self)
	return true
end
function modifier_generic_stunned.prototype.IsPurgable(self)
	return false
end
function modifier_generic_stunned.prototype.IsDebuff(self)
	return true
end
function modifier_generic_stunned.prototype.GetEffectName(self)
	return self.effectName or "particles/generic_gameplay/generic_stunned.vpcf"
end
function modifier_generic_stunned.prototype.GetStatusEffectName(self)
	return self.statusEffectName or ""
end
function modifier_generic_stunned.prototype.GetEffectAttachType(self)
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_generic_stunned.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
function modifier_generic_stunned.prototype.ShouldUseOverheadOffset(self)
	return true
end
modifier_generic_stunned =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_generic_stunned") }, modifier_generic_stunned)
____exports.modifier_generic_stunned = modifier_generic_stunned
return ____exports