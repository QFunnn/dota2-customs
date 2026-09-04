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
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local THINK_INTERVAL = 0.1
____exports.item_0241 = __TS__Class()
local item_0241 = ____exports.item_0241
item_0241.name = "item_0241"
__TS__ClassExtends(item_0241, BaseItem_CS)
function item_0241.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0241.name
end
item_0241 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0241)
____exports.item_0241 = item_0241
____exports.modifier_item_0241 = __TS__Class()
local modifier_item_0241 = ____exports.modifier_item_0241
modifier_item_0241.name = "modifier_item_0241"
__TS__ClassExtends(modifier_item_0241, BaseModifier_CS)
function modifier_item_0241.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.accumulated = 0
end
function modifier_item_0241.GetLocalizationCN(self)
	return { name = "嗜血凝锋", description = "吸血触发时累积攻击力，随后每秒衰减。" }
end
function modifier_item_0241.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_HEAL_RECEIVED }
end
function modifier_item_0241.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.accumulated = 0
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0241.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0241.prototype.OnHealReceived_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	local src = event.source
	if src ~= "attack_lifesteal" and src ~= "spell_lifesteal" then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local lifestealAmount = math.max(0, event.requested_amount or 0)
	if lifestealAmount <= 0 then
		return
	end
	local pctPerLifesteal = math.max(0, ability:GetSpecialValueFor("ability_attack_per_lifesteal_pct"))
	local gain = lifestealAmount * pctPerLifesteal / 100
	if gain <= 0 then
		return
	end
	self.accumulated = self.accumulated + gain
	local cap = ability:GetSpecialValueFor("ability_max_bonus_attack")
	if cap > 0 then
		self.accumulated = math.min(self.accumulated, cap)
	end
	self:SyncBonus()
end
function modifier_item_0241.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, self:GetParent()) then
		return
	end
	if self.accumulated <= 0 then
		return
	end
	local decayPct = math.max(0, ability:GetSpecialValueFor("ability_decay_pct_per_second"))
	local decayMin = math.max(0, ability:GetSpecialValueFor("ability_decay_min_per_second"))
	local decayPerSecond = math.max(decayMin, self.accumulated * (decayPct / 100))
	self.accumulated = math.max(0, self.accumulated - decayPerSecond * THINK_INTERVAL)
	self:SyncBonus()
end
function modifier_item_0241.prototype.GetAttributeBonus(self)
	return { bonus_attack_damage = self:GetStackCount() }
end
function modifier_item_0241.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0241.prototype.IsDebuff(self)
	return false
end
function modifier_item_0241.prototype.IsPurgable(self)
	return false
end
function modifier_item_0241.prototype.SyncBonus(self)
	local next = math.max(0, math.floor(self.accumulated))
	if next == self:GetStackCount() then
		return
	end
	self:SetStackCount(next)
	self:RefreshAttributes()
end
modifier_item_0241 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0241)
____exports.modifier_item_0241 = modifier_item_0241
return ____exports