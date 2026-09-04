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
local FREEZE_SLOW_PCT_PER_STACK = 3
local FREEZE_MAX_STACKS = 10
--- 通用冰冻 Debuff（可直接施加多层，最高 10 层）
____exports.modifier_generic_slow = __TS__Class()
local modifier_generic_slow = ____exports.modifier_generic_slow
modifier_generic_slow.name = "modifier_generic_slow"
__TS__ClassExtends(modifier_generic_slow, BaseModifier_CS)
function modifier_generic_slow.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.effectName = params.effect_name
	self.statusEffectName = params.status_effect_name
	self:SetStackCount(math.min(math.max(math.floor(params.stack or 1), 1), FREEZE_MAX_STACKS))
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_generic_slow.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.effectName = params.effect_name
	self.statusEffectName = params.status_effect_name
	local add = math.max(math.floor(params.stack or 1), 1)
	self:SetStackCount(math.min(self:GetStackCount() + add, FREEZE_MAX_STACKS))
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_generic_slow.prototype.AddCustomTransmitterData(self)
	return { effectName = self.effectName, statusEffectName = self.statusEffectName }
end
function modifier_generic_slow.prototype.HandleCustomTransmitterData(self, data)
	self.effectName = data.effectName
	self.statusEffectName = data.statusEffectName
end
function modifier_generic_slow.GetLocalizationCN(self)
	return { name = "冰冻", description = "移动速度和攻击速度降低。每层降低3%，最高叠加10层。" }
end
function modifier_generic_slow.prototype.IsHidden(self)
	return false
end
function modifier_generic_slow.prototype.IsDebuff(self)
	return true
end
function modifier_generic_slow.prototype.IsPurgable(self)
	return true
end
function modifier_generic_slow.prototype.GetAttributeBonus(self)
	local slowPct = -math.min(self:GetStackCount(), FREEZE_MAX_STACKS) * FREEZE_SLOW_PCT_PER_STACK
	return { bonus_movespeed_pct = slowPct, attack_speed = slowPct }
end
function modifier_generic_slow.prototype.GetEffectName(self)
	return self.effectName or ""
end
function modifier_generic_slow.prototype.GetStatusEffectName(self)
	return self.statusEffectName or ""
end
function modifier_generic_slow.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_generic_slow.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_generic_slow.prototype.GetTexture(self)
	return "crystal_maiden_crystal_nova"
end
modifier_generic_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_slow)
____exports.modifier_generic_slow = modifier_generic_slow
return ____exports