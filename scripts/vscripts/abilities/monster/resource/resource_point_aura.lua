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
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local AURA_RADIUS = 3000
local STACK_INTERVAL = 20
local MAX_STACK = 30
--- 资源点光环技能 - 3000范围，仅针对附近怪物：增加怪物伤害、减少怪物承受伤害，每10秒+1%最多30%
____exports.resource_point_aura = __TS__Class()
local resource_point_aura = ____exports.resource_point_aura
resource_point_aura.name = "resource_point_aura"
__TS__ClassExtends(resource_point_aura, BaseAbility)
function resource_point_aura.prototype.GetIntrinsicModifierName(self)
	return "modifier_resource_point_aura"
end
resource_point_aura = __TS__DecorateLegacy({ registerAbility(nil) }, resource_point_aura)
____exports.resource_point_aura = resource_point_aura
____exports.modifier_resource_point_aura = __TS__Class()
local modifier_resource_point_aura = ____exports.modifier_resource_point_aura
modifier_resource_point_aura.name = "modifier_resource_point_aura"
__TS__ClassExtends(modifier_resource_point_aura, BaseModifier_CS)
function modifier_resource_point_aura.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._elapsed = 0
end
function modifier_resource_point_aura.prototype.IsHidden(self)
	return true
end
function modifier_resource_point_aura.prototype.IsPurgable(self)
	return false
end
function modifier_resource_point_aura.prototype.IsDebuff(self)
	return false
end
function modifier_resource_point_aura.prototype.IsPermanent(self)
	return true
end
function modifier_resource_point_aura.prototype.GetModifierAura(self)
	return "modifier_resource_point_aura_effect"
end
function modifier_resource_point_aura.prototype.GetAuraRadius(self)
	return AURA_RADIUS
end
function modifier_resource_point_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_resource_point_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_CREEP
end
function modifier_resource_point_aura.prototype.IsAura(self)
	return true
end
function modifier_resource_point_aura.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():EmitSound("Hero_Dazzle.Shadow_Wave")
	self:SetStackCount(0)
	self._elapsed = 0
	self:StartIntervalThink(1)
end
function modifier_resource_point_aura.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self._elapsed = self._elapsed + 1
	if self._elapsed >= STACK_INTERVAL then
		self._elapsed = 0
		local stack = math.min(self:GetStackCount() + 1, MAX_STACK)
		self:SetStackCount(stack)
	end
end
modifier_resource_point_aura =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_resource_point_aura") }, modifier_resource_point_aura)
____exports.modifier_resource_point_aura = modifier_resource_point_aura
--- 资源点光环效果（仅怪物）：通过 outgoing_damage_pct 增伤 + damage_reduction_pct 减伤
____exports.modifier_resource_point_aura_effect = __TS__Class()
local modifier_resource_point_aura_effect = ____exports.modifier_resource_point_aura_effect
modifier_resource_point_aura_effect.name = "modifier_resource_point_aura_effect"
__TS__ClassExtends(modifier_resource_point_aura_effect, BaseModifier_CS)
function modifier_resource_point_aura_effect.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._lastPct = -1
end
function modifier_resource_point_aura_effect.prototype.GetPct(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return 0
	end
	local mod = caster:FindModifierByName("modifier_resource_point_aura")
	local ____mod_0
	if mod then
		____mod_0 = mod:GetStackCount()
	else
		____mod_0 = 0
	end
	return ____mod_0
end
function modifier_resource_point_aura_effect.prototype.IsHidden(self)
	return false
end
function modifier_resource_point_aura_effect.prototype.IsPurgable(self)
	return true
end
function modifier_resource_point_aura_effect.prototype.IsDebuff(self)
	return false
end
function modifier_resource_point_aura_effect.prototype.GetTexture(self)
	return "vengefulspirit_command_aura"
end
function modifier_resource_point_aura_effect.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self._lastPct = self:GetPct()
	self:StartIntervalThink(1)
end
function modifier_resource_point_aura_effect.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local pct = self:GetPct()
	if pct ~= self._lastPct then
		self._lastPct = pct
		self:RefreshAttributes()
	end
end
function modifier_resource_point_aura_effect.prototype.GetAttributeBonus(self)
	local pct = self:GetPct()
	if pct <= 0 then
		return {}
	end
	return { outgoing_damage_pct = pct, damage_reduction_pct = pct }
end
modifier_resource_point_aura_effect = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_resource_point_aura_effect") },
	modifier_resource_point_aura_effect
)
____exports.modifier_resource_point_aura_effect = modifier_resource_point_aura_effect
return ____exports