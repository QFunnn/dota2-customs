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
____exports.item_0321 = __TS__Class()
local item_0321 = ____exports.item_0321
item_0321.name = "item_0321"
__TS__ClassExtends(item_0321, BaseItem_CS)
function item_0321.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0321_heart_of_tarrasque.name
end
item_0321 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0321)
____exports.item_0321 = item_0321
____exports.modifier_item_0321_heart_of_tarrasque = __TS__Class()
local modifier_item_0321_heart_of_tarrasque = ____exports.modifier_item_0321_heart_of_tarrasque
modifier_item_0321_heart_of_tarrasque.name = "modifier_item_0321_heart_of_tarrasque"
__TS__ClassExtends(modifier_item_0321_heart_of_tarrasque, BaseModifier_CS)
function modifier_item_0321_heart_of_tarrasque.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._lastRegenAmpPct = -1
end
function modifier_item_0321_heart_of_tarrasque.prototype.IsHidden(self)
	return true
end
function modifier_item_0321_heart_of_tarrasque.prototype.IsPurgable(self)
	return false
end
function modifier_item_0321_heart_of_tarrasque.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self._lastRegenAmpPct = -1
	self:StartIntervalThink(0.5)
	self:RefreshAttributes()
end
function modifier_item_0321_heart_of_tarrasque.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:CleanupAttributes()
end
function modifier_item_0321_heart_of_tarrasque.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local next = self:ComputeRegenAmpPct()
	if next ~= self._lastRegenAmpPct then
		self._lastRegenAmpPct = next
		self:RefreshAttributes()
	end
end
function modifier_item_0321_heart_of_tarrasque.prototype.GetAttributeBonus(self)
	return { regen_amp_pct = self:ComputeRegenAmpPct() }
end
function modifier_item_0321_heart_of_tarrasque.prototype.ComputeRegenAmpPct(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return 0
	end
	local maxHp = math.max(1, parent:GetMaxHealth())
	local hp = math.max(0, parent:GetHealth())
	local missingPct = math.max(0, math.min(100, math.floor((maxHp - hp) * 100 / maxHp)))
	local ability_regen_amp_missing_health_step_pct =
		math.max(1, ability:GetSpecialValueFor("ability_regen_amp_missing_health_step_pct"))
	local ability_regen_amp_pct_per_missing_health_pct =
		math.max(0, ability:GetSpecialValueFor("ability_regen_amp_pct_per_missing_health_pct"))
	local ability_regen_amp_max_pct = math.max(0, ability:GetSpecialValueFor("ability_regen_amp_max_pct"))
	local missingStepCount = math.floor(missingPct / ability_regen_amp_missing_health_step_pct)
	local regenAmpPct = missingStepCount * ability_regen_amp_pct_per_missing_health_pct
	local ____temp_0
	if ability_regen_amp_max_pct > 0 then
		____temp_0 = math.min(regenAmpPct, ability_regen_amp_max_pct)
	else
		____temp_0 = regenAmpPct
	end
	return ____temp_0
end
modifier_item_0321_heart_of_tarrasque =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0321_heart_of_tarrasque)
____exports.modifier_item_0321_heart_of_tarrasque = modifier_item_0321_heart_of_tarrasque
return ____exports