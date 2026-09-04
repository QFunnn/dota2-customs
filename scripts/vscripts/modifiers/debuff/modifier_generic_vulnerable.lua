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
local VULNERABLE_DEFAULT_BASE_INCOMING_PCT = 15
local VULNERABLE_DEFAULT_PER_STACK_INCOMING_PCT = 2
local VULNERABLE_DEFAULT_MAX_STACK = 5
--- 易伤承伤加成硬上限（封顶），不随层数/符印超过此值
local VULNERABLE_MAX_INCOMING_PCT = 25
____exports.modifier_generic_vulnerable = __TS__Class()
local modifier_generic_vulnerable = ____exports.modifier_generic_vulnerable
modifier_generic_vulnerable.name = "modifier_generic_vulnerable"
__TS__ClassExtends(modifier_generic_vulnerable, BaseModifier_CS)
function modifier_generic_vulnerable.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.baseIncomingPct = VULNERABLE_DEFAULT_BASE_INCOMING_PCT
	self.perStackIncomingPct = VULNERABLE_DEFAULT_PER_STACK_INCOMING_PCT
	self.effectiveMaxStacks = VULNERABLE_DEFAULT_MAX_STACK
end
function modifier_generic_vulnerable.GetLocalizationCN(self)
	return {
		name = "易伤",
		description = "承受的所有伤害提高。初始提高15%，每层额外提高2%，最高25%。",
	}
end
function modifier_generic_vulnerable.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.effectName = params.effect_name
	self.statusEffectName = params.status_effect_name
	local sourceMaxStacks = self:ResolveSourceMaxStacks(params.source_max_stacks)
	self.effectiveMaxStacks = sourceMaxStacks
	local addStacks = math.max(1, math.floor(params.stack or 1))
	self:SetStackCount(math.min(sourceMaxStacks, addStacks))
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_generic_vulnerable.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.effectName = params.effect_name or self.effectName
	self.statusEffectName = params.status_effect_name or self.statusEffectName
	local sourceMaxStacks = self:ResolveSourceMaxStacks(params.source_max_stacks)
	self.effectiveMaxStacks = math.max(self.effectiveMaxStacks, sourceMaxStacks)
	local currentStacks = self:GetStackCount()
	local requestedStacks = math.max(1, math.floor(params.stack or 1))
	local permittedStacks = math.max(0, sourceMaxStacks - currentStacks)
	local addedStacks = math.min(requestedStacks, permittedStacks)
	self:SetStackCount(math.min(self.effectiveMaxStacks, currentStacks + addedStacks))
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_generic_vulnerable.prototype.ResolveSourceMaxStacks(self, value)
	return math.max(VULNERABLE_DEFAULT_MAX_STACK, math.floor(tonumber(value) or VULNERABLE_DEFAULT_MAX_STACK))
end
function modifier_generic_vulnerable.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_generic_vulnerable.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	local stacks = math.max(1, self:GetStackCount())
	local incomingPct =
		math.min(VULNERABLE_MAX_INCOMING_PCT, self.baseIncomingPct + (stacks - 1) * self.perStackIncomingPct)
	if incomingPct <= 0 then
		return
	end
	local ____event_final_0, ____mul_1 = event.final, "mul"
	if ____event_final_0[____mul_1] == nil then
		____event_final_0[____mul_1] = {}
	end
	local ____event_final_mul_2 = event.final.mul
	____event_final_mul_2[#____event_final_mul_2 + 1] =
		{ value = 1 + incomingPct / 100, source = "modifier_generic_vulnerable:易伤" }
end
function modifier_generic_vulnerable.prototype.AddCustomTransmitterData(self)
	return { effectName = self.effectName, statusEffectName = self.statusEffectName }
end
function modifier_generic_vulnerable.prototype.HandleCustomTransmitterData(self, data)
	self.effectName = data.effectName
	self.statusEffectName = data.statusEffectName
end
function modifier_generic_vulnerable.prototype.IsHidden(self)
	return false
end
function modifier_generic_vulnerable.prototype.IsDebuff(self)
	return true
end
function modifier_generic_vulnerable.prototype.IsPurgable(self)
	return true
end
function modifier_generic_vulnerable.prototype.GetEffectName(self)
	return self.effectName or ""
end
function modifier_generic_vulnerable.prototype.GetStatusEffectName(self)
	return self.statusEffectName or ""
end
function modifier_generic_vulnerable.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_generic_vulnerable.prototype.GetTexture(self)
	return "slardar_amplify_damage"
end
modifier_generic_vulnerable = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_vulnerable)
____exports.modifier_generic_vulnerable = modifier_generic_vulnerable
return ____exports