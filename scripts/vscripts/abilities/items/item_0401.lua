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
____exports.item_0401 = __TS__Class()
local item_0401 = ____exports.item_0401
item_0401.name = "item_0401"
__TS__ClassExtends(item_0401, BaseItem_CS)
function item_0401.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0401_void_blade.name
end
item_0401 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0401)
____exports.item_0401 = item_0401
____exports.modifier_item_0401_void_blade = __TS__Class()
local modifier_item_0401_void_blade = ____exports.modifier_item_0401_void_blade
modifier_item_0401_void_blade.name = "modifier_item_0401_void_blade"
__TS__ClassExtends(modifier_item_0401_void_blade, BaseModifier_CS)
function modifier_item_0401_void_blade.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedEvasionPct = -1
	self.cachedBonusCritDamagePct = 0
end
function modifier_item_0401_void_blade.prototype.GetMutexKey(self)
	return "kong_ren_mutex"
end
function modifier_item_0401_void_blade.prototype.GetMutexPriority(self)
	local ____opt_0 = self:GetAbility()
	return (____opt_0 and ____opt_0:GetAbilityName()) == "item_0401" and 200 or 100
end
function modifier_item_0401_void_blade.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateByEvasion(true)
	self:StartIntervalThink(0.5)
end
function modifier_item_0401_void_blade.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RecalculateByEvasion(true)
end
function modifier_item_0401_void_blade.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateByEvasion(false)
end
function modifier_item_0401_void_blade.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0401_void_blade.prototype.GetAttributeBonus(self)
	return { crit_damage_pct = self.cachedBonusCritDamagePct }
end
function modifier_item_0401_void_blade.prototype.IsHidden(self)
	return true
end
function modifier_item_0401_void_blade.prototype.IsPurgable(self)
	return false
end
function modifier_item_0401_void_blade.prototype.RecalculateByEvasion(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local ability_evasion_step_pct = math.max(1, ability:GetSpecialValueFor("ability_evasion_step_pct"))
	local perStepRolled = ability:GetSpecialValueFor("ability_value_crit_damage_per_step_pct")
	local ____math_max_3 = math.max
	local ____temp_2
	if perStepRolled > 0 then
		____temp_2 = perStepRolled
	else
		____temp_2 = ability:GetSpecialValueFor("ability_crit_damage_per_step_pct")
	end
	local ability_crit_damage_per_step_pct = ____math_max_3(0, ____temp_2)
	local maxRolled = ability:GetSpecialValueFor("ability_value_crit_damage_max_pct")
	local ____math_max_5 = math.max
	local ____temp_4
	if maxRolled > 0 then
		____temp_4 = maxRolled
	else
		____temp_4 = ability:GetSpecialValueFor("ability_crit_damage_max_pct")
	end
	local ability_crit_damage_max_pct = ____math_max_5(0, ____temp_4)
	local evasionPct = math.max(0, MyGameAttribute:GetAttribute(parent, "evasion_pct") or 0)
	local bonusCritDamagePct = math.min(
		ability_crit_damage_max_pct,
		math.floor(evasionPct / ability_evasion_step_pct) * ability_crit_damage_per_step_pct
	)
	local evasionChanged = math.abs(evasionPct - self.cachedEvasionPct) > 0.01
	local bonusChanged = math.abs(bonusCritDamagePct - self.cachedBonusCritDamagePct) > 0.01
	if not forceRefresh and not evasionChanged and not bonusChanged then
		return
	end
	self.cachedEvasionPct = evasionPct
	self.cachedBonusCritDamagePct = bonusCritDamagePct
	self:SetStackCount(bonusCritDamagePct)
	self:RefreshAttributes()
end
modifier_item_0401_void_blade = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0401_void_blade)
____exports.modifier_item_0401_void_blade = modifier_item_0401_void_blade
return ____exports